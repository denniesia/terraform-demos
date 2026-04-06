output "web_app_fqdn" {
  description = "value"
  value = azurerm_linux_web_app.alwa.default_hostname
}

output "ip_addres" {
  description = "value"
  value = azurerm_linux_web_app.alwa.outbound_ip_addresses
}