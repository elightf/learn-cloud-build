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

output "service_url" {
  value = google_cloud_run_service.ronin.status[0].url
}

output "function_url" {
  value = google_cloudfunctions_function.deployed_function.https_trigger_url
}
