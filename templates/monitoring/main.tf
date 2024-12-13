module "helm" {
  source = "git::git@gitlab.example.net:infra/provisioner/modules.git//helm"

  profile  = var.profile
  cluster_name  = var.cluster_name
  helm_releases = var.helm_releases
  region        = var.region
}
