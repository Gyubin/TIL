# Docker

참고 링크: [pyrasis 가장 빨리 만나는 도커](http://pyrasis.com/private/2014/11/30/publish-docker-for-the-really-impatient-book), [subicura 블로그](https://subicura.com/2017/01/19/docker-guide-for-beginners-1.html)

## 0. 설치 및 기본 명령어들

- [Download link](https://docs.docker.com/docker-for-mac/install/)로 들어가서 맥용 stable 버전을 다운받고 설치한다.
- 이미지 다운로드: `docker pull ubuntu:latest` 명령어로 원하는 이미지를 다운받을 수 있다. 다운이 끝나면 `docker images`로 이미지 목록을 확인할 수 있다.
- 컨테이너 실행: `docker run <option> <image-name> <exec-file>`
    + `docker run -i -t --name kaldi ubuntu /bin/bash`
    + `-i`(interactive), `-t`(Pseudo-tty): 실행된 Bash 셸에 입출력 작업 가능
    + `--name kaldi`: 컨테이너 이름을 kaldi로 지정
    + `ubuntu`: 이미지를 우분투로 선택
    + `/bin/bash`: 접속할 때 실행할 프로그램
- 접속한 상태에서 필요한 라이브러리를 설치하면 된다.
    + `apt-get update && apt-get upgrade`
    + `apt-get install git`
- 컨테이너를 종료: `exit`
- 컨테이너 프로세스 중단: `docker stop <container-name>`
- 종료 후 해당 컨테이너를 재시작하려면
    + `docker ps -a` : 모든 컨테이너 목록을 보여준다. `-a` 없이 쓰면 실행 중인 목록만 보여준다.
    + 원하는 컨테이너가 stop이거나 exited 상태라면 `docker start <container-name>` 명령으로 시작해준다. 시작이 되면 UP으로 변경될 것이다.
    + 실행 중일 때 재부팅을 하려면 `restart`
- 실행된 컨테이너에 접속: `docker attach kaldi`
- 컨테이너 삭제: `docker rm <container-name>`

## 1. 이미지

- 우리가 이용할 수 있는 이미지는 [Docker Hub](https://hub.docker.com/)에 등록되어있다.
- `docker search <image-name>` : 원하는 이미지를 검색할 수 있는 명령어
- `docker pull <image-name>:<tag>` : search 명령어로 검색한 이미지 이름에 버전을 지정해서 이미지를 다운받는 명령어. `latest`는 최신 버전을 의미한다.
- `docker images`: 이미지 목록
- `docker rmi <image-name>:<tag>` : 이미지 삭제

## 2 Dockerfile 구성

### 2.1 구조

```sh
# kaldi를 설치할 때의 Dockerfile이다. 메모리 꼭 4기가로 설정할것
FROM ubuntu:16.04
MAINTAINER Gyubin Son <geubin0414@gmail.com>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y vim git zlib1g-dev make gcc automake autoconf bzip2 wget libtool subversion python libatlas3-base g++
RUN ln -s -f bash /bin/sh
RUN cd ~ && git clone https://github.com/kaldi-asr/kaldi.git
RUN cd ~/kaldi/tools && make -j "$(nproc)"
RUN free -m && extras/install_irstlm.sh
RUN cd ~/../src/ && free -m && ./configure
RUN free -m && make depend -j "$(nproc)"
RUN free -m && make -j "$(nproc)"

CMD ["/bin/bash"]
```

- `FROM <image-name>:<tag>`: 베이스 이미지와 버전 지정
- `MAINTAINER: Gyubin Son <geubin0414 at gmail.com>`: 만든 사람 정보
- `RUN <script>` : 셸 스크립트 실행. 설치할 땐 `-y` 옵션을 붙여줘야 사용자 입력 생략 가능하다.
- `VOLUME ["/a", "/data", "/images"]` : 호스트 컴퓨터와 공유할 폴더.
    + `docker run -v <host dir>:<container-dir> ...`: docker run할 때 옵션으로 는 호스트와 컨테이너의 디렉터리를 연결할 수도 있다.
- `CMD ["nginx", "aaa", "bbb">`: 컨테이너가 시작되었을 때 실행할 실행 파일 또는 셸 스크립트
- `WORKDIR <dir>`: CMD에서 설정한 실행 파일이 실행될 디렉터리입니다.
- `EXPOSE <port-num>`: 호스트와 연결할 포트 번호입니다. 여러개 지정 가능. 예를 들어 80포트와 443 포트. 여러번 써주면 된다.

### 2.2 .dockerignore

- Dockerfile과 같은 디렉토리의 파일들을 context라고 한다.
- 필요없는 파일이 전송되지 않도록 .dockerignore 파일에 제외할 것들을 명시. `.git` 같은 것들 제외해주면 된다.
- 파일 매칭은 [Go 언어의 규칙](https://golang.org/pkg/path/filepath/#Match)을 따름

```
example/hello.txt
example/*.cpp
wo*
*.cpp
.git
```

### 2.3 Build

- `docker build --tag <image-name>:<version> <dockerfile-dir>` : Dockerfile을 이용해 이미지를 만든다. `--tag` 옵션으로 이미지명과 버전을 설정해줄 수 있고, 마지막에 꼭 도커파일 경로를 명시해줘야한다.
- `docker run --name <container-name> -d -p 80:80 -v /root/data:/data <image-name>:<tag>`
    + `docker run --name <container-name`: 컨테이너 이름 지정해서 실행
    + `-d`: 백그라운드 실행 옵션. 이렇게 실행하면 인터렉티브 셸 형태로 접근하기 위해 `attach` 명령이 안 먹힌다.
    + `-p 80:80`: 호스트의 80포트와 컨테이너의 80포트를 연결. `localhost:80`으로 연결하면 뜬다.(와우)
    + `-v /root/data:/data` : 호스트의 /root/data와 컨테이너의 /data 디렉토리를 연결. 컨테이너에서 호스트의 파일을 읽을 수 있다.
- 만약 다른 이미지(예를 들어 ubuntu official)에서 환경설정을 하고 그 상황을 이미지로 저장하고싶다면
    + `docker commit -a "Gyubin Son <geubin0414@gmail.com>" -m "kaldi install" kaldi kaldi-pure:0.1`
    + `-m "blah blah"`: commit 내용을 적어준다.
    + `<container-name> <image-name>:<tag>` : 이미지로 만들 컨테이너명과 새로 만들어질 이미지의 이름과 태그를 설정

## 3. Network

```sh
docker network create hello-network # network
docker run --name db -d --network hello-network mongo # db
docker run --name web -d -p 80:80 --network hello-network nginx # webserver
```

- container끼리 연결해야할 상황이 있다. 웹서버 컨테이너와 db컨테이너는 서로 연결되어야한다. 이 때 사용하는 것이 network다.
- `docker network create {network-name}` : 네트워크 생성
- `docker run --name db -d --network hello-network mongo` : mongo 이미지로 db라는 컨테이너명으로 생성하는데 hello-network와 연결한다.
- `docker run --name web -d -p 80:80 --netwrok hello-network nginx` nginx 이미지로 web 이름의 컨테이너를 생성하는데 포트는 양쪽 모두 80포트로 연결하고, hello-network와 연결한다.
- `docker exec -it web bash` : web 컨테이너에서 bash를 실행한다.
- `ping db` : 쉽게 연결된 컨테이너 이름으로 접근 가능하다.
    + `apt-get install iputils-ping` : ping이 없으면 설치

## 4. NVIDIA-Docker

참고 링크: [Towards Data Science](https://towardsdatascience.com/using-docker-to-set-up-a-deep-learning-environment-on-aws-6af37a78c551)

AWS AMI Deep Learning, Ubuntu CUDA8 인스턴스에서 다음처럼 설치했다. Docker로 GPU 메모리 제한은 못 걸고, 코드로 해야 여러 사람이 같이 사용 가능하다.

- 드라이버 업데이트

    ```sh
    sudo add-apt-repository ppa:graphics-drivers/ppa -y
    sudo apt-get update
    sudo apt-get install -y nvidia-375 nvidia-settings nvidia-modprobe
    ```

- Docker 설치

    ```sh
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    ```

- NVIDIA-Docker 설치. 버전 1은 아래 코드처럼 하고, **버전 2는 다음 [링크](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-\(version-2.0\))를 참고한다.**

    ```sh
    # Version 1
    sudo wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
    sudo dpkg -i /tmp/nvidia-docker_1.0.1-1_amd64.deb && rm /tmp/nvidia-docker_1.0.1-1_amd64.deb
    ```

- 확인하기. 다음처럼 실행해서 표 형태로 나오면 성공

    ```sh
    sudo nvidia-docker run --rm nvidia/cuda nvidia-smi
    ```

- TensorFlow 공식 이미지로 만들기
    + `sudo nvidia-docker run -it --mount type=bind,source="$(pwd)"/bookcorpus,target=/bookcorpus --name tf_gyubin tensorflow/tensorflow:latest-gpu bash`
    + mount 부분 옵션은 도커 컨테이너 밖에 있는 데이터를 도커 내에서 사용할 때 사용한다. 위 명령어에선 현재 디렉토리의 bookcorpus 디렉토리를 도커 컨테이너 내의 /bookcorpus 디렉토리 path로 사용할 수 있도록 만들어준다.
    + pip3가 설치가 안돼있을 것. 아래 명령어들로 pip3 설치하고, 가상환경 만들어서 tensorflow-gpu 설치해서 실행해보면 된다.

    ```sh
    apt-get update
    apt-get -y install python3-pip
    ```

- 도커에서 학습 등의 프로세스가 진행되고 있다면 종료가 아니라 그냥 detach 하고, 다시 접근할 때 attach 한다. detach는 tmux에서 하듯 `Ctrl+p Ctrl+q` 순서대로 눌러준다.
- 종료 후(`exit` 연타하면 됨) 해당 컨테이너를 재시작하려면
    + `sudo nvidia-docker ps -a` : 모든 컨테이너 목록을 보여준다. `-a` 없이 쓰면 실행 중인 목록만 보여준다.
    + 원하는 컨테이너가 stop이거나 exited 상태라면 `sudo nvidia-docker start <container-name>`명령으로 시작해준다. 시작이 되면 UP으로 변경될 것이다.
    + 실행 중일 때 재부팅을 하려면 `restart`
    + 실행된 컨테이너에 접속: `sudo nvidia-docker attach <container-name>`
