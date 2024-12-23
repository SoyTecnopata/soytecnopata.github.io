[comment]: # (Pass optional settings to reveal.js:)
[comment]: # (controls: true)
[comment]: # (keyboard: true)
[comment]: # (markdown: { smartypants: true })
[comment]: # (hash: false)
[comment]: # (respondToHashChanges: false)
[comment]: # (Other settings are documented at https://revealjs.com/config/)

Alma Gonzalez | Inno It | 19 Noviembre 2024

# `Terraform 101`

[comment]: # (!!! data-background-image="media/background/4.png" data-background-size="contain")

## Infraestructura como Código (IaC)

 > Se refiere a la gestión y aprovisionamiento de infraestructura a través de código en lugar de procesos manuales.

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

### Terraform para desarrolladoras:
- Permite definir la infraestructura de manera declarativa, lo que hace más fácil entender el estado deseado.
- Antes de aplicar cambios, Terraform permite visualizar el impacto de los mismos con el comando `terraform plan`.
- Lleva un seguimiento del estado de la infraestructura, lo que ayuda a gestionar cambios y dependencias.

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### IaC fuera de terraform:
 CloudFormation (AWS), Azure Resource Manager, Ansible, Pulumi.

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

![Pulumi](media/iac/pulumi.png) <!-- .element: style="transform: scale(1.25);" -->

[comment]: # (||| data-background-image="media/background/2.png" data-background-size="contain" data-auto-animate)

![Cloudformation](media/iac/cloudformation.png) <!-- .element: style="transform: scale(1.25);" -->

[comment]: # (||| data-background-image="media/background/2.png" data-background-size="contain" data-auto-animate)

![Ansible](media/iac/ansible.png)<!-- .element: style="transform: scale(1.25);" -->

[comment]: # (||| data-background-image="media/background/2.png" data-background-size="contain" data-auto-animate)

![Terraform](media/iac/terraform.png) <!-- .element: style="transform: scale(1.25);" -->

[comment]: # (||| data-background-image="media/background/2.png" data-background-size="contain" data-auto-animate)

![Opertofu](media/iac/opertofu.png)<!-- .element: style="transform: scale(1.25);" -->

[comment]: # (!!! data-background-image="media/background/2.png" data-background-size="contain" data-auto-animate)

### Cómo funciona Terraform ?

[comment]: # (!!! data-background-image="media/background/titulo_l.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">
Terraform crea y administra recursos en plataformas en la nube y otros servicios a través de sus interfaces de programación de aplicaciones (API).

Los proveedores permiten que Terraform funcione con prácticamente cualquier plataforma o servicio con una API accesible.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

![Terraform provider](media/iac/terraform-provider.png)<!-- .element: style="transform: scale(1.25);" -->

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">
HashiCorp y la comunidad Terraform ya han escrito miles de proveedores para administrar muchos tipos diferentes de recursos y servicios.

Puede encontrar todos los proveedores disponibles públicamente en el Registro de Terraform:
Amazon Web Services (AWS), Azure, Google Cloud Platform (GCP), Kubernetes, Helm, GitHub, Splunk, DataDog ...
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### Terraform Providers

