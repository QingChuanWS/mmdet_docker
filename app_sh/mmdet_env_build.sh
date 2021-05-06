#!/bin/bash

apt update
apt install -y git wget vim
#libGL.so.1: cannot open shared object file: No such file or directory
apt install -y libgl1-mesa-glx
#ImportError: libgthread-2.0.so.0: cannot open shared object file: No such file or directory
apt install -y libglib2.0-dev

wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
tar -xvf Python-3.7.9.tgz
cd Python-3.7.9
./configure --with-ssl
make
make install
apt clean
rm -rf /var/lib/apt/lists/*
ln -s /usr/local/bin/pip3 /usr/bin/pip
rm /usr/bin/python
ln -s /usr/local/bin/python3 /usr/bin/python
pip install --upgrade pip

pip install onnxruntime==1.5.1 onnx

git clone https://github.com/open-mmlab/mmcv.git && cd mmcv
wget https://github.com/microsoft/onnxruntime/releases/download/v1.5.1/onnxruntime-linux-x64-1.5.1.tgz
tar -zxvf onnxruntime-linux-x64-1.5.1.tgz
cd onnxruntime-linux-x64-1.5.1
echo -e "export ONNXRUNTIME_DIR=$(pwd)" >> ~/.bashrc
echo -e "export CPLUS_INCLUDE_PATH=\$ONNXRUNTIME_DIR/include:\${CPLUS_INCLUDE_PATH}" >> ~/.bashrc
echo -e "export LD_LIBRARY_PATH=\$ONNXRUNTIME_DIR/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
cd ..
MMCV_WITH_OPS=1 MMCV_WITH_ORT=1 pip install -e .

cd /workspace && git clone https://github.com/open-mmlab/mmdetection.git && cd mmdetection
pip install -r requirements/build.txt
pip install -v -e .  # or "python setup.py develop"

echo -e "from mmdet.apis import init_detector, inference_detector

config_file = 'configs/faster_rcnn/faster_rcnn_r50_fpn_1x_coco.py'
# download the checkpoint from model zoo and put it in `checkpoints/`
# url: http://download.openmmlab.com/mmdetection/v2.0/faster_rcnn/faster_rcnn_r50_fpn_1x_coco/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth
checkpoint_file = 'checkpoints/faster_rcnn/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth'
device = 'cuda:0'
# init a detector
model = init_detector(config_file, checkpoint_file, device=device)
# inference the demo image
inference_detector(model, 'demo/demo.jpg')" > verify.py

wget http://download.openmmlab.com/mmdetection/v2.0/faster_rcnn/faster_rcnn_r50_fpn_1x_coco/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth
mkdir -p checkpoints/faster_rcnn && mv faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth checkpoints/faster_rcnn/
python verify.py