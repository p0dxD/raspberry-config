#!/bin/bash
# Main repository.
echo "Adding the kubernetes repository."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt update

# Main tools.
echo "Installing main program."
sudo apt install -y kubelet \
    kubeadm \
    kubectl \
    kubernetes-cni

# Needed folders.
echo "Creating needed folders."
mkdir -p /etc/cni/net.d

# Network backend for arm.
echo "Setting up needed networking tools."
curl -sL https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-arm64-v1.1.1.tgz | \
tar zxvf - -C /opt/cni/bin/ ./portmap
