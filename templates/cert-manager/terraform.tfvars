
environments = {
  test = {
    cluster_name  = "example-test"
    region        = "us-east-1"
    profile       = "meli"
    helm_releases = {
      "cert-manager" = {
        repository       = "https://charts.jetstack.io"
        chart            = "cert-manager"
        version          = "v1.8.0"
        create_namespace = true
        set = {
          "installCRDs"    = "true"
        }
      }
    }
  }
}
