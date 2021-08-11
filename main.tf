terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "teraform"
    region   = "ru-central1"
    key      = "tf/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = var.yandex_token
  cloud_id  = var.yandex_cloud
  folder_id = var.yandex_folder
  zone      = var.yandex_zone
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

# resource "yandex_compute_instance" "vm-1" {
#   name = "terraform1"

#   resources {
#     cores  = 2
#     memory = 2
#   }

#   boot_disk {
#     initialize_params {
#       image_id = "fd845krrkjnt6kgrtoek"
#     }
#   }

#   network_interface {
#     subnet_id = yandex_vpc_subnet.subnet-1.id
#     nat       = true
#   }
# }

# resource "yandex_compute_instance" "vm-2" {
#   name = "terraform2"

#   resources {
#     cores  = 2
#     memory = 4
#   }

#   boot_disk {
#     initialize_params {
#       image_id = "fd845krrkjnt6kgrtoek"
#     }
#   }

#   network_interface {
#     subnet_id = yandex_vpc_subnet.subnet-1.id
#     nat       = true
#   }
# }

# resource "yandex_vpc_network" "network-1" {
#   name = "network1"
# }

# resource "yandex_vpc_subnet" "subnet-1" {
#   name           = "subnet1"
#   zone           = "ru-central1-a"
#   network_id     = yandex_vpc_network.network-1.id
#   v4_cidr_blocks = ["192.168.10.0/24"]
# }

# output "internal_ip_address_vm_1" {
#   value = yandex_compute_instance.vm-1.network_interface.0.ip_address
# }

# output "internal_ip_address_vm_2" {
#   value = yandex_compute_instance.vm-2.network_interface.0.ip_address
# }

# output "external_ip_address_vm_1" {
#   value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
# }

# output "external_ip_address_vm_2" {
#   value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
# }

# output "subnet-1" {
#   value = yandex_vpc_subnet.subnet-1.id
# }
