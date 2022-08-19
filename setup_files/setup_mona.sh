#!/bin/bash
# This is a document on setup the environment of mona on producer app and consumer app. 


echo Hello, FABRIC. From node `hostname -s`
unzip mona-demo.zip &&
sudo add-apt-repository ppa:ubuntu-toolchain-r/test &&
sudo apt-get update &&
sudo apt-get upgrade -y &&
sudo apt-get dist-upgrade -y &&


## setup miniconda 
sudo wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh &&
sudo chmod +x Miniconda3-latest-Linux-x86_64.sh &&
./Miniconda3-latest-Linux-x86_64.sh &&

echo 'RELOGIN and run setup_mona_conda.sh'!
# Accept the terms, use default location, and runing conda init

#If you'd prefer that conda's base environment not be activated on startup, 
#   set the auto_activate_base parameter to false: 

# conda config --set auto_activate_base false

# *** Re-login to activate environmnent! ***

