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
- 

## 1. 이미지

### 1.1 기본

- 우리가 이용할 수 있는 이미지는 [Docker Hub](https://hub.docker.com/)에 등록되어있다.
- `docker search <image-name>` : 원하는 이미지를 검색할 수 있는 명령어
- `docker pull <image-name>:<tag>` : search 명령어로 검색한 이미지 이름에 버전을 지정해서 이미지를 다운받는 명령어. `latest`는 최신 버전을 의미한다.
- `docker images`: 이미지 목록
- `docker rmi <image-name>:<tag>` : 이미지 삭제

### 1.2 Dockerfile 구성

- `FROM <image-name>:<tag>`: 베이스 이미지와 버전 지정
- `MAINTAINER: Gyubin Son <geubin0414 at gmail.com>`: 만든 사람 정보
- `RUN <script>` : 셸 스크립트 실행. 설치할 땐 `-y` 옵션을 붙여줘야 사용자 입력 생략 가능하다.
- `VOLUME ["/a", "/data", "/images"]` : 호스트 컴퓨터와 공유할 폴더.
    + `docker run -v <host dir>:<container-dir> ...`: docker run할 때 옵션으로 는 호스트와 컨테이너의 디렉터리를 연결할 수도 있다.
- `CMD ["nginx", "aaa", "bbb">`: 컨테이너가 시작되었을 때 실행할 실행 파일 또는 셸 스크립트
- `WORKDIR <dir>`: CMD에서 설정한 실행 파일이 실행될 디렉터리입니다.
- `EXPOSE <port-num>`: 호스트와 연결할 포트 번호입니다. 여러개 지정 가능. 예를 들어 80포트와 443 포트. 여러번 써주면 된다.
