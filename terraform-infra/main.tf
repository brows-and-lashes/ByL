resource "azurerm_resource_group" "brows_and_lashes" {
  name     = "Brows-and-lashes"
  location = "East US 2"
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "byl-sqlserver"
  resource_group_name          = azurerm_resource_group.brows_and_lashes.name
  location                     = azurerm_resource_group.brows_and_lashes.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azapi_resource" "sql_database" {
  type      = "Microsoft.Sql/servers/databases@2023-08-01-preview"
  name      = "byl-free" 
  location  = azurerm_resource_group.brows_and_lashes.location
  parent_id = azurerm_mssql_server.sqlserver.id

  body = {
    properties = {
      minCapacity                        = 0.5
      maxSizeBytes                       = 34359738368
      autoPauseDelay                     = 15
      zoneRedundant                      = false
      isLedgerOn                         = false
      useFreeLimit                       = true
      readScale                          = "Disabled"
      freeLimitExhaustionBehavior        = "BillOverUsage"
      availabilityZone                   = "NoPreference"
      requestedBackupStorageRedundancy   = "Local"
    }

    sku = {
      name     = "GP_S_Gen5"
      tier     = "GeneralPurpose"
      family   = "Gen5"
      capacity = 1
    }
  }

  schema_validation_enabled = false

  response_export_values = ["*"]

  # provider = azapi.integration
}

output "sql_database_name" {
  value = azapi_resource.sql_database.output
}