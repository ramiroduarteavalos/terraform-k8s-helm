########################################################################################################################
## START HELM VARIABLES ################################################################################################
########################################################################################################################
environments = {
  test-external-dns = {
    cluster_name  = "saa-eks-idapi-sid-euw-1"
    region        = "eu-west-1"
    domain_name   = "identity-platform.io"
    helm_releases = {
      "external-dns" = {
        repository       = "https://charts.bitnami.com/bitnami"
        chart            = "external-dns"
        version          = "6.28.4"
        create_namespace = true
        set = {
          "policy"    = "sync"
          "interval"  = "1m"
          "logLevel"  = "debug"
        }
      }
    }
  }
}
########################################################################################################################
## END HELM VARIABLES ##################################################################################################
########################################################################################################################
