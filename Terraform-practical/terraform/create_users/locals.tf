# Local definitions
# Definimos dos elementos locales:
# 1. `users`: Convierte la lista de nombres de usuario proporcionada en un conjunto único.
# 2. `user_access_keys`: Crea un mapeo entre cada usuario y sus claves de acceso (Access Key y Secret Access Key).
locals {
  users = toset(var.user_names)

  user_access_keys = {
    for user, access_key in aws_iam_access_key.inno_user_key : user => {
      access_key_id     = access_key.id
      secret_access_key = access_key.secret
    }
  }
}
