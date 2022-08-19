#!/bin/bash


# export http_proxy=socks5h://localhost:4567
# export https_proxy=socks5h://localhost:4567

echo Hello, FABRIC. Now installing SciStream protocol and simple test application. From node `hostname -s`;
sudo apt-get update && sudo apt-get install -y unzip python3-pip python-is-python3 libssl-dev python3-dev network-manager net-tools iperf iperf3 &&

sleep 10
echo START-INSTALL

unzip scistream-source-code.zip &&
cd scistream-source-code/scistream-proto &&
pip install -r requirements.txt &&

cd ../scistream/S2DS/ &&
make clean &&
make &&

cd ../../scistream-proto/ &&


sudo lsof -i -P -n | grep LISTEN &&

echo done!

####-----TOPOLOGY------######
#### https://drive.google.com/file/d/124xh4K15c7tUcaETXmj-JSPKcQLA_oTC/view?usp=sharing

#code location (FOR ALL NODES): cd ~/scistream-source-code/scistream-proto/

#h2: python S2CS/s2cs.py --s2-port=5000 --app-port=5500 --listener-ip=172.16.1.1(Prod S2CS GN IP address) 
#h4: python S2CS/s2cs.py --s2-port=6000 --app-port=6500 --listener-ip=172.16.2.1(Cons S2CS GN IP address)
#h3: python S2UC/s2uc.py --v (type: test_req.json, and remember UUID)

    
## From ProdApp Controller (Once they get UUID from the user): (NOTICE: DEFAULT 5 prod-listeners)
    ##h1: python utils/send_hello.py --s2cs-port 5500 --uid 68bdc504-1a89-11ed-af42-9380ccc382d8 --s2cs-ip 192.168.0.2 --prod-listener 172.16.0.1:7000 --prod-listener 172.16.0.1:17000 --prod-listener 172.16.0.1:27000 --prod-listener 172.16.0.1:37000 --prod-listener 172.16.0.1:47000
    ##h1: python utils/send_hello.py --s2cs-port 5500 --uid 68bdc504-1a89-11ed-af42-9380ccc382d8 --s2cs-ip 192.168.0.2 --prod-listener 172.16.1.1:7000 --prod-listener 172.16.1.1:17000 --prod-listener 172.16.1.1:27000 --prod-listener 172.16.1.1:37000 --prod-listener 172.16.1.1:47000
    ##NOTE: Prod Listener IP and port is given by avaliable ProdApp sources

## From ConsApp Controller (Once they get UUID from the user): 
    ##h5: python utils/send_hello.py --s2cs-port 6500 --uid 68bdc504-1a89-11ed-af42-9380ccc382d8 --s2cs-ip 192.168.0.4
    
## S2UC returns (examples):
    ## ProdApp listeners: ['172.16.0.1:7000', '172.16.0.1:17000', '172.16.0.1:27000', '172.16.0.1:37000', '172.16.0.1:47000']
    ## Producer S2DS listeners: ['172.16.1.1:36067', '172.16.1.1:44807', '172.16.1.1:45633', '172.16.1.1:41381', '172.16.1.1:41515']
    ## Consumer S2DS listeners: ['172.16.2.1:33757', '172.16.2.1:42269', '172.16.2.1:44325', '172.16.2.1:42957', '172.16.2.1:34243']
    
## Pub/Sub app test: location: cd ~/scistream-source-code/bfe-test/pub-sub/
#Pub: python pub_bench.py --port 7000 --sync 17000
#Sub: python sub_bench.py --remote-host 172.16.2.1 --remote-port 44325 --sync 42957
    
## need modify: 
    ### Commend out the send_hello.py code from S2UC --Note: those information suppose to be done in Prod/Cons App Controller, as given above. --DONE
    ### test_req.json prod and cons address into: 192.168.0.2 (Prod S2CS GN IP address) and 192.168.0.4 (Cons S2CS GN IP address) --DONE    
    ### send_hello.py line 36 localhost into two address....  --DONE
    ### Prod listeners need to change IP address --DYNAMIC given by ProdApp Controller --Partially DONE
    ### Allow modification of the prod/cons S2CS IP address and port number. --In Progress
    
#Pub/Sub TEST:
    #1: between two nodes without S2DS or SciStream - Test between 172.16.0.1 (PUB) ---- 172.16.0.2 (SUB) on port 7000 and sync port 17000 --------- PASS
    #2: among 4 nodes with S2DS.out provided ports - 
        #2.1: Test nc on port 7123 ----> h1 $nc -l 7123 ; h2 $./S2DS.out --remote-port=7123 --local-port=7123 --remote-host=172.16.0.1 --log ; h4 $./S2DS.out --remote-port=7123 --local-port=7123 --remote-host=172.16.1.1 --log ; h5 $nc 172.16.2.1 7123 ------------------PASS
        #2.1: Test Pub/Sub on port 50000 and 50001 (sync)  success by adding buffer on S2DS.out ---- --buffer-size=10485760 --------------- PASS
    #3: Running SciStream and test pub/sub app
        # Bug 1: There is no add buffer size option on SciStream -- S2DS.out? ---Solve by hard coded the buffer-size option into a large number, but may facing memory problem...
        # Bug 2: Once the connection is gone, there is no way to reuse that connection. For exmaple, in a pub/sub application, once the connection of 7000/17000 on pub and 3xxxx/4xxxx on sub test is finished and close, we cannot reconnect to the port and make the connection. 
        
        
#SOCAT UDP proxy command:
    # Proxy 1: From Prod GN: $ sudo socat UDP4-RECVFROM:161,fork UDP4-SENDTO:172.16.0.1:4433
    # Proxy 2: From Cons GN: $ sudo socat UDP4-RECVFROM:4433,fork UDP4-SENDTO:172.16.1.1:161
    
# Cap:
    # $ sudo tcpdump udp -i ens7 -t -s 0 -c 100 and dst port ! 22 and src net 172.16.1.0/24 -w ./prodGn_WAN.cap
    # $ sudo tcpdump udp -i ens8 -t -s 0 -c 100 and dst port ! 22 and dst net 172.16.0.0/24 -w ./prodGn_LAN.cap
    # $ sudo tcpdump udp -i ens9 -t -s 0 -c 100 and dst port ! 22 and dst net 172.16.1.0/24 -w ./consGn_LAN.cap
    # $ sudo tcpdump udp -i ens8 -t -s 0 -c 100 and dst port ! 22 and src net 172.16.2.0/24 -w ./consGn_WAN.cap
    
    #simple cap:
    # sudo tcpdump udp -i ens8 -w ./prodGn_LAN.cap
    # sudo tcpdump udp -i ens7 -w ./prodGn_WAN.cap
    # sudo tcpdump udp -i ens7 -w ./consGn_WAN.cap
    # sudo tcpdump udp -i ens8 -w ./consGn_LAN.cap
    
