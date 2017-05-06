# Kaldi asr

Kaldi asr(automatic speech recognition) 음성인식 오픈소스 라이브러리 사용법 및 예제 정리

## 0. 설치

[jrmeyer 블로그 글](http://jrmeyer.github.io/kaldi/2016/01/26/Installing-Kaldi.html)을 참고했다. 물론 설치 매뉴얼이 GitHub 소스코드에 포함되어있긴 하지만 따라하기 좀 더 쉽다.

그리고 내 맥에서 계속 `nvcc fatal   : The version ('80100') of the host compiler ('Apple clang') is not supported` 에러가 떠서 도커를 이용해서 설치했다. 도커란 기술이 나와서 감사하다.

### 0.1 Start with Docker

- [Download link](https://docs.docker.com/docker-for-mac/install/)로 들어가서 맥용 stable 버전을 다운받고 설치한다.
- 설치 후 preferences에서 **메모리를 넉넉하게 4GB로 설정**해준다. 
    + g++ 컴파일할 때 메모리가 부족하면 `g++ internal compiler error killed (program cc1plus)` 에러가 무조건 발생하게 돼있다.
    + 2GB일 때 IRSTLM 설치에서 위 에러가 났고, `free -m` 명령어로 메모리를 확보한 뒤 다시 설치하니 성공했다.
    + 여전히 도커 메모리가 2GB일 때 마지막 make에서 같은 에러가 났으며 `free -m`으로는 해결이 안됐다. 도커 환경설정에서 메모리를 4GB로 바꾸고, 메모리를 확보한 후에 make하니 정상적으로 설치됐다. 나중에 메모리 낮추면 되니 4GB로 해두고 한 번에 설치 성공하는게 좋겠다.
- `docker pull ubuntu:latest` : 먼저 우분투 이미지 파일을 받는다. 설치가 끝나면 `docker images` 명령어로 설치된 이미지 목록을 확인할 수 있다.
- `docker run -i -t --name kaldi ubuntu /bin/bash`
    + `-i`(interactive), `-t`(Pseudo-tty): 실행된 Bash 셸에 입출력 작업 가능
    + `--name kaldi`: 컨테이너 이름을 kaldi로 지정
    + `ubuntu`: 이미지를 우분투로 선택
    + `/bin/bash`: 접속할 때 실행할 프로그램
- 접속한 상태에서 라이브러리를 설치하기 시작하면 된다. 기본적으로 다음 설치
    + `apt-get update && apt-get upgrade`
    + `apt-get install git`
- exit으로 컨테이너를 종료하고 빠져나올 수 있다.
- 종료 후 해당 컨테이너를 재시작하려면
    + `docker ps -a` : 모든 컨테이너 목록을 보여준다. `-a` 없이 쓰면 실행 중인 목록만 보여준다.
    + 원하는 컨테이너가 stop이거나 exited 상태라면 `docker restart <container-name>` 명령으로 재시작해준다. 재시작하면 UP으로 변경될 것이다.
    + `docker attach kaldi`: 실행된 컨테이너에 접속

### 0.2 소스 파일 받아오기

- `git clone https://github.com/kaldi-asr/kaldi.git` : GitHub 저장소에서 소스 파일을 클론해온다.
- 루트 디렉토리에 `INSTALL`이라는 파일이 있을 것이고 tools, src 디렉토리의 `INSTALL` 파일들을 따라하라는 내용이 적혀있다.

### 0.3 tools/INSTALL

- `cd tools` 해당 디렉토리로 들어가서
- `extras/check_dependencies.sh` : prerequisites가 갖춰져있는지 확인하는 스크립트 파일 실행한다. 이러이러한 라이브러리가 없으니 이렇게 설치해라 라고 친절히 설치 명령어를 제안해주니 그대로 복사해서 붙여넣으면 된다. OK 사인이 뜰 때까지 계속 설치하고 체크하는 것을 반복한다.
- 맥에선 `sysctl -n hw.ncpu`, 리눅스에선 `nproc`으로 내 CPU 프로세서가 몇 개인지 확인하한다.
- `make -j 4` : 프로세서가 4개면 이렇게 명령어를 입력하면 된다.
- 아마 다음과 같은 warning이 뜰 것이다. [IRSTLM](http://hlt-mt.fbk.eu/technologies/irstlm)은 language modeling toolkit이다.

    ```sh
    Warning: IRSTLM is not installed by default anymore. If you need IRSTLM
    Warning: use the script extras/install_irstlm.sh
    ```

- `extras/install_irstlm.sh` : IRSTLM 설치 스크립트다. 실행하기 전에 `free -m` 해주면 좋다. 설치가 끝나면 `/usr/local`에서 확인할 수 있다. 나중에 사용하려면 `tools/extras/env.sh` 스크립트를 실행한다.

### 0.4 src/INSTALL

- `cd ../src/` : tools 디렉토리에서 빠져나가 src로 들어간다.
- `./configure` : 설정 스크립트 실행
- `make depend -j 4` : 의존성 설치
- `make -j 4` : 마지막 설치하면 끝인데 역시 미리 `free -m` 해준다.

### 0.5 (최종) 셸 스크립트 모음

도커 실행 후 아래 명령어들 복붙하면 오랜 시간 후 kaldi 설치가 완료될 것이다.

```sh
apt-get update && apt-get upgrade -y
apt-get install -y vim git zlib1g-dev make gcc automake autoconf bzip2 wget libtool subversion python libatlas3-base g++
ln -s -f bash /bin/sh
cd ~ && git clone https://github.com/kaldi-asr/kaldi.git
cd ~/kaldi/tools && make -j "$(nproc)"
free -m && ~/kaldi/tools/extras/install_irstlm.sh
free -m && cd ~/kaldi/src && ./configure
free -m && cd ~/kaldi/src &&  make clean && make depend -j "$(nproc)"
free -m && cd ~/kaldi/src &&  make -j "$(nproc)"
```
