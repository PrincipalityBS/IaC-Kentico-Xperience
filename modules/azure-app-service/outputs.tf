output "default_hostname" {
  description = "Default hostname of the Windows web app"
  value = azurerm_windows_web_app.main.default_hostname
}