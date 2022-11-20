#!/bin/bash
# Get network config.
wget https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

# Replace host name.
sed -i 's/vxlan/host-gw/' kube-flannel.yml

# Replace ips and range.
sed -i 's#10.244.0.0/16#10.1.0.0/16#' kube-flannel.yml

# Create configuration
kubectl create -f kube-flannel.yml
