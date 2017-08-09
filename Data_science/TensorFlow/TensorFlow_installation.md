# TensorFlow Installsation

1. Ubuntu 16.04 설치
2. Mac OSX Sierra 설치

## 1. Ubuntu 16.04

2017.8.8 기준

- NVIDIA 그래픽 드라이버를 배포하는 PPA 설치 및 업데이트

    ```sh
    sudo add-apt-repository ppa:graphics-drivers/ppa
    sudo apt-get update
    sudo apt-get install nvidia-375
    ```

- 재부팅: `sudo reboot`
- 잘 설치됐는지 확인: `nvidia-smi`

> 만약 무한 로그인 루프에 빠진다면 BIOS 설정에서 secure boot 옵션을 disabled 상태로 바꾼다.

- CUDA 툴킷 설치
    + https://developer.nvidia.com/cuda-downloads 로 들어가서 run 파일 다운로드
    + 실행: `sudo sh cuda_8.0.61_375.26_linux.run`
    + NVIDIA Accelerated Graphics Driver와 cuda sample을 제외하고 모두 yes
- 환경변수 설정

    ```sh
    echo -e "\n## CUDA and cuDNN paths"  >> ~/.bashrc
    echo 'export PATH=/usr/local/cuda-8.0/bin:${PATH}' >> ~/.bashrc
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:${LD_LIBRARY_PATH}' >> ~/.bashrc
    ```

- 환경변수 적용 확인
    + 위 bash 파일을 실행한 후: `source ~/.bashrc`
    + 잘 적용되었는지 확인: `nvcc --version`
- CuDNN 라이브러리 다운로드
    + https://developer.nvidia.com/rdp/cudnn-download
    + cuDNN v5.1 Library for Linux(파일명: cudnn-8.0-linux-x64-v5.1.tgz)
- CuDNN 파일 이동
    + 압축 해제: `tar xzvf cudnn-8.0-linux-x64-v5.1.tgz`
    + cuda 라는 폴더가 생겼을 것
    + `which nvcc` 로 cuda의 경로를 확인한 후(아마 /usr/local/cuda-8.0/bin/nvcc 일 것) 다음처럼 이동 및 권한 지정한다.

    ```sh
    sudo cp cuda/lib64/* /usr/local/cuda-8.0/lib64/
    sudo cp cuda/include/* /usr/local/cuda-8.0/include/
    sudo chmod a+r /usr/local/cuda-8.0/lib64/libcudnn*
    sudo chmod a+r /usr/local/cuda-8.0/include/cudnn.h
    ```

- 파일 이동 확인: `cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2`
- CUDA 인터페이스 설치: `sudo apt-get install libcupti-dev`
- 마지막으로 알맞은 가상환경을 설정한 후 텐서플로우 설치
    + `sudo apt-get install python3-pip python3-venv`
    + `python -m venv ./env_name`
    + `pip install tensorflow-gpu`

## 2. Mac OSX

참고 사이트: [공식문서](https://www.tensorflow.org/install/install_mac), [Mistobaan's gist](https://gist.github.com/Mistobaan/dd32287eeb6859c6668d), [srikanthpagadala blog](https://srikanthpagadala.github.io/notes/2016/11/07/enable-gpu-support-for-tensorflow-on-macos)

### 2.1 요구 조건

- TensorFlow GPU 버전으로 설치할 것이다. 다행히 맥북 GPU의 CUDA Compute Capability가 최저 기준인 3.0이었다.

    ```
    MacBook Pro (Retina, 15-inch, Early 2013)
    OS: macOS Sierra 10.12.3
    CPU: 2.4 GHz Intel Core i7
    메모리: 8GB 1600 MHz DDR3
    그래픽: NVIDIA GeForce GT 650M 1024 MB
            Intel HD Graphics 4000 1536 MB
    ```

- GPU 버전으로 이용하려면 TensorFlow 라이브러리 외에 다음을 갖춰야한다.
    + CUDA Toolkit 8.0
    + The NVIDIA drivers associated with CUDA Toolkit 8.0
    + cuDNN library v5.1
    + CUDA Compute Capability가 3.0 이상

### 2.2 CUDA 설치

```sh
# 설치 명령어
brew update && brew upgrade
brew install coreutils swig
brew cask install cuda
```

위 명령어로 cuda를 설치한 후 `brew cask info cuda` 명령어로 버전을 확인해본다. 나는 다음 결과를 얻었다.

```sh
cuda: 8.0.55
https://developer.nvidia.com/cuda-zone
/usr/local/Caskroom/cuda/8.0.55 (23 files, 1.3G)
From: https://github.com/caskroom/homebrew-cask/blob/master/Casks/cuda.rb
==> Name
Nvidia CUDA
==> Artifacts
```

### 2.3 NVIDIA cuDNN

- 먼저 [공식 홈페이지](https://developer.nvidia.com/cudnn)로 들어가서 **Register**한다. 여러가지 설문 조사를 해야할 것이 많다.
- 로그인 후 다시 공홈으로 가서 **Download** 버튼을 누르면 해당 라이브러리를 다운받을 수 있다.
- 아래 명령어로 압축을 풀고, cuda 디렉토리로 라이브러리 파일들을 옮긴다.

```sh
tar xzvf ~/Downloads/cudnn-7.5-osx-x64-v5.0-rc.tgz
sudo mv -v cuda/lib/libcudnn* /usr/local/cuda/lib
sudo mv -v cuda/include/cudnn.h /usr/local/cuda/include
```

### 2.4 dynamic loading

- 파이썬 스크립트로 라이브러리를 로딩하기 위해서 alias가 필요하다.

    ```sh
    export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:$DYLD_LIBRARY_PATH
    ```

- 이건 옵션이다. 내 경우는 TensorFlow가 위 디렉토리에서 `libcuda.dylib` 파일을 찾아야하는데 `libcuda.1.dylib` 파일을 찾기 때문에 segmentation fault가 계속 발생했다. 아래처럼 링크를 걸어준다.

    ```sh
    sudo ln -s /usr/local/cuda/lib/libcuda.dylib /usr/local/cuda/lib/libcuda.1.dylib
    ```

### 2.5 TensorFlow 설치

- TensorFlow 공홈에서 virtualenv를 활용하는 것을 권장했다.
- 가상환경을 만들고 버전은 Python3으로 한다.
- `pip3 install --upgrade tensorflow-gpu` 명령어로 설치한다.
- 다음 코드로 `test.py` 파일을 만들고 실행한다.

    ```py
    import tensorflow as tf
    hello = tf.constant('Hello, TensorFlow!') # Create a Constant operator
    sess = tf.Session()
    print sess.run(hello)
    ```
