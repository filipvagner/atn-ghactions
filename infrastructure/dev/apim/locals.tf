locals {
  subscription_id = "638c6283-9805-468e-b517-2e5d8717e23a" # tflearn

  global_settings = {
    passthrough    = true
    default_region = "primary_region"
    inherit_tags   = true
    regions = {
      primary_region = "centralus"
      ai_region      = "southcentralus"
    }
    tags = {
      "WorkloadName" = "AZ LI"
      "Control" : "Terraform",
      "CreatedBy" : "filip.vagner@hotmail.com",
      "Deployment Information" : "IaC"
    }
  }

  role_mapping = {
  }

  resource_groups = {
    rg_apim = {
      name = "${module.naming.resource_group.name}-apim"
      tags = {
      }
    }
  }

  log_analytics = {
    # log_apim = {
    #   name               = "${module.naming.log_analytics_workspace.name}-apim"
    #   resource_group_key = "rg_apim"
    #   retention_in_days  = 30
    # }
  }

  webapp = {
    # azurerm_application_insights = {
    #   appi_apim = {
    #     name               = "${module.naming.application_insights.name}-apim"
    #     resource_group_key = "rg_apim"
    #     application_type   = "other"
    #     log_analytics_workspace = {
    #       key = "log_apim"
    #     }
    #   }
    # }
  }

  keyvaults = {
    # kv_apim = {
    #   name                        = "${module.naming.key_vault.name}-apim"
    #   resource_group_key          = "rg_apim"
    #   sku_name                    = "standard"
    #   soft_delete_enabled         = false
    #   purge_protection_enabled    = false
    #   enabled_for_disk_encryption = false
    #   enabled_for_deployment      = false
    #   enable_rbac_authorization   = true

    #   creation_policies = {
    #     logged_in_user = {
    #       secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
    #       certificate_permissions = ["ManageContacts", "ManageIssuers"]
    #     }
    #   }
    # }
  }

  apim = {
    # api_management = {
    #   apim_apim = {
    #     name               = "${module.naming.api_management.name}-fva-apim"
    #     resource_group_key = "rg_apim"
    #     publisher_name     = "Personal"
    #     publisher_email    = "filip.vagner@orbit.cz"
    #     sku_name           = "Developer_1"
    #     identity = {
    #       type = "SystemAssigned"
    #     }
    #     #   virtual_network_type = "Internal"
    #     #   virtual_network_configuration = {
    #     #     vnet_key   = "example_vnet"
    #     #     subnet_key = "example_subnet_key"
    #     #   }
    #   }
    # }
  }
}