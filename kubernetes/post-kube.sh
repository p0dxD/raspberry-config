#!/bin/bash
# Getting config images
kubeadm config images pull

# Pod network range, must not overlap current.
echo "Preflight."
kubeadm init --pod-network-cidr=10.1.0.0/16 --service-cidr=10.2.0.0/16 --upload-certs

# After installation to access tools.
echo "Setting up configuration"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Autocompletion.
kubectl completion bash > ~/.kube/completion.bash.inc
printf "
# Kubectl shell completion
source '$HOME/.kube/completion.bash.inc'
" >> $HOME/.bash_profile
source $HOME/.bash_profile