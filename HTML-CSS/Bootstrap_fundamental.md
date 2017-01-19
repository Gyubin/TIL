# Bootstrap 4

## 0. 설치 및 사용

[버전4](https://v4-alpha.getbootstrap.com/) 링크로 가서 다운받거나, cdn으로 사용하면 된다.

- `head`에 다음 코드를 삽입

    ```html
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
    ```

- `body` 태그 마지막에 다음 코드 삽입. JQuery, Tether, BootstrapJS 순으로

    ```html
    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
    ```

- 종합해서 아래처럼 시작한다.
    - viwport meta tag: 반응형으로 만들기 위해 적어줘야 한다.

    ```html
    <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
        </head>
        <body>
          <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
        </body>
      </html>
    ```

## 1. 기본

- body 태그 하위에 여러 `section`이 들어간다. 큰 주제로 나뉘어서 구분되는 부분이다. 예를 들어 랜딩 페이지라면 cover 섹션, 팀 소개 섹션, 서비스 소개 섹션 등이다.
- 다만 `nav`, `footer` 태그는 section과 같은 등위로 배치된다.
- 반응형 breakpoint. 순서대로 css, sass 코드

    ```css
    @media (min-width: 576px) {  }
    @media (min-width: 768px) {  } <!-- Medium devices (tablets, 768px and up) -->
    @media (min-width: 992px) {  } <!-- Large devices (desktops, 992px and up) -->
    @media (min-width: 1200px) {  } <!-- Extra large devices (large desktops, 1200px and up) -->
    ```

    ```css
    @include media-breakpoint-up(xs) { ... }
    @include media-breakpoint-up(sm) { ... }
    @include media-breakpoint-up(md) { ... }
    @include media-breakpoint-up(lg) { ... }
    @include media-breakpoint-up(xl) { ... }

    // Example usage:
    @include media-breakpoint-up(sm) {
      .some-class {
        display: block;
      }
    }
    ```

### 1.1 Containers

- section 아래에 `div.container`가 위치하며 내부에 원하는 다양한 element들을 배치하면 된다.
- 부트스트랩 그리드를 사용하려면 꼭 container 안에서 써야한다.
- 두 가지 종류의 Container 존재
    + `class="container"` : max-width 속성이 쓰이는 고정폭 컨테이너
    + `class="container-fluid"` : 항상 100% 폭을 사용

### 1.2 Grid

- 기본적으로 폭을 12칸으로 나눠서 쓴다.
- `container` > `row` > `col` 순서로 포함관계다.

```html
<div class="container">
  <div class="row">
    <div class="col">
      1 of 2
    </div>
    <div class="col">
      1 of 2
    </div>
  </div>
  <div class="row">
    <div class="col">
      1 of 3
    </div>
    <div class="col">
      1 of 3
    </div>
    <div class="col">
      1 of 3
    </div>
  </div>
</div>
```

- `col`
    + 그냥 쓰면 Extra small 사이즈로 작동한다. 뒤에 `col-sm`, `col-lg` 형태로 붙여서 반응형 크기를 선택해주면 된다.
    + 숫자를 안 쓰면 자동으로 계산해서 Equal-width로 만들어준다.
    + 뒤에 `col-5`, `col-sm-4` 등으로 숫자를 명시하면 12칸으로 나뉜 것 중에 해당 숫자 칸만큼 폭을 차지함
- `col-{breakpoint}-auto` : auto를 붙이면 내부 content의 길이에 적합하게 보여진다.
- `.col` 사이에 `div.w-100` 을 넣으면 컬럼이 아래로 내려간다. 즉 여러 개의 row를 만들 수 있다.
- 일종의 팁인데 `col-sm-*` 태그만 쓰면 sm 이상일 때는 지정한 크기대로 보이지만 extra small일 때는 자동으로 한 줄로 쌓이게 된다. 반응형 쉽다.

### 1.3 Flexbox alignment

#### 1.3.1 Vertical align

- `align-items-{place}` : `start`, `center`, `end` 값으로 세로 위치 정할 수 있다. 아래의 예는 container 안에서 row의 배치를 나타낸다.

    ```html
    <div class="container">
      <div class="row align-items-start">
        <div class="col">One of three columns</div>
        <div class="col">One of three columns</div>
        <div class="col">One of three columns</div>
      </div>
      <div class="row align-items-center">
        <div class="col">One of three columns</div>
        <div class="col">One of three columns</div>
        <div class="col">One of three columns</div>
      </div>
      <div class="row align-items-end">
        <div class="col">One of three columns</div>
        <div class="col">One of three columns</div>
        <div class="col">One of three columns</div>
      </div>
    </div>
    ```

- `align-self-{place}` : 역시 `start`, `center`, `end` 값으로 설정. column의 세로 위치를 조절할 수 있고 위의 items와 이번 self의 차이는 자식들에게 적용이냐, 스스로에게 적용이냐가 다른 것 같다.

    ```html
    <div class="container">
      <div class="row">
        <div class="col align-self-start">One of three columns</div>
        <div class="col align-self-center">One of three columns</div>
        <div class="col align-self-end">One of three columns</div>
      </div>
    </div>
    ```

#### 1.3.2 Horizontal align

```html
<div class="container">
  <div class="row justify-content-start">
    <div class="col-4">One of two columns</div>
    <div class="col-4">One of two columns</div>
  </div>
  <div class="row justify-content-center">
    <div class="col-4">One of two columns</div>
    <div class="col-4">One of two columns</div>
  </div>
  <div class="row justify-content-end">
    <div class="col-4">One of two columns</div>
    <div class="col-4">One of two columns</div>
  </div>
  <div class="row justify-content-around">
    <div class="col-4">One of two columns</div>
    <div class="col-4">One of two columns</div>
  </div>
  <div class="row justify-content-between">
    <div class="col-4">One of two columns</div>
    <div class="col-4">One of two columns</div>
  </div>
</div>
```

- row에 있는 column들을 수평으로 정렬하는 방법이다.
- `justify-content-{place}` 가 기본형이고 place에 `start`, `end`, `center`, `around`, `between`이 들어가면 된다.
- 앞의 세 개는 이름과 의미가 같고, around는 적절하게 벌려놓는 느낌, between은 양 끝에 최대한 몰아넣는 느낌이다.

## 2. Component

### 2.1 Carousel

```html
<section id="carousel">
  <div id="carousel-home" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#carousel-home" data-slide-to="0" class="active"></li>
      <li data-target="#carousel-home" data-slide-to="1"></li>
      <li data-target="#carousel-home" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner" role="listbox">
      <div class="carousel-item active">
        <img src="img/woman-camera.jpg" alt="Woman taking picture with a camera">
        <div class="carousel-caption">
          <h3>A woman with a camera</h3>
          <p>She is probably taking a picture.</p>
        </div>
      </div>
      <div class="carousel-item">
        <img src="img/spiderweb.jpg" alt="A wet spiderweb">
        <div class="carousel-caption">
          <h3>Down came the rain</h3>
          <p>And washed the spider out</p>
        </div>
      </div>
      <div class="carousel-item">
        <img src="img/hearthand.jpg" alt="Two hands making a heart">
        <div class="carousel-caption">
          <h3>Making love</h3>
          <p>With their hands... </p>
        </div>
      </div>
    </div>
    <a class="left carousel-control" href="#carousel-home" role="button" data-slide="prev">
      <span class="icon-prev" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#carousel-home" role="button" data-slide="next">
      <span class="icon-next" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</section>
```

- 구조

    ```sh
    section # id="carousel"
      div # id="carousel-home" class="carousel slide" data-ride="carousel"
        ol # class="carousel-indicators"
        div # class="carousel-inner" role="listbox"
          div # class="carousel-item active"
          div # class="carousel-item"
          div # class="carousel-item"
        a # class="left carousel-control" href="#carousel-home" role="button" data-slide="prev"
        a # class="right carousel-control" href="#carousel-home" role="button" data-slide="next"
    ```

- section이 가장 상단에서 감싼다.(html 권장)
- carousel 기능이 들어가는 부트스트랩 div가 아래로 들어간다.
- 부트스트랩 div 아래 4가지가 들어간다. indicator, listbox, left-arrow, right-arrow
- listbox 안에 여러 아이템들이 들어가면 된다.
