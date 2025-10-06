# Terraform Infrastructure Deployment

Este repositorio contiene la infraestructura como código (IaC) definida con **Terraform**, organizada por entornos (`des`,`pre`, `pro`) y utilizando módulos reutilizables para definir los recursos compartidos entre ellos.

## Estructura del repositorio.

```
.
├── environments
│   ├── des
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
├── .gitignore
├── cloudbuild.yaml
└── README.md
```

## Descripción general

- **`modules/`**: Contiene los módulos reutilizables con los recursos compartidos entre diferentes entornos. Por ejemplo, el módulo `cloudsql_postgres` define una instancia de Cloud SQL PostgreSQL que puede ser usada tanto en `dev` como en `pro`.
- **`environments/des` y `environments/{entorno}`**: Contienen la definición específica para cada entorno, como configuraciones, variables y recursos particulares.
- **`cloudbuild.yaml`**: Define el pipeline de CI/CD con Google Cloud Build. Este archivo permite automatizar el despliegue de la infraestructura por entorno en GCP, ejecutando comandos como `terraform init`, `plan` y `apply` de forma controlada.

## Uso

### Requisitos previos

- [Terraform ≥ 1.0](https://www.terraform.io/downloads)
- Cuenta de GCP y permisos adecuados para crear recursos
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)

## Variables

Cada entorno define sus propias variables en `terraform.tfvars`, que sobrescriben los valores por defecto del archivo `variables.tf`.

## CI/CD con Cloud Build

Este repositorio incluye un pipeline de CI/CD definido en `cloudbuild.yaml` para desplegar automáticamente la infraestructura por entorno en Google Cloud Platform. Este pipeline puede incluir los pasos de validación, inicialización, planificación y aplicación de los cambios de Terraform.

## Buenas prácticas implementadas

- Separación clara entre entornos (`des`, `pre`, `pro`)
- Uso de módulos reutilizables para recursos compartidos
- Gestión explícita de versiones en `versions.tf`
- Outputs definidos para facilitar integraciones con otros recursos o herramientas

