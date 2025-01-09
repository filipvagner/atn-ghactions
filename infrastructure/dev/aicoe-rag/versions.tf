terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 3.100.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.43.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.6.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
    null = {
      source = "hashicorp/null"
    }
    random = {
      version = "~> 3.5.1"
      source  = "hashicorp/random"
    }
  }
  required_version = ">= 1.3.5"
}