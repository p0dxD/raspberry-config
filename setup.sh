#!/bin/bash
EMAIL="jose0797@gmail.com"
NAME="Jose"
LOWER_USER="$USER"
# Get latest updates
apt -y upgrade

# Install zip if not found
if ! command -v zip &> /dev/null
then
    apt -y install zip
fi

# Install git if not found
if ! command -v git &> /dev/null
then
    apt -y install git
    git config --global user.email $EMAIL
    git config --global user.name $NAME
fi

# Install latest docker
if ! command -v docker &> /dev/null
then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    # Configure docker
    echo $USER
    #usermod -aG docker $LOWER_USER
    #docker version
fi

# Install sdkman
if [ ! $(echo $SDKMAN_DIR) ] 
then
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk version
fi

echo "Done..."
echo "Run sudo usermod -aG docker pi"
echo "restart.."
