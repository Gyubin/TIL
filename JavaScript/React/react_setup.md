# React Setup

참고 링크: [codecademy article](https://www.codecademy.com/articles/react-setup-i) 1-5탄까지

## 1. npm, Node.js

### 1.1 설치

```sh
brew insall node
```

homebrew를 이용해서 설치한다. 위 코드로 node, npm이 동시에 깔릴 것이다.

### 1.2 init

```sh
npm init
```

프로젝트 디렉토리에서 입력한다. 상세 설정을 입력

## 2. React, ReactDOM 설치

```sh
npm install --save react # npm -i -S react
npm install --save react-dom # npm -i -S react-dom
```

`--save` 옵션은 npm의 package.json 파일에 기록하겠다는 의미. 즉 임시로 쓰는게 아니라 이 라이브러리가 이 프로젝트에 필요하다는 것을 기록

## 3. Babel

JSX 코드를 vanilla JavaScript 코드로 바꿔줘야 브라우저에서 작동한다. 이 때 필요한것이 JavaScript compiler인 바벨이다.

```sh
npm install --save-dev babel-core babel-loader babel-preset-react
# npm -i -D babel-{core, loader} babel-preset-react
```

- `--save-dev` 옵션을 주는 이유는 바벨이 development 모드에서만 사용되기 때문이다. 실 사용환경에서 babel은 필요 없다. 이를 나타내는 옵션이다.
- 기본 핵심 라이브러리가 babel-core이고 추가로 `babel-loader`, `babel-preset-react`도 설치해준다.
- 마지막으로 프로젝트 디렉토리에 `.babelrc` 파일을 만들고 안에 `{ presets: ['react'] }` 라고 기록한다.

## 4. Webpack

### 4.1 설치

JSX가 JavaScript로 바뀌는 것 등의 변환들을 쉽게 관리하고 실행할 수 있게 하는 transformation manager다. 여러 변환을 거쳐 하나의 통합 js 파일을 만든다.

```sh
npm install --save-dev webpack webpack-dev-server html-webpack-plugin
# npm -i -D webpack webpack-dev-server html-webpack-plugin
```

### 4.2 설정 파일

- 프로젝트 루트 디렉토리에 `webpack.config.js` 파일을 만들고 어떻게 변환할 것인지 설정한다. 다음 내용이 기록될 것이다.
    + 어떤 파일이 변환될 것인가
    + 어떤 변환이 적용될 것인가
    + 새롭게 만들어질 파일은 어디에 놓을 것인가.
- 어떤 파일이 변환될 것인가: entry point 설정
    + 리액트에선 가장 바깥에 있는, 가장 상위의 Component 파일이 될 것이다. 이 컴포넌트가 다른 컴포넌트를 포함한다면 웹팩은 그것도 같이 변환한다.
    + `entry`라는 property를 추가하고 해당 파일의 path를 설정한다. 원한다면 배열 형태로 여러 파일을 설정할 수도 있다.
    + `__dirname`은 Node.js에서 현재 디렉토리를 의미하는 변수다.
- 어떤 변환이 적용될 것인가: module
    + module property를 추가한다. object가 값으로 대입되고 안에 loaders 배열 속성이 존재한다. loaders에 적용될 변환을 넣으면 된다.
    + loaders 배열의 원소는 object다. 각 object는 `test` property가 필요하다. 값은 어떤 파일이 영향받을지 정규표현식으로 적으면 된다.
    + `include`, `exclude`: exclude는 이름 그대로 test의 조건에 부합하지만 포함하고 싶지 않은 파일들을 적고, include 역시 test의 조건에 부합하지 않은데 포함하고싶은 파일들을 적는다. exclude에 node_modules 폴더는 적어주는게 좋다.
    + `loader`: 어떤 loader를 활용할 것인지 적는다. test, exclude, include에 적용된 모든 파일이 loader에 의해 변환된다.
- 변환된 파일은 어디에 둘 것인가
    + `output` 속성을 추가한다. 역시 값은 object이고 내부에 `filename`, `path` 두 속성을 가진다.
    + filename은 최종 결과 파일의 이름이고, path는 파일이 위치할 경로다.

```js
// webpack.config.js
module.exports = {
  entry: __dirname + '/app/index.js',
  module: {
    loaders: [
      {
        test: /\.js$/, // .js로 끝나는 모든 파일
        exclude: /node_modules/,
        loader: 'babel-loader'
      }
    ]
  },
  output: {
    filename: 'transformed.js',
    path: __dirname + '/build'
  }
};
```

config 파일이 있는 경우 `webpack`이란 명령어로 빌드하면 된다. 그리고 `webpack-dev-server` 명령어를 통해 로컬 서버 실행할 수 있다. 변경 사항이 바로바로 적용되고 빌드되어서 결과를 브라우저에서(http://localhost:8080) 확인할 수 있다.

## 5. HTML plugin

기존에 작업할 때 메인이 되는 html 파일이 있었을 것이다. 거기엔 `<script src="./index.js"></script>`라는 코드가 있어서 우리가 결과를 보면서 작업했다. 하지만 새롭게 변환을 거쳐 만들어진 파일은 다른 경로에 다른 이름으로 있기 때문에 이 변환도 역시 이루어져야한다.

위에서 작업한 `webpack.config.js` 파일의 맨 위에 다음 코드를 추가한다.

- `var HTMLWebpackPlugin = require('html-webpack-plugin');` : constructor function을 리턴한다. 이 함수로 만들어진 instance를 통해 작업이 이뤄진다.
- `var HTMLWebpackPluginConfig = new HTMLWebpackPlugin({});` : 인스턴스 생성한다. 매개변수로 들어가는 object에 속성으로 설정 내용을 기록한다.
    + `template` : 원본 html 파일의 경로를 적는다.
    + `filename` : 새롭게 만들어진 파일명. exports할 때 적는 output 경로에 파일이 만들어진다.
    + `inject` : `head` or `body` 가 값이 된다. 새롭게 만들어질 html 파일의 script tag가 헤드에 위치할 것인지, 바디에 위치할 것인지를 정한다.
- module.exports에 마지막 속성으로 `plugins`를 추가한다. 배열의 원소로 만든 instance를 넣어주면 된다.

```js
// webpack.config.js
var HTMLWebpackPlugin = require('html-webpack-plugin');
var HTMLWebpackPluginConfig = new HTMLWebpackPlugin({
  template: __dirname + '/app/index.html',
  filename: 'index.html',
  inject: 'body'
});

module.exports = {
  entry: __dirname + '/app/index.js',
  module: {
    loaders: [
      {
        test: /\.js$/, // .js로 끝나는 모든 파일
        exclude: /node_modules/,
        loader: 'babel-loader'
      }
    ]
  },
  output: {
    filename: 'transformed.js',
    path: __dirname + '/build'
  },
  plugins: [HTMLWebpackPluginConfig]
};
```

## 6. NPM Scripts

npm에서 스크립트 명령어들을 조합해서 alias를 지정해놓는 것이다. `package.json` 파일 내부에 `scripts` 속성을 보면 된다. 이미 test라는 alias가 있을 것이고 그와 같은 형태로 추가해주면 된다.

`npm run [alias]` 형태로 스크립트를 실행할 수 있다.
