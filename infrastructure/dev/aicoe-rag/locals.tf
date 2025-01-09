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
    rg_rag = {
      name = "${module.naming.resource_group.name}-aicoe-rag"
      tags = {
      }
    }
    rg_rag_uc04 = {
      name = "${module.naming.resource_group.name}-aicoe-rag-uc04"
      tags = {
      }
    }
    rg_rag_branch = {
      name = "${module.naming.resource_group.name}-aicoe-rag-branch"
      tags = {
      }
    }
    rg_rag_uc50 = {
      name = "${module.naming.resource_group.name}-aicoe-rag-uc50"
      tags = {
      }
    }
    rg_rag_uc62 = {
      name = "${module.naming.resource_group.name}-aicoe-rag-uc62"
      tags = {
      }
    }
    rg_aiportal = {
      name = "${module.naming.resource_group.name}-aicoe-aiportal"
      tags = {
      }
    }
    rg_aiportal_gptwrapper = {
      name = "${module.naming.resource_group.name}-aicoe-aiportal-gptwrapper"
      tags = {
      }
    }
    rg_aiportal_web = {
      name = "${module.naming.resource_group.name}-aicoe-aiportal-web"
      tags = {
      }
    }
    rg_aiportal_digitalization = {
      name = "${module.naming.resource_group.name}-aicoe-aiportal-digitalization"
      tags = {
      }
    }
    rg_aiportal_raiaevaluation = {
      name = "${module.naming.resource_group.name}-aicoe-aiportal-raiaevaluation"
      tags = {
      }
    }
    rg_aiportal_translator = {
      name = "${module.naming.resource_group.name}-aicoe-aiportal-translator"
      tags = {
      }
    }
  }

  storage_accounts = {
    st_rag = {
      name                          = "${module.naming.storage_account.name}rag"
      resource_group_key            = "rg_rag"
      account_kind                  = "StorageV2"
      access_tier                   = "Hot"
      account_tier                  = "Standard"
      account_replication_type      = "ZRS"
      allow_blob_public_access      = false
      public_network_access_enabled = true
      network = {
        bypass   = []
        ip_rules = []
        subnets = {
        }
      }
      containers = {
      }
    }
    st_rag_uc50 = {
      name                          = "${module.naming.storage_account.name}uc50"
      resource_group_key            = "rg_rag_uc50"
      account_kind                  = "StorageV2"
      access_tier                   = "Hot"
      account_tier                  = "Standard"
      account_replication_type      = "LRS"
      allow_blob_public_access      = false
      public_network_access_enabled = true
      network = {
        bypass   = []
        ip_rules = []
        subnets = {
        }
      }
      containers = {
      }
    }
    st_rag_uc62 = {
      name                          = "${module.naming.storage_account.name}uc62"
      resource_group_key            = "rg_rag_uc62"
      account_kind                  = "StorageV2"
      access_tier                   = "Hot"
      account_tier                  = "Standard"
      account_replication_type      = "LRS"
      allow_blob_public_access      = false
      public_network_access_enabled = true
      network = {
        bypass   = []
        ip_rules = []
        subnets = {
        }
      }
      containers = {
      }
    }
  }

  log_analytics = {
    log_apim = {
      name               = "${module.naming.log_analytics_workspace.name}-apim"
      resource_group_key = "rg_apim"
      retention_in_days  = 30
    }
    log_rag = {
      name               = "${module.naming.log_analytics_workspace.name}-rag"
      resource_group_key = "rg_rag"
      retention_in_days  = 30
    }
  }

  webapp = {
    azurerm_application_insights = {
      appi_apim = {
        name               = "${module.naming.application_insights.name}-apim"
        resource_group_key = "rg_apim"
        application_type   = "other"
        log_analytics_workspace = {
          key = "log_apim"
        }
      }
      appi_rag_uc04 = {
        name               = "${module.naming.application_insights.name}-uc04"
        resource_group_key = "rg_rag_uc04"
        application_type   = "other"
        log_analytics_workspace = {
          key = "log_rag"
        }
      }
      appi_rag_branch = {
        name               = "${module.naming.application_insights.name}-branch"
        resource_group_key = "rg_rag_branch"
        application_type   = "other"
        log_analytics_workspace = {
          key = "log_rag"
        }
      }
      appi_rag_uc50 = {
        name               = "${module.naming.application_insights.name}-uc50"
        resource_group_key = "rg_rag_uc50"
        application_type   = "other"
        log_analytics_workspace = {
          key = "log_rag"
        }
      }
      appi_rag_uc62 = {
        name               = "${module.naming.application_insights.name}-uc62"
        resource_group_key = "rg_rag_uc62"
        application_type   = "other"
        log_analytics_workspace = {
          key = "log_rag"
        }
      }
    }
  }

  keyvaults = {
    kv_apim = {
      name                        = "${module.naming.key_vault.name}-apim"
      resource_group_key          = "rg_apim"
      sku_name                    = "standard"
      soft_delete_enabled         = false
      purge_protection_enabled    = false
      enabled_for_disk_encryption = false
      enabled_for_deployment      = false
      enable_rbac_authorization   = true

      creation_policies = {
        logged_in_user = {
          secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
          certificate_permissions = ["ManageContacts", "ManageIssuers"]
        }
      }
    }
    kv_rag = {
      name                        = "${module.naming.key_vault.name}-rag"
      resource_group_key          = "rg_rag"
      sku_name                    = "standard"
      soft_delete_enabled         = false
      purge_protection_enabled    = false
      enabled_for_disk_encryption = false
      enabled_for_deployment      = false
      enable_rbac_authorization   = true

      creation_policies = {
        logged_in_user = {
          secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
          certificate_permissions = ["ManageContacts", "ManageIssuers"]
        }
      }
    }
  }

  database = {
    mssql_servers = {
      sql_rag = {
        name                = "${module.naming.mssql_server.name}-rag"
        resource_group_key  = "rg_rag"
        administrator_login = "sqladmin"
        keyvault_key        = "kv_rag"
      }
    }
    # mssql_databases = {
    #   sqldb_rag = {
    #     name               = "${module.naming.mssql_database.name}-rag"
    #     server_id         = "/subscriptions/018805fe-880b-417d-bf6b-6eccfbefac5a/resourceGroups/rg-rbcz-aicoe-rag/providers/Microsoft.Sql/servers/sql-rbcz-rag"
    #     // server_name         = module.caf.mssql_servers.sqldb_rag.name
    #     sku_name            = "S1"
    #     max_size_gb         = 50
    #     collation          = "SQL_Latin1_General_CP1_CI_AS"
    #   }
    # }
  }

  apim = {
    api_management = {
      apim_apim = {
        name               = "${module.naming.api_management.name}-fva-apim"
        resource_group_key = "rg_apim"
        publisher_name     = "Personal"
        publisher_email    = "filip.vagner@orbit.cz"
        sku_name           = "Developer_1"
        identity = {
          type = "SystemAssigned"
        }
        #   virtual_network_type = "Internal"
        #   virtual_network_configuration = {
        #     vnet_key   = "example_vnet"
        #     subnet_key = "example_subnet_key"
        #   }
      }
    }
  }

  app_service_plans = {
    # "${module.naming.app_service_plan.name}-rag" = {
    #   location               = local.global_settings.regions["primary_region"]
    #   resource_group_name    = module.caf.resource_groups.rg_rag.name
    #   os_type                = "Linux"
    #   sku_name               = "P1v3"
    #   zone_balancing_enabled = true
    # }
  }

  web_apps = {
    #     "${module.naming.app_service.name}-uc04" = {
    #       location                    = local.global_settings.regions["primary_region"]
    #       resource_group_name         = module.caf.resource_groups.rg_rag_uc04.name
    #       service_plan_resource_id    = module.plan["${module.naming.app_service_plan.name}-rag"].resource_id
    #       os_type                     = "Linux"
    #       kind                        = "webapp"
    #       builtin_logging_enabled     = true
    #       client_affinity_enabled     = false
    #       https_only                  = true
    #       enable_application_insights = false
    #       app_settings = {
    #         "APPINSIGHTS_INSTRUMENTATIONKEY"                  = module.caf.application_insights.appi_rag_uc04.instrumentation_key
    #         "APPLICATIONINSIGHTS_CONNECTION_STRING"           = module.caf.application_insights.appi_rag_uc04.connection_string
    #         "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
    #         "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
    #         "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3"
    #         "DiagnosticServices_EXTENSION_VERSION"            = "~3"
    #         "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    #         "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    #         "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    #         "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
    #         "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
    #       }
    #       sticky_settings = {
    #         sticky_settings = {
    #           app_setting_names = [
    #             "APPINSIGHTS_INSTRUMENTATIONKEY",
    #             "APPLICATIONINSIGHTS_CONNECTION_STRING ",
    #             "APPINSIGHTS_PROFILERFEATURE_VERSION",
    #             "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
    #             "ApplicationInsightsAgent_EXTENSION_VERSION",
    #             "XDT_MicrosoftApplicationInsights_BaseExtensions",
    #             "DiagnosticServices_EXTENSION_VERSION",
    #             "InstrumentationEngine_EXTENSION_VERSION",
    #             "SnapshotDebugger_EXTENSION_VERSION",
    #             "XDT_MicrosoftApplicationInsights_Mode",
    #             "XDT_MicrosoftApplicationInsights_PreemptSdk",
    #             "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
    #             "XDT_MicrosoftApplicationInsightsJava",
    #             "XDT_MicrosoftApplicationInsights_NodeJS",
    #           ]
    #           //connection_string_names = []
    #         }
    #       }
    #       site_config = {
    #         application_stack = {
    #           node = {
    #             node_version       = "20-lts"
    #             use_custom_runtime = false
    #           }
    #         }
    #       }
    #     }
    #     "${module.naming.app_service.name}-branch" = {
    #       location                    = local.global_settings.regions["primary_region"]
    #       resource_group_name         = module.caf.resource_groups.rg_rag_branch.name
    #       service_plan_resource_id    = module.plan["${module.naming.app_service_plan.name}-rag"].resource_id
    #       os_type                     = "Linux"
    #       kind                        = "webapp"
    #       builtin_logging_enabled     = true
    #       client_affinity_enabled     = false
    #       https_only                  = true
    #       enable_application_insights = false
    #       app_settings = {
    #         "APPINSIGHTS_INSTRUMENTATIONKEY"                  = module.caf.application_insights.appi_rag_branch.instrumentation_key
    #         "APPLICATIONINSIGHTS_CONNECTION_STRING"           = module.caf.application_insights.appi_rag_branch.connection_string
    #         "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
    #         "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
    #         "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3"
    #         "DiagnosticServices_EXTENSION_VERSION"            = "~3"
    #         "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    #         "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    #         "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    #         "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
    #         "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
    #       }
    #       sticky_settings = {
    #         sticky_settings = {
    #           app_setting_names = [
    #             "APPINSIGHTS_INSTRUMENTATIONKEY",
    #             "APPLICATIONINSIGHTS_CONNECTION_STRING ",
    #             "APPINSIGHTS_PROFILERFEATURE_VERSION",
    #             "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
    #             "ApplicationInsightsAgent_EXTENSION_VERSION",
    #             "XDT_MicrosoftApplicationInsights_BaseExtensions",
    #             "DiagnosticServices_EXTENSION_VERSION",
    #             "InstrumentationEngine_EXTENSION_VERSION",
    #             "SnapshotDebugger_EXTENSION_VERSION",
    #             "XDT_MicrosoftApplicationInsights_Mode",
    #             "XDT_MicrosoftApplicationInsights_PreemptSdk",
    #             "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
    #             "XDT_MicrosoftApplicationInsightsJava",
    #             "XDT_MicrosoftApplicationInsights_NodeJS",
    #           ]
    #           //connection_string_names = []
    #         }
    #       }
    #       site_config = {
    #         application_stack = {
    #           node = {
    #             node_version       = "20-lts"
    #             use_custom_runtime = false
    #           }
    #         }
    #       }
    #     }
  }

  func_apps = {
    #     "${module.naming.function_app.name}-uc50" = {
    #       location                                       = local.global_settings.regions["primary_region"]
    #       resource_group_name                            = module.caf.resource_groups.rg_rag_uc50.name
    #       service_plan_resource_id                       = module.plan["${module.naming.app_service_plan.name}-rag"].resource_id
    #       os_type                                        = "Linux"
    #       kind                                           = "functionapp"
    #       storage_account_name                           = module.caf.storage_accounts.st_rag_uc50.name
    #       storage_account_access_key                     = module.caf.storage_accounts.st_rag_uc50.primary_access_key
    #       builtin_logging_enabled                        = true
    #       client_affinity_enabled                        = false
    #       client_certificate_mode                        = "Optional"
    #       ftp_publish_basic_authentication_enabled       = false
    #       https_only                                     = true
    #       webdeploy_publish_basic_authentication_enabled = true
    #       create_service_plan                            = true
    #       enable_application_insights                    = false
    #       all_child_resources_inherit_tags               = true
    #       app_settings = {
    #         "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
    #         "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
    #         "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3"
    #         "DiagnosticServices_EXTENSION_VERSION"            = "~3"
    #         "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    #         "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    #         "WEBSITE_RUN_FROM_PACKAGE"                        = "1"
    #         "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    #         "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
    #         "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
    #       }

    #       sticky_settings = {
    #         sticky_settings = {
    #           app_setting_names = [
    #             "APPINSIGHTS_INSTRUMENTATIONKEY",
    #             "APPINSIGHTS_PROFILERFEATURE_VERSION",
    #             "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
    #             "ApplicationInsightsAgent_EXTENSION_VERSION",
    #             "DiagnosticServices_EXTENSION_VERSION",
    #             "InstrumentationEngine_EXTENSION_VERSION",
    #             "SnapshotDebugger_EXTENSION_VERSION",
    #             "XDT_MicrosoftApplicationInsights_BaseExtensions",
    #             "XDT_MicrosoftApplicationInsights_Mode",
    #             "XDT_MicrosoftApplicationInsights_PreemptSdk",
    #             "APPLICATIONINSIGHTS_CONNECTION_STRING ",
    #             "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
    #             "XDT_MicrosoftApplicationInsightsJava",
    #             "XDT_MicrosoftApplicationInsights_NodeJS",
    #           ]
    #         }
    #       }

    #       site_config = {
    #         always_on                              = true
    #         application_insights_connection_string = module.caf.application_insights.appi_rag_uc50.connection_string
    #         application_insights_key               = module.caf.application_insights.appi_rag_uc50.instrumentation_key

    #         application_stack = {
    #           node_version = {
    #             node_version       = "20"
    #             use_custom_runtime = false
    #           }
    #         }
    #       }
    #     }
    #     "${module.naming.function_app.name}-uc62" = {
    #       location                                       = local.global_settings.regions["primary_region"]
    #       resource_group_name                            = module.caf.resource_groups.rg_rag_uc62.name
    #       service_plan_resource_id                       = module.plan["${module.naming.app_service_plan.name}-rag"].resource_id
    #       os_type                                        = "Linux"
    #       kind                                           = "functionapp"
    #       storage_account_name                           = module.caf.storage_accounts.st_rag_uc62.name
    #       storage_account_access_key                     = module.caf.storage_accounts.st_rag_uc62.primary_access_key
    #       builtin_logging_enabled                        = true
    #       client_affinity_enabled                        = false
    #       client_certificate_mode                        = "Optional"
    #       ftp_publish_basic_authentication_enabled       = false
    #       https_only                                     = true
    #       webdeploy_publish_basic_authentication_enabled = true
    #       create_service_plan                            = true
    #       enable_application_insights                    = false
    #       all_child_resources_inherit_tags               = true
    #       app_settings = {
    #         "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
    #         "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
    #         "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3"
    #         "DiagnosticServices_EXTENSION_VERSION"            = "~3"
    #         "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    #         "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    #         "WEBSITE_RUN_FROM_PACKAGE"                        = "1"
    #         "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    #         "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
    #         "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
    #       }

    #       sticky_settings = {
    #         sticky_settings = {
    #           app_setting_names = [
    #             "APPINSIGHTS_INSTRUMENTATIONKEY",
    #             "APPINSIGHTS_PROFILERFEATURE_VERSION",
    #             "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
    #             "ApplicationInsightsAgent_EXTENSION_VERSION",
    #             "DiagnosticServices_EXTENSION_VERSION",
    #             "InstrumentationEngine_EXTENSION_VERSION",
    #             "SnapshotDebugger_EXTENSION_VERSION",
    #             "XDT_MicrosoftApplicationInsights_BaseExtensions",
    #             "XDT_MicrosoftApplicationInsights_Mode",
    #             "XDT_MicrosoftApplicationInsights_PreemptSdk",
    #             "APPLICATIONINSIGHTS_CONNECTION_STRING ",
    #             "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
    #             "XDT_MicrosoftApplicationInsightsJava",
    #             "XDT_MicrosoftApplicationInsights_NodeJS",
    #           ]
    #         }
    #       }

    #       site_config = {
    #         always_on                              = true
    #         application_insights_connection_string = module.caf.application_insights.appi_rag_uc62.connection_string
    #         application_insights_key               = module.caf.application_insights.appi_rag_uc62.instrumentation_key

    #         application_stack = {
    #           node_version = {
    #             node_version       = "20"
    #             use_custom_runtime = false
    #           }
    #         }
    #       }
    #     }
  }

  paas_mssqls = {
    "${module.naming.mssql_server.name}-rag" = {
      location               = local.global_settings.regions["primary_region"]
      resource_group_name    = module.caf.resource_groups.rg_rag.name
      version                = "12.0"
      administrator_login    = "sqladmin"
      administrator_login_pw = "P@ssw0rd1234" #FIXME change to random password generation
      databases = {
        sample_db = {
          name         = "${module.naming.mssql_database.name}-rag"
          create_mode  = "Default"
          collation    = "SQL_Latin1_General_CP1_CI_AS"
          license_type = "LicenseIncluded"
          max_size_gb  = 50
          #sku_name     = "S0" #FIXME this is not possible to configure as S1 in current module

          short_term_retention_policy = {
            retention_days           = 1
            backup_interval_in_hours = 24
          }

          long_term_retention_policy = {
            weekly_retention  = "P2W1D"
            monthly_retention = "P2M"
            yearly_retention  = "P1Y"
            week_of_year      = 1
          }
        }
      }
    }
  }

  cognitive_services = {
    cognitive_services_account = {
      oai_rag = {
        resource_group_key                 = "rg_rag"
        region                             = "ai_region"
        name                               = "oai-${module.naming.cognitive_account.name}-rag"
        kind                               = "OpenAI"
        sku_name                           = "S0"
        dynamic_throttling_enabled         = false
        local_auth_enabled                 = true
        custom_subdomain_name              = "oai-${module.naming.cognitive_account.name}-rag"
        public_network_access_enabled      = true
        outbound_network_access_restricted = false
        tags = {
          Acceptance = "Test"
        }
        network_acls = {
          default_action = "Allow"
          ip_rules       = []
        }
        identity = {
          type = "SystemAssigned"
        }
      }
      di_rag = {
        resource_group_key                 = "rg_rag"
        region                             = "ai_region"
        name                               = "di-${module.naming.cognitive_account.name}-rag"
        kind                               = "FormRecognizer"
        sku_name                           = "F0"
        dynamic_throttling_enabled         = false
        local_auth_enabled                 = true
        custom_subdomain_name              = "di-${module.naming.cognitive_account.name}-rag"
        public_network_access_enabled      = true
        outbound_network_access_restricted = false
        tags = {
          Acceptance = "Test"
        }
        network_acls = {
          default_action = "Allow"
          ip_rules       = []
        }
        identity = {
          type = "SystemAssigned"
        }
      }
      ais_rag_branch = {
        resource_group_key                 = "rg_rag_branch"
        region                             = "ai_region"
        name                               = "ais-${module.naming.cognitive_account.name}-rag-branch"
        kind                               = "CognitiveServices"
        sku_name                           = "S0"
        dynamic_throttling_enabled         = false
        local_auth_enabled                 = true
        custom_subdomain_name              = "ais-${module.naming.cognitive_account.name}-rag-branch"
        public_network_access_enabled      = true
        outbound_network_access_restricted = false
        tags = {
          Acceptance = "Test"
        }
        network_acls = {
          default_action = "Allow"
          ip_rules       = []
        }
        identity = {
          type = "SystemAssigned"
        }
      }
    }
  }

  search_services = {
    search_services = {
      srch_rag = {
        name                                     = "srch-${module.naming.search_service.name}-rag"
        resource_group_key                       = "rg_rag"
        region                                   = "ai_region"
        sku                                      = "basic"
        allowed_ips                              = []
        authentication_failure_mode              = null
        customer_managed_key_enforcement_enabled = false
        hosting_mode                             = "default"
        local_authentication_enabled             = true
        partition_count                          = 1
        public_network_access_enabled            = true
        replica_count                            = 1
        identity = {
          type = "SystemAssigned"
        }
      }
    }
  }
}