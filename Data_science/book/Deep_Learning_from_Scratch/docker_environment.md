# Docker 환경 세팅

책에 텐서플로우 내용은 없지만 중간중간 개인적으로 관련 코드를 짜보려 한다. 아직 Python 3.5 버전이 범용적으로 지원되고 있어서 도커 환경에서 진행할 것이다.

내 맥북의 Python 버전은 3.6이고 homebrew가 관리하고 있다. 3.5로 버전 내리기도 싫고, [Macports](https://www.macports.org/)같은 다른 도구로 3.5를 깔아서 관리가 분산되는 것도 싫다. 가장 큰 것은 3.5 추가로 깔았다가 현재 맥북 세팅과 충돌할까봐 무섭다.

## 1. 도커 컨테이너 만들기

CPU-only로 설치한다.

- `docker pull ubuntu:latest` : 우분투 최신 이미지 받기
- `docker run -it -p 8888:8888 -p 6006:6006 --name dl-scratch gcr.io/tensorflow/tensorflow /bin/bash` : 컨테이너 생성
    + `-p hostPort:containerPort` : 포트 설정이다. 컨테이너 외부로 jupyter notebook과 tensorboard 실행하기 위해 설정한다. 8888은 주피터, 6006은 텐서보드 용이다.
    + gcr.io 부분은 TensorFlowCPUImage 를 지칭한다. 이미지를 바로 지정해서 쉽게 사용
    + 컨테이너명을 'dl-scratch'라고 정했다. 원하는 것으로 변경

## 2. 기본 세팅

텐서플로우 측에서 제공하는 이미지를 설치했기 때문에 웬만한 것은 설치돼있다.

- 현재 설치된 목록 업데이트 및 업그레이드

    ```sh
    apt-get update && apt-get upgrade
    ```

- Python 2.7.12와 3.5.2 버전이 설치돼있다. vim 에디터, git만 추가 설치해준다.

    ```sh
    apt-get install vim git
    ```

- pip3 설치 및 업그레이드

    ```sh
    apt-get install python3-pip
    pip3 install --upgrade pip
    ```

## 3. 라이브러리 설치

- numpy, pandas

    ```sh
    pip3 install numpy
    pip3 install pandas
    ```

- tensorflow 설치

    ```sh
    pip3 install tensorflow
    ```
