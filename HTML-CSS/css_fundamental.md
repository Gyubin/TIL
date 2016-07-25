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

- `text-indent` : 양수는 들여쓰기, 음수 값을 주면 내어쓰기. 주로 `em` 값을 준다.
- `text-transform`: 글자를 강제로 대, 소문자로 바꾼다.
    + `uppercase`: 대문자로
    + `lowercase`: 소문자로
    + `capitalize`: 각 단어의 첫 글자를 대문자로
- 글자 간격
    + `letter-spacing`: 자간을 설정한다. 0이 기본 값이다.
    + `word-spacing: `: 단어 사이 띄어쓰기 간격 조절. 0이 기본값.
-`vertical-align`: 연달아 오는 inline 속성의 엘리먼트 간의 정렬을 말한다. 일반적인 중앙 정렬, 중앙 배치 그런게 아니다.
    + `baseline` : 텍스트 베이스라인 기준. 기본값.
    + `sub` : 아래 첨자
    + `super` : 윗 첨자
    + `top` : 해당 줄의 가장 높은 요소 기준으로 위에 정렬
    + `text-top` : 부모 요소의 글자를 기준으로 맨 위에 정렬
    + `bottom` : 해당 줄의 가장 낮은 요소를 기준으로 맨 아래에 정렬
    + `text-bottom` : 부모 요소의 글자를 기준으로 맨 아래에 정렬
    + `middle` : 부모 요소의 글자를 기준으로 가운데 정렬
    + `숫자단위(px)` : 베이스 라인 기준으로 양수는 위, 음수는 아래
    + `비율단위(%)` : line-height 기준으로 양수 비율은 위로, 음수 비율은 아래
- `white-space`
    + `nowrap` : 모든 줄바꿈 무시. 한 줄로 쭉 표시된다. br 태그도, 속한 박스도 무시하고 줄바꿈 일어나지 않는다.
    + `pre` : pre 요소와 동일. 띄어쓰기 O, 줄바꿈 O, 박스 초과 O
    + `pre-line` : 띄어쓰기 X, 줄바꿈 O, 박스 초과 X
    + `pre-wrap` : 띄어쓰기 O, 줄바꿈 O, 박스 초과 X

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

### 2.1 자식, 형제

- 자식 선택자
    + ` ` 공백: `grand parents child` 처럼 element를 순서대로 한 칸 씩 띄워서 쓰면 모든 자식을 의미한다. 자식의 자식, 자식의 자식의 자식 element도 선택된다.
    + `>` : `grand > parents > child` 처럼 `>`로 구분해서 쓰면 바로 연결된 직속 자식만이 선택된다.
- `+` : 인접 형제 선택자. Orange, Banana만 폰트 색이 빨강으로 바뀐다.

    ```css
    <div class="abc">
      <p>Apple.</p>
      <p>Orange.</p>
      <p>Banana.</p>
    </div>

    p + p {
      color: red;
    }
    ```

- `~`: 일반 형제 선택자. 아래 코드에서 Orange, Banana 변경. 바로 옆에 인접하지 않더라도 형제라면 선택된다.

    ```css
    <div class="abc">
      <p>Apple.</p>
      <p>Orange.</p>
      <div>Something else</div>
      <p>Banana.</p>
    </div>

    p ~ p {
      color: red;
    }
    ```

### 2.2 pseudo-class 선택자

#### 2.2.1 링크 관련

- `:link` : href 속성이 있는 element 선택.
- `:visited` : 방문한 링크
- `:hover` : 해당 엘리먼트 위에 커서가 올 때. 링크 아니라도 적용 가능
- `:active` : 마우스로 링크를 클릭한 순간

위 네 가지 선택자는 모두 같은 우선순위라서 순서에 따라 적용되는 것이 달라진다. 그러므로 a 태그를 쓸 때는 순서에 유의해야 함. 즉 **:link > :visited > :hover > :active** 순으로.

#### 2.2.2 다른 것

- `:focus` : colon을 한 번쓰면 다음에 이벤트가 올 수 있는데 focus는 input element에서 초점이 와있는 것을 말한다. a element에서도 가능.
- `:first-child` : 첫 번째 자식인 것만 선택한다. 해당 태그 중에서 첫 번째를 선택하는 것이 아니라 다양한 태그들 중에서 첫 번째다. 아래 코드는 p 선택 안된다.

    ```html
    <style type="text/css">
      p:first-child{
        color: red;
      }
    </style>
    <div class="abc">
      <div>Something else</div>
      <p>Apple.</p>
      <p>Orange.</p>
    </div>
    ```

- `::pseudo` : 태그 자체를 선택하는 것이 아니라 태그의 특정 '상태'를 선택한다. 또는 placeholder같은 것들을 붙잡을 때 쓸 수도 있다.
- 여러 개 선택할 때: 쉼표로 구분한다. 자식 선택할 때도 쉼표로 구분하는 것을 적용할 수 있다.

    ```css
    h1, p, a, .container, #gyubin {
        color: aqua;
    }
    h1, .container p, a {
        color: aqua;
    }
    ```

