# NGINX

## 0. 설치

- CentOS에 설치하는 방법이다.
- nginx 전용 저장소 등록 `/etc/yum.repos.d/nginx.repo` 파일을 만들어서 아래 코드 입력

    ```
    [nginx]
    name=nginx repo
    baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
    gpgcheck=0
    enabled=1
    ```

- `sudo yum install nginx`: 설치 명령어
- `systemctl enable nginx`: 재부팅시 nginx가 자동 실행되도록 하기
- `systemctl start nginx`: 지금 당장 쓰기 위해서

## 1. 기본 설정

### 1.1 방화벽 설정

- CentOS 7부터 기본 방화벽 시스템이 firewalld로 변경되었다.
- `systemctl enable firewalld`: 재부팅시 자동으로 해당 방화벽이 실행되도록 변경
- `systemctl start firewalld`: 지금 당장 재부팅하지 않고 실행해야하니까 명령어 실행한다.
- `yum install firewalld`: 해당 방화벽을 관리할 수 있는 패키지다.
- 80포트를 허용해야하므로 아래 명령어 순차 실행
    + `firewall-cmd --permanent --zone=public --add-service=http`
    + `firewall-cmd --permanent --zone=public --add-service=https`
    + `firewall-cmd --reload`

### 1.2 설정 파일

- `/etc/nginx`: nginx 설정파일이 위치
    + `/etc/nginx/nginx.conf`: 기본 설정 파일이다.
    + `/etc/nginx/conf.d`: 위 기본 설정 파일에서 `server` 블락을 보면 이 디렉토리의 .conf 파일을 include하는 것을 볼 수 있다. server 설정해주면 된다.
- `/usr/share/nginx/html`: 디폴트 사용자 디렉토리

## etc. 에러 예시

- 80 port 에러
    + nginx를 start했을 때 `[emerg]: bind() to 0.0.0.0:80 failed (98: Address already in use)` 라는 에러가 난다면
    + `yum install -y psmisc` 패키지 설치한 후
    + `sudo fuser -k 80/tcp` 명령으로 80포트 사용하는 process를 없앤다.
    + 그 후 다시 start 해주면 된다. `systemctl start nginx.service`
- CentOS에서 루트 유저 만들기: `usermod -aG wheel username`
- uWSGI 설치하기
    + `yum groupinstall "Development Tools"`
    + `yum install python-devel`
    + `pip install uwsgi`
