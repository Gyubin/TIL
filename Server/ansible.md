# Ansible

에이전트가 없는 배포 및 자동화 빌드 툴. 하나의 관리 서버에서 모든 node 서버들을 쉽게 중앙관리할 수 있다는 점이 가장 큰 장점이다.

## 1. 실습 환경 구성

- virtualbox를 이용해서 server 1대, node 2대를 만들 것이다.
- centos를 쓸 것이고 단순 테스트용이므로 [다운로드 링크](https://www.centos.org/download/)에서 minimal iso를 선택한다.(약 700메가)

### 1.1 Sever

- 먼저 가상머신을 만든다.
    + 이름은 Ansible-server
    + Linux의 Redhat 64비트 선택
- 추가 설정
    + "저장소 - 광학드라이브" 부분에 다운로드받은 iso 파일 지정
    + 네트워크 설정에서 "브리지 어댑터"로 변경(가상머신끼리 연결되어야하므로)
- 가상머신 시작하면 설치가 시작된다.
- 가상머신의 화면에서 초기 설정해준다.
    + 네트워크에서 Hostname을 알기 쉽게 Ansible-Server로 해준다.
    + 설치 경로 들어가서 확인 눌러주고
    + KDUMP는 용량확보를 위해 꺼준다.
- Root 비밀번호 설정한다. 비밀번호가 쉽다고 하면 Done을 2번 눌러주면 넘어감
- 시작하면 login은 root, 비밀번호는 방금 전 설정한 것이다.
- 끄려면 `poweroff` 명령어 치면 꺼진다.

### 1.2 Node

- 기존 서버 가상머신에 우클릭해서 복제한다.
- "모든 네트워크카드의 MAC 주소 초기화" 꼭 체크해줘야함
- 완전복제 선택
- 위처럼 2개 정도 만들어준다.
- 테스트용이므로 Node의 메모리는 512로 수정해준다.

### 1.3 세팅

- 모든 가상머신을 선택하고 실행한다.
- 시작하기 전 각 노드의 hostname이 복제를 해서 Ansible-Sever로 되어있을 것이다. 다음 명령어를 통해 각 hostname의 이름을 변경해준다.

    ```sh
    hostnamectl set-hostname Ansible-Node1
    hostnamectl set-hostname Ansible-Node2
    ```

- 먼저 내 IP를 확인한다. 맥이라면 터미널에서 `ifconcig | grep inet` 입력
    + ip: 192.168.1.7
    + netmask: 0xffffff00
    + gateway: 192.168.1.255
- 가상머신이 브릿지 네트워크로 되어있기 때문에 바꿔줘야한다. 위 정보에 따라서 각 가상머신을 다음처럼 설정하겠다.
    + ip는 192.168.1.10/24, 192.168.1.11/24, 192.168.1.12/24
    + DNS는 8.8.8.8 (구글)
    + gateway는 192.168.1.1
- 가상머신에서 `nmtui` 입력해서 GUI 화면으로 넘어간다.
    + IP address는 각각 맞는 것을 입력해주고, gateway에 동일하게 192.168.1.1를 입력한다.
    + DNS 부분은 8.8.8.8 입력
    + 아래쪽에 automatically connect도 스페이스바 눌러서 체크
    + OK -> BACK -> OK 눌러서 빠져나온다.
- `systemctl restart network`로 네트워크 재시작
- `ip add` 명령어를 통해 확인 가능, `ping google.com`으로 잘 동작하는지 확인한다.
- Node1, 2에 대해서도 같은 작업 반복

## 2. Ansible install

- 설치: 서버에만 하면 된다.
    + `yum install epel-release -y`
    + `yum install ansible -y`
- 설정
    + `vi /etc/ansible/hosts` 파일 편집해서 맨 아래에 연결해야할 노드의 ip를 입력한다.
    + `192.168.1.11`, `192.168.1.12` 한 줄씩 입력해줌
- 확인
    + `ansible all -m ping` 명령어 입력하면 추가하겠냐고 물음이 뜰거고 yes 엔터, yes 엔터 해주면 된다.
    + 그다음에 `ansible all -m ping -k` 해보면 잘 될 것임
- 접속: 터미널에서는 `ssh root@192.168.1.10` 형태로 접속하고 비밀번호 치면 된다.
- ip 관리 그룹 지정
    + `vi /etc/ansible/hosts` 로 파일 편집해서 이전에 ip 몇 가지를 입력했던 부분 바로 위에 `[nginx]` 입력한다.
    + 하위의 ip들을 nginx 이름으로 가리키겠다는 의미
    + `ansible nginx -m ping -k` 형태로 명령하면 nginx라는 이름으로 관리되고 있는 ip들에 연결이 된다.
- `/etc/ansible/ansible.cfg` 이 파일에 모든 설정 옵션들이 들어있으므로 원하는대로 커스텀한다.

## 3. 자주 사용하는 옵션

### 3.1 `-i`, `--inventory-file`

- 특정 파일을 활용해 적용될 호스트들에 대한 파일을 명시해줄 수 있다.
- test라는 파일을 만들어서 내부에 노드 ip 주소를 입력: `192.168.1.11` 문자열을 입력하고 저장한다.
- `ansible all -i test -m ping -k` 명령어로 실행한다. i 옵션의 타겟 파일이 방금 전 만든 test 파일이다.
- test 파일에서 지정한 노드만 연결이 된다.

### 3.2 `-m`, `--module-name`

- 모듈을 선택할 수 있도록 한다.
- 지금까지 썼던 명령어의 ping은 일반적으로 알고있는 ping이 아니라 파이썬 모듈이다.
- 즉 파이썬으로 다양한 모듈을 짜서 원하는 작업 실행 가능

### 3.3 `-k`, `--ask-pass`

- 패스워드를 물어보도록 설정한다.
- -k 옵션이 없으면 키 없어서 에러난다. 즉 -k는 패스워드를 물어보도록 해서 입력해서 접속할 수 있도록 하는 것
- 옵션 없이 쓴다는 것은 이미 키 파일이 있어서 자동으로 그걸 쓰겠다는 의미

### 3.4 `-K`, `--ask-become-pass`

- 관리자로 권한을 획득하겠다는 의미
- `ansible nginx -m ping -k -K` : 이런 식으로 -K 옵션을 추가하면 접속할 때 관리자 권한을 가질 수 있다. 특정 작업에 관리자 권한이 필요할 수 있으니 그 때 사용한다.
- 비밀번호를 한 번 더 물어보게 되는데 디폴트로 ssh 비밀번호와 동일하게 되기 때문에 그냥 엔터 치면 된다.

### 3.5 `--list-hosts`

- 적용되는 호스트들을 확인할 수 있다.
- 뒤에 이 옵션을 붙여주면 실행은 안되고 호스트만 출력해준다. 미리 확인하고 하면 좋음
- 예제
    + `ansible nginx -m ping --list-hosts`
    + `ansible all -i test -m ping --list-hosts`

## 4. 실제 사용하기

### 4.1 기본 명령어들

- uptime 확인 : `ansible all -m shell -a 'uptime' -k`
- 디스크 용량 확인 : `ansible all -m shell -a 'df -h'`
    + 디스크 용량 확인하는 명령어이고 -h는 human readable이란 의미다.
- 메모리 상태 확인 : `ansible all -m shell -a 'free -h' -k`
- 새로운 유저 만들기 : `ansible all -m user -a 'name=bloter password=1234' -k`
    + 근데 저렇게 만들면 실제로 bloter라는 유저가 만들어지긴 하지만 password가 달라진다. 암호화를 하기 때문.
    + 1234로 로그인하려면 1234를 암호화해서 넣어줘야 저 명령어에 넣어줘야한다.
- 파일 전송하기
    + `ansible nginx -m copy -a 'src=./hey.jpg dest=/tmp/' -k`
- 서비스 설치 : `ansible nginx -m yum -a 'name=httpd state=present' -k`
    + 각 node에 접속한 후 다음 명령어 중 하나로 설치 유무를 확인해본다.
    + `yum list installed | grep httpd`
    + `systemctl status httpd`

### 4.2 Playbook 기본 및 예제

- PlayBook : 다양한 명령어들을 모아서 하나의 파일을 만들고 Ansible이 실행하게 되는데 이 파일을 PlayBook이라고 한다.
- 다수의 서버에 웹서비스를 설치 및 기동해야할 때 편리하다.
    + 한 번의 명령어로 모든 서버에 한 번에 설치 및 실행 가능
    + 하나 하나 ssh로 접속해서 설치, 설정할 필요 없음
- 플레이북에 쓰여진 기능을 shell script로 할 수 있지 않느냐라고 생각할 수 있는데 약간 더 편리해졌다.
    + 예를 들어 아래 스크립트를 그냥 실행하게 되면 계속해서 중복해서 입력되게 된다. 물론 if 조건문을 활용해서 방지할 수는 있지만 불편하다.

    ```sh
    echo -e "[bloter]\n192.168.1.13" >> /etc/ansible/hosts
    cat /etc/ansible/hosts
    ```

- ansible을 활용하면 좀 더 쉬워진다. `vi bloter.yml` 명령어로 파일을 다음처럼 편집한다.
    + 아래처럼 입력하고 `ansible-playbook bloter.yml` 으로 실행
    + ok 사인이 뜨고, changed에 몇 줄이 변했는지 적힌다. 다시 실행하면 변화가 없으니 changed=0 처럼 적힐 것이다.

    ```yml
    ---
    - name: Ansible_vim
      hosts: localhost

      tasks:
      - name: Add ansible hosts
        blockinfile:
          path: /etc/ansible/hosts
          block: |
            [bloter]
            192.168.1.13
    ```

- 이번엔 nginx 예제: `vi nginx.yml`로 편집하고 아래 파일을 생성하면 ``ansible-playbook nginx.yml -k`로 실행한다.

    ```yml
    ---
    - hosts: nginx
      remote_user: root
      tasks:
        - name: install epel-release
          yum: name=epel-release state=latest
        - name: install nginx web server
          yum: name=nginx state=present
        - name: Start nginx web server
          service: name=nginx state=started
    ```
