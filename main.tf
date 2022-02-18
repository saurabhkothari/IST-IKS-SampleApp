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

resource helm_release helloiksfrtfcb {
  name       = "helloiksapp"
  namespace = "default"
  chart = "https://github.com/CiscodCloud/helm_chart/raw/f64d4bd7b58c379b79f584e325ebdd07d1725381/helloiks-0.1.0.tgz"

  set {
    name  = "MESSAGE"
    value = "ATX Demo - Expanding to New Use Cases Cisco Intersight Service for HashiCorp Terraform"
  }
}

provider "helm" {
  kubernetes {
    host = var.kubehost
    client_certificate = base64decode(var.kubeclientcert)
    client_key = base64decode(var.kubeclientkey)
    cluster_ca_certificate = base64decode(var.kubeclustercert)
  }
}


