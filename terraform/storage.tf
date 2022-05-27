resource "google_storage_bucket" "function_bucket" {
  name          = "${var.project}-function"
  location      = var.region
  force_destroy = true
}
