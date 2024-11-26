[comment]: # (Pass optional settings to reveal.js:)
[comment]: # (controls: true)
[comment]: # (keyboard: true)
[comment]: # (markdown: { smartypants: true })
[comment]: # (hash: false)
[comment]: # (respondToHashChanges: false)
[comment]: # (Other settings are documented at https://revealjs.com/config/)

Alma Gonzalez | Inno It | 26 Noviembre 2024

# `Terraform Practical`

[comment]: # (!!! data-background-image="media/background/4.png" data-background-size="contain")

## Configurar AWS en Terraform

[comment]: # (!!! data-background-image="media/background/titulo_l.png" data-background-size="contain" data-auto-animate)
### Provider Block
<div style="text-align: justify">
Es la forma más directa de configurar AWS en Terraform. Aquí defines el provider y las credenciales necesarias.
</div>

```HCL
provider "aws" {
  region  = "eu-west-3"
  access_key = "AKIA...YOURACCESSKEY"
  secret_key = "SECRETKEY...YOURSECRETKEY"
}

```
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### Usando variables de entorno
<div style="text-align: justify">
Puedes configurar el proveedor de AWS sin exponer tus credenciales directamente en el archivo de configuración usando variables de entorno.
Las variables de entorno que Terraform usa para AWS son:
</div>

```bash
export AWS_ACCESS_KEY_ID="AKIA...YOURACCESSKEY"
export AWS_SECRET_ACCESS_K-EY="SECRETKEY...YOURSECRETKEY"
export AWS_DEFAULT_REGION="us-west-2"
```
```HCL
provider "aws" {
  region  = "eu-west-3"
}
```
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### AWS CLI credentials
<div style="text-align: justify">
Si tienes configurada la AWS CLI, Terraform puede usar el archivo de credenciales generado por la CLI
</div>

```bash [1|3-6]
aws configure

> AWS Access Key ID [****************6PPY]: 
> AWS Secret Access Key [****************HDZ5]: 
> Default region name [eu-west-3]: 
> Default output format [json]: 
```
```HCL
provider "aws" {
  region  = "eu-west-3"
}
```
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain")

### Terraform Providers

[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">
Un `Terraform provider plugin` es un binario ejecutable que implementa el marco de complementos de Terraform.
Crea una capa de abstracción entre las API ascendentes del proveedor y las construcciones con las que Terraform espera trabajar.
https://registry.terraform.io/browse/providers
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
# TODO: Comentar el codigo para que sea más legible
Hablar de como funciona 
```
create_users/
├── iam.tf
├── inno.tfvars
├── locals.tf
├── output.tf
├── provider.tf
├── terraform.tf
└── variables.tf 

```
[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

### Reto 

Crea una instancia de AWS del tipo t2.micro o t3.micro usa una ami "Amazon Linux 2023" y la pem key llamada inno-terraform
para esto usa el workspace como en el correo de inno en mi casi `agonzalez`

hints: documentación

[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)

### Remote State

[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)

<div style="text-align: justify">
El remote state en Terraform permite almacenar el estado del proyecto de infraestructura en un lugar centralizado, en lugar de mantenerlo localmente. Esto es especialmente útil cuando trabajas en equipo o en proyectos donde necesitas consistencia y colaboración, evitando conflictos y asegurando que todas las personas trabajen con el mismo estado.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

Si utilizas Amazon S3 como backend para almacenar el estado remoto, obtendrás ventajas como:

- Centralización: Todo el equipo accede al mismo estado almacenado en S3.
- Persistencia: El estado se guarda de forma segura y redundante en AWS.
- * Bloqueo de estado: * Al combinar S3 con DynamoDB, puedes habilitar bloqueo para evitar que múltiples usuarios modifiquen el estado al mismo tiempo, previniendo corrupción.

- [comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

### Reto 

De tu codigo en local crea un estado remoto en el bucket de s3 que crearemos

```HCL
  backend "s3" {
    bucket               = "inno-terraform-26112024"
    key                  = "terraform.tfstate"
    region               = "eu-west-3"
    workspace_key_prefix = "inno/terraform"
  }
```

[comment]: # (!!! data-background-image="media/background/2.png" data-background-size="contain" data-auto-animate)
### Atlantis

[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">
Atlantis es una herramienta de código abierto que automatiza el flujo de trabajo de Terraform en un entorno colaborativo. Se integra con sistemas de control de versiones como GitHub, GitLab y Bitbucket, y permite gestionar la infraestructura de manera eficiente mediante "pull requests".
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
<div style="text-align: justify">
Cuando un desarrollador realiza un cambio en la infraestructura, Atlantis ejecuta el plan de Terraform automáticamente y proporciona una revisión previa al despliegue. Esto mejora la colaboración, asegura consistencia y permite auditar los cambios en la infraestructura, todo mientras se mantiene el control de versiones. Además, ayuda a gestionar permisos y facilita la integración continua (CI) de infraestructuras en la nube.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

<iframe width="560" height="315" src="https://www.youtube.com/watch?v=TmIPWda0IKg" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


[comment]: # (!!! data-background-image="media/background/2.png" data-background-size="contain" data-auto-animate)
### Modulos

[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)

<div style="text-align: justify">
En Terraform, los módulos son una forma de organizar y reutilizar configuraciones. Un módulo es simplemente un conjunto de archivos de configuración de Terraform que agrupan recursos y lógica relacionados, y que pueden ser reutilizados en diferentes partes de tu infraestructura o en proyectos distintos.
</div>

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

Los módulos permiten:

- Reutilización: Puedes crear un módulo una vez y luego utilizarlo en múltiples lugares, lo que ahorra tiempo y esfuerzo al evitar la duplicación de código.
- Organización: Facilitan la organización de configuraciones complejas en componentes más pequeños y manejables.
- Mantenibilidad: Al centralizar la lógica de recursos comunes en módulos, puedes actualizar y mantener esos recursos de manera más eficiente, ya que los cambios en un módulo afectan a todas sus instancias.


[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

<div style="text-align: justify">
Los módulos pueden ser locales (definidos en tu propio proyecto) o remotos (como los proporcionados por la comunidad o por proveedores oficiales en plataformas como el Terraform Registry).
</div>


[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

<div style="text-align: justify">
Anton Babenko es un conocido experto en Terraform, especialmente reconocido por su contribución a la comunidad con módulos de Terraform bien estructurados y reutilizables. Babenko mantiene un repositorio de módulos de Terraform en GitHub, donde comparte una amplia gama de soluciones para configurar y gestionar infraestructuras en la nube de manera eficiente, usando prácticas recomendadas y patrones de diseño escalables. 
</div>


https://github.com/antonbabenko/terraform-best-practices?tab=readme-ov-file

https://www.antonbabenko.com/your-weekly-dose-of-terraform-live-streams/

https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)

[comment]: # (!!! data-background-image="media/background/1.png" data-background-size="contain" data-auto-animate)
### Gracias
[comment]: # (!!! data-background-image="media/background/titulo_m.png" data-background-size="contain" data-auto-animate)

# `Terraform practical`

[comment]: # (!!! data-background-image="media/background/4.png" data-background-size="contain")
