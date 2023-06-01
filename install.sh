#!/bin/zsh

# Install required dependencies
sudo apt install libc6-dev gcc make curl net-tools -y

# Build endlessh
make

# Move the endlessh binary to the appropriate location
echo "Moving endlessh to /usr/local/bin..."
sudo mv endlessh /usr/local/bin

# Verify the installation
which endlessh

# Copy the endlessh systemd service file
echo "Copying endlessh.service to /etc/systemd/system"
sudo cp endlessh.service /etc/systemd/system

# Enable the endlessh service
echo "Enabling endlessh..."
sudo systemctl enable endlessh

# Create the configuration file
echo "Creating /etc/endlessh directory..."
sudo mkdir -p /etc/endlessh
echo "Downloading custom endlessh service..."
sudo curl https://raw.githubusercontent.com/sunstep/endlessh/master/config --output /etc/endlessh/config

# Start the endlessh service
echo "Starting Endlessh..."
sudo systemctl start endlessh

# Check if endlessh is listening on port 22
sudo netstat -tulpn | grep endlessh
