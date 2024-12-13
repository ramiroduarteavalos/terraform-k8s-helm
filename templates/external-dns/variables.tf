########################################################################################################################
## START AWS VARIABLES #################################################################################################
########################################################################################################################
variable "profile" {
  description = "AWS profile"
  type = string  
}
########################################################################################################################
## END AWS VARIABLES ###################################################################################################
########################################################################################################################

########################################################################################################################
## START HELM VARIABLES ################################################################################################
########################################################################################################################
variable "environments" {
  description = "Configuration for Helm releases"
  type = map(object({
    cluster_name  = string
    region        = string
    domain_name   = optional(string)
    helm_releases = map(object({
        name                        = optional(string)
        repository                  = string
        chart                       = optional(string)
        version                     = string
        timeout                     = optional(number)
        values                      = optional(list(string))
        create_namespace            = bool
        namespace                   = optional(string)
        lint                        = optional(bool, false)
        description                 = optional(string)
        repository_key_file         = optional(string)
        repository_cert_file        = optional(string)
        repository_username         = optional(string)
        repository_password         = optional(string)
        verify                      = optional(bool)
        keyring                     = optional(string)
        disable_webhooks            = optional(bool)
        reuse_values                = optional(bool)
        reset_values                = optional(bool)
        force_update                = optional(bool)
        recreate_pods               = optional(bool)
        cleanup_on_fail             = optional(bool)
        max_history                 = optional(number, 0)
        atomic                      = optional(bool, false)
        skip_crds                   = optional(bool)
        render_subchart_notes       = optional(bool)
        disable_openapi_validation  = optional(bool)
        wait                        = optional(bool)
        wait_for_jobs               = optional(bool)
        dependency_update           = optional(bool)
        replace                     = optional(bool)
        set                         = optional(map(any))
    }))
  }))
}
########################################################################################################################
## END HELM VARIABLES ##################################################################################################
########################################################################################################################