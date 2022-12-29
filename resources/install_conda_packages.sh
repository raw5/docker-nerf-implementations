#!/bin/bash

source /home/kasm-default-profile/anaconda3/bin/activate
conda activate

ARCH=$(uname -p)

if [[ "${ARCH}" =~ ^aarch64$ ]] ; then
    pip install numpy opencv-python typing \
        ptflops onnx onnxruntime lxml scikit-image Pillow ffmpeg

else
    pip install numpy opencv-python typing \
        ptflops onnx onnxruntime lxml scikit-image Pillow ffmpeg

    conda install -c conda-forge basemap matplotlib
fi
