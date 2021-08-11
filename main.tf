terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_image" "postgres" {
  name         = "postgres:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial-nginx"
  ports {
    internal = 80
    external = 8000
  }
}

resource "docker_container" "postgres" {
  image = docker_image.postgres.latest
  name  = "tutorial-postgres"
  env = [
    "POSTGRES_HOST_AUTH_METHOD=trust"
  ]
  ports {
    internal = 5432
    external = 15432
  }
  volumes {
    volume_name    = "postgres_volume"
    container_path = "/var/lib/postgresql"
  }
}

resource "docker_volume" "postgres_volume" {
  name = "postgres_volume"
}
