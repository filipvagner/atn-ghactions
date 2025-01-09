## Code Explenation
### Azure SQL Database Deployment
Server for DB is specified in file *03-locals* using module *caf* in file *01-main*.

To deploy Azure DB (PaaS) has been used single resource in file *04-resources* section *#region PaaS SQL*, because it is requiring input of *var.server_id* which is not possible to reference *caf* module, because it is causing *Terraform Cycle error*.

Using *Azure Verified Module* https://registry.terraform.io/modules/Azure/avm-res-sql-server/azurerm/latest?tab=dependencies was causing conflict of *Terraform* providers.

### AI Services Deployment
#### Cognitive Account
- Azure OpenAI Service
- Document Inteligence

Using *Azure Verified Module* https://registry.terraform.io/modules/Azure/avm-res-cognitiveservices-account/azurerm/0.4.0?tab=inputs was causing conflict of *Terraform* providers.

### Azure AI Services
Azure AI services has standalone resource, which is available since *AzureRM* provider version *3.116.0* https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/resources/ai_services which is not used in current configuration (for *aztfmod* compatibility).

Instead, it is used *aztfmod* module, using resource *cognitive_services_account*.