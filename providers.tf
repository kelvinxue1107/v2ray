#provider "google" {
#  credentials = file("../keys/GCPRoles/ccs-backup-b3341b96e630.json")
#  project     = "ccs-backup-8b03e6e5"
#  region      = "asia-northeast1"
#}

provider "google" {
  version     = "2.9.0"
  credentials = "${file(var.credentials)}"
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  version     = "2.9.0"
  credentials = "${file(var.credentials)}"
  project     = var.project_id
  region      = var.region
}

#provider "kubernetes" {
#  version = "1.10"
#  load_config_file       = false
#  host                   = "https://${local.cluster_endpoint}"
#  token                  = data.google_client_config.default.access_token
#  cluster_ca_certificate = base64decode(local.cluster_ca_certificate)
#}