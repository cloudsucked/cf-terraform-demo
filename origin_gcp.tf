resource "google_compute_instance" "gcp_origin" {
  depends_on = [cloudflare_tunnel.gcp_tunnel, cloudflare_tunnel_config.gcp_tunnel_config]
  // Gives the VM a name like httpbin-
  name                      = random_id.namespace.hex
  zone                      = "australia-southeast1-a"
  machine_type              = "e2-small"
  tags                      = ["terraformed", replace(var.cloudflare_zone, ".", "-")]
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "projects/cos-cloud/global/images/family/cos-stable"
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
    docker network create --subnet=172.18.0.0/24 cfnet
    sudo docker run --net cfnet --ip 172.18.0.10 --restart always -d cloudflare/cloudflared:latest tunnel run --token ${cloudflare_tunnel.gcp_tunnel.tunnel_token}
    sudo docker run --net cfnet --ip 172.18.0.11 --restart always -d kennethreitz/httpbin
    sudo docker run --net cfnet --ip 172.18.0.12 --restart always -d bkimminich/juice-shop
    sudo docker run --net cfnet --ip 172.18.0.13 --restart always -d swaggerapi/petstore3:unstable
    SCRIPT
}

output "gcp_instance_id" {
  value = google_compute_instance.gcp_origin.instance_id
}

output "tunnel_id" {
  value = cloudflare_tunnel.gcp_tunnel.id
}
