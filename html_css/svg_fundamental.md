# SVG 기초

참고링크: [MDN tutorial](https://developer.mozilla.org/ko/docs/Web/SVG/Tutorial), [W3Schools tutorial](http://www.w3schools.com/svg/)

Scalable Vector Graphics의 약자. 브라우저에서 그래픽을 마크업으로 표현하기 위한 것. 자세한 명세는 MDN의 [SVG element reference](https://developer.mozilla.org/ko/docs/Web/SVG/Element), [SVG element interface](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model#SVG_interfaces)에서 찾아볼 수 있다.

시작하기 전에 유의사항 2가지

- XML이 대소문자를 구분하는 언어이므로 SVG 요소와 속성은 반드시 예제에 보여지는 대로 입력해야한다.
- SVG에서 속성 값은 숫자라고 할 지라도 반드시 따옴표로 둘러싸야한다.

## 1. 샘플 코드

```html
<svg version="1.1"
     baseProfile="full"
     width="300" height="200"
     xmlns="http://www.w3.org/2000/svg">
  <rect width="100%" height="100%" fill="red" />
  <circle cx="150" cy="100" r="80" fill="green" />
  <text x="150" y="125" font-size="60" text-anchor="middle" fill="white">SVG</text>
</svg>
```

위 코드를 `.svg` 확장자로 저장해서 브라우저에 열어볼 수 있다. 렌더링 과정은 다음과 같다.

- root element로 SVG를 만든다.
    + HTML의 doctype 선언은 쓰지않는다. DTD 기반의 SVG 검증은 득보다 실이 많다.
        * a doctype declaration as known from (X)HTML should be left off because DTD based SVG validation leads to more problems than it solves
    + DTD 말고 다른 validation에서 SVG의 버전을 알아내려면 version, baseProfile 속성을 꼭 적어줘야한다.
    + XML 구문 내에서는 SVG를 xmlns 속성으로 namespace를 명시해줘야한다.
- 이미지 영역 전체를 차지하는 rectangle을 그리면서 배경색이 빨강으로 지정된다.
- 초록색 원이 80px 반지름으로 빨간 사각형 중앙에 그려진다. offset은 30+120px inward, 50+50px upward다.
- 텍스트 SVG가 그려진다. 글자는 하얀색으로 채워지고, text-anchor를 middle로 설정했으므로 중앙에 그려진다. 녹색 원의 정 중앙이다.

## 2. 그리드, user unit

![grid](https://developer.mozilla.org/@api/deki/files/78/=Canvas_default_grid.png)

모든 elements에 대해서 SVG는 그리드 시스템을 사용한다. 즉 왼쪽 상단이 (0,0)이다. 위치는 왼쪽 상단을 기준으로 픽셀로 이동된다. x, y 좌표가 커질수록 우측, 아래로 이동한다. HTML의 방식과 같다.

기본적으로 SVG의 픽셀 한 개는 출력 장치의 한 개 픽셀과 대응된다. 하지만 이렇게만 구현된다면 이름에서처럼 scalable이 구현되지 않는다. CSS의 absolute, relative 폰트 사이즈와 비슷하게 SVG는 absolute units를 정의해서 사용하는데 'pt'나 'cm'과 비슷한 것이다. user units라고 불리기도 한다. 90dpi에서 1cm는 약 35.43px 정도인데 이 때 이것을 35.43 user unit이라 표현한다. SVG에서 따로 뒤에 단위를 적지 않고 숫자만 적으면 user unit으로 여겨진다. 이러한 매핑을 `user coordinate system`이라 하고 기본은 1 user unit에 1 screen unit 대응이다.

```html
<!-- 아래는 일반적인 경우. 1 user unit = 1 screen unit -->
<svg width="100" height="100">

<!-- 아래 코드는 너비 200, 높이 200의 svg 공간이다.
viewBox 속성을 통해 디스플레이에 대한 캔버스의 비율을 설정할 수 있다.
아래는 200*200px 공간을 user unit (0,0) 위치에서 시작해서
user unit (100,100) 크기로 표현한다는 의미다. -->
<svg width="200" height="200" viewBox="0 0 100 100">

<!-- 아래는 좌표 (-50, -50)에서 시작해서 (300, 300) 크기로 그린다는 의미.
즉 SVG를 left 50, top 50으로 위치 이동 시키고 300, 300 크기로 그린다는 것이다.
SVG를 기존 200,200 좌표계로 보는 것이 아니라 300, 300으로 본다는 의미. -->
<svg width="200" height="200" viewBox="-50 -50 300 300">
```

뷰박스 좌표에 대해선 다음 [슬라이드쉐어 자료](http://www.slideshare.net/ssuser99dc16/mars-svg)의 16, 17 슬라이드 이미지를 보거나, [MSDN](https://msdn.microsoft.com/ko-kr/library/gg589508) 자료를 보면 확 와닿을거다.

## 3. 기본 모양

기본적으로 모두에 적용되는 속성: `stroke`, `fill`, `stroke-width`

### 3.1 Rectangles

- 사각형: `<rect />`
- `x`, `y`: 시작 x, y 좌표
- `width`, `height`: 너비, 높이
- `rx`, `ry`: x, y의 radius 값이다.
- `<rect x="10" y="10" width="30" height="30"/>`
- `<rect x="60" y="10" rx="10" ry="10" width="30" height="30"/>`

### 3.2 Circle

- 원: `<circle />`
- `r`: 반지름
- `cx`, `cy`: 중점 좌표
- `<circle cx="25" cy="75" r="20"/>`

### 3.3 Ellipse

- 타원형: `<ellipse />`
- `cx`, `cy`: 중점 좌표
- `rx`, `ry`: x, y radius
- `<ellipse cx="75" cy="75" rx="20" ry="5"/>`

### 3.4 Line

- 선: `<line />`
- `x1`, `y1`: 시작점
- `x2`, `y2`: 끝점
- `<line x1="10" x2="50" y1="110" y2="150"/>`

### 3.5 Polyline

- 선 여러개가 연결된 것: `<polyline />`
- `points`: comma로 연결된 좌표들
- `<polyline points="60 110, 65 120, 70 115, 75 130"/>`

### 3.6 Polygon

- 다각형: `<polygon />`
- `points`: comma로 연결된 좌표들. ex) `points = "50 30, 30 20, 20 20"`
- polyline과 비슷하지만 마지막 점이 첫 점과 자동으로 연결된다는 점이 다르다. 그래서 닫힌 도형이 된다.
- `<polygon points="50 160, 55 180, 70 180, 60 190, 65 205, 50 195, 35 205, 40 190, 30 180, 45 180"/>`

### 3.7 Path

- SVG에서 가장 많이 쓰인다. 지금까지 설명한 모든 도형을 Path로 표현 가능하다. 특히 bezier curves, quadratic curves 중요하다.
- `d`: 점들의 집합이면서 이걸 어떻게 그릴지에 대한 정보가 들어있다. 자세하게 따로 설명.
- `<path d="M 20 230 Q 40 205, 50 230 T 90230"/>`

## 4. Paths

SVG basic shapes 중 가장 강력한 요소다. 태그 내에 `d` 속성 하나만 존재하며 이 안에 여러 command 정보들을 넣게 된다. 5개의 line commands, 3개의 curve commands가 존재하고 대문자로 쓰면 absolute position, 소문자로 쓰면 relative position이다.

이 부분은 unitless가 무엇을 의미하는지 몰라서 일단 남겨뒀다: Coordinates in the d attribute are always **unitless** and hence in the user coordinate system. Later, we will learn how paths can be transformed to suit other needs.

### 4.1 Line commands

5개의 line commands가 있다. 두 점 사이에서 직선을 그리는 commands다. path로 직선을 그리든, 다른 basic shapes를 쓰든 성능 차이는 없다.

- `M`: Move to. parser가 이 명령에 도달하면 점을 다음 좌표로 이동시킨다. path를 그리기 시작할 때 시작 지점으로 삼기 위해 쓰기도 하고, 중간에 선 그려짐 없이 단순 좌표 이동할 때도 쓰인다. 공백으로 구분된 x, y 좌표가 들어간다.
    + `"M 10 10"`: absolute position (10, 10)으로 움직이고자 하는 것
    + `"m 10 10"`: relative position. 이전 좌표 기준으로 10픽셀씩 이동
- `L`: Line to. 현재 커서가 위치한 지점에서 정해준 좌표까지 직선을 그린다. 역시 대문자는 절대 좌표, 소문자는 상대 거리를 나타낸다.
    + `"L 5 10"`, `"l 20 30"`
- `H`, `V`: Horizontal, vertical lines. 대소문자 역시 동작하고 현재 위치에서 수평, 수직선을 그리는 commands다. 좌표는 하나만 들어간다.
    + `"H x"`, `"h dx"`, `"V y"`, `"v dy"`
- `Z`: Close Path. path를 끝내는 command다. 현재 커서 위치에서 첫 좌표까지 직선을 그으면서 마무리한다. 주로 d 속성에서 마지막에 위치하는데 굳이 안써도 될 때도 명시적으로 마무리하기 위해 사용하는 편. 대소문자 구분 없고 매개변수 안들어간다.

### 4.2 Curve commands

부드러운 곡선을 그리는 3개의 commands가 존재한다. 베지어 곡선(Bezier curves)에서 cubic(`C`), quadratic(`Q`)과 원의 일부인 `arc`다.

#### 4.2.1 Cubic Bezier

- `C`로 표기. control points 2개와 끝 점으로 구성된다.
    + absolute: `C x1 y1, x2 y2, x y`
    + relative: `c dx1 dy1, dx2 dy2, dx dy`
- `x1`, `y1`: 커브, 휘어짐이 시작되는 좌표
- `x2`, `y2`: 커브, 휘어짐이 끝나는 좌표
- `x`, `y`: 곡선이 끝나는 좌표
- `<path d="M130 110 C 120 140, 180 140, 170 110" stroke="black" fill="transparent"/>`

##### * 추가로 `S` command도 있다.

![s-command](https://mdn.mozillademos.org/files/10405/ShortCut_Cubic_Bezier_with_grid.png)

- `S`로 표기. 몇 개의 베지어 곡선을 여러개 잇는데 활용한다. C나 S 뒤에 S가 온다면, 휘어짐이 시작되는 좌표가 앞의 곡선의 커브가 끝나는 좌표와 같다고 봐서 생략한다. C의 축약 버전인 셈이다.
    + `S x2 y2, x y`
    + `s dx2 dy2, dx dy`
- 곡선이 2개 있는데 한 쪽의 control point와 다른 쪽의 control point가 같은 직선 그래프 위의 점이라면 기울기가 유지된다. 이 때 `S` 커맨드를 사용한다.
- 만약 S 앞에 C, S가 없고 처음에 쓰인다면 두 control points가 같다고 보고 path가 그려진다.
- `<path d="M10 80 C 40 10, 65 10, 95 80 S 150 150, 180 80" stroke="black" fill="transparent"/>`

#### 4.2.2 Quadratic Bezier

- `Q`로 표기. 하나의 control point만 가진다. 곡선의 시작점과 끝점의 기울기를 동시에 조정한다.
    + `Q x1 y1, x y`
    + `q dx1 dy1, dx dy`
- `<path d="M10 80 Q 95 10 180 80" stroke="black" fill="transparent"/>`

##### * 역시 잇는 command `T`가 존재한다.

![t-command](https://mdn.mozillademos.org/files/10407/Shortcut_Quadratic_Bezier_with_grid.png)

- `T`로 표기. 앞의 control point를 이용하기 때문에 끝점만 지정한다.
    + `T x y`
    + `t dx dy`
- `<path d="M10 160 Q 52.5 90, 95 160 T 180 160" stroke="black" fill="transparent"/>`

#### 4.2.3 Arcs

![arguments](http://www.namo.co.kr/binary/as/techlist/olddate/webcanvas/539/arcs02.png)

- `A`로 표기.
    + `A rx ry x-axis-rotation large-arc-flag sweep-flag x y`
    + `a rx ry x-axis-rotation large-arc-flag sweep-flag dx dy`
- 매개변수가 많은 이유는 단순히 radius와 시작, 끝 점만 있어선 만들어질 호가 위 그림처럼 4가지나 될 수 있기 때문이다.
- `rx`, `ry`: x, y의 radius 값
- `x-axis-rotaion`: 그려진 ellipse가 회전하는 각도를 의미. 음수 가능
- `large-arc-flag`: 호의 중심각이 180도 이상이면 1로 설정
- `sweep-flag`: 1이면 양수 각도 방향, 0이면 음수 각도 방향
- `x`, `y`: 현재커서 위치에서 (x,y) 좌표까지 호를 그린다. 즉 현재 시작점과 (x,y)의 중점이 cx, cy가 되는 것.

## 5. Texts



## 9. 자료

- [구글 코드](https://code.google.com/archive/p/svgweb/)
- [html5rocks](http://www.html5rocks.com/ko/features/graphics)
- [hakim.se](http://hakim.se/)
- [강좌 모음](http://modangs.tistory.com/548)
- [MSDN 기본](https://msdn.microsoft.com/ko-kr/library/gg193979)
- [MDN](https://developer.mozilla.org/ko/docs/Web/SVG/Attribute/pointer-events), [W3](https://www.w3.org/TR/SVG/interact.html#PointerEventsProperty) pointer-events property: SVG 이벤트 체계에서 굉장히 강력한 역할을 한다. 원래 SVG에서 사용하려고 만든거지만 다른 HTMLElement에도 사용 가능. `none`, `all`이 주로 사용되고, z-order를 무시하고 이벤트를 걸 수 있다.
- [W3 SVG arcTo](https://www.w3.org/TR/SVG/paths.html#PathDataEllipticalArcCommands)
- [회전행렬 증명](http://egloos.zum.com/saruchi/v/2079220)
- [코드스쿨 ES6 강의](http://campus.codeschool.com/courses/es2015-the-shape-of-javascript-to-come/)
- [ES6 Katas](http://es6katas.org/)
- [You Dont Know JS](https://github.com/getify/You-Dont-Know-JS/tree/master/es6%20%26%20beyond)
- [ES6 In Depth](http://hacks.mozilla.or.kr/category/es6-in-depth/)
