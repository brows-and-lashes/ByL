terraform {
  cloud {
    organization = "ByLBeautyBar"
    hostname     = "app.terraform.io"
    workspaces {
      name = "azure-oicd-stack"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.5.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

provider "github" {
  owner = var.organization_name
}