[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">
Un `Terraform provider plugin` es un binario ejecutable que implementa el marco de complementos de Terraform.
Crea una capa de abstracción entre las API ascendentes del proveedor y las construcciones con las que Terraform espera trabajar.
https://registry.terraform.io/browse/providers
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

```HCL [1-9|11-13]
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

```
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

### Recursos

[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)

<div style="text-align: justify">
Un bloque de recursos declara que se desea que exista un objeto de infraestructura en particular con la configuración dada.
Si está escribiendo una nueva configuración por primera vez, los recursos que define existirán solo en la configuración y aún no representarán objetos de infraestructura reales en la plataforma de destino.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
Los bloques de recursos se componen de:

- Tipo de recurso.
- Nombre del recurso.
- Configuración del recurso.

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
Resource block

```HCL[1|2-7|8-9]
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

```

[comment]: # (||| data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">
El prefijo del tipo se asigna al nombre del proveedor. En la configuración de ejemplo, Terraform administra el recurso aws_s3_bucket con el proveedor aws.
Juntos, el tipo de recurso y el nombre del recurso forman un ID único para el recurso.

Por ejemplo, el ID para su este recurso es `es aws_s3_bucket.example`

El bloque de recursos contiene argumentos que se utilizan para configurar el recurso.
Los argumentos pueden incluir cosas como tamaños de instancias, nombre del bucket.
En la documentación del  provider se enumeran los argumentos obligatorios y opcionales para cada recurso.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

### Data Sources

[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">

Las `Data Sources` permiten a Terraform utilizar información de recursos que existen fuera del codigo local de Terraform,
esta puede estar definida por otra configuración independiente de Terraform o modificada por funciones.

https://registry.terraform.io/providers/hashicorp/aws/latest/docs
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
Los bloques de datos se componen de:

- Tipo de recurso.
- Nombre del recurso.
- Configuración del recurso.

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
Data block

```HCL
data "aws_iam_role" "example" {
  name = "an_example_role_name"
}
```

[comment]: # (||| data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">
Un bloque de datos solicita que Terraform lea desde una fuente de datos determinada ("aws_ami") y exporte el resultado con el nombre local indicado ("ejemplo"). El nombre se utiliza para hacer referencia a este recurso desde otra parte del mismo módulo de Terraform, pero no tiene importancia fuera del alcance de un módulo.

La fuente de datos y el nombre juntos sirven como identificador para un recurso determinado y, por lo tanto, deben ser únicos dentro de un módulo.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

### Variables

[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">
las variables son una manera de hacer que las configuraciones sean más flexibles y reutilizables, permitiéndote parametrizar valores en lugar de hardcodearlos directamente en los archivos de configuración.
Cada variable tiene un bloque variable que incluye su nombre y, opcionalmente, puede especificarse un valor predeterminado, una descripción y restricciones.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
Resource block

```HCL
variable "instance_type" {
  description = "Tipo de instancia para el servidor"
  type        = string
  default     = "t2.micro"
}

```
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### Estado

[comment]: # (!!! data-background-image="media/background/titulo.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">

Terraform guarda el estado en un archivo llamado terraform.tfstate.
Este archivo contiene un mapeo de los recursos que Terraform ha creado y el estado de cada uno. Esto permite a Terraform comparar el estado "deseado" en tu código con el estado "real" de tus recursos en la infraestructura.
</div>

![Terraform provider](media/iac/terraform-state.png)<!-- .element: style="transform: scale(1.0);" -->

[comment]: # (||| data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
Por defecto, el archivo terraform.tfstate se guarda localmente en la carpeta de tu proyecto. Sin embargo, en equipos o proyectos grandes es preferible almacenar el estado de forma remota para que todos los integrantes trabajen con la misma referencia.

Algunas opciones de almacenamiento remoto incluyen:

- Terraform Cloud/Enterprise: Ofrece gestión de estado en la nube, bloqueo de estado y control de versiones.
- Backends remotos: Puedes usar backends como AWS S3, Google Cloud Storage, o Azure Blob Storage junto con DynamoDB para bloquear el estado (en AWS).

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

## Instalar Terraform
[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)
- CLI de Terraform
  - El cliente es un único binario ejecutable compilado desde Go. Solo se necesita descarguar el binario apropiado para
  el sistema operativo y arquitectura desde el sitio web de Terraform.
    - https://developer.hashicorp.com/terraform/install
    
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
- TFenv
  - Terraform version manager
    - https://github.com/tfutils/tfenv?tab=readme-ov-file#installation

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### Comandos principales

[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)
<div style="font-size: 2em;">

```HCL
terraform init
```
</div>
<div style="text-align: justify">


Este comando prepara el entorno de trabajo para un proyecto de Terraform. Es el primer paso que necesitas dar en cualquier proyecto nuevo.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">

- **Descarga de proveedores:** Terraform busca en el archivo de configuración (.tf) las dependencias de proveedores especificadas (como AWS, Google Cloud, Azure) y descarga los plugins correspondientes.

- **Configuración del backend:** Si has definido un backend (como Amazon S3 para almacenar el estado de forma remota), terraform init lo configura.

- **Reinicialización:** Si ya has ejecutado terraform init antes, puedes utilizar terraform init -upgrade para forzar una reinicialización del backend o del proveedor.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

<div style="font-size: 2em;">

```HCL
terraform plan
```
</div>
<div style="text-align: justify">


Este comando analiza tu configuración y genera un plan de ejecución que muestra las acciones que Terraform tomará en la infraestructura (creación, modificación o destrucción de recursos).
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">

- **Visualización de cambios:** terraform plan muestra un desglose detallado de las modificaciones que planea hacer. Las adiciones de recursos aparecen como +, las eliminaciones como -, y las modificaciones con ~.

- **Control de cambios:** Es una práctica común revisar el plan antes de aplicar cambios, ya que te da la oportunidad de evitar errores o ajustes no deseados.

- **Salida en archivo:** Puedes guardar el plan en un archivo para revisarlo o aplicarlo más tarde con terraform apply, usando la opción -out.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

<div style="font-size: 2em;">

```HCL
terraform apply
```
</div>
<div style="text-align: justify">


Este comando realiza las modificaciones en la infraestructura en base a la configuración actual y al archivo de estado, siguiendo el plan que se generó.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">

- **Confirmación de cambios:** Si ejecutas terraform apply sin un archivo plan, Terraform te pedirá confirmar los cambios antes de aplicarlos.

- **Aplicación de planes guardados:** Al usar terraform apply tfplan, Terraform utiliza el plan guardado y aplica los cambios sin requerir confirmación adicional, lo que puede ser útil en automatizaciones.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">

- **Ejecución en paralelo:** Terraform ejecuta tareas en paralelo cuando puede, lo que acelera el proceso de implementación en grandes despliegues.

- **Errores y fallos:** Si algo falla durante el proceso, Terraform intenta revertir los cambios realizados en la medida de lo posible para mantener la infraestructura en un estado consistente.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

<div style="font-size: 2em;">

```HCL
terraform destroy
```
</div>

<div style="text-align: justify">
Este comando elimina todos los recursos creados y gestionados por Terraform en el entorno definido, llevándolos al estado de "sin recursos" o borrándolos.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">

- **Uso con precaución:** borra todos los recursos especificados en la configuración de Terraform, así que es importante usarlo cuidadosamente, especialmente en entornos productivos.

- **Confirmación requerida:** Antes de iniciar el proceso de eliminación, Terraform pide confirmación para evitar borrar recursos por error.

- **Filtrado de recursos:**  Aunque terraform destroy está pensado para destruir todos los recursos, se pueden especificar recursos individuales usando -target para eliminar solo un recurso o grupo específico.

</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### Organización y Estructura del Código
[comment]: # (!!! data-background-image="media/background/titulo_l.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">
La organización del código en Terraform es crucial para facilitar el mantenimiento, colaboración y escalabilidad.
</div>

#### Archivos organizados por propósito:

- `main.tf`: Configuración principal del recurso.
- `variables.tf`: Declaración de variables.
- `outputs.tf`: Declaración de valores de salida.
- `providers.tf`: Configuración de proveedores.
- `backend.tf`: Configuración del backend de estado.

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
#### Nombres claros y consistentes:
Usa nombres descriptivos para los módulos y archivos.

```css
project/
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── terraform.tfvars

```

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
#### Separación por Entornos
Evitar interferencias entre configuraciones de entornos (producción, desarrollo, pruebas) y facilitar la gestión de cada uno.

- Estructura de carpetas por entorno:
  Crea una carpeta para cada entorno y define configuraciones específicas.
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
```CSS
envs/
├── dev/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── prod/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf

```
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

- Workspaces
<div style="text-align: justify">
Los workspaces permiten manejar múltiples entornos dentro de una misma configuración, manteniendo un estado separado para cada uno.
Cuando trabajas con workspaces, cada uno tiene su propio archivo de estado, pero comparte las mismas configuraciones de Terraform (.tf files).

Crear diferentes workspaces para dev, staging y prod.
Cada workspace tiene su propio archivo de estado, aislando los recursos.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
Comandos para workspaces:

```HCL [1|3|5|7|9]
terraform workspace list

terraform workspace new <nombre_del_workspace>

terraform workspace select <nombre_del_workspace>

terraform workspace delete <nombre_del_workspace>

terraform workspace show

```
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### Uso de Variables Globales y Locales
[comment]: # (!!! data-background-image="media/background/titulo_l.png" data-background-size="contain" data-auto-animate)
Terraform permite usar variables para hacer el código dinámico y reutilizable

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

#### Variables globales:
Se definen en un archivo como variables.tf y pueden ser sobrescritas usando terraform.tfvars o variables de entorno.

```HCL
variable "region" {
  description = "Región de AWS"
  default     = "us-west-1"
}

```
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
#### Variables locales:
  Son específicas de un módulo o archivo y se definen con la sintaxis locals.

```HCL

locals {
  environment = "dev"
  instance_name = "${local.environment}-web-server"
}

```
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

#### Sobreescritura de variables:
Usa archivos .tfvars o variables de entorno (TF_VAR_<variable>).

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
###  Estandarización de Nombres
[comment]: # (!!! data-background-image="media/background/titulo_l.png" data-background-size="contain" data-auto-animate)
Nombrar recursos de forma consistente mejora la claridad y el mantenimiento:

Patrones comunes:
```
[entorno]-[nombre del recurso]-[número]
```
Ejemplo:
```
prod-web-server-01
```

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
Variables dinámicas:
Usa interpolación para generar nombres automáticamente:

```HCL

resource "aws_instance" "example" {
  name = "${var.environment}-${var.role}-server"
}
```

Evita nombres genéricos o ambiguos: Usa nombres que reflejen el propósito y el entorno del recurso.

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### Prácticas de Seguridad
[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)

Evitar Claves Secretas en el Código
*Errores comunes:*

- Incluir claves API, contraseñas o secretos en los archivos .tf.
- Versionar estos archivos en sistemas como Git.

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

- Soluciones:

  - Usa servicios de gestión de secretos como AWS Secrets Manager, HashiCorp Vault o Azure Key Vault.
Define claves como variables sensibles:
```HCL
  variable "db_password" {
    type      = string
    sensitive = true
  }
```

Almacena valores sensibles en variables de entorno:
```HCL
  export TF_VAR_db_password="mi_clave_secreta"
```  

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### Linters y herramientas de análisis de código
[comment]: # (!!! data-background-image="media/background/titulo_l.png" data-background-size="contain" data-auto-animate)

*Terraform fmt:*  Garantiza un formato estándar para los archivos .tf.

Para verificar el formato sin modificar:
```HCL
terraform fmt -check
```

Para corregir automáticamente el formato:
```HCL
terraform fmt
```
Integración: Se puede incluir en pipelines de CI/CD para garantizar que el código siempre siga un estándar antes de ser revisado o aplicado.

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

*TFLint:* Detecta errores comunes, configuraciones inválidas y recomienda mejores prácticas específicas del proveedor (como AWS o Azure).

- Identifica errores antes de ejecutar terraform apply. 
- Valida configuraciones del proveedor, como el tamaño de instancias, regiones soportadas, etc. 
- Permite personalizar reglas específicas.

Intalación: https://github.com/terraform-linters/tflint

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### Gracias
[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)

Alma Gonzalez | Inno It | 26 Noviembre 2024

# `Terraform practical`

[comment]: # (!!! data-background-image="media/background/4.png" data-background-size="contain")
