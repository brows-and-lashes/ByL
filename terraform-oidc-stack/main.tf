resource "azurerm_resource_group" "byl_resource_group" {
  name     = "Brows-and-lashes"
  location = "East US 2"
}

resource "azurerm_user_assigned_identity" "github_identity" {
  location            = azurerm_resource_group.byl_resource_group.location
  resource_group_name = azurerm_resource_group.byl_resource_group.name
  name                = "github"
}

resource "azurerm_federated_identity_credential" "github_identity_credentials" {
  name                = "github-actions"
  resource_group_name = azurerm_resource_group.byl_resource_group.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  parent_id           = azurerm_user_assigned_identity.github_identity.id
  subject             = "repo:${var.organization_name}/${var.repository_name}:ref:refs/heads/main"
}

resource "azurerm_role_assignment" "github_contributor" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.github_identity.principal_id
}

resource "github_actions_secret" "client_id" {
  repository      = var.repository_name
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = azurerm_user_assigned_identity.github_identity.client_id
}

resource "github_actions_secret" "tenant_id" {
  repository      = var.repository_name
  secret_name     = "AZURE_TENANT_ID"
  plaintext_value = azurerm_user_assigned_identity.github_identity.tenant_id
}

resource "github_actions_secret" "subscription_id" {
  repository      = var.repository_name
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = var.subscription_id
}
