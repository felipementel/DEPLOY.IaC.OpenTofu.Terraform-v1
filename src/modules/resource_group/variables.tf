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

variable "tags" {
  description = "Tags to be applied to all resources."
  type        = map(string)
  default     = {}
}
