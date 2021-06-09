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


#Root or Sudoer verifying.
if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Install.sh need to run as root or sudoer"
    exit 0
fi


#=============================================================================================
echo -e "${RED}[+] Installing all requirements${NC}"
#Installing packages
apt-get update && apt-get install net-tools htop vim gzip zip git python3-pip jq tmux snap -y

#Installing newer GO
apt purge golang
apt autoremove golang 
cd /tmp
wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz
go version

#Moving all above GO bins to /usr/bin
mv /usr/local/go/bin/* /usr/bin
mv ~/go/bin/* /usr/bin

#Installing anew
go get -u github.com/tomnomnom/anew

#=============================================================================================
#Install assetfinsder
echo -e "${RED}[+] Installing assetfinder${NC}"
go get -u github.com/tomnomnom/assetfinder
mv ~/go/bin/assetfinder /usr/local/bin

#Install assetfinder
echo -e "${RED}[+] Installing subfinder${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
mv ~/go/bin/subfinder /usr/local/bin

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