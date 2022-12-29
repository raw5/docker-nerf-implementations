#!/bin/bash

sudo apt install -y cmake libdrm-dev libsystemd-dev libncurses5-dev libncursesw5-dev gcc

cd /tmp
git clone https://github.com/Syllo/nvtop.git
mkdir -p nvtop/build && cd nvtop/build
cmake .. -DNVIDIA_SUPPORT=ON -DAMDGPU_SUPPORT=ON -DINTEL_SUPPORT=ON
make
make install
cd /tmp
rm -rf /tmp/nvtop
