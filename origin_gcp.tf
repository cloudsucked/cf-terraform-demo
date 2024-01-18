resource "google_compute_instance" "gcp_origin" {
  // Gives the VM a name like httpbin-
  name                      = random_id.namespace.hex
  zone                      = "australia-southeast1-a"
  machine_type              = "e2-small"
  tags                      = ["terraformed", split(".", var.cloudflare_zone)[0]]
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      // OS of the VPS; in this case Contianer Optimized OS Stable edition
      image = "gce-uefi-images/cos-stable"
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
  scheduling {
    // This tells Google Cloud to destory the VM after 24 hours
    preemptible       = true
    automatic_restart = false
  }
  metadata = {
    cf-zone = var.cloudflare_zone
  }
  labels = {
    // Adds owner label for (C)SE GCloud fair usage 
    "owner" = split("@", replace(var.cloudflare_email, ".", "_"))[0]
  }
  // Runs the following command on the VPS at startup
  metadata_startup_script = <<SCRIPT
    sudo docker run --restart always -d -p 80:80 kennethreitz/httpbin
    sudo docker run --restart always -d -p 81:3000 bkimminich/juice-shop
    sudo docker run --restart always -d -p 82:8080 swaggerapi/petstore3:unstable
    SCRIPT
}

output "juiceshop_origin_ip" {
  value = google_compute_instance.gcp_origin.network_interface.0.access_config.0.nat_ip
}
