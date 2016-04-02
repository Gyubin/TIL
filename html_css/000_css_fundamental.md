# CSS 기초

css에 대해서 공부하면서 새로운 것들, 외워둘 것들 등등에 대해서 정리해 나가는 파일

## 1. 기본

- 브라우저 지원 : 앞에 붙인다. `-webkit-`, `-moz-`, `-o-`
- `#` -> `.` -> `나머지` : 스타일 겹칠 때 적용 우선순위
- `margin: 100px auto;` : 상하 마진 100px 주고, 좌우는 auto로 중앙 정렬시킨다.
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
