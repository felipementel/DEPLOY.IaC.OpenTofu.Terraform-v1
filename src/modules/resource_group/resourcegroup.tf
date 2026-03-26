resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}${var.env_dash_abrev}"
  location = var.location
  tags     = var.tags
}
