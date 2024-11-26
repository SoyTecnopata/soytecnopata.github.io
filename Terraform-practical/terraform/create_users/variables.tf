# Variable Definitions
# Definimos una variable llamada `user_names` que recibe una lista de nombres de usuarios.
variable "user_names" {
  description = "Name of the user to create"
  type        = list(string)
}
