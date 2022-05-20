terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.53"
    }
  }
}

provider "google" {
  project = var.project
}

locals {
  service_folder = "service"
  service_name   = "ronin"

  ronin_worker_sa = "serviceAccount:${google_service_account.ronin_worker.email}"
}
