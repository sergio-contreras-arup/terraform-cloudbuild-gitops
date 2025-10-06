# Infraestructura del Simulador Estratégico del PGOUM

Este repositorio contiene la **infraestructura como código (IaC)** para el **Simulador Estratégico del PGOUM**, definida con **Terraform**, organizada por entornos (`des`, `pre`, `pro`) y utilizando módulos reutilizables que encapsulan los recursos comunes.

## Estructura del repositorio

```
.
├── environments
│   ├── des
│   │   ├── destroy_infra.ps1
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   ├── terraform.tfvars
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── ...
├── modules
│   └── cloudsql_postgres
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── scripts
│   └── destroy_infra.ps1
├── .gitignore
├── cloudbuild.yaml
└── README.md
```

## Descripción general

- **`modules/`**: Contiene módulos reutilizables con recursos compartidos entre entornos. Por ejemplo, el módulo `cloudsql_postgres` define una instancia de Cloud SQL PostgreSQL.
- **`environments/{entorno}`**: Define la infraestructura específica de cada entorno (`desarrollo`, `preproducción`, `producción`) con sus configuraciones, variables y recursos.
- **`cloudbuild.yaml`**: Archivo de configuración para el pipeline de CI/CD con Google Cloud Build. Automatiza la ejecución de los comandos `terraform init`, `plan` y `apply`.

## Requisitos previos

Antes de desplegar la infraestructura, asegúrate de cumplir con los siguientes requisitos:

- Tener [Terraform ≥ 1.0](https://www.terraform.io/downloads) instalado.
- Disponer de una cuenta de GCP con permisos suficientes para crear recursos.
- Tener instalada la [gcloud CLI](https://cloud.google.com/sdk/docs/install).

### ⚠️ Creación del bucket para el estado remoto de Terraform

Antes de ejecutar cualquier despliegue, es **necesario crear manualmente un bucket en Google Cloud Storage** que permita almacenar el estado remoto de Terraform.

Ejemplo de comando para crear el bucket:

```bash
gsutil mb -p [PROJECT_ID] -l [REGION] -c standard gs://[BUCKET_NAME]
```

Asegúrate de que el bucket tenga habilitado el versionado si deseas realizar rollback de estados anteriores:

```bash
gsutil versioning set on gs://[BUCKET_NAME]
```

El nombre y la configuración del bucket deben coincidir con lo definido en los bloques `backend` de cada entorno.

## Uso

Cada entorno contiene su propio archivo `terraform.tfvars`, donde se definen valores específicos. Estos sobrescriben los valores por defecto definidos en `variables.tf`.

### Ejemplo básico de despliegue

```bash
cd environments/des
terraform init
terraform plan
terraform apply
```

## CI/CD con Cloud Build

El repositorio está integrado con un pipeline definido en `cloudbuild.yaml` que permite desplegar automáticamente la infraestructura en GCP por entorno. El pipeline incluye pasos para:

- Validar la sintaxis de los archivos
- Inicializar Terraform
- Planificar y aplicar los cambios

## Destrucción de la infraestructura

Para eliminar completamente todos los recursos desplegados por Terraform (menos la vpc que será necesario eliminar manualmente), puedes ejecutar el siguiente script (requiere PowerShell):

```powershell
.\environments\des\destroy_infra.ps1
```

Este script automatiza el proceso de ejecución de `terraform destroy` para cada entorno. Revisa el contenido del script y adapta los parámetros si es necesario.

## Buenas prácticas implementadas

- Separación clara entre entornos (`des`, `pre`, `pro`)
- Uso de módulos reutilizables
- Gestión explícita de versiones en `versions.tf`
- Outputs definidos para facilitar integraciones
- Estado remoto de Terraform con bucket dedicado