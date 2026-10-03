module "Managed-Identity" {
  source                                        = "../../modules/azure-managed-identity"
  tags                                          = var.tags
  resource_group_name                           = var.resource_group_name
  location                                      = var.location
  identity_name                                 = var.managed_identity_name
}

module "Storage-Account" {
  source                                        = "../../modules/azure-storage-account"
  tags                                          = var.tags
  resource_group_name                           = var.resource_group_name
  location                                      = var.location
  storage_account_name                          = var.storage_account_name
  account_replication_type                      = var.storage_replication_type
  container_name                                = var.storage_container_name
  managed_identity_principal_id                 = module.Managed-Identity.principal_id
}

module "Main-Site-AppService" {
  source                                        = "../../modules/azure-app-service"
  tags                                          = var.tags
  resource_group                                = var.resource_group_name
  location                                      = var.location
  app_name                                      = var.mainsite-app_name
  serviceplan_name                              = var.mainsite-serviceplan_name
  serviceplan_os                                = var.mainsite-serviceplan_os
  serviceplan_sku                               = var.mainsite-serviceplan_sku
  serviceplan_zone_balancing_enabled            = var.mainsite-serviceplan_zone_balancing_enabled
  network_resource_group                        = var.network_resource_group
  virtual_network_name                          = var.virtual_network_name
  subnet_name                                   = var.subnet_name
  ip_address_default_action                     = var.webmain_ip_address_default_action
  ip_restriction_action                         = var.webmain_ip_restriction_action
  ip_restriction_ip_address                     = var.webmain_ip_restriction_ip_address
  ip_restriction_priority                       = var.webmain_ip_restriction_priority
  ip_restriction_name                           = var.webmain_ip_restriction_name
  enable_frontdoor_lockdown                     = var.mainsite_enable_frontdoor_lockdown
  frontdoor_resource_guid                       = var.mainsite_frontdoor_resource_guid
  dr_bypass_ip_addresses                        = var.mainsite_dr_bypass_ip_addresses
  managed_identity_id                           = module.Managed-Identity.identity_id
}

module "Admin-Site-AppService" {
  source                                        = "../../modules/azure-app-service"
  tags                                          = var.tags
  resource_group                                = var.resource_group_name
  location                                      = var.location
  app_name                                      = var.adminsite-app_name
  serviceplan_name                              = var.adminsite-serviceplan_name
  serviceplan_os                                = var.adminsite-serviceplan_os
  serviceplan_sku                               = var.adminsite-serviceplan_sku
  serviceplan_zone_balancing_enabled            = var.adminsite-serviceplan_zone_balancing_enabled
  network_resource_group                        = var.network_resource_group
  virtual_network_name                          = var.virtual_network_name
  subnet_name                                   = var.subnet_name
  ip_address_default_action                     = var.webadmin_ip_address_default_action
  ip_restriction_action                         = var.webadmin_ip_restriction_action
  ip_restriction_ip_address                     = var.webadmin_ip_restriction_ip_address
  ip_restriction_priority                       = var.webadmin_ip_restriction_priority
  ip_restriction_name                           = var.webadmin_ip_restriction_name
  managed_identity_id                           = module.Managed-Identity.identity_id
}

module "SQL-Database" {
  source                                        = "../../modules/azure-sql-database"
  tags                                          = var.tags
  resource_group_name                           = var.resource_group_name
  location                                      = var.location
  mssql_server_name                             = var.mssql_server_name
  mssql_server_version                          = var.mssql_server_version
  mssql_server_administrator                    = var.mssql_server_administrator
  mssql_server_password                         = var.mssql_server_password
  mssql_database_name                           = var.mssql_database_name
  mssql_database_collation                      = var.mssql_database_collation
  mssql_database_enclave_type                   = var.mssql_database_enclave_type
  mssql_database_license                        = var.mssql_database_license
  mssql_database_max_size_gb                    = var.mssql_database_max_size_gb
  mssql_database_read_scale                     = var.mssql_database_read_scale
  mssql_database_sku_name                       = var.mssql_database_sku_name
  mssql_database_zone_redundant                 = var.mssql_database_zone_redundant
  
}

module "Search-Service" {
  source                                       = "../../modules/azure-search-service"
  tags                                         = var.tags
  resource_group_name                          = var.resource_group_name
  location                                     = var.location
  search_service_name                          = var.search_service_name
  search_service_sku                           = var.search_service_sku
  search_service_public_network_access_enabled = var.search_service_public_network_access_enabled
  
}

# module "front-foor" {
#   source                                       = "../../modules/azure-frontdoor"
#   tags                                         = var.tags
#   resource_group_name                          = var.resource_group_name
#   location                                     = var.location
#   front_door_sku_name                          = var.front_door_sku_name
#   front_door_endpoint_name                     = var.front_door_endpoint_name
#   front_door_route_name                        = var.front_door_route_name
#   front_door_origin_group_name                 = var.front_door_origin_group_name
#   front_door_profile_name                      = var.front_door_profile_name
#   front_door_origin_name                       = var.front_door_origin_name
#   default_hostname                             = module.Main-Site-AppService.default_hostname
#
#   depends_on = [module.resource-group, module.Main-Site-AppService]
# }
