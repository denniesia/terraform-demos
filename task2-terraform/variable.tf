variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "location" {
  description = "The location in which to create the resources."
  type        = string

}

variable "service_plan_name" {
  description = "The name of the service plan to create."
  type        = string

}

variable "web_app_name" {
  description = "The name of the web app to create."
  type        = string

}

variable "sql_server_name" {
  description = "The name of the SQL server to create."
  type        = string

}

variable "sql_database_name" {
  description = "The name of the SQL database to create."
  type        = string

}

variable "sql_admin_username" {
  description = "The administrator username for the SQL server."
  type        = string

}

variable "sql_admin_password" {
  description = "The administrator password for the SQL server."
  type        = string
  sensitive   = true

}

variable "firewall_rule" {
  description = "value"
  type        = string
}

variable "github_repo_url" {
  description = "value"
  type        = string
}