- `tag[attributes=value]` : tag 뒤에 대괄호를 쓰면 속성에 접근할 수 있다.
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

```css
body{
  font-family: "돋움", dotum, "굴림", gulim, arial, helvetica, sans-serif;
}
```

- 순서대로 우선순위가 적용되는데 첫 번째가 없으면 다음이 적용된다.
- 한글로 안돼있는 경우가 있어서 위처럼 같은 폰트지만 영어로도 다음 순서로 적어주는게 일반적.
- 마지막의 `sans-serif`는 폰트가 아니라 형태를 나타내므로 앞 폰트가 하나도 없다면 sans-serif 형태의 폰트를 적용해라 라는 의미다.
- 한글 이름이나 띄워쓰기가 있는 폰트는 쌍따옴표로 감싸준다.

## 7. 배경 이미지

- `background-image: url('../img/bg.png');`
- `background-repeat`
    + `repeat` : 이미지 바둑판 모양으로 반복. 기본값.
    + `repeat-x` : 가로로 반복
    + `repeat-y` : 세로로 반복
    + `no-repeat` : 한 번만 보여주고 반복 없음
- `background-position`
    + 수치 값: `px` 또는 `%`로 지정. 기준은 좌우로는 좌측, 상하로는 상 기준. %는 이미지의 사이즈 기준으로 상대값이라고 한다.
    + 문자 값: `top`, `bottom`, `left`, `right`, `center`
    + 한 개 값만 지정할 수도 있고, 공백으로 구분해서 두 개 값을 입력할 수 있다.
    + 한 개 값을 **수치**로 입력하면 x좌표 값이 되고, y좌표는 자동으로 `center`가 된다. 하지만 **문자** 값으로 하나만 입력하면 각 값의 성질에 따라 x 혹은 y 값이 정해지고, 나머지 값은 역시 center가 된다. center 값을 하나만 넣게되면 당연히 정 중앙에 위치.
    + 두 개 값을 수치로 입력하면 순서대로 x, y 좌표로 적용된다. 다만 문자값으로 입력하면 순서 상관없다. 그래도 순서 지키는게 좋을듯.
    + `background-position: 100% 16px;`
    + `background-position: right bottom;`
- `background-size`: position에서와 같은 원리로 수치나 퍼센트를 한 개 혹은 두 개 입력해주면 된다. 문자값은 없다.
- `background-attachment` : 배경이미지가 보이는걸 어떻게 할지.
    + `scroll` : 기본 값. 해당 element의 그 위치에 고정되어있다. 스크롤을 하더라도 이미지는 움직이지 않는다.
    + `local` : 스크롤을 하면 사라진다.
    + `fixed` : background-position의 좌표를 뷰포트 기준으로

## 8. border

`top`, `bottom`, `left`, `right` 네 변에 적용 가능.

### 8.1 border-width

```css
div {
  border-top-width : 3px;
}
```

- border-방향-width 형태로 작성
- px 값을 많이 사용.

### 8.2 border-style

```css
div {
  border-right-style : dotted;
}
```

- border-방향-style 형태로 사용
- `none` : 기본값. 선 없음
- `solid` : 실선
- `dotted` : 점선
- `dashed` : 바느질 선. 긴선 띄우고 짧은 점 반복
- `double` : 이중 선. width가 최소한 3px은 되어야 볼 수 있다.
- `groove` : 입체적으로 움푹 들어간 것처럼. 최소 굵기 2px
- `ridge` : groove와 반대로 돌출
- `inset` : 요소 전체가 안으로 들어가 보임
- `outset` : inset의 반대

### 8.3 border-color

```css
div {
  border-bottom-color : #aaa;
}
```

### 8.4 조합

```css
/* width style color 순서로 준다.*/
div {
  border-top : 3px dotted red;
}
```

```css
div {
  border-width: 3px 2px 1px 2px; /* top, right, bottom, left */
  border-width: 3px 1px 2px; /* top, (right+left), bottom */
  border-color : red #333; /* (top+bottom) (right+left) */
}
```

## 9. Box model

