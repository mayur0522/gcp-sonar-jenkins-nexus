#!/bin/bash
# Startup script for Jenkins server on GCP (Ubuntu 22.04)

################################################################################################
# System Update & Java (required for Jenkins)
################################################################################################
sudo apt update -y
sudo apt install -y openjdk-17-jre unzip curl wget gnupg ca-certificates apt-transport-https software-properties-common

################################################################################################
# Jenkins Installation
################################################################################################
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins

# Allow Jenkins to use sudo without password
echo "jenkins ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

################################################################################################
# Docker Installation
################################################################################################
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add Jenkins user to Docker group
sudo usermod -aG docker jenkins
sudo chmod 666 /var/run/docker.sock



################################################################################################
# Maven Installation
################################################################################################
sudo apt install -y maven

################################################################################################
# Restart Jenkins
################################################################################################
sudo systemctl enable jenkins
sudo systemctl restart jenkins
