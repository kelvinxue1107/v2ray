credentials        = "../keys/GCPRoles/k8s-admin.json"
project_id         = "ccs-backup-8b03e6e5"
region             = "asia-northeast1"
zones              = ["asia-northeast1-a", "asia-northeast1-b", "asia-northeast1-c"]
name               = "gke-cluster"
machine_type       = "g1-small"
min_count          = 1
max_count          = 3
disk_size_gb       = 10
service_account    = "ccs-deployment-gke@ccs-backup-8b03e6e5.iam.gserviceaccount.com"
initial_node_count = 3