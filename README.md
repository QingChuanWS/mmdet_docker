# MMDetection Docker 使用方法

本文档介绍 MMDetection Docker 文件的使用方法。

- 环境依赖：
```shell
CUDA 10.1
Docker version 20.10.5
```
Note: 需要安装 [Nvidia-Docker2](https://github.com/NVIDIA/nvidia-docker/)

- 使用方法：
    - 构建镜像并启动镜像：
    ```shell
    docker build -t mmdet:pytorch1.x -f Dockerfile/mmdet_torch1.x.Dockerfile
    docker run --runtime=nvidia -it mmdet:pytorch1.x /bin/bash
    ```
    - 在镜像中执行：
    ```shell
    sh mmcv_mmdet_build.sh 
    ```