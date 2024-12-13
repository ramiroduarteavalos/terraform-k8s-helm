########################################################################################################################
## START DATA ##########################################################################################################
########################################################################################################################
## Start Terraform Data EKS ----------------------------------------------------
data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.cluster_name
}
## End Terraform Data EKS ------------------------------------------------------

## Start Terraform Data Karpenter ----------------------------------------------
data "aws_iam_role" "karpenter" {
  count = local.count_karpenter_release

  name = "karpenter-controller-${data.aws_eks_cluster.this.name}"
}

#data "aws_ecrpublic_authorization_token" "token" {
#  count = local.count_karpenter_release

#  provider = aws.virginia
#}
## End Terraform Data Karpenter ------------------------------------------------
########################################################################################################################
## END DATA ############################################################################################################
########################################################################################################################

########################################################################################################################
## START LOCALS ########################################################################################################
########################################################################################################################
locals {
  ## Start Karpenter Variables -------------------------------------------------
  count_karpenter_release = contains(keys(var.helm_releases), "karpenter") ? 1 : 0
  ## End Karpenter Variables ---------------------------------------------------

  ## Start Helm Variables ------------------------------------------------------
  # Add Helm Chart Set Values terraform origin ---------------------------------
  helm_releases_set = { for service, set in merge(
    { for service in keys(var.helm_releases) : service => {} },
    {
      datadog = contains(keys(var.helm_releases), "datadog") ? {
        "datadog.clusterName" = data.aws_eks_cluster.this.name
      } : {},
      external-dns = contains(keys(var.helm_releases), "external-dns") ? {
        "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" = module.external-dns[0].role_arn
        "aws.region"                                                = var.region
      } : {},
      karpenter = contains(keys(var.helm_releases), "karpenter") ? {
        "settings.aws.clusterName"                                  = data.aws_eks_cluster.this.name
        "settings.aws.clusterEndpoint"                              = data.aws_eks_cluster.this.endpoint
        "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" = data.aws_iam_role.karpenter[0].arn
        "settings.aws.defaultInstanceProfile"                       = "KarpenterNodeInstanceProfile-${data.aws_eks_cluster.this.name}"
      } : {},
      loki = contains(keys(var.helm_releases), "loki") ? {
        "cluster.name" = lookup(try(var.helm_releases.loki, "set", {}), "cluster.name", null) != null ? var.helm_releases.loki.set["cluster.name"] : var.cluster_name
      } : {}
    }
  ) : service => set if length(set) > 0 }

  # Add Helm Chart Set Sensitive Values terraform origin -----------------------
  helm_releases_set_sensitive = { for service, set_sensitive in merge(
    { for service in keys(var.helm_releases) : service => {} },
    {
      loki = contains(keys(var.helm_releases), "loki") ? { for hr_set_key, hr_set_value in {
        "externalServices.loki.host"               = var.loki_host
        "externalServices.loki.basicAuth.username" = var.loki_username
        "externalServices.loki.basicAuth.password" = var.loki_password
      } : hr_set_key => hr_set_value if hr_set_value != null } : {}
    }
  ) : service => set_sensitive if length(set_sensitive) > 0 }

  # Merge Helm Chart Set Values ------------------------------------------------
  helm_releases_merge_set = { for service, hr_attr in var.helm_releases : service => { for key, value in hr_attr : key => key == "set" ? merge(
    value,
    lookup(local.helm_releases_set, service, {})
  ) : value } }

  # Merge Helm Chart Set Sensitive Values --------------------------------------
  helm_releases_merge_set_sensitive = { for service, hr_attr in local.helm_releases_merge_set : service => merge(
    hr_attr,
    { set_sensitive = try(nonsensitive(lookup(local.helm_releases_set_sensitive, service, {})), lookup(local.helm_releases_set_sensitive, service, {})) }
  ) }

  # Merge Helm Chart Values templates by service if exists ---------------------
  helm_releases = { for service, attributes in local.helm_releases_merge_set_sensitive : service => merge(attributes, { values = fileexists("${path.module}/values/${service}.yaml") ? [(file("${path.module}/values/${service}.yaml"))] : [] }) }
  ## End Helm Variables --------------------------------------------------------
}
########################################################################################################################
## END LOCALS ##########################################################################################################
########################################################################################################################

########################################################################################################################
## START MODULES #######################################################################################################
########################################################################################################################
resource "helm_release" "this" {
  for_each = local.helm_releases

  name                       = each.value.name != null ? each.value.name : each.key
  repository                 = each.value.repository
  chart                      = each.value.chart != null ? each.value.chart : each.key
  version                    = each.value.version
  timeout                    = each.value.timeout
  values                     = each.value.values
  create_namespace           = each.value.create_namespace
  namespace                  = each.value.namespace != null ? each.value.namespace : each.key
  lint                       = each.value.lint
  description                = each.value.description
  repository_key_file        = each.value.repository_key_file
  repository_cert_file       = each.value.repository_cert_file
  repository_username        = each.value.repository_username
  repository_password        = each.value.repository_password
  verify                     = each.value.verify
  keyring                    = each.value.keyring
  disable_webhooks           = each.value.disable_webhooks
  reuse_values               = each.value.reuse_values
  reset_values               = each.value.reset_values
  force_update               = each.value.force_update
  recreate_pods              = each.value.recreate_pods
  cleanup_on_fail            = each.value.cleanup_on_fail
  max_history                = each.value.max_history
  atomic                     = each.value.atomic
  skip_crds                  = each.value.skip_crds
  render_subchart_notes      = each.value.render_subchart_notes
  disable_openapi_validation = each.value.disable_openapi_validation
  wait                       = each.value.wait != null ? each.value.wait : true
  wait_for_jobs              = each.value.wait_for_jobs
  dependency_update          = each.value.dependency_update
  replace                    = each.value.replace

  dynamic "set" {
    for_each = each.value.set != null ? each.value.set : {}
    content {
      name  = set.key
      value = set.value
      type  = try(set.value.type, null)
    }
  }

  dynamic "set_sensitive" {
    for_each = each.value.set_sensitive != null ? each.value.set_sensitive : {}
    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  depends_on = [
    module.external-dns,
  ]
}
########################################################################################################################
## END MODULES #########################################################################################################
########################################################################################################################

########################################################################################################################
## START DEPENDENCIES ##################################################################################################
########################################################################################################################


module "external-dns" {
  count = contains(keys(var.helm_releases), "external-dns") ? 1 : 0

  source = "./modules/external-dns"

  domain_name      = var.domain_name
  cluster_name     = var.cluster_name
  r53_private_zone = var.r53_private_zone
}
########################################################################################################################
## END DEPENDENCIES ####################################################################################################
########################################################################################################################
