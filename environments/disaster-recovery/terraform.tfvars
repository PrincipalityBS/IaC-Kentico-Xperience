#Global Variables
primary_subscription_id                      = "a4c09b29-6220-4c6b-b497-85ab8d04f636"
tags = {
    Environment       = "production-dr"
    Application       = "Kentico Xperience"
    WorkloadName      = "Kentico Xperience Application Infrastructure"
    CostCentre        = "1512"
    Provisioner       = "Terraform"
    Owner             = "IT Infrastructure"
    BusinessUnit      = "IT"
    Criticality       = "Level 1 - Critical"
}

#Resource Group Variables
resource_group_name                          = "rg-p-ukw-kenticoxp"

#Managed Identity
managed_identity_name                        = "id-p-ukw-kenticoxp"

#Storage Account (Kentico Blob Storage)
# storage_account_name must be globally unique, 3-24 lowercase alphanumeric chars — update before applying
storage_account_name                         = "stpkxpukw"
storage_replication_type                     = "LRS"
storage_container_name                       = "cmsstorage"
location                                     = "ukwest"

#Variables for main Application Site
mainsite-serviceplan_sku                     = "P1v3"
mainsite-serviceplan_name                    = "splan-p-ukw-principalitywebsite"
mainsite-serviceplan_os                      = "Windows"
mainsite-app_name                            = "app-p-ukw-principalitywebsite"
mainsite-serviceplan_zone_balancing_enabled  = false

#Variables for Admin Application Site
adminsite-serviceplan_sku                    = "P1v3"
adminsite-serviceplan_name                   = "splan-p-ukw-principalitywebsitecms"
adminsite-serviceplan_os                     = "Windows"
adminsite-app_name                           = "app-p-ukw-principalitywebsitecms"
adminsite-serviceplan_zone_balancing_enabled = false

#Variable set for azurerm_mssql_server
mssql_server_name                            = "sql-p-ukw-kenticoxp-db"
mssql_server_version                         = "12.0"
mssql_server_administrator                   = "pbs-admin"
mssql_server_password                        = ""

#Network Configuration (data resource)
subnet_name                                  = "snet-p-ukw-app-kentico"
virtual_network_name                         = "vnet-p-ukw-public"
network_resource_group                       = "rg-p-ukw-vnet"
#Web Application Firewall Configuration (Main Site)
webmain_ip_address_default_action            = "Allow"
webmain_ip_restriction_action                = "Allow"
webmain_ip_restriction_ip_address            = "0.0.0.0/0"
webmain_ip_restriction_priority              = 100
webmain_ip_restriction_name                  = "AllowAll" 

#Front Door Lockdown (Main Site)
# Set enable to true and supply frontdoor_resource_guid (from azurerm_cdn_frontdoor_profile.resource_guid) once Front Door is deployed
mainsite_enable_frontdoor_lockdown           = false
mainsite_frontdoor_resource_guid             = null
mainsite_dr_bypass_ip_addresses              = []

#Web Application Firewall Configuration (Admin Site)
webadmin_ip_address_default_action           = "Deny"
webadmin_ip_restriction_action               = "Allow"
webadmin_ip_restriction_ip_address           = "10.0.0.0/8"
webadmin_ip_restriction_priority             = 100
webadmin_ip_restriction_name                 = "Allow Internal Network Access" 