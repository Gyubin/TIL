# webpack

참고: [공식 페이지](https://webpack.github.io/), [Naver d2](http://d2.naver.com/helloworld/0239818), [egghead.io 강의](https://egghead.io/lessons/tools-validate-your-webpack-config-with-webpack-validator)

서버가 아니라 자바스크립트에서 처리하는 로직이 많아지고 있다. 코드가 많아지면 모듈로 나눠서 편리하게 관리하면 좋은데 JavaScript는 모듈 개념이 없다. 그래서 webpack이 나왔다.

## 1. 설치

```sh
npm install webpack -g
```

## 2. 간단 실행

- 아래 2개의 `entry.js` 파일, `index.html` 파일을 만든다.

    ```js
    // entry.js
    document.write("It works.");
    ```

    ```html
    <html>
        <head>
            <meta charset="utf-8">
        </head>
        <body>
            <script type="text/javascript" src="bundle.js" charset="utf-8"></script>
        </body>
    </html>
    ```

- 터미널에서 다음 명령어 실행

    ```sh
    webpack ./entry.js bundle.js
    ```

- `index.html` 실행해보면 정상적으로 동작한다.
