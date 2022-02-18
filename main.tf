terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.4.1"
    }
  }
}

variable "kubehost" {
  type = string
}

variable "kubeclientcert" {
  type = string
}

variable "kubeclientkey" {
  type = string
}

variable "kubeclustercert" {
  type = string
}

resource helm_release nginx_ingress {
  name       = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

provider "helm" {
  kubernetes {
    host = var.kubehost
    client_certificate = var.kubeclientcert
    client_key = var.kubeclientkey
    cluster_ca_certificate = var.kubeclustercert
  }
}


