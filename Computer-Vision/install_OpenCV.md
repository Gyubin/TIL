# Install OpenCV on Ubuntu 16.04

- Docker 컨테이너를 만든다

    ```sh
    docker run -it -p 8888:8888 -p 6006:6006 --name opencv ubuntu /bin/bash
    ```

> OSX에는 설치하다가 포기했다

- 기본적인 것들부터 설치

    ```sh
    apt-get update && sudo apt-get upgrade
    apt-get install python python3 git cmake vim wget unzip curl
    ```

- GIMP toolkit library

    ```sh
    apt-get install libgtk2.0-dev
    pkg-config libgtk2.0-dev
    ```

- pip2, pip3 설치
    + python을 실행했을 때와 python3를 실행했을 때 불러오는 라이브러리 위치가 다르다. 그래서 pip를 두 버전 각각에 맞게 깔고, 라이브러리를 설치해야한다.
    + 두 버전 모두에 라이브러리를 설치해야 OpenCV가 각각의 파이썬에 잘 매핑된다.

    ```sh
    # pip
    apt-get install python-dev python-pip
    pip2 install -U pip

    # pip3
    apt-get install python3-pip
    pip3 install -U pip
    ```

- opencv dependency 설치(이거 안하면 Python과 매핑이 안됨)

    ```sh
    pip2 install numpy matplotlib jupyter
    pip3 install numpy matplotlib jupyter
    apt-get install libpng-dev libfreetype6-dev
    ```

- FFmpeg 설치: 동영상, 이미지의 인코딩/디코딩. 설치 후엔 shell에서 `ffmpeg` 를 입력해본다.

    ```sh
    # sudo -i # root 권한의 shell 열기 ubuntu에서만
    apt-get install -y yasm nasm libx264-dev
    cd /usr/src
    wget https://ffmpeg.org/releases/ffmpeg-3.3.2.tar.gz
    tar -xvzf ffmpeg-3.3.2.tar.gz
    cd ffmpeg-3.3.2
    ./configure --enable-libx264 --enable-gpl --enable-pic --enable-shared
    make -j8 && make install
    ldconfig
    # exit # root shell 닫기
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

    make -j4

    make install
    ldconfig
    ```

- 컨테이너 외부에서 jupyter notebook 실행하기

    ```sh
    jupyter notebook --ip 0.0.0.0 --allow-root
    ```

## 2. Mac OSX

다음 [링크](https://medium.com/@nszceta/python-3-6-opencv-3-2-and-pyenv-on-macos-sierra-6ebcebd6193e)가 잘 설명한 것 같은데 내 맥 환경과 pyenv가 충돌이 있어서 잘 안된다. pure한 상태라면 시도해봐도 좋을듯.
