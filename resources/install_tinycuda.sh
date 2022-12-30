#!/bin/bash

echo "------------- Activating Conda ----------------"
source /opt/anaconda3/bin/activate
conda activate

cd $USER_HOME

conda activate sdfstudio

echo "------------- Installing Tiny Cuda ----------------"
pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch
echo "------------- Finished Installing Tiny Cuda ----------------"