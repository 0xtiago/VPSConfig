#!/bin/bash

LOCALPATH=$(pwd)

#COLORS
#========================================
#https://www.shellhacks.com/bash-colors/
RED='\e[31m'
GREEN='\e[32m'
CYAN='\e[36m'
PURPLE='\e[35m'
YELLOW='\e[33m'
NC='\e[0m' # No Color
#========================================

if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Install.sh need to run as root or sudoer"
    exit 0
fi

#=============================================================================================
echo -e "${RED}[+] Configuring environment PATHs${NC}"
echo "PATH=$PATH:~/go/bin:/usr/local/go/bin" > ~/.bashrc
source ~/.bashrc

#=============================================================================================
echo -e "${RED}[+] Installing all requirements${NC}"
#Installing packages
sudo apt-get update && sudo apt-get install gzip zip git python3-pip jq tmux snap -y

#Installing newer GO
apt purge golang
apt autoremove golang 
cd /tmp
wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz
go version

#Installing anew
go get -u github.com/tomnomnom/anew

#=============================================================================================
#Install assetfinsder
echo -e "${RED}[+] Installing assetfinder${NC}"
go get -u github.com/tomnomnom/assetfinder

#Install assetfinder
echo -e "${RED}[+] Installing subfinder${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder

#Install amass
echo -e "${RED}[+] Installing amass${NC}"
snap install amass

#Install findomain
echo -e "${RED}[+] Installing findomain${NC}"
cd /tmp
wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux
mv findomain-linux findomain
mv findomain /usr/bin
chmod +x /usr/bin/findomain