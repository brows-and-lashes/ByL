terraform {
    cloud {
    organization = "ByLBeautyBar"
    hostname     = "app.terraform.io"
    workspaces {
      name = "azure-byl"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "2.2.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

provider "azapi" {}
