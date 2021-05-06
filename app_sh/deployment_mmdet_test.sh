#!/bin/bash

cd mmdetection

mkdir -p checkpoints/faster_rcnn
if [ ! -f "checkpoints/faster_rcnn/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth" ];then
  wget -P $(pwd)/checkpoints/faster_rcnn http://download.openmmlab.com/mmdetection/v2.0/faster_rcnn/faster_rcnn_r50_fpn_1x_coco/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth   
fi
echo -e "\n---------------------------------\n" | tee model_test.log
python tools/deployment/pytorch2onnx.py configs/faster_rcnn/faster_rcnn_r50_fpn_1x_coco.py \
                checkpoints/faster_rcnn/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth  \
                --output-file checkpoints/faster_rcnn/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.onnx \
                --input-img demo/demo.jpg \
                --test-img tests/data/color.jpg \
                --verify $1 | tee -a model_test.log
echo -e "\n---------------------------------\n" | tee -a model_test.log

mkdir -p checkpoints/fcos
if [ ! -f "checkpoints/fcos/fcos_r50_caffe_fpn_gn-head_1x_coco-821213aa.pth" ];then
  wget -P $(pwd)/checkpoints/fcos https://openmmlab.oss-cn-hangzhou.aliyuncs.com/mmdetection/v2.0/fcos/fcos_r50_caffe_fpn_gn-head_1x_coco/fcos_r50_caffe_fpn_gn-head_1x_coco-821213aa.pth
fi
echo -e "\n---------------------------------\n" | tee -a model_test.log
python tools/deployment/pytorch2onnx.py configs/fcos/fcos_r50_caffe_fpn_gn-head_1x_coco.py \
                checkpoints/fcos/fcos_r50_caffe_fpn_gn-head_1x_coco-821213aa.pth \
                --output-file checkpoints/fcos/fcos_r50_caffe_fpn_gn-head_1x_coco-821213aa.onnx \
                --input-img demo/demo.jpg \
                --test-img tests/data/color.jpg \
                --shape 1333 800 \
                --mean 102.9801 115.9465 122.7717 \
                --std 1. 1. 1. \
                --verify $1 | tee -a model_test.log
echo -e "\n---------------------------------\n" | tee -a model_test.log

mkdir -p checkpoints/fsaf
if [ ! -f "checkpoints/fsaf/fsaf_r50_fpn_1x_coco-94ccc51f.pth" ];then
  wget -P $(pwd)/checkpoints/fsaf http://download.openmmlab.com/mmdetection/v2.0/fsaf/fsaf_r50_fpn_1x_coco/fsaf_r50_fpn_1x_coco-94ccc51f.pth
fi
echo -e "\n---------------------------------\n" | tee -a model_test.log
python tools/deployment/pytorch2onnx.py configs/fsaf/fsaf_r50_fpn_1x_coco.py \
                checkpoints/fsaf/fsaf_r50_fpn_1x_coco-94ccc51f.pth \
                --output-file checkpoints/fsaf/fsaf_r50_fpn_1x_coco-94ccc51f.onnx \
                --input-img demo/demo.jpg \
                --test-img tests/data/color.jpg \
                --verify $1 | tee -a model_test.log
echo -e "\n---------------------------------\n" | tee -a model_test.log

mkdir -p checkpoints/retinanet
if [ ! -f "checkpoints/retinanet/retinanet_r50_fpn_1x_coco_20200130-c2398f9e.pth" ];then
  wget -P $(pwd)/checkpoints/retinanet http://download.openmmlab.com/mmdetection/v2.0/retinanet/retinanet_r50_fpn_1x_coco/retinanet_r50_fpn_1x_coco_20200130-c2398f9e.pth
fi
echo -e "\n---------------------------------\n" | tee -a model_test.log
python tools/deployment/pytorch2onnx.py configs/retinanet/retinanet_r50_fpn_1x_coco.py \
                checkpoints/retinanet/retinanet_r50_fpn_1x_coco_20200130-c2398f9e.pth \
                --output-file checkpoints/retinanet/retinanet_r50_fpn_1x_coco_20200130-c2398f9e.onnx \
                --input-img demo/demo.jpg \
                --test-img tests/data/color.jpg \
                --verify $1 | tee -a model_test.log
echo -e "\n---------------------------------\n" | tee -a model_test.log

mkdir -p checkpoints/ssd
if [ ! -f "checkpoints/ssd/ssd300_coco_20200307-a92d2092.pth" ];then
  wget -P $(pwd)/checkpoints/ssd http://download.openmmlab.com/mmdetection/v2.0/ssd/ssd300_coco/ssd300_coco_20200307-a92d2092.pth
fi
echo -e "\n---------------------------------\n" | tee -a model_test.log
python tools/deployment/pytorch2onnx.py configs/ssd/ssd300_coco.py \
                checkpoints/ssd/ssd300_coco_20200307-a92d2092.pth \
                --output-file checkpoints/ssd/ssd300_coco_20200307-a92d2092.onnx \
                --input-img demo/demo.jpg \
                --test-img tests/data/color.jpg \
                --shape 300 300 \
                --mean 123.675 116.28 103.53 \
                --std 1. 1. 1. \
                --verify $1 | tee -a model_test.log
echo -e "\n---------------------------------\n" | tee -a model_test.log

mkdir -p checkpoints/yolo
if [ ! -f "checkpoints/yolo/yolov3_d53_mstrain-608_273e_coco-139f5633.pth" ];then
  wget -P $(pwd)/checkpoints/yolo http://download.openmmlab.com/mmdetection/v2.0/yolo/yolov3_d53_mstrain-608_273e_coco/yolov3_d53_mstrain-608_273e_coco-139f5633.pth
fi
echo -e "\n---------------------------------\n" | tee -a model_test.log
python tools/deployment/pytorch2onnx.py configs/yolo/yolov3_d53_mstrain-608_273e_coco.py \
                checkpoints/yolo/yolov3_d53_mstrain-608_273e_coco-139f5633.pth \
                --output-file checkpoints/yolo/yolov3_d53_mstrain-608_273e_coco-139f5633.onnx \
                --input-img demo/demo.jpg \
                --test-img tests/data/color.jpg \
                --shape 608 608 \
                --mean 0. 0. 0. \
                --std 255. 255. 255. \
                --verify $1 | tee -a model_test.log
echo -e "\n---------------------------------\n" | tee -a model_test.log
