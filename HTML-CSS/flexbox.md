# flexbox

CSS의 레이아웃 속성이다. 수직, 수평 정렬 등을 매우 쉽게 해준다. 이거 있으면 딱히 부트스트랩 안 써도 될 것 같다.

참고 링크: [css-tricks](https://css-tricks.com/snippets/css/a-guide-to-flexbox/), [solved-by-flexbox](https://philipwalton.github.io/solved-by-flexbox/), [w3 doc](https://www.w3.org/TR/css-flexbox-1/)

## 1. 기본

### 1.1 flex container

- display
    + `display: flex;` : contaner를 block 속성으로
    + `display: inline-flex;` : inline 속성으로
- 정렬 방향: 속한 요소를 어느 방향으로 차례대로 놓을 것인가에 대한
    + `flex-direction: row;` : ltr일 때 좌->우, rtl일 때 우->좌. **default**.
    + `flex-direction: row-reverse;` : row 속성과 반대
    + `flex-direction: column;` : top to bottom
    + `flex-direction: column reverse;` : bottom to top
- flex-wrap
    + `flex-wrap: nowrap;` : 싱글 라인. item이 container의 width를 넘어가서 한 줄에 그대로 쭉 나열된다. **default**.
    + `flex-wrap: wrap;` : 멀티 라인. container의 width를 넘어가면 다음 라인에서 나열된다.
    + `flex-wrap: wrap-reverse;` : 멀티 라인 속성은 똑같은데 width를 넘어가면 라인이 추가되는 위치가 '위' 쪽이다. 그냥 `wrap`은 아래쪽에 추가되는 것과 반대.
- `flex-flow: <‘flex-direction’> || <‘flex-wrap’>`: direction, wrap 속성을 한 번에 쓸 수 있는 단축키같은 것. 공백으로 구분해서 쓰면 된다.
- justify-content
    + `justify-content: flex-start;` : 시작하는 쪽에 붙임. **default**.
    + `justify-content: flex-end;` : 끝나는 쪽에 붙임
    + `justify-content: center;` : 중앙 정렬
    + `justify-content: space-between;` : 첫 아이템은 시작에 붙이고, 끝 아이템은 끝에 붙이는 상황에서 사이 간격 균등하게 배치한다.
    + `justify-content: space-around;` : 아이템 사이의 간격을 균등하게 배치한다. 각 엘리먼트의 좌 우에 균등한 공백을 하나씩 넣는다고 생각하면 된다. 그래서 양 끝의 엘리먼트는 끝에 아무 요소도 없기 때문에 한 칸의 공백만 들어가고, 엘리먼트의 사이에는 양쪽 엘리먼트에서 공백 하나씩 있기 때문에 2배 크기의 공백이 있을 것이다.
- align-items : justify-content의 세로축 버전이라 생각하면 된다.
    + `align-items: flex-start;` : 위 끝에 맞춘다.
    + `align-items: flex-end;` : 아래쪽 끝에 맞추어 정렬
    + `align-items: center;` : 중앙 정렬
    + `align-items: baseline;` : item의 텍스트의 baseline 기준으로 정렬
    + `align-items: stretch;` : 늘여서 전체 세로 크기 다 차지한다. min-height, max-height 제한은 여전히 먹힌다. 그리고 이게 **default다**.
- align-content : item들이 속한 각 라인(행)들을 어떻게 배치할 것인가에 대한 것. justify-content의 라인 별 행동방식이라 보면 된다.
    + `align-content: flex-start;` : 위 라인에 붙인다.
    + `align-content: flex-end;` : 아래 라인에 붙인다.
    + `align-content: center;` : 중앙 정렬
    + `align-content: space-between;` : 양 끝 라인은 끝에 붙이고 균등 분할
    + `align-content: space-around;` : 요소별로 위 아래에 균등한 공백 부여.
    + `align-content: stretch;` : 전체 요소 크기 차지. **default**

### 1.2 flex items

grow, shrink, basis 부분이 이해가 잘 안됐는데 [hangwoo님 블로그](https://hangwoo.github.io/posts/css3_flex_box/)를 참고했다. 감사합니다.

- `order: <integer>;` : 숫자로 순서를 매기면 그 순서로 정렬된다. 음수도 가능
- `flex-grow: <number>;` : 컨테이너에 아이템을 채우고 남은 공간들을 어떤 비율로 배분할 것인가에 대한 비율이다. 500 컨테이너에 100 아이템 3개가 있다면 남은 200을 비율에 따라 배분받게 된다. 0 이상인 수만 넣을 수 있고 default는 0. 
- `flex-shrink: <number>;` : grow와 반대 개념이다. row에 공간이 충분하지 않을 때 부족한 공간을 어떻게 배분받아서 줄일 것인가에 대한 비율이다. 500 컨테이너에 300 아이템 3개가 있다면 부족한 공간은 400이고, 이 400을 비율에 따라서 배분받아 기존 크기 300에서 뺀 후 적용된다. default는 1
- `flex-basis: ;` : flex-grow를 통해 남은 너비를 배분 받을 때 얼마만큼을 각 아이템에 고정 수치로 줄 것인지를 정한다. flex-grow의 비율과 관계없이 고정 수치를 주는 것. default는 auto로 콘텐츠 크기를 말하고, 0을 주면 고정크기 없이 모든 공간을 flex-grow 값으로 배분한다는 의미다. 아래 이미지 참고

![image](https://www.w3.org/TR/css-flexbox-1/images/rel-vs-abs-flex.svg)

- `flex: <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]` : default는 `0 1 auto`. shrink와 basis는 optional이다. 이런 shorthand를 쓰는 것을 추천한다고 한다.
- align-self : container의 `align-items` 속성을 개별 아이템에서 오버라이드할 수 있다.
    + `align-self: auto;`
    + `align-self: flex-start;`
    + `align-self: flex-end;`
    + `align-self: center;`
    + `align-self: baseline;`
    + `align-self: stretch;`

## 2. 양 끝에 붙이기

참고링크: http://stackoverflow.com/questions/10272605/align-two-inline-blocks-left-and-right-on-same-line

### 1.1 flex 사용

```html
<!-- html -->
<div class="header">
  <h1>Title</h1>
  <div class="nav">
    <a>A Link</a>
    <a>Another Link</a>
    <a>A Third Link</a>
  </div>
</div>
```

```css
/* css */
.header {
  background: #ccc; 
  display: flex;
  justify-content: space-between;
}
```

- `display:flex` 를 활용한 예인데 IE는 버전 10부터 지원한다.

### 1.2 IE7 이상 적용하기

```html
<!-- html -->
<div class="header">
  <h1>Title</h1>
  <div class="nav">
    <a>A Link</a>
    <a>Another Link</a>
    <a>A Third Link</a>
  </div>
</div>
```

```css
/* css */
.header {
  background: #ccc;
  text-align: justify;

  /* IE special */
  width: 100%;
  -ms-text-justify: distribute-all-lines;
  text-justify: distribute-all-lines;
}

.header:after {
  content: '';
  display: inline-block;
  width: 100%;
  height: 0;
  font-size:0;
  line-height:0;
}

h1 {
  display: inline-block;
  margin-top: 0.321em;

  /* ie 7*/ 
  *display: inline;
  *zoom: 1;
  *text-align: left;
}

.nav {
  display: inline-block;
  vertical-align: baseline;
  
  /* ie 7*/
  *display: inline;
  *zoom:1;
  *text-align: right;
}
```

- `text-align: justify` 활용
