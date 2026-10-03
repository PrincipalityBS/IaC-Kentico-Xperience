terraform {
  backend "azurerm" {
    resource_group_name  = "rg-p-tf-c-inf"
    storage_account_name = "stkenticoxptfcinf"
    container_name       = "terraformstate"
    key                  = "iac-kenticoxp/disaster-recovery.tfstate"
    subscription_id      = "cb2ca086-161f-4ae5-bf65-ffbc4a3693e7"
    tenant_id            = "83c9b2db-2a15-4eed-8c33-618567b8e797"
  }
}
