#!/bin/bash
## https://nextgentips.com/2021/12/23/how-to-install-go-1-18-on-ubuntu-20-04/
## as of July 2022, use newest go version for quic-go repo, go version: 1.18.3 

cd ~/ &&
sudo apt update && sudo apt upgrade -y &&
curl -LO https://go.dev/dl/go1.18.3.linux-amd64.tar.gz &&
sudo rm -rf /usr/local/go &&
sudo tar -C /usr/local -xzf ~/go*.linux-amd64.tar.gz &&
sudo sh -c 'echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile' &&
export PATH=$PATH:/usr/local/go/bin &&
source /etc/profile &&
go version &&
## should output: go version go1.18.3 linux/amd64

unzip quic-go.zip && unzip quic-proxy-example.zip &&
cp -r quic-proxy-example/* quic-go/example/ &&

cd quic-go/example/ &&

## REQUIRED: increase UDP datagram buffer
## Check https://github.com/lucas-clemente/quic-go/wiki/UDP-Receive-Buffer-Size for details
## Following command line increase the buffer size into a (relatively) large one: ~25MB
sudo sysctl -w net.core.rmem_max=25000000 &&
go get github.com/montanaflynn/stats && 
echo done!
## QUIC Proxy Commands (Attention: sequence is important, please execute one by one (Due to TLS session estabilishment rule)!):

## First: open Prod GN proxy node:
    ## Prod GN: $ go run proxy.go -addrFrom 172.16.0.2:4242 -addrTo 172.16.1.2:4243
## Second: open Cons GN proxy node: 
    ## Cons GN: $ go run proxy.go -addrFrom 172.16.1.2:4243 -addrTo 172.16.2.2:5252
## Third: open Cons App to receive:
    ## Cons App: $ go run receiver.go -addr=172.16.2.2:5252
## Last: open Prod App to send:
    ## Prod app: go run sender.go -addr=172.16.0.2:4242