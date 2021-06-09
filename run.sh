#!/bin/bash

#Update repositories and install packages

apt update 
sudo apt upgrade -y
sudo apt install python3-pip jq tmux -y

#Install Golang
cd /tmp
wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version


