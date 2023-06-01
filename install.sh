#!/bin/zsh

# Change to the directory containing the endlessh source code
git clone https://github.com/sunstep/endlessh.git
cd endlessh

# Install required dependencies
sudo apt install libc6-dev gcc make

# Build endlessh
make

# Move the endlessh binary to the appropriate location
sudo mv endlessh /usr/local/bin

# Verify the installation
which endlessh

# Copy the endlessh systemd service file
sudo cp endlessh.service /etc/systemd/system

# Enable the endlessh service
sudo systemctl enable endlessh

# Create the configuration file
sudo mkdir -p /etc/endlessh
cd /etc/endlessh
sudo curl https://raw.githubusercontent.com/sunstep/endlessh/master/config --output config

# Start the endlessh service
sudo systemctl start endlessh

# Check if endlessh is listening on port 22
sudo netstat -tulpn | grep endlessh
