variable domain_name {
  description = "Domain name"
  type        = string
}

variable cluster_name {
  description = "Cluster name"
  type        = string
}

variable r53_private_zone {
  description = "Route53 private zone"
  type        = bool
  default     = false
}