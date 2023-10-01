#
variable "identifier" {
  type = string
}

variable "environment" {
  type = string
}

variable "application" {
  type = string
}

variable "location" {
  type = string
}

variable "iteration" {
  type = string
}

variable "application_owner" {
  type = string
}

variable "deployment_source" {
  type = string
}

variable "tags" {
  type = map
}

variable "vsts_configuration" {
  type = object({
    vsts_account_name     = string
    vsts_branch_name      = string
    vsts_project_name     = string
    vsts_repository_name  = string
    vsts_root_folder      = string
    tenant_id             = string
  })
  default = null
}

variable "tenant_id" {
  type = string
}

variable "synapse-sqlpool-sku" {
  type = string
}

variable "sql_threat_detection_state" {
  type = string
}

variable "sql_threat_detection_rentention" {
  type = string
}

variable "sql_threat_detection_email" {
  type = string
}

variable "storage_account_type" {
  type = string
}

variable "storage_account_tier" {
  type = string
}

variable "storage_min_tls_version" {
  type = string
}

variable "storage_allow_blob_public_access" {
  type = string
}

variable "storage_account_kind" {
  type = string
}

variable "synapse-sqlpool-createmode" {
  type = string
}

variable "adf-public_network_enabled" {
  type = string
}

variable "vnet_address_space" {
  type = list
}

variable "vnet_address_space_sub_pvl" {
  type = list
}


