#!/bin/bash
## install essentials

conda install -c anaconda swig -y &&
conda install -c conda-forge pyzmq -y &&
conda install -c conda-forge tomopy -y &&
conda install -c conda-forge gcc=12.1.0 -y &&
conda install libgcc -y &&
pip install numpy h5py dxchange&&

# PRODUCER app
# cd mona-demo/streamer-daq

# CONSUMER app...

cd mona-demo/streamer-dist/ &&
make clean &&
# sudo vim Makefile
# change TPYHOME address to: /home/ubuntu/miniconda3
make &&

sudo lsof -i -P -n | grep LISTEN &&

echo done!

# PRODUCER app... location: cd ~/mona-demo/streamer-daq

#man
# --synch_count: is the expected number of data distributors/subscribers to connect this data source
# --synch_addr: is the address to be bind for synchronization
# --mode: is the data acquisition mode. 2 refers to generate random data with --num_sinograms, --numsinogram_columns, and num_sinogram_projections parameters.
# --publisher_addr: is the address to publish generated data to whatever node is subscribed. In this example there will be only one subscriber (synch_count=1).
# --num_sinograms: is the y-dimension of the data
# --num_sinogram_columns: is the x-dimension of the data
# --num_sinogram_projections: is the z-dimension of the data
# Note: Above example generates 10000 projections with (1024, 2048) dimension/image size (16bit per pixel).

## RUN the experiments
# ATTENTION: test 10000 projections. Be aware of the buffer size settings on SciStream!
# cd ~/mona-demo/streamer-daq
# python DAQStream.py --synch_count 1 --synch_addr tcp://*:17000 --mode 2 --publisher_addr tcp://*:7000 --num_sinograms 512 --num_sinogram_columns 1024 --num_sinogram_projections 1000


# CONSUMER app... location: cd ~/mona-demo/streamer-dist/

#man
# --data_source_addr: Data source process address to receive data (same as the bonded address above for pub)
# --data_source_synch_addr: Data source synchronization address (same as the bonded address above for sync)
# --uint16_to_float32: Convert 16bit data to 32bit float.

## RUN the experiments
## ATTENTION: make sure the port number match!!!
# E.g. Consumer S2DS listeners: ['172.16.2.1:36131', '172.16.2.1:43675', '172.16.2.1:36547', '172.16.2.1:42349', '172.16.2.1:37659']
# cd ~/mona-demo/streamer-dist/
# python ModDistStreamPubDemo.py --data_source_addr tcp://172.16.2.1:36733 --data_source_synch_addr tcp://172.16.2.1:37841 --uint16_to_float32

#python ModDistStreamPubDemo.py --data_source_addr tcp://192.168.0.3:45467 --data_source_synch_addr tcp://192.168.0.3:42991 --uint16_to_float32
