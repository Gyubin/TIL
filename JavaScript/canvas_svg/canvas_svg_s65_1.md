# Canvas & SVG S65 1회차: 인트로

2016년 2월 11일 목요일

[스터디](http://www.bsidesoft.com/?p=2049) 참여 기록을 남긴다. BSIDESOFT에서 사회 환원 목적으로 무료 특강을 한다. 듣는 사람들도 계속적으로 만들고 소통하고 해야하기에 스터디라는 말을 쓰는 것 같다. 총 8주차 과정이고 매주 목요일 열린다. 다음은 커리큘럼이다.

- intro
- svg elements & properties
- path command
- svg parser
- getting started with cart library
- why are arcs so sick?
- charts that animates itself
- buffered

## 1. Graphics System

산업에서 쓰이는 그림의 모든 것들을 일컫는다. 컴퓨터에선 '점을 찍는 것'이 모든 그래픽의 기본이다. 이 행위는 하드웨어에서 물리적으로 픽셀 하나를 껐다 켰다 하는 것이다. 즉 비트맵 시스템이다.

픽셀 맵.

점을 찍을 때 사람이 일일이 채우는게 아니라 컴퓨터가 계산, 수학적인 방법으로 색을 채우는 방법.

점을 찍을 때 필요한 요소들: color, x, y, width, height

Layer0 - Fixed Number. 이게 가장 기저. 빨강색 이라는 숫자. 몇 번쨰 픽셀. 뭐 이런것들.
하지만 이건 단점. 수치를 알지만 알지못한다. 만약 fixed로 1920을 채웠을 때 모바일로 보면 다 튀어나간다.
사용자들은 가변하는 상황을 기본으로 가정한다. 크기가 달라지는 반응형 대응하려면 fixed로는 부족.
그림 그리는 것과 매우 비슷하다. 하드웨어 레벨에서 그리는 메소드를 지원하는 경우가 많다. 기저 레이어라서 내가 직접 함수들을 조절할 수 없는 경ㅇ우가 많다.

레이어0과 1 사이에 큰 차이가 있음. 기저 하드웨어 레벨, 추상화 레이어.
그 사이에 이런게 있다. DrawingAPI, Shader, Filter, FontRenderer, GDLibrary 리눅스? 유닉스?에서 제공한단다.
gd2, gd3같은게 좀 구식이라서 API를 좀 개조해서 대시보드API라는게 맥 OS에서 나왔다. 대체할만큼 잘 나왔다.

Drawing api
html 패권이 원래 MS에서 갖고 있었다. MS에서 IE 버전 발표하면 W3G가 따라가고 그랬다. 근데 그 이후에 구글과 애플이 막 표준화 지원하고 밀어붙여서 패권을 가져옴.
근데 요샌 구글과 애플이 결별. 애플은 이정도면 거의 네이티브를 안써도 될 것 같다 싶은 기능은 사파리에서 지원 안됨. 최신 기능이 잘 지원 안되고 있음.
크롬은 웹으로 모든걸 대체하려고 하기 때문에 최신기능을 적극 도입하고 있고 격차 커지고 있다.
캔버스 API라고 믿고 있는건 맥의 API다. 표준. 안드로이드 드로잉 캔버스 API와 애플에서 캔버스 계열. 비트맵을 다루는 것이 결국 같은게 쓰인다. 

fliter. shader. 필터는 인자로 칼라값 하나만 받을 수 있다. RGB 받아서 반으로 줄여서 리턴하는것. 근데 이런 값 하나만 받아서 쓰기엔 너무 단순하고 기능없다.
다른 변수들을 여러개 받게 하는게 shader다. 필터를 쓰려면 for 루프 등으로 엄청 반복을 많이 해야하는데 shader는 한 번에 쭉 뿌려서 리스트로 받는. 뭐 그런 거다. GPU가 뭐 그렇게.

FontRenderer : 픽셀에 예쁘게 찍어주는. 

이런 것들은 추상화가 아니라 도트를 바로 찍어주는 레벨이지만 좀 더 우리가 쉽게 쓸 수 있도록 해줬다. 


Layer1 - Calculator Hint. 사람이 아니라 기계가 계산한다. 사람은 힌트만 준다. 크롬의 웹킷 엔진이 fixed number로 바꿔서 렌더링. 즉 그래픽 추상화 레이어(abstract layer)
그래서 left, right, top, bottom, absolute, float, inline 등등. 즉 직접 수치를 주지 않는 것.
ScreenSize, ChromeSize, Foreground, Activated, Layout System, LazyDetector, ReFlow, 

Layer2 - Components. 모아둔 것. 버튼 하나 캔버스로 그리려면 200줄 씩 막 해야된다 그라데이션 넣고. 뭐. 근데 버튼! 하면 버튼 나오는게 컴포넌트다.
컴포넌트는 컴포넌트를 포함할 수 있다. 네비가 버튼을 포함하고, 버튼은 레이블을 포함하고 뭐. 기저 컴포넌트도 제공되지만, 응용 컴포넌트도 제공한다.
우린 대부분 component를 쓰지만 아래 레이어로 잘 안내려간다.
문제는 모두가 다 부트스트랩 쓰면 다 똑같애진다. 결국 하다보면 자꾸 내려가게 된다. layer1로. 레이어0으로. 차별화해야되니까.

div, input, textarea, ima, a 모두가 component다.
인풋 박스를 만들려면. 모든 키보드 이벤트 다 받아서 폰트 계속 바꾸고 그려줘야 하고, 커서 깜빡이게 하고 다 해야된다. 오피스365는 내가 텍스트 치면 이벤트가 서버로 날아가서 네이티브 워드가 그리는 그대로 다시 정보 날려서 찍어준다. 미친 ㅋㅋㅋ

기능이 방대하고 공통된게 많다. Element를 상속받는다. 일반적인 html element는. 또 이벤트 타고 할 때는 element의 부모인 node를 타게 되어있다.

전체 모든 태그에 적용되는 컨센서스가 있다. 즉 상속구조를 가지고 있는게 당연하다.

회사들은 레이어를 더 잘게 잘라서 한다. 근데 레이어가 많으면 함수 호출단계가 많아져서 느려진다. 그래서 html 최적화 보면 리플로우 줄여라 등의 말들이 많다.

====

div hello world div
이렇게 치면 딱 뜬다. static rendering. 매우 빠름. 다만 변하지 않는다. 하지만 변하는게 실 서비스에선 필요하다.

변하는 부분이 모델(데이터), 변하지 않는 부분이 뷰(레이아웃)

기억해야만 할것이 데이터다. 그럼 기억해야한다는 것을 누가 정하느냐. 그 정하는 과정을 모델링이라고 한다. 데이터긴 한데 기억해야할 것만 추려진 것들. 모델링. 그래서 모델이라고 한다.

그래서 이런게 Runtime Rendering. 실행 중일 때만 그릴 수 있다.

Layer3 - Frameworks

주로 일하면 여기에서만 논다. 이 아래것을 다룰줄 알아야한다.

===
캔버스가 제공해주는 것은 Layer0까지다. 점찍는 것밖에 안된다. 그것도 숫자로 찍어야됨. 게임도 이걸로만은 못 만든다.
우리는 레이아웃과 모델을 조합해서 렌더링하는 사람이다. 짱멋있따.

8주만에 자바스크립트 코드로 순수하게 layer1, 2를 구현하는 것.

=======================================

svg: scalable vector graphics
2d 그래픽을 xml에서 다루는 언어. 세 가지 타입임.(vector shapes, images, text)

group, style, transform 할 수 있다.

## 1. 왜 svg 써야되냐.

xml 표준을 잘 따르고 있다. 브라우저 상에서 DOM object처럼 사용할 수 있다. 하지만 HTMLElement의 instance는 아니다.
XML 1.0 권고사항과 호환된다.

css, XSLT로 svg를 컨트롤할 수 있다.
이벤트 리스너 가능

## 2. 비교

### A. SVG vs VML

vml은 ms에서 제안한 포맷. 처음엔 오피스 제품군에서 도형 표현할 때 자체적으로 구축해서 쓴 것. IE11에선 MS도 버렸다.

### B. SVG vs canvas

비슷한 용도, 사용성, 적용 가능 상황 때문에 비교 ㅁ낳이 한다. 캔버스는 도트 기반이고, svg는 벡터 기반 API다. DOM 의 나쁜 점도 답습하기 때문에 개체 수가 많아지면 svg 렌더링 시간이 느려진다. 이에 반해 화면 크기에 비해선 svg가 느려지지 않는다. canvas는 느려짐.

## 3. tools/libs for SVG

SVG를 간편하게 그려주는 프레임웤 생김.

- tool: CorelDRAW, LibreOffice Draw, OpenOffice Draw, Adobe iLLustrator, Inkscape(요거 주목할 만 하다. 무료고 운영체제별 배포판 있다. 근데 구림)
- library: raphaelJS(ie8 이하에서 호환성 도움된다. vml 관련해서), D3.js

SVG as a markup

http://jsfiddle.net/oveRock/6eg1j9ou/

```html
<body>
  <svg width="150" height="100" viewBox="0 0 3 2">
    <rect width="1" height="2" x="0" fill="#008d46" />
    <rect width="1" height="2" x="1" fill="#ffffff" />
    <rect width="1" height="2" x="2" fill="#d2232c" />
  </svg>
</body>
```


http://jsfiddle.net/oveRock/L3kdhmyn/

```js
var ns = 'http://www.w3.org/2000/svg';

var svg = document.createElementNS(ns, 'svg');
    svg.setAttribute('width', 150);
    svg.setAttribute('height', 100);
    svg.setAttribute('viewBox', '0 0 3 2');

var left = document.createElementNS(ns, 'rect');
    left.setAttribute('width', 1);
    left.setAttribute('height', 2);
    left.setAttribute('x', 0);
    left.setAttribute('fill', '#008d46');
    
var mid = document.createElementNS(ns, 'rect');
    mid.setAttribute('width', 1);
    mid.setAttribute('height', 2);
    mid.setAttribute('x', 1);
    mid.setAttribute('fill', '#fff');

var right = document.createElementNS(ns, 'rect');
    right.setAttribute('width', 1);
    right.setAttribute('height', 2);
    right.setAttribute('x', 2);
    right.setAttribute('fill', '#d2232c');
    
svg.appendChild(left);
svg.appendChild(mid);
svg.appendChild(right);
document.body.appendChild(svg);
```








