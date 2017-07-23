#!/bin/bash

# change repository server to JP
sed -i.bak -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list

# install golang and gobgp dependencies
add-apt-repository ppa:masterminds/glide -y

apt-get update -qq
apt-get upgrade -y
apt-get install -y \
    golang \
    git \
    gcc \
    glide \
    iperf \
    bridge-utils \
    traceroute

# configure GOPATH
echo 'export GOPATH=$HOME/.golang' >> $HOME/.bashrc
echo 'export PATH=$GOPATH/bin:$PATH' >> $HOME/.bashrc

source $HOME/.bashrc

export GOPATH=$HOME/.golang
export PATH=$GOPATH/bin:$PATH

# install goplane, gobgp, gobgpd and its dependencies
go get github.com/spf13/cobra
go get github.com/kr/pretty
go get github.com/osrg/goplane

cd $GOPATH/src/github.com/osrg/goplane; glide install
cd vendor/github.com/osrg/gobgp/gobgpd
go install .

cd $GOPATH/src/github.com/osrg/goplane
cd vendor/github.com/osrg/gobgp/gobgp
go install .

go install github.com/osrg/goplane
exit
