module "namespaces" {
  source     = "../namespaces"
  namespaces = var.namespaces
}

module "backend" {
  source     = "../backend"
  depends_on = [module.namespaces]
}
