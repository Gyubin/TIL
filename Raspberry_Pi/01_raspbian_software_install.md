# Raspbian에 OS(Jessie) 및 sw 설치!

참고 링크: [공식 홈페이지 인스톨 가이드](https://www.raspberrypi.org/documentation/installation/installing-images/mac.md), [메카솔루션 오픈랩](http://blog.naver.com/roboholic84)

## 1. 이미지 파일 다운로드

- 쉽게 설치하고 싶다면?
    + 초보자용 설치 인스톨러인 [NOOBS](https://www.raspberrypi.org/downloads/noobs/)를 활용한다.
    + 이걸로 한 번 깔아봤는데 클릭 몇 번으로 끝났다. NOOBS를 활용할 경우 이미지를 다운로드 받을 필요가 없고, 가이드 [영상](https://www.raspberrypi.org/help/noobs-setup/)을 보면서 쉽게 따라할 수 있다. 아래 설명 글은 더 안봐도 된다.
- 이미지로 설치하려면 일단 다운로드
    + [라즈비안 다운로드 페이지](https://www.raspberrypi.org/downloads/raspbian/)로 들어가면 버전이 2가지가 있다. JESSIE와 WHEEZY다. 가볍게 쓸 경우엔 WHEEZY도 좋다고 하고, JESSIE가 좀 더 다양한 기능이 있는 것 같다. 굳이 무겁게 쓸 필요 없으면 WHEEZY도 좋겠다.
    + 나는 다양하게 연습 삼아 테스트를 해보고 보일러 조절로 넘어갈거라서 일단 다양한 기능이 있는 JESSIE를 선택했다.
    + 압축을 풀 땐 'The Unarchiver'를 사용한다. 그냥 맥 내장 기능으로 압축을 풀면 오류가 날 수도 있다고 한다.

## 2. 터미널로 설치하기

디스크 유틸리티로 설치해도 되지만 터미널이 뭔가 더 정감이 간다. 어렵지 않다. 몇 개 코드만 입력하면 끝이다.

- SD카드가 삽입된 상태에서 `diskutil list`를 터미널에 입력한다. 그러면 현재 저장 장치들의 파티션 상태가 쭉 뜬다. 그 중에서 SD카드 디스크를 찾는다. 난 8기가 짜리를 꼽아서 용량으로 찾았다. 내 경우 아래 이미지에서 disk2다.
![diskutil](http://qbinson.com/wp-content/uploads/2015/11/diskutil_list.png)
- `diskutil unmountDisk /dev/disk#` 이 명령어를 터미널에 입력해서 disk를 unmount 시켜야 한다. **중요: 마지막 `#` 표시 부분을 자신의 SD카드 번호로 바꿔줘야 한다. 내 경우엔 disk2라서 '#'을 '2'로 바꿔주었다.** 자신의 경우에 맞는 disk 번호를 잘 적어주자.
- `sudo dd bs=1m if=이미지파일 of=/dev/rdisk#` 설치 명령어다. 왼쪽 명령어에서 2가지를 바꿔준다. '이미지파일'이라고 된 부분을 1에서 다운받은 이미지파일로 지정해주고, 명령어 마지막 '#'을 내 디스크 번호로 바꿔준다. 내 경우엔 이미지 파일이 있는 경로로 들어가서 다음 명령어를 사용했다. `sudo dd bs=1m if=2015-09-24-raspbian-jessie.img of=/dev/rdisk2` sudo라서 비밀번호를 요구할 것이다.
- 5분이 채 안되게 걸렸던 것 같다. 여유있게 기다리자.

## 3. 라즈비안 구동하기

- 설치는 다 됐다. 이제 micro sd카드를 분리해서 라즈베리파이 키트에 끼운다. 그리고 모니터를 연결하고 부팅한다.
- 처음 검은색 화면에서 텍스트가 주루룩 올라갈거다. 완료되면 라즈베리파이가 다음처럼 구동된다. 키보드와 마우스를 USB로 연결해서 사용하면 된다.
![제시](http://qbinson.com/wp-content/uploads/2015/11/raspberry_jessie_151124.jpg)

## 4. 인터넷 연결하기

- 사실 랜선-USB 연결 잭만 있으면 키트에다가 USB 꼽으면 바로 된다. 하지만 난 와이파이 동글을 샀으므로 연결을 꼭 시켜야겠다!
- 온갖 삽질을 다 했다. `/etc/network/interfaces` 파일에서 뭘 수정하라고 해서 vi로 파일을 켰더니 이게 vim이 아니라 vi라서 완전 키 세팅이 달랐다. 키가 다 이상하게 먹혀서(나는 vim밖에 모른다 ㅜㅜ) 텍스트 몇 개를 수정하라고 하는데 글 마다 다르고, 더군다나 2012년 글이었다!! 뭔가 약간 지금과는 다른 상황일 것 같아서 넘기고 다른걸 찾아보다가 어떤 글에서 전체를 업그레이드부터 하래서 업그레이드했는데 또 안되길래 진짜 interfaces 파일을 수정해야되나 하다가 갑자기 `reboot` 단어가 눈에 확 들어왔다. 설마.. 했는데 재시작하니까 와이파이 동글이 먹힌다. 으하하하하.. 뭐랄까 엄한데에 시간 엄청 뺏기고 화가 나는데, 성공한게 기뻐서 우는듯 웃는듯 이상한 표정을 지어버렸다.
- 자. 라즈베리파이2, raspbian jessie 최신 버전에선 다음만 하면 된다.
    + `sudo apt-get update` : repository를 업데이트한다.
    + `sudo apt-get upgrade` : 업데이트된 repo를 기반으로 설치된 앱들을 업데이트한다.
- 끝이다. 재시작하면 와이파이 인터페이스가 생긴다!!!

## 5. node.js 설치

아래 두 코드를 순서대로 터미널에서 실행하고 `node -v`로 버전 확인해본다.

- `wget http://node-arm.herokuapp.com/node_latest_armhf.deb`
- `sudo dpkg -i node_latest_armhf.deb`
