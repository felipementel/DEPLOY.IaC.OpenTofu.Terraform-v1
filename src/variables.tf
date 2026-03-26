variable "arm_client_id" {
  description = "The Client ID of the Service Principal used for Azure authentication."
  type        = string
}

variable "arm_client_secret" {
  description = "The Client Secret of the Service Principal used for Azure authentication."
  type        = string
  sensitive   = true
}

variable "arm_subscription_id" {
  description = "The Subscription ID for the Azure subscription."
  type        = string
  sensitive   = false
}

variable "arm_tenant_id" {
  description = "The Tenant ID for the Azure Active Directory."
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string

  validation {
    condition = contains([
      "brazilsouth"
    ], var.location)
    error_message = "Location must be a valid Azure region."
  }
}

variable "location_static_web_apps" {
  description = "Azure region for Static Web Apps"
  type        = string

  validation {
    condition = contains([
      "eastus2",
    ], var.location_static_web_apps)
    error_message = "Location must be a valid Azure region."
  }
}

variable "environment" {
  description = "The environment tag for resources."
  type        = string
}

variable "env_abrev" {
  description = "The suffix to be added to resource names based on the environment."
  type        = string
  default     = ""
}

variable "env_dash_abrev" {
  description = "The suffix with dash to be added to resource names based on the environment."
  type        = string
  default     = ""
}

variable "ghcr_username" {
  description = "GitHub username for GHCR authentication."
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources."
  type        = map(string)
  default     = {}
}

variable "github_token" {
  description = "GitHub Personal Access Token (PAT) for authentication."
  type        = string
  sensitive   = true
}
