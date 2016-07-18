# CSS 기초

css에 대해서 공부하면서 새로운 것들, 외워둘 것들 등등에 대해서 정리해 나가는 파일

## 0. 종류 별 분류

- 폰트
    + `font-size` : 크기
    + `color` : 색깔
    + `font-family` : 폰트 종류
    + `font-weight` : 폰트 굵기. bold로 지정해도 되고, 100 단위로 지정해도 좋다. `normal`은 400, `lighter`는 400 이하, `bold`는 700, `bolder`는 700 이상.
    + `font-style`: `italic`으로 지정하는 용도로 많이 사용
    + `font-variant : small-caps;` : 대문자 형태를 소문자 크기로 보여주는.
- 위 폰트 속성을 `font`에다가 다 박을 수도 있다. 순서는 `font : font-style font-variant font-weight font-size/line-height font-family`
- 텍스트 줄간격 조절: `line-height: 100%`
    + px, % 단위 넣어서 사용 가능.
    + 그냥 숫자만 적으면 `em`으로 인식
    + 글씨 크기가 여러가지인 부분에선 상대단위 쓰는 것을 추천.
    + 수직정렬에 이용하기도 함.
- `text-decoration`
    + `none` : 기본값
    + `underline`: 밑줄
    + `overline`: 윗줄
    + `line-through`: 중앙 취소선같이 생긴 것.
- 배경: `background-color`
- `text-align`: 텍스트 정렬

    ```html
    <body>
      <h3 style="text-align:center">Favorite Football Teams</h3>
      <ol>
      <li style="text-align:left">The Hawthorn Football Club</li> 
        <li style="text-align:center">San Franscisco 49ers</li>
        <li style="text-align:right">Barcelona FC</li>
      </ol>     
    </body>
    ```

## 1. 기본

- 크기 단위
    + `px`: 모니터의 픽셀을 나타냄. 고정적인 단위다.
    + `%`: 상위 요소에 대한 상대적 단위.
    + `em`: 해당 element의 폰트 크기에 대한 상대적 단위다. 1em이 해당 폰트 크기와 같다. 그래서 폰트 크기에 따라 동적으로 크기가 변함. 소수점은 `.5` 처럼 표시한다. 그런데 폰트 사이즈를 em으로 지정하면 부모 엘리먼트의 폰트 크기를 참조한다.
- 색상
    + 기본 색상 종류: aqua, black, blue, fuchsia, gray, green, lime, maroon, navy, olive, orange, purple, red, silver, teal, white, yellow
    + RGB: `RGB(255, 0, 0)`
    + HEX: `#ffcc00`
