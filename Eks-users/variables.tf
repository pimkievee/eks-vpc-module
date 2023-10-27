variable "username" {
  type = list(any)
  default = [ "developer1", "manager" ]
}

variable "env" {
  type = list(any)
  default = ["Development", "production"]
  }

variable "tags" {
  type = map(string)
  default = {
    "Env" = "production"
  }
}