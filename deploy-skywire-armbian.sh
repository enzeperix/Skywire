#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' 
echo -e "${YELLOW}STARTING INSTALLATION OF SKYWIRE APP ...\n${NC}"
echo -e "${GREEN}UPDATING PACKAGE REPOSITORY ...\n${NC}"
apt update
echo -e "${GREEN}INSTALLING SOME DEPENDENCIES ...\n${NC}"
apt install -y curl git mercurial make binutils gcc bison screen wget ca-certificates
echo -e "${GREEN}DOWNLOADING AND INSTALLING GO ...\n${NC}"
curl -L https://dl.google.com/go/go1.10.linux-arm64.tar.gz -o go1.10.linux-arm64.tar.gz
cd /usr/local/
tar -xzvf ~/go1.10.linux-arm64.tar.gz
mkdir -p ~/go/{bin,pkg,src}
echo -e "${GREEN}Updating the .bashrc file with the needed envs ...\n${NC}"

export GOPATH="$HOME/go"
export GOBIN="$HOME/go/bin"
export GOROOT="/usr/local/go"
export PATH="$PATH:/usr/local/go/bin:${GOPATH//://bin:}/bin"

echo 'export GOPATH="$HOME/go"' >> ~/.bashrc
echo 'export GOBIN=$HOME/go/bin' >> ~/.bashrc
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export PATH="$PATH:/usr/local/go/bin:${GOPATH//://bin:}/bin"' >> ~/.bashrc

echo -e "${GREEN}CLONING AND INSTALLING SKYWIRE ...\n${NC}"
mkdir -p $GOPATH/src/github.com/skycoin
cd $GOPATH/src/github.com/skycoin
git clone https://github.com/skycoin/skywire.git
cd $GOPATH/src/github.com/skycoin/skywire/cmd
echo -e "${GREEN}INSTALLING SKYWIRE . . . \n${NC}"
go install ./...
echo -e "${GREEN} DONE !\n${NC}"

echo -e "${GREEN} CREATING GO SYMLINKS AND DELETING THE GO ARCHIVE ...\n${NC}"
ln -s /usr/local/go/bin/go /usr/local/bin/go
ln -s /usr/local/go/bin/godoc /usr/local/bin/godoc
ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt
rm -f ~/go1.10.linux-arm64.tar.gz
echo -e "${GREEN} SKYWIRE INSTALLATION IS COMPLETE ! YOU CAN NOW GRAB YOUR BEER ! \n${NC}"


