FROM pytorch/pytorch:1.5.1-cuda10.1-cudnn7-devel

ENV TZ=Asia/Shanghai                                                          
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
        g++ \
        git \
        wget \
        cmake \
        vim \
        libgl1-mesa-glx\
        libglib2.0-dev

WORKDIR /workspace

ENV ONNXRUNTIME_DIR="/workspace/mmcv/onnxruntime-linux-x64-1.5.1"\
    CPLUS_INCLUDE_PATH="${ONNXRUNTIME_DIR}/include:${CPLUS_INCLUDE_PATH}"\
    LD_LIBRARY_PATH="${ONNXRUNTIME_DIR}/lib:${LD_LIBRARY_PATH}"

RUN pip install onnxruntime==1.5.1 onnx && \
    git clone https://github.com/open-mmlab/mmcv.git && \
    cd mmcv && \
    wget https://github.com/microsoft/onnxruntime/releases/download/v1.5.1/onnxruntime-linux-x64-1.5.1.tgz && \
    tar -zxvf onnxruntime-linux-x64-1.5.1.tgz && \
    cd onnxruntime-linux-x64-1.5.1 && \
    cd /workspace && \
    git clone https://github.com/open-mmlab/mmdetection.git && \
    cd mmdetection && \
    pip install -r requirements/build.txt && \
    cd /workspace/mmdetection && \
    wget http://download.openmmlab.com/mmdetection/v2.0/faster_rcnn/faster_rcnn_r50_fpn_1x_coco/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth && \
    echo "from mmdet.apis import init_detector, inference_detector\n\
config_file = 'configs/faster_rcnn/faster_rcnn_r50_fpn_1x_coco.py'\n\
checkpoint_file = 'checkpoints/faster_rcnn/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth'\n\
device = 'cuda:0'\n\
model = init_detector(config_file, checkpoint_file, device=device)\n\
inference_detector(model, 'demo/demo.jpg')" >> verify.py && \
    mkdir -p checkpoints/faster_rcnn && mv faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth checkpoints/faster_rcnn/ && \
    cd /workspace && \
    echo "cd mmcv\n\
MMCV_WITH_OPS=1 MMCV_WITH_ORT=1 pip install -e .\n\
cd /workspace/mmdetection/\n\
pip install -v -e .\n\
python verify.py" >> mmcv_mmdet_build.sh 
