resource "azurerm_resource_group" "byl_resource_group" {
  name     = "Brows-and-lashes"
  location = "East US 2"
}

resource "azurerm_user_assigned_identity" "github_identity" {
  location            = azurerm_resource_group.byl_resource_group.location
  resource_group_name = azurerm_resource_group.byl_resource_group.name
  name                = "github"
}

resource "azurerm_federated_identity_credential" "example" {
  name                = "github-actions"
  resource_group_name = azurerm_resource_group.byl_resource_group.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  parent_id           = azurerm_user_assigned_identity.github_identity.id
  subject             = "repo:brows-and-lashes/ByL:*"
}

data "github_organization" "byl_org" {
  name = "github"
}