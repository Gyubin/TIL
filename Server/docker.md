# Docker

참고 링크: [pyrasis 가장 빨리 만나는 도커](http://pyrasis.com/private/2014/11/30/publish-docker-for-the-really-impatient-book), [subicura 블로그](https://subicura.com/2017/01/19/docker-guide-for-beginners-1.html)

## 0. 설치 및 실행

- [Download link](https://docs.docker.com/docker-for-mac/install/)로 들어가서 맥용 stable 버전을 다운받고 설치한다.
- 이미지 다운로드: `docker pull ubuntu:latest` 명령어로 원하는 이미지를 다운받을 수 있다. 다운이 끝나면 `docker images`로 이미지 목록을 확인할 수 있다.
- 컨테이너 실행: `docker run -i -t --name kaldi ubuntu /bin/bash`
    + `-i`(interactive), `-t`(Pseudo-tty): 실행된 Bash 셸에 입출력 작업 가능
    + `--name kaldi`: 컨테이너 이름을 kaldi로 지정
    + `ubuntu`: 이미지를 우분투로 선택
    + `/bin/bash`: 접속할 때 실행할 프로그램
- 접속한 상태에서 필요한 라이브러리를 설치하면 된다.
    + `apt-get update && apt-get upgrade`
    + `apt-get install git`
- 컨테이너를 종료: `exit`
- 종료 후 해당 컨테이너를 재시작하려면
    + `docker ps -a` : 모든 컨테이너 목록을 보여준다. `-a` 없이 쓰면 실행 중인 목록만 보여준다.
    + 원하는 컨테이너가 stop이거나 exited 상태라면 `docker restart <container-name>` 명령으로 재시작해준다. 재시작하면 UP으로 변경될 것이다.
    + `docker attach kaldi`: 실행된 컨테이너에 접속
