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
