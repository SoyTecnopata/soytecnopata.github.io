# IAM Policy for EC2 Operations

# Define un documento de política IAM para otorgar permisos específicos relacionados con instancias EC2.
data "aws_iam_policy_document" "allow_ec2_free_tier_creation" {
  # Primer bloque: Permite lanzar, detener, iniciar y terminar instancias EC2 de tipos t2.micro y t3.micro.
  statement {
    sid       = "AllowLaunchT2T3MicroInstances"
    effect    = "Allow" # Define la acción como permitida.
    actions   = [
      "ec2:RunInstances",       # Permite lanzar instancias EC2.
      "ec2:StopInstances",      # Permite detener instancias EC2.
      "ec2:TerminateInstances", # Permite terminar instancias EC2.
      "ec2:StartInstances"      # Permite iniciar instancias EC2.
    ]
    resources = ["*"] # Aplica a todos los recursos EC2.
    condition {
      test   = "StringEquals" # Condición para restringir los tipos de instancias.
      variable = "ec2:InstanceType"
      values = ["t2.micro", "t3.micro"] # Solo permite estos tipos de instancias.
    }
  }

  # Segundo bloque: Permite el uso de llaves, redes, y otros recursos necesarios para lanzar instancias EC2.
  statement {
    sid       = "AllowLaunchKeyPair"
    effect    = "Allow"
    actions   = ["ec2:RunInstances"]
    resources = [
      "arn:aws:ec2:eu-west-3:879381281365:key-pair/*",         # Llaves SSH.
      "arn:aws:ec2:eu-west-3:879381281365:network-interface/*",# Interfaces de red.
      "arn:aws:ec2:eu-west-3:879381281365:security-group/*",   # Grupos de seguridad.
      "arn:aws:ec2:eu-west-3:879381281365:subnet/*",           # Subredes.
      "arn:aws:ec2:eu-west-3:879381281365:volume/*",           # Volúmenes de almacenamiento.
      "arn:aws:ec2:eu-west-3::image/*"                         # Imágenes (AMIs).
    ]
  }

  # Tercer bloque: Permite describir instancias EC2, grupos de seguridad y etiquetas asociadas.
  statement {
    sid       = "AllowDescribeInstances"
    effect    = "Allow"
    actions   = [
      "ec2:Describe*",         # Permite consultar detalles de instancias EC2.
      "ec2:*SecurityGroup*",   # Permite consultar detalles de grupos de seguridad.
      "ec2:*Tags"              # Permite consultar etiquetas asociadas.
    ]
    resources = ["*"] # Aplica a todos los recursos EC2.
  }
}

# Recurso para asignar una política personalizada a cada usuario de IAM.
# El recurso usa un bucle "for_each" para iterar sobre los usuarios definidos en la variable local `users`.
# La política se define en el data block `aws_iam_policy_document`.
resource "aws_iam_user_policy" "inno_terraform" {
  for_each = local.users
  name   = "inno_terraform_policy_${each.value}" # Nombre dinámico para la política basado en el usuario.
  user   = aws_iam_user.inno_user[each.value].name # Asocia la política al usuario creado.
  policy = data.aws_iam_policy_document.allow_ec2_free_tier_creation.json # Referencia al documento de política JSON.
  # combined[each.value]
}

# Recurso para crear usuarios de IAM.
# Este bloque crea un usuario para cada valor definido en la variable `users` en el scope local.
resource "aws_iam_user" "inno_user" {
  for_each = local.users
  name = each.value # Asigna el nombre al usuario basado en los valores de `users`.
  path = "/inno/"   # Ruta base para organizar los usuarios en AWS.

  # Etiquetas asignadas a cada usuario para facilitar la identificación.
  tags = {
    username = each.value
  }
}

# Recurso para generar claves de acceso (Access Keys) para los usuarios de IAM.
# Cada usuario obtiene un par de claves para realizar autenticaciones programáticas.
resource "aws_iam_access_key" "inno_user_key" {
  for_each = local.users
  user = aws_iam_user.inno_user[each.value].name # Asocia la clave de acceso con el usuario correspondiente.
}
