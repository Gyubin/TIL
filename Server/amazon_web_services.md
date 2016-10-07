# AWS - Amazon Web Services

단순히 웹 호스팅, 서버라고 지칭할 수 없을만큼 거대한 서비스다. 클라우드 서비스이며 "서버의 구매, 구축, 운영을 대행"해준다. 가상화 기술을 통해 물리적 서버를 잘게 쪼개 필요한 사람에게 필요한 만큼만 제공해줄 수 있고, 오토 스케일링, 종량제(사용한 만큼만 과금) 등 다양한 기능이 존재한다. 개발자에게 필수 서비스이다.

## 1. 대표적 서비스들

### 1.1 EC2 - Elastic Compute Cloud

- 독립적인 컴퓨터 한 대를 아마존 인프라에 설치한다고 생각하면 됨
- 웹서버, 애플리케이션 서버로 사용.
- T가 일반적인 것이고 M은 메모리에서 더 좋은 것, C는 CPU 성능이 더 좋은 것이다. 앞에 Family 칸에 붙어있는 설명을 보면 대충 필요한 것을 알 수 있다.
- EBS: EC2의 저장용량을 의미한다. 30기가까지는 무료다. 리눅스는 8기가로 오케이. 그리고 Volume Type은 저장장치의 종류인데 마그네틱이 가장 느리고 provisioned는 IOPS 수치를 높게 해서 성능을 더 높일 수 있다. "Delete on Terminations"을 체크하면 EC2를 terminate했을 때 EBS도 같이 지워진다. 체크를 안하면 남아있다.
- Tag는 Key, Value 쌍으로 여러가지 입력해줄 수 있다.
- Security Group: 네트워크에서 어떤 타입으로(SSH, HTTP, HTTPS 등) 인스턴스에 접근하는 것을 허용할 것인가에 대한 것이다. 기본적으로 터미널로 접근할 때는 SSH가 Anywhere로 돼있으면 된다. 만약 SSH가 My IP로 돼있으면 현재 위치 IP가 자동으로 적용된다. 또한 해당 인스턴스를 웹서버로 이용한다면 HTTP 타입으로 열어서 Anywhere로 해주면 된다. 만약 윈도우 서버라면 RDP 타입이 추가로 필요하다.
- 비밀번호: 매우 긴 길이의 문자로 이루어져있는 pem 파일을 이용한다. 새로 만들거나, 기존에 있는 것을 이용할 수 있다. 한 번 파일 받으면 다시는 제공받지 못하기 때문에 잘 간수해야함.
- 연결하기: 인스턴스 우클릭해서 connect 눌러보면 설명 나온다. `ssh -i "webs_server.pem" ubuntu@54.249.221.234`로 들어가고 `exit`으로 빠져나온다.

### 1.2 S3 - Simple Storage Service

- 파일 서버. 무제한으로 저장 가능하기 때문에 파일 서버로 사용한다. EC2는 용량 제한이 있다.
- 스케일은 아마존 인프라가 담당하기 때문에 동접 트래픽 걱정 안해도 된다.
- 단일 파일이 1 byte에서 5 tera byte 까지 가능하다.
- 파일이 업로드 되었을 때 이벤트로 잡을 수 있다. 뭔가 다른 추가 동작을 설정할 수 있음.
- 사용 방법
    + GUI: S3 들어가서 bucket을 만든다. region은 서비스 지역과 가장 가까운 곳으로 선택하면 된다. 업로드 버튼을 눌러서 파일을 올리면 되고, 올리면 각 파일마다 고유 링크가 만들어진다. 하지만 이렇게 사용하는 경우는 거의 없다.
    + SDK: nodejs를 이용한 S3 SDK. https://opentutorials.org/module/1946/11797

### 1.3 RDS - Relational Database Service

- MySQL, Oracle, SQL Server 지원
- 백업, 리플리케이션같은 것을 아마존 인프라가 제공하기 때문에 굉장히 편리

### 1.4 ELB - Elastic Load Balancing

- EC2로 유입되는 트래픽을 여러대의 EC2로 부하 분산
- 인스턴스를 항상 체크해서 장애가 발생한 EC2는 자동으로 배제.
- Auto Scaling 기능 존재. 트래픽에 따라서 자동으로 똑같은 이미지 EC2를 생성하고 삭제한다.(Cloud watch)

