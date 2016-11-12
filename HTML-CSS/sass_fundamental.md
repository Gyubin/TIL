# SASS 기초

참고: [공식 가이드 문서](http://sass-lang.com/guide)

Sass(Syntactically Awesome StyleSheets)는 CSS3의 확장 버전이다. nested rules, variables, mixins, selector 상속 등의 기능들이 추가됐다. Sass에 두 신택스가 있는데 가장 메인이 SCSS(Sassy CSS)이다. CSS3의 슈퍼셋이어서 CSS3 문법을 써도 정상적으로 작동한다.

## 1. 기본

- `gem install sass` : 터미널에서 설치
- `sass main.scss main.css` : Sass는 브라우저가 모르는 문법이기 때문에 먼저 변환, 컴파일해서 CSS3 코드로 바꿔줘야한다.
- `sass --watch app/sass:public/stylesheets` : watch 옵션을 써서 특정 디렉토리를 계속 보고 있다가 변경되면 다시 자동으로 전처리해준다.

## 2. Nesting

### 2.1 Selector nesting

- 셀렉터 안에 또 셀렉터를 쓰는 것
- `{ }`를 기점으로 부모, 자식 셀렉터로 나뉘어진다.

```css
.hello {
    .thanks {
        font-family: "Pacifico", cursive;
    }
}
```

### 2.2 Property nesting

- property 뒤에 `:` 을 쓰고 `{ }` 써서 나타낸다.

```css
/* scss code */
.parent {
  font : {
    family: Roboto, sans-serif;
    size: 12px;
    decoration: none;
  }
}

/* css code */
.parent {
  font-family: Roboto, sans-serif;
  font-size: 12px;
  font-decoration: none;
}
```

### 2.3 `&` ampersand

- 부모 element를 참조한다.
- `:hover`같은 pseudo class같은 경우에 주로 사용

```css
/* scss */
.notecard { 
  &:hover {
    @include transform (rotatey(-180deg));  
  }
}

/* css */
.notecard:hover {
  transform: rotatey(-180deg);
}
```

## 3. Variables

```css
$translucent-white: rgba(255,255,255,0.3);
.parent {
    background-color: $translucent-white;
}
```

- 위와 같은 형태로 `$`를 써서 import문이 있다면 그 아래에 선언해준다.
- 대입은 등호 기호가 아니라 `:`으로 한다.
- 사용할 때도 역시 `$`를 함께 써줘야한다.

## 4. Data type

### 4.1 기본형

- Numbers: `3.14`, `100`도 숫자지만 `10px`도 숫자로 여겨진다.
- Strings: quotes가 있든 없든 상관없다. `"Gyubin"`도 문자열이고 `span`도 문자열이다.
- Booleans: `true`, `false`
- null: 빈 값이다.

### 4.2 List, Maps

- Lists
    + 스페이스나 콤마로 구분된다.
    + 리스트를 괄호로 감싸서 다른 리스트의 원소로 넣을 수도 있다.

    ```
    1.5em Helvetica bold;
    Helvetica, Arial, sans-serif;
    $standard-border: 4px solid black;
    ```

- Maps
    + 리스트와 비슷한데 key-value 쌍으로 이루어져있다.
    + value는 map이나 list가 될 수도 있다.

    ```
    (key1: value1, key2: value2);
    ```

## 5. Mixin

- 선언은 `@mixin`, 호출은 `@include`로 사용한다.
- variable이 한 줄, 하나의 개체를 여러 번 사용할 수 있다면 mixin은 거대한 코드 뭉치를 재사용할 수 있게 해준다.
- 주로 여러 브라우저의 종속성 문제를 해결하기 위한 코드를 mixin으로 만들어서 재사용한다.

```css
/* Example 1 */
@mixin backface-visibility {
  -webkit-backface-visibility: hidden;
     -moz-backface-visibility: hidden;
      -ms-backface-visibility: hidden;
       -o-backface-visibility: hidden;
          backface-visibility: hidden;
}
.notecard {
  .front, .back {
    width: 100%;
    height: 100%;
    position: absolute;
    @include backface_visibility;
  }
}
```

```css
/* Example 2 */
@mixin rounded-top {
  $side: top;
  $radius: 10px;

  -webkit-border-#{$side}-radius: $radius;
     -moz-border-radius-#{$side}: $radius;
          border-#{$side}-radius: $radius;
}
#navbar li { @include rounded-top; }
#footer { @include rounded-top; }
```

## 6. Partials

- 파일 앞에 `_` 언더스코어를 붙여서 부분 파일을 만들 수 있다. 즉 모듈화할 수 있는 기능이다. `_partial.scss` 같은 파일을 만들면 된다.
- 앞에 언더스코어를 붙이면 scss 전처리기가 해당 파일을 css로 변환하지 않는다.
- CSS는 기본적으로 파일을 작게 나눌 수 있도록 import 옵션을 가지고 있는데 매 호출 `@import`마다 HTTP request를 발생시키는 것이 단점이다. SCSS는 파일들을 전처리해서 하나의 CSS 파일로 만들기 때문에 그런 문제가 없어진다.

```css
/* _reset.scss*/
html,
body,
ul,
ol {
   margin: 0;
  padding: 0;
}

/* base.scss*/
@import 'reset';

body {
  font: 100% Helvetica, sans-serif;
  background-color: #efefef;
}
```

```css
/* result.css */
html, body, ul, ol {
  margin: 0;
  padding: 0;
}

body {
  font: 100% Helvetica, sans-serif;
  background-color: #efefef;
}
```

## 7. Extend/Inheritance

- `@extend` : 셀렉터 간의 CSS 속성들을 상속받을 수 있다.
- 다른 셀렉터 내에서 `@extend {selector};` 형태로 써주면 된다.
- 아래 코드 예제는 `.message` 셀렉터의 속성들을 `.success`, `.error`, `.warning` 셀렉터가 사용하는 형태다.

```css
/* scss */
.message {
  border: 1px solid #ccc;
  padding: 10px;
  color: #333;
}

.success {
  @extend .message;
  border-color: green;
}

.error {
  @extend .message;
  border-color: red;
}

.warning {
  @extend .message;
  border-color: yellow;
}
```

```css
/* result.css */
.message, .success, .error, .warning {
  border: 1px solid #cccccc;
  padding: 10px;
  color: #333;
}

.success {
  border-color: green;
}

.error {
  border-color: red;
}

.warning {
  border-color: yellow;
}
```

## 8. 연산자

- `+`, `-`, `*`, `/`, `%` 연산자를 이용할 수 있다.

```css
/* scss file */
.container { width: 100%; }

article[role="main"] {
  float: left;
  width: 600px / 960px * 100%;
}

aside[role="complementary"] {
  float: right;
  width: 300px / 960px * 100%;
}
```

```css
/* result.css */
container {
  width: 100%;
}

article[role="main"] {
  float: left;
  width: 62.5%;
}

aside[role="complementary"] {
  float: right;
  width: 31.25%;
}
```
