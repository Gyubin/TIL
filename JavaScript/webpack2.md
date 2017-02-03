# Webpack 2

버전 2는 달라진게 많다고 들어서 따로 정리한다. 참고한 블로그: [madewithenvy](https://blog.madewithenvy.com/getting-started-with-webpack-2-ed2b86c68783#.6jjoobds3)

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

## 3. 여러 파일 다루기

- input: `entry`의 `app`의 값으로 여러 파일들을 array에 담는다.

    ```js
    entry: {
      app: ['./home.js', './events.js', './vendor.js'],
    }
    ```

- output: entry에 서로 다른 속성으로 담으면 각 속성별로 아웃풋이 나온다. `filename`의 값에서 `[name]` 부분이 entry의 키값으로 대체되어 나온다.

    ```js
    const path = require('path');
    const webpack = require('webpack');
    module.exports = {
      context: path.resolve(__dirname, './src'),
      entry: {
        home: './home.js',
        events: './events.js',
        contact: './contact.js',
      },
      output: {
        path: path.resolve(__dirname, './dist'),
        filename: '[name].bundle.js',
      },
    };
    ```

## 4. vendor 파일 따로 번들하기

- automatic: `CommonsChunkPlugin`이라는 빌트인 플러그인이 존재한다. `minChunks`에 세팅된 '초' 이상의 시간이 걸리면 이 플러그인이 자동으로 최종 번들될 파일을 분리해준다. 분리된 파일 중 일부를 캐시로 두면 성능 향상에 도움된다.

    ```js
    module.exports = {
      plugins: [
        new webpack.optimize.CommonsChunkPlugin({
          name: 'commons',
          filename: 'commons.js',
          minChunks: 2,
        }),
      ],
    };
    ```

- manual: 수동으로 하고싶다면 위 **3**에서 했던 것처럼 entry에 `vender` 항목을 따로 만들고 예를 들어 react나 react-native 등의 vendor js 파일을 따로 묶고, 그 파일들을 캐시로 쓰면 된다. 이 쪽이 더 유용해보인다.

## 5. dev server

```js
devServer: {
  contentBase: path.resolve(__dirname, './src'),  // New
}
```

- exports하는 객체에 `devServer` 속성을 추가한다.
- `./src` 폴더에 `index.html` 파일을 두고, 최종 아웃풋 파일을 `<script>` 태그로 불러오게 한다.
- `webpack-dev-server` 터미널에서 실행하면 끝. js 파일이 변할 때마다 hotload 된다. 하지만 config 파일을 수정했을 땐 종료하고 재실행해야함.

## 6. Global scope 사용하기

```js
module.exports = {
  output: {
    library: 'myClassName',
  }
};
```

- 위 형태처럼 `library`에 인스턴스명을 적어주면 된다.
- 참고링크: [공식문서](https://webpack.js.org/concepts/output/#output-library)

## 7. Loader

babel, sass 등을 사용할 때 loader 형태로 사용한다.

### 7.1 Babel

- 로더 설치: `yarn add --dev babel-loader babel-core babel-preset-es2015`
- config 파일
    + `test`: RegEx 문법으로 적어주면 해당되는 파일이 바벨을 통해 로드된다.
    + `include`, `exclude`: `test`에 의해 포함되는 파일에서 예외를 처리할 수 있다. 포함되지 않는데 포함해야하거나, 포함되는데 빼야하는 파일들 설정.

    ```js
    module.exports = {
      module: {
        rules: [
          {
            test: /\.js$/,
            use: [{
              loader: 'babel-loader',
              options: { presets: ['es2015'] }
              exclude: [/node_modules/],
            }],
          },
          // Loaders for other file types can go here
        ],
      },
    };
    ```

### 7.2 CSS

- js파일에서 `import styles from './assets/stylesheets/application.css'` 이 있다고 가정
- 로더 설치: `yarn add --dev css-loader style-loader`
- `use`: 로더를 여러개 특정지을 때. 역순으로 호출된다. 아래 예제에선 css-loader가 먼저 로드됨.

    ```js
    module.exports = {
      module: {
        rules: [
          { babel rules },
          {
            test: /\.css$/,
            use: ['style-loader', 'css-loader'],
          },
        ],
      },
    };
    ```

- 파일이 번들되면서 `style-loader`가 html의 head에다가 해당 내용을 쓴다. header request를 하지 않기 때문에 속도도 빠르고, js 파일과 markup 파일이 매칭되기 때문에 component-oriented, 즉 모듈화를 해서 사용할 수 있다. 또 중복도 줄인다.

### 7.3 CSS Node modules

- npm이나 yarn으로 라이브러리를 받았다고 할 때: `yarn add normalize.css`
- `@import "~normalize.css";` 이런 형태로 가져다 쓸 수 있다.
