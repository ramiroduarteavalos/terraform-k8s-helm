########################################################################################################################
## START AWS VARIABLES #################################################################################################
########################################################################################################################
variable "region" {
  description = "AWS region"
  type        = string
}

variable "profile" {
  description = "AWS profile"
  type        = string
}
########################################################################################################################
## END AWS VARIABLES ###################################################################################################
########################################################################################################################

########################################################################################################################
## START K8S VARIABLES #################################################################################################
########################################################################################################################
variable "domain_name" {
  description = "Domain name for external dns submodule."
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "Name of the cluster to obtain credentials for helm connection"
  type        = string
}

variable "r53_private_zone" {
  description = "Route53 private zone"
  type        = bool
  default     = false
}

variable "loki_host" {
  description = "Grafana loki host"
  type        = string
  default     = null
  sensitive   = true
}

variable "loki_username" {
  description = "Grafana loki username"
  type        = string
  default     = null
  sensitive   = true
}

variable "loki_password" {
  description = "Grafana loki password"
  type        = string
  default     = null
  sensitive   = true
}

########################################################################################################################
## END K8S VARIABLES ###################################################################################################
########################################################################################################################

########################################################################################################################
## START HELM VARIABLES ################################################################################################
########################################################################################################################
variable "helm_releases" {
  description = "Configuration for Helm releases"
  type = map(object({
    name                       = optional(string)
    repository                 = string
    chart                      = optional(string)
    version                    = string
    timeout                    = optional(number, 300)
    values                     = optional(list(string))
    create_namespace           = optional(bool, false)
    namespace                  = optional(string)
    lint                       = optional(bool, false)
    description                = optional(string)
    repository_key_file        = optional(string)
    repository_cert_file       = optional(string)
    repository_username        = optional(string)
    repository_password        = optional(string)
    verify                     = optional(bool, false)
    keyring                    = optional(string, "/.gnupg/pubring.gpg")
    disable_webhooks           = optional(bool, false)
    reuse_values               = optional(bool, false)
    reset_values               = optional(bool, false)
    force_update               = optional(bool, false)
    recreate_pods              = optional(bool, false)
    cleanup_on_fail            = optional(bool, false)
    max_history                = optional(number, 0)
    atomic                     = optional(bool, false)
    skip_crds                  = optional(bool, false)
    render_subchart_notes      = optional(bool, false)
    disable_openapi_validation = optional(bool, false)
    wait                       = optional(bool, true)
    wait_for_jobs              = optional(bool, false)
    dependency_update          = optional(bool, false)
    replace                    = optional(bool, false)
    set                        = optional(map(any))
  }))
}
########################################################################################################################
## END HELM VARIABLES ##################################################################################################
########################################################################################################################
