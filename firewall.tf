# sonar-server 
resource "google_compute_firewall" "sonar-server-fw" {
  name    = "sonar-server-fw"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "9000"]
  }

  target_tags = ["sonar-server"]

  source_ranges = ["0.0.0.0/0"]
}

