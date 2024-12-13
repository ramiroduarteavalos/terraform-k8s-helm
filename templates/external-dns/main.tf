module "external-dns" {
  source = "git::git@gitlab.example.net:infra/provisioner/modules.git//helm"

  profile  = var.profile
  cluster_name  = var.environments[terraform.workspace].cluster_name
  domain_name   = var.environments[terraform.workspace].domain_name
  helm_releases = var.environments[terraform.workspace].helm_releases
  region        = var.environments[terraform.workspace].region
}
