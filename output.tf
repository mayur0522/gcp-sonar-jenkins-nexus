output "jenkins_server_ip" {
  description = "External IP address of the Jenkins server"
  value       = google_compute_instance.jenkins_server.network_interface[0].access_config[0].nat_ip
}

output "sonar_server_ip" {
  description = "External IP address of the SonarQube server"
  value       = google_compute_instance.sonar-server.network_interface[0].access_config[0].nat_ip
}