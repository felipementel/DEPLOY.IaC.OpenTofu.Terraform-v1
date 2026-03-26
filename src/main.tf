terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.65.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.11.1"
    }
  }

  required_version = ">= 1.11.1"
}

provider "azurerm" {
  features {

    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }

  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
  tenant_id       = var.arm_tenant_id
}

provider "github" {
  token = var.github_token
  owner = var.ghcr_username
}

##################################
# LOCALS
##################################
locals {
  default_tags = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "opentofu"
  }
  tags = merge(local.default_tags, var.tags)
}

##################################
# MODULES
##################################
module "resource_group" {
  source         = "./modules/resource_group"
  project_name   = var.project_name
  location       = var.location
  environment    = var.environment
  env_abrev      = var.env_abrev
  env_dash_abrev = var.env_dash_abrev
  tags           = local.tags
}

module "sql_database" {
  source = "./modules/sql_database"

  project_name        = var.project_name
  location            = var.location
  environment         = var.environment
  env_abrev           = var.env_abrev
  env_dash_abrev      = var.env_dash_abrev
  tags                = local.tags
  resource_group_name = module.resource_group.resource_group_name
}
