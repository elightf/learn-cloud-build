# Generates an archive of the source code compressed as a .zip file.
data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/../functions"
  output_path = "/tmp/function.zip"
}

# Add source code zip to the Cloud Function's bucket
resource "google_storage_bucket_object" "zip" {
  source       = data.archive_file.source.output_path
  content_type = "application/zip"

  # Append to the MD5 checksum of the files's content
  # to force the zip to be updated as soon as a change occurs
  name   = "src-${data.archive_file.source.output_md5}.zip"
  bucket = google_storage_bucket.function_bucket.name

  # Dependencies are automatically inferred so these lines can be deleted
  depends_on = [
    google_storage_bucket.function_bucket, # declared in `storage.tf`
    data.archive_file.source
  ]
}

resource "google_cloudfunctions_function" "deployed_function" {
  name    = "function-tf" # this forms the endpoint in the url
  runtime = "nodejs14"    # of course changeable
  region  = var.region

  # Get the source code of the cloud function as a Zip compression
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.zip.name
  trigger_http          = true

  # Must match the functionName in the cloud function source code
  entry_point = "hello_tf"

  # Dependencies are automatically inferred so these lines can be deleted
  depends_on = [
    google_storage_bucket.function_bucket, # declared in `storage.tf`
    google_storage_bucket_object.zip
  ]
}

resource "google_cloudfunctions_function_iam_binding" "binding" {
  project        = google_cloudfunctions_function.deployed_function.project
  region         = google_cloudfunctions_function.deployed_function.region
  cloud_function = google_cloudfunctions_function.deployed_function.name
  role           = "roles/cloudfunctions.invoker"
  members = [
    "allUsers",
  ]
}
