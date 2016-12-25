# NGINX

## 0. 설치

### 0.1 nginx 설치

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

### 0.2 방화벽 설정

- CentOS 7부터 기본 방화벽 시스템이 firewalld로 변경되었다.
- `systemctl enable firewalld`: 재부팅시 자동으로 해당 방화벽이 실행되도록 변경
- `systemctl start firewalld`: 지금 당장 재부팅하지 않고 실행해야하니까 명령어 실행한다.
- `yum install firewalld`: 해당 방화벽을 관리할 수 있는 패키지다.
- 80포트를 허용해야하므로 아래 명령어 순차 실행
    + `firewall-cmd --permanent --zone=public --add-service=http`
    + `firewall-cmd --permanent --zone=public --add-service=https`
    + `firewall-cmd --reload`
