# SASS 기초

Sass(Syntactically Awesome StyleSheets)는 CSS3의 확장 버전이다. nested rules, variables, mixins, selector 상속 등의 기능들이 추가됐다. Sass에 두 신택스가 있는데 가장 메인이 SCSS(Sassy CSS)이다. CSS3의 슈퍼셋이어서 CSS3 문법을 써도 정상적으로 작동한다.

- [공식 가이드 문서](http://sass-lang.com/guide)
- [SassWay](http://www.thesassway.com/)
    + [placeholder 설명](http://thesassway.com/intermediate/understanding-placeholder-selectors)
    + [function 설명](http://thesassway.com/advanced/pure-sass-functions)
- [sitepoint](https://www.sitepoint.com/sass-reference/)
    + [sitepoint 예제](https://www.sitepoint.com/html-css/css/sass-css/)
    + [mixin 예제](https://www.sitepoint.com/sass-basics-the-mixin-directive/)
- [scotch tutorials](https://scotch.io/tutorials/getting-started-with-sass)
- [css-tricks ampersand](https://css-tricks.com/the-sass-ampersand/)
- [inception-rule](http://thesassway.com/beginner/the-inception-rule)
- [color 함수들](http://jackiebalzer.com/color)

## 1. 기본

- 오리지널 sass
    + ruby gem으로 설치: `gem install sass`
    + `sass main.scss main.css` : Sass는 브라우저가 모르는 문법이기 때문에 먼저 변환, 컴파일해서 CSS3 코드로 바꿔줘야한다.
    + `sass --watch app/sass:public/stylesheets` : watch 옵션을 써서 특정 디렉토리를 계속 보고 있다가 변경되면 다시 자동으로 전처리해준다.
- libsass
    + C언어로 작성되어 매우 빠른 sass 컴파일러다. 하지만 sass가 업데이트되었을 때 바로 적용되진 않는다.
    + `sudo npm install -g node-sass` : node 환경에서 사용할 때 설치
    + `node-sass style.scss -o .` : style.scss를 컴파일해서 현재 디렉토리에 저장
    + `node-sass style.scss -w -o .` : watch 옵션 주기
- `//`: 한 줄 주석 가능 

## 2. Nesting

### 2.1 Selector nesting

- 셀렉터 안에 또 셀렉터를 쓰는 것
- `{ }`를 기점으로 부모, 자식 셀렉터로 나뉘어진다.
- [the-sass-way](http://thesassway.com/beginner/the-inception-rule)에 따르면 최대 4중첩까지만 하는걸 추천한다.

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

### 2.4 `@at-root`

- 코드를 보다가 nesting 되어있는 선택자가 그 밖에서 사용된다는 걸 알았을 때 앞에다 붙여준다.
- 그냥 잘라내서 바깥에 붙여주는게 가장 좋겠지만 Sass 코드를 처음부터 리팩토링할 때 유용하다.

```css
.container {
  .child {
    color: blue;
  }
  @at-root .sibling {
    color: gray;
  }
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
- scope 개념이 있어서 셀렉터 내에서 사용하면 해당 셀렉터에서만 접근 가능함.
    + 셀렉터 내에서 선언하는데 글로벌하게 설정하고 싶다면 `$my-color: #abc !global;` 처럼 뒤에 표시해주면 된다.

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

## 5. Interpolation

- `#{}` 형태로 치환할 수 있다. 안에는 주로 변수가 들어간다.

```
/* style.scss */

$side: top;
$radius: 10px;

.rounded-top {
  border-#{$side}-radius: $radius;
  -moz-border-radius-#{$side}: $radius;
  -webkit-border-#{$side}-radius: $radius;
}
```

```css
/* result.css */

.rounded-top {
  -webkit-border-top-radius: 10px;
     -moz-border-radius-top: 10px;
          border-top-radius: 10px;
}
```

## 6. Mixin

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

### 6.1 인자 활용하기

- mixin은 함수처럼 인자를 가질 수 있다. 역시 mixin 내부에서만 작동하는 지역변수같은 의미다.
- 기본값을 줄 수 있어서 값이 들어오지 않으면 기본값이 적용된다.

```css
/* style.scss */

@mixin rounded($side, $radius: 10px) {
  border-#{$side}-radius: $radius;
  -moz-border-radius-#{$side}: $radius;
  -webkit-border-#{$side}-radius: $radius;
}

#navbar li { @include rounded(top); }
#footer { @include rounded(top, 5px); }
#sidebar { @include rounded(left, 8px); }
```

```css
/* style.css */

#navbar li {
  border-top-radius: 10px;
  -moz-border-radius-top: 10px;
  -webkit-border-top-radius: 10px;
}

#footer {
  border-top-radius: 5px;
  -moz-border-radius-top: 5px;
  -webkit-border-top-radius: 5px;
}

#sidebar {
  border-left-radius: 8px;
  -moz-border-radius-left: 8px;
  -webkit-border-left-radius: 8px;
}
```


## 7. Partials

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

## 8. Extend/Inheritance

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

- 추가로 `%` 선택자를 사용하면 "상속"은 가능하지만 해당 코드가 "컴파일"되지는 않는다. 선언도 사용도 모두 `%`를 붙여줘야함

    ```css
    %box {
      padding: 0.5em;
    }
     
    .success-box {
      @extend %box;
      color: green;
    }

    .error-box {
      @extend %box;
      color: red;
    }
    ```

## 9. 연산자

- `+`, `-`, `*`, `/`, `%` 연산자를 이용할 수 있다.
    + 단위를 통일시켜야함. `100% - 20px` 이건 오류 발생.
- `==`, `!=` 비교연산자도 사용 가능

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

## 10. 함수

### 10.1 내장 함수

- `darken($color, 10%);` : color 값을 10% 더 어둡게 해서 컬러 값을 리턴

    ```css
    /* Sass, Compass library 활용*/
    $buttonColor: #2ecc71;
    $buttonDark: darken($buttonColor, 10%);
    $buttonDarker: darken($buttonDark, 10%);
    ```

- 공식 문서: http://sass-lang.com/documentation/Sass/Script/Functions.html
- color 관련: http://jackiebalzer.com/color

### 10.2 내 함수 만들기

- mixin은 모든 스타일 마크업을 통으로 반환하지만 function은 특정 값 하나를 리턴한다. 일반적인 함수와 같다.
- `@function`으로 선언하고 `@return`으로 내부에서 반환한다.

```css
@function calc-percent($target, $container) {
  @return ($target / $container) * 100%;
}
 
@function cp($target, $container) {
  @return calc-percent($target, $container);
}
 
.my-module {
  width: cp(650px, 1000px);
}
```
