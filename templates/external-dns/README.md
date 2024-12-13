## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_external-dns"></a> [external-dns](#module\_external-dns) | git::git@gitlab.example.net:infra/provisioner/modules.git//helm | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environments"></a> [environments](#input\_environments) | Configuration for Helm releases | <pre>map(object({<br>    cluster_name  = string<br>    region        = string<br>    domain_name   = optional(string)<br>    helm_releases = map(object({<br>        name                        = optional(string)<br>        repository                  = string<br>        chart                       = optional(string)<br>        version                     = string<br>        timeout                     = optional(number)<br>        values                      = optional(list(string))<br>        create_namespace            = bool<br>        namespace                   = optional(string)<br>        lint                        = optional(bool, false)<br>        description                 = optional(string)<br>        repository_key_file         = optional(string)<br>        repository_cert_file        = optional(string)<br>        repository_username         = optional(string)<br>        repository_password         = optional(string)<br>        verify                      = optional(bool)<br>        keyring                     = optional(string)<br>        disable_webhooks            = optional(bool)<br>        reuse_values                = optional(bool)<br>        reset_values                = optional(bool)<br>        force_update                = optional(bool)<br>        recreate_pods               = optional(bool)<br>        cleanup_on_fail             = optional(bool)<br>        max_history                 = optional(number, 0)<br>        atomic                      = optional(bool, false)<br>        skip_crds                   = optional(bool)<br>        render_subchart_notes       = optional(bool)<br>        disable_openapi_validation  = optional(bool)<br>        wait                        = optional(bool)<br>        wait_for_jobs               = optional(bool)<br>        dependency_update           = optional(bool)<br>        replace                     = optional(bool)<br>        set                         = optional(map(any))<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS profile | `string` | n/a | yes |

## Outputs

No outputs.