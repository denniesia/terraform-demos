variable "resource_group_name" {
  description = ""
  type        = string
}

variable "location" {
  default = ""
  type    = string
}

variable "app_service_plan_name" {
  description = "value"
  type        = string

}

variable "app_service_name" {
  description = "value"
  type        = string

}

variable "sql_server_name" {
  description = "value"
  type        = string

}

variable "sql_database_name" {
  description = "value"
  type        = string
}

variable "sql_admin_name" {
  description = "value"
  type        = string

}

variable "sql_admin_password" {
  description = "value"
  type        = string
}

variable "firewall_rule_name" {
  description = "value"
  type        = string
}