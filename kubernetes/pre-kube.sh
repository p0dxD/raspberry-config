#!/bin/bash
# Setup initial configurations
# Other configuration
echo "Appending groups needed to cmdline.txt."
sudo sed -i '1s/^/cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 /' /boot/cmdline.txt
echo "After appending to cmdline.txt."
sudo cat /boot/cmdline.txt

# Other need config for docker
echo "Adding docker config."
sudo touch /etc/docker/daemon.json
sudo cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# steps from https://medium.com/flant-com/install-vanilla-kubernetes-raspberry-pi-b21895a51550
sudo dphys-swapfile swapoff
sudo systemctl disable dphys-swapfile #disable swap as per kube

# Update packages
sudo apt-get update && \
    sudo apt-get dist-upgrade -y

# Install other tools needed
sudo apt install -y apt-transport-https \
    curl \
    bridge-utils \
    iptables-persistent

sudo iptables -F && \
    sudo iptables -t nat -F && \
    sudo iptables -t mangle -F && \
    sudo iptables -X

sudo systemctl daemon-reload
sudo systemctl restart docker

# Reboot
echo "Will now reboot."
sudo shutdown -r now