variable "location" {
  type        = string
  description = "Location for Azure Resource Group."
  default     = "East US"
}

variable "container_registry_name" {
  description = "Name of the container registry."
  type        = string
  default     = "atntestregistry"
}

variable "azp_org_name" {
  description = "Name of your Azure DevOps Organization."
  type        = string
  default     = "AzureAtNight"
}

variable "azp_token" {
  description = "Personal access token for your Azure DevOps Organziation."
  type        = string
  default     = "7v5F9TZfzNSeGzUoL41Fce8DU2GOzWmjJvOUynrNlBFHJOGBsF9aJQQJ99BAACAAAAAsbxxFAAASAZDOZFXV"
}

variable "azp_pool" {
  description = "Name of the agent pool you created in Azure DevOps. If not set, a new pool named aci-agents will be created."
  type        = string
  default     = "atn-test-pool"
}

variable "agent_image" {
  description = "Docker image for the self-hosted agent."
  type        = string
  default     = "atntestregistry.azurecr.io/azp-agent:1.0"
}