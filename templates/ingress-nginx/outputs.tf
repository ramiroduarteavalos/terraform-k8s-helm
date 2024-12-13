output "outputs" {
  value = module.helm.outputs
  description = "Component output"
  sensitive = true
}