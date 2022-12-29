#!/bin/bash

source /opt/anaconda3/bin/activate
conda activate

ARCH=$(uname -p)

if [[ "${ARCH}" =~ ^aarch64$ ]] ; then
    pip install numpy torch opencv-python torchvision typing \
        torchstat torchsummary ptflops onnx onnxruntime lxml scikit-image Pillow ffmpeg

else
    pip install numpy torch opencv-python torchvision typing \
        torchstat torchsummary ptflops onnx onnxruntime lxml scikit-image Pillow ffmpeg

    conda install -c conda-forge basemap matplotlib
fi
