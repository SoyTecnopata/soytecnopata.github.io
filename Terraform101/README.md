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

<div style="text-align: justify">
TODO

</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

TODO

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)


Resource block

```HCL[1|2-7|8-9]
terraform TODO

```

[comment]: # (||| data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

TODO

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)


fin

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

Notice the background color change.

[comment]: # (section attributes for the just-ending slide can be specified:)
[comment]: # (!!! data-background-color="aquamarine")

Use background videos, background pictures and **text formatting**,
everything *without breaking* your markdown files.

[comment]: # (Other background options: https://revealjs.com/backgrounds/)
[comment]: # (!!! data-background-video="media/video.mp4", data-background-video-loop data-background-video-muted data-background-opacity="0.2")

Even speaker notes, accessed through the `S` key on your keyboard.

(You may have to allow pop-up windows and try again.)

Note:
This will only appear in the speaker view! 🤯

[comment]: # (!!!)

## Pictures

![picture of spaghetti](media/image0.gif) <!-- .element: style="height:50vh; max-width:80vw; image-rendering: crisp-edges;" -->

Showcase media including images, videos and animations.

[comment]: # (!!!)

## Animations

- This is an example list
- Just to showcase Reveal.js' animations

[comment]: # (!!! data-auto-animate)

## Animations

- This is an example list
- Just to showcase Reveal.js' animations
- This item will be automatically faded-in

[comment]: # (!!! data-auto-animate)

```js [1-2|3|4]
let a = 1;
let b = 2;
let c = x => 1 + 2 + x;
c(3);
```
<!-- .element: data-id="code" -->

[comment]: # (!!! data-auto-animate)

```js [5]
let a = 1;
let b = 2;
let c = x => 1 + 2 + x;
c(3);
c(5);
```
<!-- .element: data-id="code" -->

Animate code as well <!-- .element: class="fragment" data-fragment-index="1" -->

[comment]: # (!!! data-auto-animate)

Insert Youtube videos.

<iframe width="560" height="315" src="https://www.youtube.com/embed/KPfzRSBzNX4" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[comment]: # (!!!)

Insert local videos.

<iframe width="560" height="315" src="media/video.mp4" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[comment]: # (!!!)

Download [markdown-slides](https://gitlab.com/da_doomer/markdown-slides)!

[comment]: # (!!!)

A couple more examples follow.

[comment]: # (!!!)

![logo](media/wide.png)

***use markdown to write slides***

Author Name

[comment]: # (!!!)

Add tables:

| Insert | Tables |
| ------ | ------ |
| A row  | Another|
| text   | more   |

[comment]: # (!!!)

## Vertical separator

----------

Some other text.

[comment]: # (!!!)

You can also use in-line HTML.

<div style="font-size: 1em;">
small
</div>

<div style="font-size: 5em;">
large
</div>