## 2. Region, Availability zone

- Region: 데이터 센터. 서비스 할 지역과 가까워야 한다. 내 위치에서 하는게 아니다. [cloudping](http://www.cloudping.info)에서 현재 접속 지역과 각 리전에 대한 속도를 확인할 수 있다.
- AZ: 한 region에서 백업 등의 이유로 다른 zone이 존재한다. 서울은 2개, 일본은 3개 등이 있다. 자연재해나 장애로 인해 문제가 발생할 소지가 있기 때문에 존재한다. 같은 region에서 각 AZ들은 전용선으로 연결돼있어서 매우 빠른 속도로 데이터 백업 등이 가능하다.

## 3. 인스턴스 종류

- On-demand: 사용하는 만큼만 내는 가장 일반적인 과금 정책
- 예약: 미리 결제하면 할인 받는 것. 1년, 3년 미리 결제 가능하다.
- 스팟: AWS의 노는 컴퓨터가 많아지면 가격이 실시간으로 떨어진다. bidding이 들어감.

## 4. Marketplace

- 다른 사람들이 만든 이미지를 쓸 수 있다. AWS Marketplace에서 보면 사람들이 올린 이미지를 볼 수 있다. 더 쉽게는 https://aws.amazon.com/marketplace 로 들어가서 원하는것을 고르면 된다. 대표적으로 wordpress(HVM 버전 선택하는게 좋다.)
- 이미지에 대한 가격과 AWS 사용 가격이 따로 표시돼있으니 총 합계 가격을 잘 확인해야 한다.

## 5. 아키텍쳐

![Imgur](http://i.imgur.com/Xwr0JeHh.png)

- 위와 같은 구조가 기본적으로 자주 쓰인다고 한다. AWS Beanstalk을 활용하면 쉽게 한 번에 구축 가능하다.
- 관련 링크: [pdf](https://github.com/cloudtrack/yonsei-class)

## 6. Scalability

- 두 가지 종류가 있다.
    + Scale UP: 더 좋은 성능의 컴퓨터 사용. 수직 스케일.
    + Scale OUT: 컴퓨터를 더 늘인다. 수평 스케일.

### 6.1 부하 테스트

`ab` 라는 부하 발생기를 사용한다.

- `sudo apt-get update;` : 모든 설치된 프로그램 업데이트 하고
- `sudo apt-get install apache2-utils` : `ab`가 아파치 모듈에 속해있다.
- `ab` : 이렇게만 쳐보면 사용 가능한 명령어들이 나온다. 그 중에 `-n`(requests), `-c`(concurrency) 옵션을 사용하면 된다. 순서대로 1 user 접속량, 동시 접속량을 의미한다. 에로 100, 10을 하면 총 100번의 접속이 일어나는데 동시 접속이 10씩 일어난다는 의미.
- `ab -n 400 -c 1 http://11.111.111.111/` : 테스트한다. 주소는 http와 마지막 슬래쉬를 꼭 적어줘야함.
- 모든 접속이 끝나면 결과가 출력된다. 동시 접속을 조금씩 늘려가면서 변화를 확인해보면 "개별 처리 속도"가 크게 변하는 것을 알 수 있다. 동시 접속이 늘어날 수록 사용자 1명이 기다려야 하는 로딩 시간이 매우 길어진다. 참고로 ms(밀리세컨드)는 1/1000초를 말한다.
- 서버 인스턴스에서 `top`을 치면 현재 사용되는 메모리 현황을 볼 수 있다.

### 6.2 Scale up

- Elastic IPs
    + IP는 한정적인 자산이다. 만약 서버를 Scale up 시키려고 기존 것을 멈추고 이미지를 옮겨서 새로운 EC2로 Start하게 되면 IP가 달라진다.
    + 그래서 EC2와 상관없이 IP 주소만 독립적으로 받아서 사용해야하는데 이것이 Elastic IP다. Elastic IP를 하나 받아서 하나 인스턴스에 매칭한 상태라면 무료지만 매칭하지 않거나, 여러개 Elastic IP를 인스턴스에 매칭한다면 시간당 0.005달러를 받는다.
    + associate를 원하는 인스턴스와 하면 연결되는 것이고, IP의 삭제는 release IP를 하면 된다.
- Image 생성
    + 스케일 업하기 위해 기존 running되고 있는 인스턴스를 복사해야한다. 우클릭해서 Image 메뉴의 Create Image를 선택. 적당히 적고 만든다.
    + 이미지를 생성하는 동안엔 서버가 꺼진다.
- 인스턴스 타입 선택
    + 인스턴스 정보에서 monitoring 탭을 클릭해보면 그래프가 나온다.
    + 피크를 기록하고 있는 부분을 살펴봐서 적당한 타입으로 결정하면 된다.
    + 다시 Images의 AMIs로 가서 만들어진 이미지를 우클릭한 후 Launch를 선택한다. 미리 의사결정했던 타입을 선택하고 진행하면 된다.
    + Elastic IP 메뉴로 다시 가서 해당 IP를 먼저 disassociate한 후 associate한다.

### 6.3 Scale out

#### 6.3.1 기본 내용

![elb](http://i.imgur.com/nKfNRjy.png)

- 기본적으로 스케일 아웃보다 스케일업을 먼저 적용한다. 더 쉽고 단순하다. 스케일 업에서 한계를 만난다든가 낭비가 심해지면 스케일 아웃을 한다.
- 우선 웹 앱은 크게 "Web Server", "Middle ware", "Database"로 구성되어있다.
    + Web Server: nginx, apache
    + Middle ware: django, rails, jsp
    + Database: MySQL, NoSQL
- 먼저 세 구성 요소가 한 컴퓨터에 모두 위치해있었던 것에서 각각을 다른 컴퓨터로 떼어낸다.
- Database scale out
    + 사용량이 늘어나면 DB에서 먼저 문제가 발생하는데 이 땐 컴퓨터를 또 하나 만들어서 Database 담당을 2개로 늘린다. 즉 Master와 Slave 두 개의 데이터베이스가 존재하는 것. master에는 쓰기 작업만 하고, slave에는 읽기 작업만 한다. 이 분기는 미들웨어에서 처리한다. 변경이 일어나면 최대한 빠른 시간 내에 master에서 slave로 복제를 하는 방식. 이런식으로 slave를 여러개 늘리는 방식으로 한다.
    + 그래도 안되면 샤딩이란 방법을 쓴다. 즉 마스터를 2개로 쪼개서 1-1000번 유저는 Master1을, 1000-2000번 유저는 Master2를 쓰는 방식.
- Middle ware scale out
    + 똑같은 미들웨어를 하나 더 만들어서 한 번은 미들웨어1, 한 번은 미들웨어2로 보내주면 된다.
- Web Server scale out
    + 첫 번째 방식은 DNS 서비스를 이용하는 것. 도메인과 여러 개의 IP를 연결해서 각 IP가 다른 Web server로 연결되도록 하는 것.
    + 두 번째 방식은 Load balancer를 이용하는 것. AWS에 ELB(Elastic Load balancer)라는 서비스가 있다. 웹서버 바로 전에서 ELB가 사용자 접속을 받아서 알아서 분산시켜준다. ELB는 웹서버가 살았는지 죽었는지 알 수 있고, 성능이 각각의 웹서버가 어떤 상황인지 알 수 있기 때문에 그걸 바탕으로 분배한다.
    + ELB는 AWS가 알아서 관리하는 것이기 때문에 죽지 않는다. managed라고 표현하는데 실제로 우리가 구현하면 높은 비용이 든다. 매우 편리.

#### 6.3.2 ELB

![Imgur](http://i.imgur.com/nb86AYf.png)

- ELB 생성
    + Create Load balancer 메뉴 선택.
    + Load Balancer Port는 사용자가 접속할 때, Instance Port는 로드 밸런서가 웹서버에 접속할 때 사용하는 방식, 포트다.
    + 프로토콜을 선택할 때 만약 우리 서비스가 HTTPS를 쓴다면 추가해주면 된다. 다만 로드밸런서와 인스턴스 사이에서 인스턴스 포트를 HTTPS로 해 줄 필요는 없다. 둘 사이는 안전하다.
    + Security group은 HTTP로 모든 IP에서 접속 가능하게 한다.
    + Configure Health Check: ELB가 각 인스턴스의 상태를 확인하기 위해 정기적으로 접속을 해본다. Ping Protocol, Ping Port, Ping Path를 설정해주면 되고 Ping path의 접속이 가능하면 컴퓨터가 살아있다라고 생각한다. 그 아래 고급 설정에서 Response Timeout은 이 이상 걸리면 죽었다고 혹은 성능이 안좋다 판단하는 기준이고, Interval은 헬스 체크 주기이고, Threshold는 조건에 최소 몇 번 맞지 않으면 죽었다고 판단, 재 시도해서 최소 몇번 이상 오케이가 뜨면 다시 살아났다고 판단하는 기준이다.
    + 인스턴스를 당장은 추가 안해도 일단 생성해놓을 수 있다.
- 서버와 사용자 인스턴스 생성
    + `sudo apt-get install apache2` : web server를 설치한다. 매우 경량이기 때문에 부하 테스트를 하기엔 이거만으론 부족하다.
    + php나 django 등의 미들웨어를 설치하고 뭔가 처리를 추가해준다. 다음 순서는 php를 활용한 예다.
    + 서버 인스턴스에서 `sudo apt-get install php5`
    + `cd var/www/html` : 웹서버에 사용자가 접속하면서 요청하는 파일이 있는 디렉토리다. 여기에 `index.html` 파일이 있을거고 이것을 편집해서 다음 코드를 추가한다. `<?php for ($i=0; $i<10000000; $i++){} ?>`
    +  이번엔 사용자 인스턴스에서 부하 발생기를 실행한다. `ab -n 100 -c 10 http://11.111.111.111/index.php`
- ELB 적용
    + 웹서버가 2개 이상이어야 의미가 있다. 같은 웹서버를 만들어둔다.
    + Load Balancers 메뉴로 들어가서 Instances 메뉴의 Edit Instances 버튼 클릭하고 원하는 웹서버 인스턴스를 선택해주면 된다. 상태가 InService가 되면 동작하는 것.
    + Description 메뉴에 보면 도메인이 있다. ELB로 접속하고싶으면 사용하면 된다. `도메인주소/index.php` 로 접속해보면 원하는 화면이 뜰거다. 위에서 입력했던 코드에선 빈화면이 뜰 것.
    + 웹서버로 직접 접속하고싶으면 웹서버 인스턴스의 `IP 주소/index.php`로 해주면 된다. 그리고 접속 정보를 터미널에 띄울 수도 있다. 다음 코드를 터미널에 입력하면 된다. `sudo tail -f /var/log/apache2/access.log`
    + 로드 밸런서로 들어가서 여러번 새로고침해보면 접속 정보가 번갈아서 뜨는 것을 확인할 수 있다.
    + 역시 위에서 만들었던 부하발생기를 이용해서 테스트하면 된다. `ab -n 100 -c 10 로드밸런서도메인/index.php`

#### 6.3.3 Auto Scaling

- ELB에 인스턴스를 붙이는 작업을 자동화할 수 있다. 자동으로 인스턴스를 생성하고 삭제하는 것을 Auto Scaling이라고 한다.
- Auto Scaling 메뉴
    + Launch configurations: 복제할 인스턴스의 이미지가 준비되어야한다. 이미지를 인스턴스화 하는 것을 Launch라고 하며 어떤 인스턴스 타입으로 할것인지 등을 정하는 것이 해당 메뉴이다.
    + Auto Scaling groups: 위 설정을 기반으로 어떠한 조건에서 자동으로 생성/삭제되도록 할 것인가를 정하는 곳. 이벤트라고 말할 수도 있겠다.
- Launch configurations
    + Create Auto scaling group 버튼 눌러서 과정에 진입하면 먼저 configuration을 만들라고 할 것이다. 인스턴스를 만드는 과정과 거의 일치한다.
    + My AMIs 메뉴로 들어가서 원하는 이미지를 선택하고 이미지가 들어갈 인스턴스의 타입을 지정한다.
    + Configuration 정보를 저장해놓고 재사용할 수 있는데 `LC_2016_10_04_22_00` 처럼 약자와 날짜 정보로 이름 지정해주면 좋다.
    + 설정 파일만 만든거고 실제로 인스턴스가 생성되는건 아니다.
- Auto Scaling groups
    + 역시 Group name은 이름만으로 알 수 있게 짓는다. `AC_2016_10_04_23_00`
    + Group size는 시작하는 인스턴스 개수를 지정한다.
    + Subnet은 흰 빈 칸을 클릭하면 Availability zone이 뜬다. 클릭해서 추가해주면 된다 아마 2개가 뜰 것임.
    + Advanced detail의 Load balancing은 새롭게 만들어진 인스턴스가 어느 ELB에 붙을건지를 정해줄 수 있는 부분이다. 원하는 ELB를 선택한다. 나머지는 건드릴 필요 없음
    + 다음 Scaling policies로 넘어간다. Keep this group at its initial size 부분은 이전화면에서 Group size를 항상 유지하겠다는 의미이고, 아래 다른 옵션은 필요에 따라 인스턴스를 늘이고 줄이고 하겠다는 의미다.
    + 인스턴스 크기의 최소, 최대값을 설정하는 등 언제 인스턴스를 늘이고 줄일지에 대한 정책을 결정한다.
    + alarm은 특정 상황에서 Auto scaling에게 그 상황이라는 정보를 전달하는 역할이다. 즉 이벤트다. 추가하면 상세 설정할 수 있는데 CPU utilization(점유율)의 평균이 어떤 값인지, 그리고 얼마간 지속된다면 등의 조건을 설정할 수 있다.(여담이지만 같은 페이지에 이전에 어떤 점유율을 보였는지 그래프가 제공된다. 매우 훌륭한 UX다.)
    + 그리고 alarm이 일어났을 때 어떤 행동을 할지도 지정할 수 있다. 재밌는 것은 여기서도 조건 분기를 할 수 있다는 것. 만약 alarm의 조건이 CPU 점유율 60% 이상이라면, 행동 설정에서 60~80 구간과 80~100 구간에서 인스턴스를 한 번에 1개 만들지 2개 만들지 등으로 분기해서 행동을 설정할 수 있다는 것이다.
    + 3. Configuring notification 메뉴에서 오토 스케일링의 종류(생성, 삭제 등)에 대해서 메일로 알림을 보낼 수 있다.
    + 모두 완료하면 오토 스케일링 그룹의 instances, Load balancers의 instances, Instances 메뉴에 공통으로 하나의 인스턴스가 생긴 것을 볼 수 있다.
- Cloud watch
    + Auto scaling에서 썼던 alarm에 대한 관제탑 같은 서비스다. 들어가보면 만들었던 알람들이 현재 울리는 알람은 "ALARM"이라고, 아닌 알람은 "OK"라고 표시가 돼있을 것이다.
    + 실시간으로 변경되는 것을 확인할 수 있다. 역시 부하 발생기를 이용해서 접속 수를 엄청 많이 해놓고 시간을 기다리면 오토스케일링 되는 것을 볼 수 있다.
- 모두 사용이 끝났으면 오토 스케일링 그룹, 알람, ELB, 부하발생기 인스턴스를 모두 삭제한다. 그리고 SNS 서비스에 가면 또 뭔가가 있을거다 그것도 삭제.

## 7. AWS 제어하기

- CLI
    + `pip install awscli` : 먼저 CLI로 제어할 수 있는 프로그램 설치한다.
    + `aws configure` : 나의 AWS 계정과 연결하기 위해 설정을 시작하는 명령어
    + `aws ec2 describe-instances` : ec2의 상태를 텍스트로 뿌려주는 기본적인 명령어다.
- API
    + 웹 서버의 주소로 접근할 수 있다.
    + `https://ec2.amazonaws.com/?Action=DescribeInstances` : 뒤에 인증키에 대한 것을 붙여넣어줘야하지만 이런 형태로 요청을 하면 xml 결과가 나온다.
- nodejs로 제어하기: https://opentutorials.org/module/1946/11768
