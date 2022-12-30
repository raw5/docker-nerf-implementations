#!/bin/bash

echo "------------- Activating Conda ----------------"
source /opt/anaconda3/bin/activate
conda activate

cd $USER_HOME
chown -R 1000:1000 /home/kasm-default-profile/.bashrc

#Create environment
conda create --name sdfstudio -y python=3.8
conda activate sdfstudio

# Install Dependencies
pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 -f https://download.pytorch.org/whl/torch_stable.html


# Installing SDFStudio
# Installing Nerfsudio
echo "------------- Installing SDFStudio ----------------"
git clone https://github.com/autonomousvision/sdfstudio.git
cd sdfstudio
pip install --upgrade pip setuptools
pip install -e .
conda install -c conda-forge qt

conda deactivate
cd $USER_HOME

#Create environment
conda create --name nerfstudio -y python=3.8
conda activate nerfstudio

# Install Dependencies
pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 -f https://download.pytorch.org/whl/torch_stable.html

# Installing Nerfsudio
echo "------------- Installing Nerf Studio ----------------"
git clone https://github.com/nerfstudio-project/nerfstudio.git
cd nerfstudio
pip install --upgrade pip setuptools
pip install -e .
conda install -c conda-forge qt

# install tab completion
# ns-install-cli
conda deactivate

cd $HOME
