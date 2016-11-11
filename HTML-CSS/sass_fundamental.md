# SASS 기초

Sass(Syntactically Awesome StyleSheets)는 CSS3의 확장 버전이다. nested rules, variables, mixins, selector 상속 등의 기능들이 추가됐다. Sass에 두 신택스가 있는데 가장 메인이 SCSS(Sassy CSS)이다. CSS3의 슈퍼셋이어서 CSS3 문법을 써도 정상적으로 작동한다.

## 1. 기본

- `gem install sass` : 터미널에서 설치
- `sass main.scss main.css` : Sass는 브라우저가 모르는 문법이기 때문에 먼저 변환, 컴파일해서 CSS3 코드로 바꿔줘야한다.

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

```css
/* Example 1 */
@mixin backface-visibility {
  backface-visibility: hidden;
  -webkit-backface-visibility: hidden;
  -moz-backface-visibility: hidden;
  -ms-backface-visibility: hidden;
  -o-backface-visibility: hidden;
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
 
  border-#{$side}-radius: $radius;
  -moz-border-radius-#{$side}: $radius;
  -webkit-border-#{$side}-radius: $radius;
}
#navbar li { @include rounded-top; }
#footer { @include rounded-top; }
```
