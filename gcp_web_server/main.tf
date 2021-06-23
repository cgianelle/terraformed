provider "google" {
    region = "us-east1"     //--export GCLOUD_REGION="us-east1"
    zone = "us-east1-b"     //--export GCLOUD_ZONE="us-east1-b"
    project = "terraform-fun-317603" //--export GCLOUD_PROJECT="terraform-fun-317603"
    credentials = file("terraform-fun-317603-ed0eb0d4ed3c.json") //--GCLOUD_KEYFILE_JSON="terraform-fun-317603-ed0eb0d4ed3c.json"
}

//--Enables the following resources on the current project
# resource "google_project_service" "api" {
#   for_each = toset([
#     "cloudresourcemanager.googleapis.com",   //--https://cloud.google.com/resource-manager/reference/rest
#     "compute.googleapis.com"
#   ])
#   disable_on_destroy = false
#   service            = each.value
# }

//--Be Patient - it might take a while to create the instance and install everything
resource "google_compute_instance" "my-web-server" {
    name = "my-web-server"
    machine_type = "e2-micro"
    boot_disk {
        initialize_params {
            image = "ubuntu-1804-lts" //--uses the Ubuntu 18.04 LTS image (family name)
        }
    }

    network_interface {
        network = "default" //--This enable Private IP Address
        access_config {} //--This enables Public IP Address 
    }

    //--Public SSH Key
    metadata = {
        ssh-keys = "cgianelle:${file("~/.ssh/cgianelle.GCP.pub")}"
    }

  metadata_startup_script = <<EOF
#!/bin/bash
apt update -y
apt install apache2 -y
echo "<h2>WebServer on GCP Build by Me using Terraform!<h2>"  >  /var/www/html/index.html
systemctl restart apache2
EOF

    # depends_on = [google_project_service.api, google_compute_firewall.terraform-ssh-rule]
    # depends_on = [google_compute_firewall.terraform-ssh-rule]
}

//--Enables SSH and HTTP access
resource "google_compute_firewall" "terraform-ssh-rule" {
  name = "terraform-ssh-rule"
  network = "default"
  allow {
    protocol = "tcp"
    ports = ["22", "80", "443"]
  }
#   target_tags = ["my-web-server"] //---don't need this as this rule is for the default network and will apply to any instances on that network
  source_ranges = ["0.0.0.0/0"]
}