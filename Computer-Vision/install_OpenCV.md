# Install OpenCV

## 1. Ubuntu 16.04

- 일단 기존 설치된 것들 업그레이드부터

    ```sh
    sudo apt-get update && sudo apt-get upgrade
    sudo apt-get install git cmake
    ```

- GIMP toolkit library

    ```sh
    sudo apt-get install libgtk2.0-dev
    sudo pkg-config libgtk2.0-dev
    ```

- pip, pip3 설치
    + 처음에 pip3만 설치해서 라이브러리 깔았더니 opencv가 python2에는 래핑이 안됐다. 둘 다 깔고, 둘 모두에 각각 라이브러리를 설치하자(그냥 pip만 설치해도 Python3에 설치될지도 모르지만 그렇게는 안해봤다.)

    ```sh
    # pip
    sudo apt-get install python-dev curl
    curl -k -O https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py

    # pip3
    sudo apt-get install python3-pip
    ```

- opencv dependency 설치(이거 안하면 Python과 래핑이 안됨)

    ```sh
    sudo pip install numpy matplotlib jupyter
    sudo pip3 install numpy matplotlib jupyter
    sudo apt-get install libpng-dev libfreetype6-dev
    ```

- FFmpeg 설치: 동영상, 이미지의 인코딩/디코딩. 설치 후엔 shell에서 `ffmpeg` 를 입력해본다.

    ```sh
    sudo -i # root 권한의 shell 열기
    apt-get install -y yasm nasm libx264-dev
    cd /usr/src
    wget https://ffmpeg.org/releases/ffmpeg-3.3.2.tar.gz
    tar -xvzf ffmpeg-3.3.2.tar.gz
    cd ffmpeg-3.3.2
    ./configure --enable-libx264 --enable-gpl --enable-pic --enable-shared
    make -j8 && make install
    ldconfig
    exit
    ```

- OpenCV
    + OpenCV와 opencv_contrib이라는 추가 모듈까지 같이 설치한다.
    + 설치가 끝나면 파이썬 REPL에서 `import cv2` 해보면 된다.

    ```sh
    mkdir ~/opencv && cd ~/opencv
    wget https://github.com/opencv/opencv/archive/3.2.0.zip -O opencv-3.2.0.zip
    wget https://github.com/opencv/opencv_contrib/archive/3.2.0.zip -O opencv_contrib-3.2.0.zip
    unzip opencv-3.2.0.zip && unzip opencv_contrib-3.2.0.zip
    cd opencv-3.2.0
    mkdir build && cd build
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_CUDA=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D BUILD_EXAMPLES=ON -D WITH_FFMPEG=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.2.0/modules ..

    make -j8

    sudo make install
    sudo ldconfig
    ```
