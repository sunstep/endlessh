#! /bin/sh
Echo "Installing dependencies, building and moving binary"
sudo apt install libc6-dev
make
sudo mv endlessh /usr/local/bin
which endlessh

Echo "Setting up Endlessh" 
sudo cp util/endlessh.service /etc/systemd/system
sudo systemctl enable endlessh
sudo mkdir -p /etc/endlessh
cd /etc/endlessh
sudo chown $USER:$USER -R /etc/endlessh
sudo chmod 774 -R /etc/endlessh
curl https://raw.githubusercontent.com/sunstep/endlessh/master/config --output config 
sudo systemctl start endlessh

sudo netstat -tulpn | grep endlessh

Echo "Endlessh not bound to port 22, fixing it now."
cd /etc/systemd/system/
sudo mv endlessh.service endlessh.service.backup
curl https://raw.githubusercontent.com/sunstep/endlessh/master/endlessh.service --output endlessh.service
sudo setcap 'cap_net_bind_service=+ep' /usr/local/bin/endlessh
sudo systemctl daemon-reload && sudo systemctl restart endlessh
sudo netstat -tulpn | grep endlessh
Echo "Port should now be listening to port 22, if not manually fix it."
Echo "If endlessh is listening to port 22, the set up should be complete now."
