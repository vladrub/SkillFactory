variable "yandex_token" {
  description = "<OAuth token>"
  type        = string
  sensitive   = true
  default     = null
}

variable "yandex_cloud" {
  description = "<Идентификатор облака>"
  type        = string
  default     = null
}

variable "yandex_folder" {
  description = "<Идентификатор каталога>"
  type        = string
  default     = null
}

variable "yandex_zone" {
  description = "<Зона (регион)>"
  type        = string
  default     = "ru-central1-a"
}

variable "yandex_access_key" {
  description = "<Идентификатор статического ключа>"
  type        = string
  sensitive   = true
  default     = null
}

variable "yandex_secret_key" {
  description = "<Секретный ключ>"
  type        = string
  default     = null
}
