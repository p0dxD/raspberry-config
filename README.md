# Starter configuration
The following scripts must be run in the following order (run in sudo):
- [Setup](#setupsh)
- [Kubernetes](#kubernetes)
    - [Pre-kube](#pre-kubesh)
    - [Kube](#kubesh)
    - [Post-kube](#post-kubesh)
    - [Network-config](#network-configsh)

If all steps work as expected the workers can join the main cluster
``` 
kubeadm join $192.#.#.#:6443 --token $TOKEN --discovery-token-ca-cert-hash $HASH
```
## setup.sh
Upgrades, and installs the following:
- git
- sdkman
- docker
- zip
# Kubernetes
## pre-kube.sh
Sets the initial configuration needed for kubernetes to operate corrently:
* It updates _/boot/cmdline.txt_, and _/etc/docker/daemon.json_
* Disables swap
* Gets latest updates again
* Installs the following
    - curl
    - apt-transport-https
    - bridge-utils
    - iptables-persistent
* Configures iptables
* Reloads daemon and restarts docker
* Reboots

## kube.sh
Installs the main tools:
* It adds the repo containing the tools
* Installs the following:
    - kubelet
    - kubeadm
    - kubectl
    - kubernetes-cni
* Creates needed directory for cni
* sets needed networking tools

## post-kube.sh
Once tools are ready it pulls the needed configs
* Pulls config images
* Sets up network with allowed range
* Sets configuration for current user for non root
* Sets auto-complete

## network-config.sh
Gets and creates the needed configuration

