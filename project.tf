# Enable services
resource "google_project_service" "run" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "iam" {
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudbuild" {
  service            = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

# Create a service account
resource "google_service_account" "ronin_worker" {
  account_id   = "ronin-worker"
  display_name = "Ronin Worker SA"
}

# Set permissions
resource "google_project_iam_binding" "service_permissions" {
  for_each = toset(["run.invoker"])

  role       = "roles/${each.key}"
  members    = [local.ronin_worker_sa]
  depends_on = [google_service_account.ronin_worker]
}
