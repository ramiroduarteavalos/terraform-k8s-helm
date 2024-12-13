## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.25.0 |
| <a name="provider_aws.virginia"></a> [aws.virginia](#provider\_aws.virginia) | 5.25.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.11.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_external-dns"></a> [external-dns](#module\_external-dns) | ./modules/external-dns | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_ecrpublic_authorization_token.token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecrpublic_authorization_token) | data source |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_role.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_iam_role"></a> [aws\_iam\_role](#input\_aws\_iam\_role) | AWS IAM Role to assume | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster to obtain credentials for helm connection | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name for external dns submodule. | `string` | `null` | no |
| <a name="input_helm_releases"></a> [helm\_releases](#input\_helm\_releases) | Configuration for Helm releases | <pre>map(object({<br>    name                       = optional(string)<br>    repository                 = string<br>    chart                      = optional(string)<br>    version                    = string<br>    timeout                    = optional(number, 300)<br>    values                     = optional(list(string))<br>    create_namespace           = optional(bool, false)<br>    namespace                  = optional(string)<br>    lint                       = optional(bool, false)<br>    description                = optional(string)<br>    repository_key_file        = optional(string)<br>    repository_cert_file       = optional(string)<br>    repository_username        = optional(string)<br>    repository_password        = optional(string)<br>    verify                     = optional(bool, false)<br>    keyring                    = optional(string, "/.gnupg/pubring.gpg")<br>    disable_webhooks           = optional(bool, false)<br>    reuse_values               = optional(bool, false)<br>    reset_values               = optional(bool, false)<br>    force_update               = optional(bool, false)<br>    recreate_pods              = optional(bool, false)<br>    cleanup_on_fail            = optional(bool, false)<br>    max_history                = optional(number, 0)<br>    atomic                     = optional(bool, false)<br>    skip_crds                  = optional(bool, false)<br>    render_subchart_notes      = optional(bool, false)<br>    disable_openapi_validation = optional(bool, false)<br>    wait                       = optional(bool, true)<br>    wait_for_jobs              = optional(bool, false)<br>    dependency_update          = optional(bool, false)<br>    replace                    = optional(bool, false)<br>    set                        = optional(map(any))<br>  }))</pre> | n/a | yes |
| <a name="input_r53_private_zone"></a> [r53\_private\_zone](#input\_r53\_private\_zone) | Route53 private zone | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_outputs"></a> [outputs](#output\_outputs) | n/a |