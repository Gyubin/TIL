# Webpack 2

버전 2는 달라진게 많다고 들어서 따로 정리한다.

## 0. 설치

- `brew install yarn` : yarn 패키지 매니저 설치
- webpack 설치
    + `npm i -g webpack@2 webpack-dev-server@2` : npm으로 설치하든지
    + `yarn add --dev webpack@2 webpack-dev-server@2` : yarn으로 하든지 선택

## 1. webpack.config.js

```js
const path = require('path');
const webpack = require('webpack');

module.exports = {
  context: path.resolve(__dirname, './src'),
  entry: {
    app: './app.js',
  },
  output: {
    path: path.resolve(__dirname, './dist'),
    filename: '[name].bundle.js',
  },
};
```

- `context` 폴더에서 시작해서
- `entry` 속성에 들어있는 파일들을 찾고 읽는다.
- 모든 `import`(ES6)와 `require`(Node)로 엮여져있는 의존성 파일들이 번들된다.
- 최종 빌드된 파일은 `output.path`에서 지정한 곳에 `output.filename`이란 이름으로 만들어진다. 위 경우 `app.bundle.js` 파일이 만들어짐.

## 2. 예제

- `yarn add moment` : moment 라이브러리 가져온다.
- `app.js` 파일 만들기

    ```js
    import moment from 'moment';
    
    var rightNow = moment().format('MMMM Do YYYY, h:mm:ss a');
    console.log(rightNow);
    ```

- 위에서 예를 든 config 파일을 만들어준다.
- `webpack -p` : production 모드로 빌드한다. 자동으로 uglify, minify해준다. 사용하는 moment 라이브러리 파일을 따로 가져올 필요없이 번들된 js 파일만 있으면 됨
