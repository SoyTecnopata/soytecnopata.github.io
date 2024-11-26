# Terraform Settings
# Especificamos las versiones requeridas para Terraform y el proveedor de AWS.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.77" # Compatible con cualquier versión de la 5.x.x a partir de 5.77
    }
  }
  required_version = ">= 1" # Terraform 1.0 o superior
}
