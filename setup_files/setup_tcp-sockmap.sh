#!/bin/bash
## Read carefully about the following before make
## ATTENTION: linux core version is very important, this setup file use ubuntu-20.04, please give some space for linux source to be complied.
## ATTENTION2: REQUIRE ROOT ACCESS!
## uname -a
#### Linux db0ba4ac-e700-4542-bc2d-e17e16158494-h1 5.4.0-97-generic #110-Ubuntu SMP Thu Jan 13 18:22:13 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

echo Hello, FABRIC. Now installing sockmap proxy and dependencies. From node `hostname -s` &&
sudo apt-get update &&

sudo apt install -y clang llvm flex bison libelf-dev &&

#Compiling requires having installed:
# * clang >= version 3.4.0
# * llvm >= version 3.7.1

#Note that LLVM's tool 'llc' must support target 'bpf', list version
#and supported targets with command: ``llc --version``

sudo apt-get install -y linux-source &&

#### ATTENTION AGAIN! As of Aug 2022, the linux source version is 5.4.0 by default when apt-get, please keep updated if new system 

cd /usr/src/linux-source-5.4.0 &&

## ROOT access requires here! 
sudo su <<EOF
tar -xf linux-source-5.4.0.tar.bz2 &&
cd linux-source-5.4.0/samples/bpf &&

#sudo vim sockmap_kern.c
#ADD sockmap_kern.c
#sudo vim sockmap_user.c
#ADD sockmap_user.c
#sudo vim Makefile 
#ADD (line 56): hostprogs-y += sockmap
#ADD (line 113): sockmap-objs := sockmap_user.o
#ADD (line 175): always += sockmap_kern.o

cp -r /home/ubuntu/sockmap_code/* /usr/src/linux-source-5.4.0/linux-source-5.4.0/samples/bpf/ &&


cd ../../ &&
make -C tools clean &&
make -C samples/bpf clean &&
make clean &&
make defconfig &&
make headers_install &&
make M=samples/bpf &&
# IGNORE ERRORS (that is because of the kernel version file outdated): ./include/linux/spinlock.h:60:10: fatal error: 'asm/mmiowb.h' file not found

cd samples/bpf &&
# !!!! Check compiled files: sockmap & sockmap_kern.o & sockmap_user.o

# If error: RE-COMPILE
#cd ../../
#make -C samples/bpf clean
#make M=samples/bpf
#cd samples/bpf
EOF

echo done!

## Unknown BUG: may require re-login the command-line to activate something???
## Other unknown bug: if still facing block, maybe use simple nc test to start ebpf first??? What's the logic behind this? 
#RUN EXPERIMENTS:
#1. Open Sockmap Proxy (ROOT REQUIRE!):
#    cd /usr/src/linux-source-5.4.0/linux-source-5.4.0/samples/bpf/
#    ./sockmap 0 0 192.168.0.1 17000
#    ./sockmap 0 0 192.168.0.1 7000
#    ./sockmap 0 0 192.168.0.2 12345 (for chain, port given by proxy 1)
#    ./sockmap 0 0 192.168.0.2 23456 (for chain, port given by proxy 1)
#2. Type something on nc port 7000 and receive by nc port 12345
#    nc -l 7000
#    nc 192.168.0.2 12345
#3. Validation on streaming: (on proxy node)
#    sudo cat /sys/kernel/debug/tracing/trace_pipe
    
#TODO: 
#1.run the proxy code first and then the listening port. --done
#2.how to run remotely for both side? --done