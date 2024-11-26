# Output
# Este bloque genera como salida las claves de acceso de los usuarios creados.
# La salida está marcada como sensible para proteger los datos.
output "user_access_keys" {
  value     = local.user_access_keys
  sensitive = true
}
