#!/usr/bin/zsh

sudo apt install libc6-dev
make
sudo mv endlessh /usr/local/bin
which endlessh

sudo cp util/endlessh.service /etc/systemd/system
sudo systemctl enable endlessh
sudo mkdir -p /etc/endlessh
cd /etc/endlessh
curl https://raw.githubusercontent.com/sunstep/endlessh/master/config --output config 
sudo systemctl start endlessh

sudo netstat -tulpn | grep endlessh
