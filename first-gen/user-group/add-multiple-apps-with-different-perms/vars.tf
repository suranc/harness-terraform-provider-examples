variable "regulated_apps" {
  description = "A list of apps to get regulated permission."
  type = list(string)
}

variable "nonregulated_apps" {
  description = "A list of apps to get non regulated permission."
  type = list(string)
}