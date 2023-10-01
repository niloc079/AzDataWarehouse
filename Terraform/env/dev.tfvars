#START
identifier                     = ""                 #Org name, Location
environment                    = "dev"          #Hub, Prd, Stg, Dev, Tst, Idp
application                    = "dw"          #net, app, ads
iteration                      = ""             #Numeric
location                       = "centralus"    #Azure Location
application_owner              = "Mark Brendanawicz"
deployment_source              = "terraform"
# Azure Tags
tags =  {
identifier                     = ""                 #Org name, Location
environment                    = "dev"          #Hub, Prd, Stg, Dev, Tst, Idp
application                    = "dw"          #net, app, ads
iteration                      = ""             #Numeric
location                       = "centralus"    #Azure Location
application_owner              = "Mark Brendanawicz"
deployment_source              = "terraform"
}
# ADF and Azure DevOps
#Comment non-Dev/Starting Environments
vsts_configuration = {
        vsts_account_name           = "azdo" 
        vsts_branch_name            = "ADF" 
        vsts_project_name           = "DW" 
        vsts_repository_name        = "ADF" 
        vsts_root_folder            = "/ADF"
        tenant_id                   = "?Tenant ID?"
    }
#Configuration
tenant_id                           = "?Tenant ID?"
vnet_address_space                  = ["10.221.0.0/16"]
vnet_address_space_sub_pvl          = ["10.221.0.0/24"]
synapse-sqlpool-sku                 = "DW100c"
synapse-sqlpool-createmode          = "Default"
storage_account_type                = "RAGRS"
storage_account_tier                = "Standard"
storage_min_tls_version             = "TLS1_2"
storage_account_kind                = "StorageV2"
storage_allow_blob_public_access    = false
adf-public_network_enabled          = false
sql_threat_detection_state          = "Enabled"
sql_threat_detection_rentention     = "90"
sql_threat_detection_email          = true
# END