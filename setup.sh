#!/bin/bash

# Get latest updates
yes | sudo apt upgrade

# Install zip if not found
if ! command -v zip &> /dev/null
then
    yes | sudo apt install zip
fi

# Install git if not found
if ! command -v git &> /dev/null
then
    yes | sudo apt install git
fi

# Install latest docker
if ! command -v docker &> /dev/null
then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    # Configure docker
    echo $USER
    sudo usermod -aG docker $USER
    docker version
fi

# Install sdkman
if [ ! $(echo $SDKMAN_DIR) ] 
then
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk version
fi