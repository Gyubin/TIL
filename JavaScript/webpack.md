# webpack

참고: [공식 페이지](https://webpack.github.io/), [Naver d2](http://d2.naver.com/helloworld/0239818), [egghead.io 강의](https://egghead.io/lessons/tools-validate-your-webpack-config-with-webpack-validator)

서버(노드)가 아니라 프론트엔드단에서 자바스크립트에서 처리하는 로직이 많아지고 있다. 코드가 많아지면 모듈로 나눠서 편리하게 관리하면 좋은데 JavaScript는 모듈 개념이 없다. 그래서 webpack이 나왔다.

## 1. 설치

```sh
npm install webpack -g
```

## 2. js 파일 핸들링

### 2.1 첫 파일

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

### 2.2 파일 바꿔보기

- `content.js` 파일을 새로 만들고 `entry.js` 파일을 수정한다.

    ```js
    // content.js
    module.exports = "It works from content.js";
    ```

    ```js
    // entry.js
    document.write(require("./content.js"));
    ```

- 다시 `webpack ./entry.js bundle.js`로 빌드해서 실행시켜본다. content.js의 문장으로 바뀌었을 것.

## 3. CSS 파일 핸들링

- `npm install css-loader style-loader` : webpack은 기본적으로 js 파일만 다룬다. 그래서 추가로 이 모듈들을 설치해줘야한다. 글로벌이 아니라 로컬로 설치해야하고 `--save` 옵션으로 디펜던시 추가해줘야하는지는 잘 모르겠다.
- `style.css`, `entry.js`파일을 만들고 수정한다.

    ```css
    /* style.css */
    body {
        background: yellow;
    }
    ```

    ```js
    // entry.js
    require("!style!css!./style.css");
    document.write(require("./content.js"));
    ```

- 빌드하고 실행한다.
- 여기서 entry.js 파일의 css require하는 코드가 길기 때문에 다음처럼 변경할 수 있다.
    + `require("./style.css");` : entry.js에서 단순하게 변경하고
    + `webpack ./entry.js bundle.js --module-bind 'css=style!css'` : 빌드할 때 모듈 바인드해주면 된다.

## 4. config 파일

다음 내용으로 `webpack.config.js` 파일을 만든다. 그러면 더이상 명령어에 옵션을 더해서 실행하지 않고 단순히 `webpack` 만으로 빌드가 가능하다.

```js
module.exports = {
  entry: "./entry.js",
  output: {
    path: __dirname,
    filename: "bundle.js"
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style!css" }
    ]
  }
};
```

## 5. 기타

- `webpack --progress --colors` : 파일이 커지면 시간이 걸린다. 진행상태를 표현하고 예쁘게 보여준다.
- `webpack --progress --colors --watch` : 자동으로 파일들의 변화를 감지하여 변경이 생기면 바로바로 컴파일한다.
- 최강의 development server
    + `npm install webpack-dev-server -g` 설치하고
    + `webpack-dev-server --progress --colors` 실행한다.
    + express 서버를 띄워서 작업상태를 계속 볼 수 있다. 역시 watch 모드도 기본 작동이다.
