locals {
  users = toset(var.user_names)

  user_access_keys = {
    for user, access_key in aws_iam_access_key.inno_user_key : user => {
      access_key_id     = access_key.id
      secret_access_key = access_key.secret
    }
          }


}
