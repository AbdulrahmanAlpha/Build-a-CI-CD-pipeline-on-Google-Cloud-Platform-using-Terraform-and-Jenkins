# Configure the Google Cloud Platform provider
provider "google" {
  project     = var.project_id
  region      = var.region
}

# Create a firewall rule that allows SSH access from a specific IP address
resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.ssh_source_ip]
}

# Create a Jenkins instance
resource "google_compute_instance" "jenkins" {
  name         = "jenkins"
  machine_type = var.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.jenkins_image
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Use ephemeral IP address
    }
  }

  metadata_startup_script = file("jenkins-startup-script.sh")
}

# Create a build environment
resource "google_compute_instance" "build" {
  name         = "build"
  machine_type = var.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.build_image
    }
  }

  network_interface {
    network = "default"
  }
}

# Create a deployment environment
resource "google_compute_instance" "deploy" {
  name         = "deploy"
  machine_type = var.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.deploy_image
    }
  }

  network_interface {
    network = "default"
  }

  metadata_startup_script = file("deploy-startup-script.sh")
}

# Create a Jenkins job that defines the pipeline stages
resource "jenkins_job" "pipeline" {
  name     = "pipeline"
  config   = file("pipeline.xml")
  folder   = var.jenkins_folder
  plugin   = "workflow-aggregator"
}

# Output the Jenkins IP address
output "jenkins_ip" {
  value = google_compute_instance.jenkins.network_interface[0].access_config[0].nat_ip
}