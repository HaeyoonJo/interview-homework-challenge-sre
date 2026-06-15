variable "namespaces" {
  description = "List of namespace names to create"
  type        = list(string)
  default     = ["collector", "integration", "orcrist", "monitoring", "tools"]
}
