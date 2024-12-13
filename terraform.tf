########################################################################################################################
## START VERSIONS ######################################################################################################
########################################################################################################################
terraform {
  required_version = ">= 1.3.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }    
  }
}
########################################################################################################################
## END VERSIONS ########################################################################################################
########################################################################################################################

########################################################################################################################
## START PROVIDERS #####################################################################################################
########################################################################################################################
provider "aws" {
  region = var.region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = var.profile
}

provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster_auth.token
  }
#  dynamic "registry" {
#    for_each = { for service, attributes in var.helm_releases : service => attributes.repository if service == "karpenter" }
#    content {
#      url      = registry.value
#      username = data.aws_ecrpublic_authorization_token.token[0].user_name
#      password = data.aws_ecrpublic_authorization_token.token[0].password
#    }
#  }
}
########################################################################################################################
## END PROVIDERS #######################################################################################################
########################################################################################################################
