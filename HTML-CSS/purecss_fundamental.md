# Pure.css

참고 링크: [seoh.github.io](http://seoh.github.io/pure-site/grids.html), [공식 홈페이지](http://purecss.io/start/)

부트스트랩 말고 다른거 써보고싶어서 선택한 css 모듈이다. js 없이 오직 css로만 구성되어있어서 가볍고 빠르다. 그리고 뭔가 디자인이 예쁘다.

## 0. 설치

- CDN 사용

    ```html
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
    ```

- 직접 호스팅: 경로에 맞게 링크하기.

    ```sh
    # 두 코드 중에 아무거나 터미널에서 실행
    bower install --save pure
    npm install purecss
    ```

## 1. 그리드

`pure-g` 클래스로 row를 만들고, 그 내부에 `pure-u-*` 클래스로 column을 만든다. 자체 커스텀 그리드를 만들고 싶으면 [yui](http://yui.github.io/gridbuilder/)에서 만든다.

```html
<style>
    .sidebar {
        padding: 0.5em; 
        border-right: 2px solid #777;
    }
    .main {
        padding: 0.75em 0.5em; 
    }
</style>

<div class="pure-g">
    <div class="pure-u-1-2">
        <div class="sidebar"> ... </div>
    </div>
    <div class="pure-u-1-2">
        <div class="main"> ... </div>
    </div>
</div>
```



















