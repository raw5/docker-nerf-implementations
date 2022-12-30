#!/bin/bash

echo "------------- Activating Conda ----------------"
source /opt/anaconda3/bin/activate
conda activate

# cd $USER_HOME

# #Create environment
# conda create --name sdfstudio -y python=3.8
# conda activate sdfstudio
# python -m pip install --upgrade pip

# # Install Dependencies
# pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 -f https://download.pytorch.org/whl/torch_stable.html
# pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch


# # Installing SDFStudio
# git clone https://github.com/autonomousvision/sdfstudio.git
# cd sdfstudio
# pip install --upgrade pip setuptools
# pip install -e .
# # install tab completion
# ns-install-cli
# conda deactivate

# Install Nerfstudio
cd $USER_HOME

echo "------------- Creating Nerf Studio Env ----------------"
#Create environment
conda create --name nerfstudio -y python=3.8
conda activate nerfstudio
python -m pip install --upgrade pip

# Install Dependencies
echo "------------- Installing Torch ----------------"
pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 -f https://download.pytorch.org/whl/torch_stable.html
echo "------------- Installing Tiny Cuda ----------------"
pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch


# Installing Nerfsudio
echo "------------- Installing Nerf Studio ----------------"
git clone https://github.com/nerfstudio-project/nerfstudio.git
cd nerfstudio
pip install --upgrade pip setuptools
pip install -e .

# install tab completion
chown -R 1000:1000 /home/kasm-default-profile/.bashrc
ns-install-cli
conda deactivate

cd $HOME
