Write-Host "Preparando para eliminar toda la infraestructura en el entorno de desarrollo (des)..."
terraform init

# destruir-sin-vpc.ps1

Write-Host "⛔ Iniciando destrucción controlada (excluyendo la VPC)..." -ForegroundColor Cyan

# Paso 1: Destruir el clúster GKE
Write-Host "Paso 1: Destruyendo GKE..." -ForegroundColor Yellow
terraform destroy "-target=module.gke" -auto-approve
if ($LASTEXITCODE -ne 0) {
    Write-Error "Error al destruir GKE. Abortando."
    exit 1
}

# Paso 2: Destruir instancia de Cloud SQL
Write-Host "Paso 2: Destruyendo Cloud SQL..." -ForegroundColor Yellow
terraform destroy "-target=module.cloudsql_postgres_carto" -auto-approve
if ($LASTEXITCODE -ne 0) {
    Write-Error "Error al destruir Cloud SQL. Abortando."
    exit 1
}

# Paso 3: Destruir Cloud NAT
Write-Host "Paso 3: Destruyendo Cloud NAT..." -ForegroundColor Yellow
terraform destroy "-target=module.cloud_nat_carto" -auto-approve
if ($LASTEXITCODE -ne 0) {
    Write-Error "Error al destruir Cloud NAT. Abortando."
    exit 1
}

# Paso 4: Destruir Subred
Write-Host "Paso 4: Destruyendo Subred..." -ForegroundColor Yellow
terraform destroy "-target=module.subnet_carto" -auto-approve
if ($LASTEXITCODE -ne 0) {
    Write-Error "Error al destruir la subred. Abortando."
    exit 1
}

# Paso 5: Destruir Buckets
Write-Host "Paso 5: Destruyendo buckets de almacenamiento..." -ForegroundColor Yellow
terraform destroy "-target=module.storage_bucket_carto" "-target=module.storage_bucket_pgoum_frontend" -auto-approve
if ($LASTEXITCODE -ne 0) {
    Write-Error "Error al destruir buckets. Abortando."
    exit 1
}

# Paso 6: Destruir Artifact Registry
Write-Host "Paso 6: Destruyendo Artifact Registry..." -ForegroundColor Yellow
terraform destroy "-target=module.artifact_registry_pgoum" -auto-approve
if ($LASTEXITCODE -ne 0) {
    Write-Error "Error al destruir Artifact Registry. Abortando."
    exit 1
}

# Paso 7: (Opcional) APIs habilitadas
Write-Host "Paso 7: Destruyendo APIs (opcional)..." -ForegroundColor Yellow
terraform destroy "-target=module.apis" -auto-approve
if ($LASTEXITCODE -ne 0) {
    Write-Error "Error al destruir APIs. Abortando."
    exit 1
}

Write-Host "✅ Todos los recursos han sido destruidos, excepto la VPC (module.vpc_carto)." -ForegroundColor Green