- HTML 링크: `<link rel="stylesheet" type="text/css" href="file_name.css">.`
- 브라우저 지원 : 앞에 붙인다. `-webkit-`, `-moz-`, `-o-`
- `text-transform: uppercase` : 대문자로 바꾸기
- `letter-spacing: 3px;` : 글자 간격 3px
- `box-sizing: border-box;` : 설정된 width, height 값을 무조건 지킨다. 이 속성이 없을 때 padding 값이 있으면 태그의 범위가 더 넓어진다. 즉 전체 가로가 width + padding left, right 값이 되는 것. 하지만 속성이 있으며녀 무조건 가로는 width다.
- `border: none;` : input box에서 테두리선 없애기. 자동으로 있게 마련이다.
- `outline: none;` : 입력 부분이 focus 되더라도 테두리선으로 강조표시 하지 않음.
- `transition: all 0.2s ease-in-out;` : [참고링크](https://css-tricks.com/almanac/properties/t/transition/) `transition: [transition-property] [transition-duration] [transition-timing-function] [transition-delay];` 형태로 사용한다.

## 2. selector

- `grand parents child` : 태그를 순서대로 한 칸 씩 띄워서 쓰면 자식을 의미한다.
- `tag[attributes=value]` : tag 뒤에 대괄호를 쓰면 속성에 접근할 수 있다.
- `:focus` : colon을 한 번쓰면 다음에 이벤트가 올 수 있다.
- `::pseudo` : 태그는 없지만 존재하는 placeholder같은 것들을 붙잡을 때 쓴다.
- 여러 개 선택할 때: 쉼표로 구분한다. 자식 선택할 때도 쉼표로 구분하는 것을 적용할 수 있다.

    ```css
    h1, p, a, .container, #gyubin {
        color: aqua;
    }
    h1, .container p, a {
        color: aqua;
    }
    ```

- 우선순위
    + `#` -> `.` -> `나머지` : 스타일 겹칠 때 적용 우선순위
    + 아래 쪽으로 읽어내려가기 때문에 아래쪽이 최종 적용
    + 자식을 선택한 부분이 있다면 더 구체적인 부분이 적용된다. 그냥 `div`보다 `.container div` 형태가 더 구체적이므로 후자 적용


## 3. layout - position property

- static(default): `position: static;`
    + top, bottom, left, right 속성에 영향을 받지 않는다.
    + 다른 어떤 방법으로도 위치를 조절할 수 없다. normal flow로 위치 매겨짐.

    ```css
    div.static {
        position: static;
        border: 3px solid #73AD21;
    }
    ```

- relative: `position: relative;`
    + top, bottom, left, right 속성으로 위치 조절 가능
    + normal position을 기준으로 위치가 조정된다.

    ```css
    div.relative {
        position: relative;
        left: 30px;
        border: 3px solid #73AD21;
    }
    ```

- fixed: `position: fixed;`
    + viewport 기준으로 relative다. 그래서 스크롤을 움직여도 동일 장소에 박혀서 계속 보인다.
    + top, bottom, left, right 속성으로 위치 조절 가능
    + 원래 순서대로 위치했을 normal position에서 완전히 사라진다. html에서 3개의 div가 있을 때 중간의 div가 fixed라면 1, 3번 div가 normal position에서 바로 앞 뒤가 되는 것.

    ```css
    div.fixed {
        position: fixed;
        bottom: 0;
        right: 0;
        width: 300px;
        border: 3px solid #73AD21;
    }
    ```

- absolute: `position: absolute;`
    + 가장 가까운 'positioned ancestor'(static이 아닌 position이 할당된 DOM)에 대하여 relative다.
    + 만약 아무리 타고 올라가도 positioned ancestor가 없다면 document body를 조상으로 잡는다. 그리고 특정 위치에 박혀서 스크롤을 내리면 보이지 않는다.(fixed와 다른 점)

    ```html
    <div class="relative">This div element has position: relative;
      <div class="absolute">This div element has position: absolute;</div>
    </div>
    ```

    ```css
    /* css */
    div.relative {
        position: relative;
        width: 400px;
        height: 200px;
        border: 3px solid #73AD21;
    } 
    div.absolute {
        position: absolute;
        top: 80px;
        right: 0;
        width: 200px;
        height: 100px;
        border: 3px solid #73AD21;
    }
    ```

- z-index
    + positioned라면. 즉 static position이 아니라면 overlap 가능하다.
    + z-index는 stack의 순서를 의미한다. 높을 수록 나중에 그려지고, 즉 맨 위에 보인다. 음수, 양수 모두 가능하다.
    + 만약 z-index 없이 중첩되면 html 코드에서 나중에 나온 것이 더 위에 그려진다.

    ```html
    <h1>This is a heading</h1>
    <img src="w3css.gif" width="100" height="140">
    <p>Because the image has a z-index of -1, it will be placed behind the text.</p>
    ```

    ```css
    img {
        position: absolute;
        left: 0px;
        top: 0px;
        z-index: -1;
    }
    ```

## 4. pseudo classes

요소의 특별한 상태를 나타낼 때 쓴다. 마우스가 over된 상태, 링크의 클릭(방문) 여부, 요소가 focus되었는지에 대한 것을 잡아낼 수 있다. 매우 다양한 클래스들이 있고 다음 w3school [링크](http://www.w3schools.com/css/css_pseudo_classes.asp)의 맨 아래 부분에 목록과 예제가 존재한다.

```css
selector:pseudo-class {
    property:value;
}
```

### 4.1 link 관련

- `a:hover`를 효율적으로 사용하려면 `a:link`와 `a:visited` 뒤에 와야한다.
- `a:active` 역시 `a:hover` 뒤에 오는게 좋다.
- 대소문자 구별 없어서 HOVER 써도 된다.

```css
/* unvisited link */
a:link { color: #FF0000; }

/* visited link */
a:visited { color: #00FF00; }

/* mouse over link */
a:hover { color: #FF00FF; }

/* selected link. 클릭 중일 때. */
a:active { color: #0000FF; }

/* 특정 클래스인 녀석을 지정할 수도 있다 */
a.highlight:hover { color: #ff0000; }
```

### 4.2 child element

```css
/* 첫 번째 자식 element */
p:first-child { color: blue; }

/* 모든 p에 대해서 첫 번째 자식 element인 i */
p i:first-child { color: blue; }

/* 첫 번째 자식인 p에 대해서 모든 i */
p:first-child i { color: blue; }
```

### 4.3 :lang

- `:lang`은 다른 languages에 대해 특별한 규칙을 지정할 수 있다.
- IE8에서는 !DOCTYPE이 명시되어있어야 동작한다.

```html
<p>Some text <q lang="no">A quote in a paragraph</q> Some text.</p>
```

```css
q:lang(no) { quotes: "~" "~"; }
```

## 5. 견고한 중앙 정렬 기법

참고 링크: [css-tricks.com](http://css-tricks.com/centering-css-complete-guide/)

일반적으로 `margin: 100px auto;` 형태로 중앙정렬한다. 하지만 위 참고링크에서처럼 상황에 따라 적용이 안 될 경우가 있다. 아래처럼 테이블, 테이블 셀을 활용해서 div를 중첩하면 어디서든 적용되는 견고한 중앙정렬 형태가 만들어진다. 아래 코드에서 `div.centered` 안에 원하는 것을 넣으면 된다.

- 요소의 수평 중앙 정렬: `.inner`의 `text-align` 속성 수정
- 요소의 수직 중앙 정렬: `.inner`의 `vertical-align` 속성 수정

```html
<div class="container">
  <div class="outer">
    <div class="inner">
      <div class="centered">
        ...
      </div>
    </div>
  </div>
</div>
```

```css
.container {
  width: 70%;
  height: 70%;
  margin: 40px auto;
  background: red;
}
.outer {
  display: table;
  width: 100%;
  height: 100%;
}
.inner {
  display: table-cell;
  vertical-align: middle;
  text-align: center;
}
.centered {
  position: relative;
  display: inline-block;
 
  width: 50%;
  padding: 1em;
  background: orange;
  color: white;
}
```

## 5. display, visible

### 5.1 display: 어떻게 보여질 것인가

#### 5.1.1 inline

- span, strong, em, label, a, img 등의 태그들이 있다.
- 줄 바꿈이 일어나지 않는다.
- width, height 속성을 변경할 수 없다.
- `display: inline;` : inline element로 바꾼다.

#### 5.1.2 block

- 영역을 나타내는 대부분의 태그들. div, section, article, p, ol, ul, table
- 가로 전체를 사용하며 줄바꿈된다.
- width, height 속성 변경 가능.
- `display: block;` : block element로 바꾼다.

#### 5.1.3 none

- 보이지 않는 속성

#### 5.1.4 inline-block

- block 박스로 만들어지나, inline 처럼 한 줄로 배치가 된다.
- margin, width, height 속성 지정 가능
- 기본이 block이거나 inline이거나 모두 이 속성으로 바꿔줄 수 있다.
- `display: inline-block`: inline-block element로 바꾼다.
- 상, 하 여백을 margin과 line-height 두가지 속성으로 제어 가능
- inline-block 속성을 가진 태그끼리 연속으로 사용하면 좌우 5px 정도의 여백이 자동으로 적용된다.
- IE7 이하는 다음 코드처럼 적용한다.

    ```css
    div {
      display: inline-block;
      *display: inline;
      *zoom: 1;
    }
    ```

### 5.2 visible: 보이게 할 것인가 말 것인가

- `visibility: visible;` : 기본값으로 요소가 그대로 보인다.
- `visibility: hidden;` : 숨기지만, 자신의 영역은 계속 차지한다. 결국 투명임.
- `visibility: collapse;` : table 태그에서만 지정할 수 있는 속성이다. 해당 테이블의 행, 열을 숨긴다. 표의 행 열 위치가 뭉개지지 않기 때문에 table에서 사용하면 좋다. 여전히 투명하게 공간을 차지하고, 다른 태그에서 쓰면 hidden처럼 동작한다.
- `visibility: inherit` : 부모 요소의 값을 상속

## 6. 폰트

### 6.1 CSS에서 적용 방법

```css
body{
  font-family: "돋움", dotum, "굴림", gulim, arial, helvetica, sans-serif;
}
```

- 순서대로 우선순위가 적용되는데 첫 번째가 없으면 다음이 적용된다.
- 한글로 안돼있는 경우가 있어서 위처럼 같은 폰트지만 영어로도 다음 순서로 적어주는게 일반적.
- 마지막의 `sans-serif`는 폰트가 아니라 형태를 나타내므로 앞 폰트가 하나도 없다면 sans-serif 형태의 폰트를 적용해라 라는 의미다.
- 한글 이름이나 띄워쓰기가 있는 폰트는 쌍따옴표로 감싸준다.

### 6.2 sans-serif, serif

- serif는 꺾쇠가 있는것, sans는 없는 것.
- 
