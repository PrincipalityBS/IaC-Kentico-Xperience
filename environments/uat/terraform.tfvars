#Global Variables
primary_subscription_id                      = "540e4e3f-cccc-40a4-893a-99be668faa89"
tags = {
    Environment       = "uat"
    Application       = "Kentico Xperience"
    WorkloadName      = "Kentico Xperience Application Infrastructure"
    CostCentre        = "1512"
    Provisioner       = "Terraform"
    Owner             = "IT Infrastructure"
    BusinessUnit      = "IT"
    Criticality       = "Level 3 - Standard"
}

#Resource Group Variables
resource_group_name                          = "rg-d-uks-kenticoxp"

#Managed Identity
managed_identity_name                        = "id-d-uks-kenticoxp"

#Storage Account (Kentico Blob Storage)
# storage_account_name must be globally unique, 3-24 lowercase alphanumeric chars — update before applying
storage_account_name                         = "stdkxpuks"
storage_replication_type                     = "LRS"
storage_container_name                       = "cmsstorage"
location                                     = "uksouth"

#Variables for main Application Site
mainsite-serviceplan_sku                     = "P1v3"
mainsite-serviceplan_name                    = "splan-d-uks-principalitywebsite"
mainsite-serviceplan_os                      = "Windows"
mainsite-app_name                            = "app-d-uks-principalitywebsite"
mainsite-serviceplan_zone_balancing_enabled  = false

#Variables for Admin Application Site
adminsite-serviceplan_sku                    = "P1v3"
adminsite-serviceplan_name                   = "splan-d-uks-principalitywebsitecms"
adminsite-serviceplan_os                     = "Windows"
adminsite-app_name                           = "app-d-uks-principalitywebsitecms"
adminsite-serviceplan_zone_balancing_enabled = false

#Variable set for azurerm_mssql_server
mssql_server_name                            = "sql-d-uks-kenticoxp-db"
mssql_server_version                         = "12.0"
mssql_server_administrator                   = "pbs-admin"
mssql_server_password                        = ""

#Variable set for azurerm_mssql_database
mssql_database_name                          = "ExperienceDB"
mssql_database_collation                     = "SQL_Latin1_General_CP1_CI_AS"
mssql_database_license                       = "LicenseIncluded"
mssql_database_max_size_gb                   = 10
mssql_database_read_scale                    = false
mssql_database_sku_name                      = "S3"
mssql_database_zone_redundant                = false
mssql_database_enclave_type                  = "VBS"

#Search Instance Configuration
search_service_name                          = "as-d-uks-kenticoxp-search"
search_service_sku                           = "standard"
search_service_public_network_access_enabled = true

#Network Configuration (data resource)
subnet_name                                  = "snet-d-uks-app-kentico"
virtual_network_name                         = "vnet-d-uks-public"
network_resource_group                       = "rg-d-uks-vnet"
#Web Application Firewall Configuration (Main Site)
webmain_ip_address_default_action            = "Allow"
webmain_ip_restriction_action                = "Allow"
webmain_ip_restriction_ip_address            = "0.0.0.0/0"
webmain_ip_restriction_priority              = 100
webmain_ip_restriction_name                  = "AllowAll" 

#Front Door Lockdown (Main Site)
mainsite_enable_frontdoor_lockdown           = false
mainsite_frontdoor_resource_guid             = null
mainsite_dr_bypass_ip_addresses              = []

#Web Application Firewall Configuration (Admin Site)
webadmin_ip_address_default_action           = "Deny"
webadmin_ip_restriction_action               = "Allow"
webadmin_ip_restriction_ip_address           = "10.0.0.0/8"
webadmin_ip_restriction_priority             = 100
webadmin_ip_restriction_name                 = "Allow Internal Network Access" 
