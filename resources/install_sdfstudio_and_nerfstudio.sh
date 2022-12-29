#!/bin/bash

source /opt/anaconda3/bin/activate
conda activate

ARCH=$(uname -p)

cd $HOME

#Create environment
conda create --name sdfstudio -y python=3.8
conda activate sdfstudio
python -m pip install --upgrade pip

# Install Dependencies
pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 -f https://download.pytorch.org/whl/torch_stable.html
pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch


# Installing SDFStudio
git clone https://github.com/autonomousvision/sdfstudio.git
cd sdfstudio
git clone https://github.com/autonomousvision/sdfstudio.git
cd sdfstudio
pip install --upgrade pip setuptools
pip install -e .

# Install Nerfstudio
cd $HOME
git clone git@github.com:nerfstudio-project/nerfstudio.git
cd nerfstudio
pip install --upgrade pip setuptools
pip install -e .
# install tab completion
ns-install-cli
cd $HOME
