#ssh username@publicIP

#https://qiita.com/ebisennet/items/573618ab827ce1660b0e
#chmod u+x ubuntu1804_tensorflow220.sh
#./ubuntu1804_tensorflow220.sh

#上記手動
###########################################
#"""
#step1

#!/bin/bash
sudo apt update
sudo apt upgrade
sudo apt-get update

#https://qiita.com/pdv/items/1107bcdca7fa43de673d
# 事前準備
sudo apt install -y build-essential # c++コンパイラ
sudo apt install -y libffi-dev
sudo apt install -y libssl-dev # openssl
sudo apt install -y zlib1g-dev
sudo apt install -y liblzma-dev
sudo apt install -y libbz2-dev libreadline-dev libsqlite3-dev # bz2, readline, sqlite3

# pyenv本体のダウンロードとインストール
sudo apt install -y git
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# .bashrcの更新
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
source ~/.bashrc
pyenv -v # pyenvがインストールできたかを確認

# pythonのインストール
pyenv install 3.7.4 # 例えば，version 3.6.8
pyenv versions # インストール済みのpyenvのバージョンを確認できる
pyenv local 3.7.4 #(任意のディレクトリで実行)


#https://codelabo.com/posts/20200229081221
echo -e "\n## CUDA and cuDNN paths"  >> ~/.bashrc
echo 'export PATH=/usr/local/cuda-10.1/bin:${PATH}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64:${LD_LIBRARY_PATH}' >> ~/.bashrc
source ~/.bashrc
source ~/.bashrc


#https://www.tensorflow.org/install/gpu?hl=ja



pip install tensorflow==2.2 #stable

#pip install tf-nightly  # preview


#ubuntu18.04 CUDA10.1

echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.1/extras/CUPTI/lib64>> ~/.bashrc'
source ~/.bashrc
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.1/extras/CUPTI/lib64 #これはいらないかも


# Add NVIDIA package repositories
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo dpkg -i cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
sudo apt-get update
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt-get update

# Install NVIDIA driver
sudo apt-get install --no-install-recommends nvidia-driver-450
#sudo wget http://jp.download.nvidia.com/XFree86/Linux-x86_64/440.36/NVIDIA-Linux-x86_64-440.36.run
sudo reboot
# Reboot. Check that GPUs are visible using the command: nvidia-smi
##############################################################
#step2

#nvidia-smi
#上記コマンドを実行してnvdiaがうまく認識されているか確認

##############################################################
#step3
#step2がうまく行ってたらstep1,2をコメントアウトして再度 ./ubuntu1804_tensorflow220.sh
#"""

# Install development and runtime libraries (~4GB)
sudo apt-get install --no-install-recommends \
    cuda-10-1 \
    libcudnn7=7.6.4.38-1+cuda10.1  \
    libcudnn7-dev=7.6.4.38-1+cuda10.1


# Install TensorRT. Requires that libcudnn7 is installed above.
sudo apt-get install -y --no-install-recommends libnvinfer6=6.0.1-1+cuda10.1 \
    libnvinfer-dev=6.0.1-1+cuda10.1 \
    libnvinfer-plugin6=6.0.1-1+cuda10.1