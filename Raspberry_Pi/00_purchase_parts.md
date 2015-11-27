# #00 시작은 부품 구매부터

아무래도 생 초짜이다보니 부품 고르는 것도 힘들었다. 어느 쇼핑몰이 좋을까, 부품 버전은 따로 있는걸까, 몇 개나 사야하나 검색하느라 진이 다 빠졌다. 결국 [메카솔루션](www.mechasolution.com) 쇼핑몰에서 사기로 했다. 메카솔루션을 선택한 가장 큰 이유는 쇼핑몰에서 운영하는 [메카위키](mechasolutionwiki.com) 때문이다.

요즘 쇼핑몰 비즈니스와 콘텐츠와의 연관성이 날로 깊어지고 있다. 버티컬플랫폼의 [이커머스 사업자는 왜 콘텐츠 비즈니스로 확장해나갈까](http://verticalplatform.kr/archives/5605), 아웃스탠딩의 [콘텐츠-커머스기사](http://outstanding.kr/이제는-콘텐츠가-커머스-커머스가-콘텐츠인-시대), 비석세스의 [두여자-라운지에프 콜라보](http://besuccess.com/2015/11/deuxyeoza/) 글들을 보면 알 수 있다. 메카솔루션 역시 메카위키의 발전과 쇼핑몰의 매출이 큰 연관이 있을 것이다.

어쨌든 부품 또 사서 배송비 또 지출하기 싫어서 최대한 꾹꾹 눌러담았다. 하지만! 왠지 또 주문해야할 것 같다. 생각해보니 전동밸브를 안샀다. 아아

![valve actuator](http://qbinson.com/wp-content/uploads/2015/11/valve_actuator.jpg)
> 요놈 샀어야하는데.. 출처: [밸브갓 슬라이드](http://www.slideshare.net/KyuhoKim/20150122-valve-god)

## 1. 전체샷
일단 요렇게 샀다. 나중에 추가 구매한 부품이 있다면 수정하겠다.

![all](http://qbinson.com/wp-content/uploads/2015/11/raspberry_00_all_151120.jpg)
![영수증](http://qbinson.com/wp-content/uploads/2015/11/raspberry_01_buy_151120.jpg)

## 2. 라즈베리파이 2 키트
이게 하나의 컴퓨터다. 손바닥보다 작은 요놈에 모니터만 연결시키면 리눅스든 윈도우든 구동할 수 있다. 놀랍다 내 첫 컴퓨터는 엄청 두꺼웠는데.

![키트 정밀샷](http://qbinson.com/wp-content/uploads/2015/11/raspberry_03_kit_151120.jpg)
![패키지](http://qbinson.com/wp-content/uploads/2015/11/raspberry_05_kit2_151120.jpg)

## 3. 다른 부품들

- 와이파이 동글

![와이파이](http://qbinson.com/wp-content/uploads/2015/11/raspberry_04_wifi_dongle_151120.jpg)

- sd카드

![sd카드](http://qbinson.com/wp-content/uploads/2015/11/raspberry_06_sdcard_151120.jpg)

- 전선, 저항, led, 온도센서

![저항, led, 전선, 온도센서](http://qbinson.com/wp-content/uploads/2015/11/raspberry_08_etc_151120.jpg)

- adc

![adc](http://qbinson.com/wp-content/uploads/2015/11/raspberry_07_adc_151120.jpg)

- 방열판, 케이스

![방열판, 케이스](http://qbinson.com/wp-content/uploads/2015/11/raspberry_09_case_151120.jpg)

- 릴레이. 의외로 릴레이가 엄지손가락 한 마디 만했다. 얘로 전동밸브를 껐다켰다 신호 주는 것 같은데 흠.. 아직 잘 모르겠다.

![릴레이](http://qbinson.com/wp-content/uploads/2015/11/raspberry_10_relay_151120.jpg)

- 브레드보드

![브레드보드](http://qbinson.com/wp-content/uploads/2015/11/raspberry_11_breadboard_151120.jpg)

## 4. 조립을 해보자.

- 우선 케이스부터 조립했다. 옆부분 끼우는게 좀 어려웠는데 잘못하다가 접합부분이 부러졌다.(ㅜㅜ) 그래도 다행히 고정은 확실하게 되더라.

![망가짐](http://qbinson.com/wp-content/uploads/2015/11/raspberry_12_broken_151120.jpg)
![케이스](http://qbinson.com/wp-content/uploads/2015/11/raspberry_13_complete_151120.jpg)

- 방열판도 뒤에 3M 양면테이프가 붙여져있어서 쉽게 접합했다.

![방열판](http://qbinson.com/wp-content/uploads/2015/11/raspberry_14_radiator_151120.jpg)
![접착](http://qbinson.com/wp-content/uploads/2015/11/raspberry_15_set_radiator_151120.jpg)

## 4. 라즈비안 깔기 시도!!
마이크로 sd카드를 라즈베리파이에 장착하기 전에 우선 라즈비안을 설치하기로 했다. Raspbian은 라즈베리파이에 깔리는 저사양 리눅스다. 이래저래 건드려보기엔 wheezy보단 jessie 버전의 라즈비안이 더 좋은 것 같아서(wheezy보다 jessie가 더 고사양이다) [라즈베리공홈](https://www.raspberrypi.org/)에 들어가봤다.

![공홈](http://qbinson.com/wp-content/uploads/2015/11/raspberry_org_151120.jpg)

일단 후딱 막 건드려보고싶어서 커맨드라인 설치보다는 NOOBS를 활용해서 쉽게 설치하기로 했다. 마이크로SD카드를 SD카드케이스(?)에 꼽아서 NOOBS 파일을 옮긴 다음 라즈베리에 꽂아서 실행을 했다.... 는 실패했다.

아쉽게도 입력 단자가 불량인 모양이다. 딸깍 소리가 살짝 나면서 뭔가 걸리는 느낌은 나는데 자꾸 튕겨져 나온다.

![딸깍](http://qbinson.com/wp-content/uploads/2015/11/raspberry_16_sdfail_151120.jpg)

혹시 micro sd 카드가 문제가 아닐까 싶어서(그럴린 없겠지만..) 가지고 있던 카드 하나를 뜯어서 시도해봤지만 역시 안되더라.

![삼성](http://qbinson.com/wp-content/uploads/2015/11/raspberry_19_samsung_micro_sdcard_151120.jpg)
![실패](http://qbinson.com/wp-content/uploads/2015/11/raspberry_20_samsung_fail_151120.jpg)

## 5. 다음으로 이어집니다.

주말에 이거 가지고 뚝딱뚝딱 해볼려고 했는데 계획이 물거품이 됐다. 메카솔루션에 전화를 하니 반품처리를 해준다고 한다. 빠르면 다음주 월요일에 새 라즈베리파이 키트를 받을 수 있을 것 같다. 아쉽지만 다음주에 OS 설치를 해보겠다.

---

---

## 6. 라즈베리파이 키트 교환 완료(최고!!)

금요일 오후에 반송시켰는데 토요일 오후 1시쯤 새 제품을 받았다. 불량품인지 확인하고 반품해준다고 했는데 그냥 날 믿어주시고 바로 새 제품을 배송해주신 모양이다. 정말 감사하다. 케이스도 부러진 것 대신 쓰라고 새거 보내주시고, 과자도 보내주셨다. 메카솔루션 감사합니다! 물론 SD카드 단자도 제대로 작동한다! ^^

![새 케이스](http://qbinson.com/wp-content/uploads/2015/11/raspberry_new_case_151124.jpg)
![약과](http://qbinson.com/wp-content/uploads/2015/11/raspberry_cookies_151124.jpg)
