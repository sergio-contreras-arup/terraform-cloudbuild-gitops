Write-Host "🔧 Paso 1: Eliminando conexión de service networking y rango reservado..."
terraform destroy `
  -target=google_service_networking_connection.private_vpc_connection `
  -target=google_compute_global_address.private_ip_alloc `
  -auto-approve

Write-Host "✅ Paso 1 completado."

Write-Host "🧹 Paso 2: Eliminando el resto de la infraestructura..."
terraform destroy -auto-approve

Write-Host "✅ Infraestructura eliminada por completo."