![box-model](http://webberstd.cdn1.cafe24.com/img/css-1/box-model.png)

### 9.1 margin, padding

- margin은 element 바깥, padding은 안쪽
- 기본: top, right, bottom, left 속성 줄 수 있고, 나눠 쓸수도 한 번에 적용할 수도 있다. px, em, %로 값을 조절한다.
- 서로 **붙어있는 element의 margin은 더 큰 값으로 정해진다.** 합쳐지는게 아니다.

### 9.2 width, height, border

- width, height는 border, margin, padding과 겹치는 값이 아니다. 독립적인 값.
- border 2px, padding 4px, margin 4px인데 전체 너비가 100px이고 싶다면 width를 90px로 줘야한다.

## 10. list-style

### 10.1 list-style-type

```css
ul {
  list-style-type : circle;
}
```

- ul
    + `none` : 장식 없음
    + `disc` : 채워진 원. 보통 기본값
    + `circle` : 속이 빈 원
    + `square` : 채워진 사각형
- ol
    + `decimal` : 숫자
    + `lower-alpha` : 소문자 순서
    + `upper-alpha` : 대문자
    + `lower-roman` : 로마자 소문자 숫자
    + `upper-roman` : 로마자 대문자 숫자

### 10.2 list-style-image

```css
ul {
  list-stype-image : url('../img/dot.png');
}
```

### 10.3 list-style-position

```css
ul {
  list-style-position : inside; /* 불릿이 글 문단 내부에 위치 */
  list-style-position : outside; /* 기본값 */
}
```

### 10.4 조합 가능

```css
ul {
  list-style : square url('../img/dot.png') inside;
}
```

- `type - image - position` 순서로.
- 타입과 이미지 모두 지정하면 image가 로드되지 않았을 때 type으로 보여진다.

## 11. 크로스 브라우징

### 11.1 CSS 초기화

- 브라우저 엔진마다 약간씩 다른 점이 있기 때문에 초기 세팅을 동등하게 하는 방법을 많이 쓴다.
- 하지만 잘못된 초기화를 쓰면 나중에 고치기가 쉽지 않기 때문에 초반에는 직접 하나하나 크로스 브라우징 하는 것도 좋다.
- font 관련 속성은 절대 초기화에 넣지 않는 것이 좋다. 상속 개념에서 굉장히 힘들어진다. 그냥 body, html에 한 번만 적용해주면 된다.

```css
/* 모든 요소. *를 쓰면 살짝 느려진다하여 아래처럼 하나하나 지정하기도 함 */
* {
  margin: 0;
  padding: 0;
}
html, body, div, h1, h2, h3, h4, h5, h6, p, dl, dt, dd, ul, ol, li, table, tr, th, td
{
  margin: 0;
  padding: 0;
}
```

```css
/* 기본 모양은 거의 안 쓴다. */
ol,ul {
  list-style: none;
}
```

```css
/* img border 없애기 */
img {
  border: none;
}
```

### 11.2 IE Hack

#### 11.2.1 비추천

- `*`: IE7 이하(6, 7)
- `_`: IE6 이하
- 이런 방법은 코드를 지저분하게 할 수 있다.

```css
div {
  color: red;
  *color: blue; /* IE 7이하 용 */
  _color : green; /* IE6 용 */
}
```

#### 11.2.2 추천

html 파일에서 IE에서만 스타일시트를 링크하는 방식이다.

```html
<!--[if IE 7]>
<link href="ie7.css" type="text/css" rel="stylesheet" />
<![endif]-->

<!--[if IE 6]>
<p>당신은 구형 IE6을 사용하고 있습니다. 최신 브라우저를 통해 더 나은 웹을 경험해보세요.</p>
<![endif]-->
```

아래 코드는 버전의 범위를 지정한다.

```html
<!--[if lt IE 8]>
<p>이 문구는 IE8이 포함되지않은 하위 브라우저, 즉 IE7,6에서 보여지게 됩니다.</p>
<![endif]-->
```

- `lt` : less than - 미만 (명시된 버전 미 포함)
- `lte` : less than or equal to - 이하 (명시된 버전 포함)
- `gt` : greater than - 초과 (명시된 버전 미 포함)
- `gte` : greater than or equal to - 이상 (명시된 버전 포함)

### 11.3 메타 이용

```html
<meta http-equiv="X-UA-Compatible" content="IE=7" />
```

- 위 메타 태그가 있으면 IE 버전이 9더라도 7과 동일하게 랜더링 해준다. `7`, `8`, `edge` 등의 값을 입력할 수 있다.
- 하지만 **비추천**. 하위 브라우저 모드가 점점 제대로 안되기도 하고 CSS3 사용도 잘 안되는 등의 부작용이 많다.

## 12. 스타일 시트에서 우선순위

### 12.1 스타일 시트 간의 우선순위

- link하면 그냥 여러 파일이 쭉 펼쳐지는 형태. 아래쪽이 더 나중에 적용되므로 우선순위가 높다.
- 적용 우선순위. 여기서 '중요 선언'이라는 의미는 아래 코드에서처럼 `!important` 표시를 한 것을 말한다.(비추천)
    + 1순위 사용자 선언: 사용자가 넣은 스타일 시트 중 중요 표시한 속성
    + 2순위 제작자 선언: 제작자가 넣은 시트 중 중요 표시한 속성
    + 3순위 제작자 선언: 제작자가 넣은 스타일 시트
    + 4순위 사용자 선언: 사용자의 스타일 시트
    + 5순위 User Agent 선언   브라우저의 기본 스타일 시트

    ```css
    /* 여기서 color 속성은 덮어씌워지지 않고 red로 유지된다.
    하지만 사용하는거 추천하지 않음. */
    p {
      font-size: 12px;
      color: red !important;
      line-height: 1.5;
    }
    p {
      font-size: 14px;
      color: blue;
    }
    ```
