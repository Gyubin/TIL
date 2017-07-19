# Ansible

에이전트가 없는 배포 및 자동화 빌드 툴

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
    + ip는 192.168.1.10, 192.168.1.11, 192.168.1.12
    + netmask는 255.255.255.0
    + gateway는 192.168.1.1
- 가상머신에서 `nmtui` 입력해서 GUI 화면으로 넘어간다.
    + IP address는 각각 맞는 것을 입력해주고, gateway에 동일하게 192.168.1.1를 입력한다.
    + 아래쪽에 automatically connect도 스페이스바 눌러서 체크
    + OK -> BACK -> OK 눌러서 빠져나온다.
- `systemctl restart network`로 네트워크 재시작
- `ip add` 명령어를 통해 확인 가능
- Node1, 2에 대해서도 같은 작업 반복

## 2. Ansible install

pass
