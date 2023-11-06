
variable "username" {
  type    = list(any)
  default = ["Hope", "Veebayo", "master"]
}

variable "env" {
  type    = list(any)
  default = ["Development", "production"]
}

variable "tags" {
  type = map(string)
  default = {
    "Env" = "production"
  }
}
