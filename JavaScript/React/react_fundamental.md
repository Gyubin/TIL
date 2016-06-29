# React

[udemy 강의](https://www.udemy.com/react-redux/) 정리

- 강사 이메일: ste.grider@gmail.com
- 트위터: @sg_in_sf
- GitHub: [github.com/stephengrider](https://github.com/stephengrider)

## 0. 구동 방식

![js-tooling](http://i.imgur.com/lHNqzoZ.png)

- 우리가 만든 js 코드 파일과 라이브러리 파일들이 있을 것이고, 아마 이것은 ES6와 JSX로 되어있을 것이다.
- babel을 이용하여 js 코드를 ES5 코드로 바꾸고, webpack을 통해 하나의 application.js 파일을 만든다.
- 그래서 최종적으로 만들어진 파일만 실행하면 된다.

## 1. ReduxSimpleStarter

![Imgur](http://i.imgur.com/nUS8vwu.png)

- [ReduxSimpleStarter](https://github.com/StephenGrider/ReduxSimpleStarter)를 이용해 샘플 프로젝트를 만들 것임.
- README에 나온 것처럼 하면 되는데 `npm install`은 dependency를 설치하는 용도다.
- 터미널의 해당 디렉토리에서 `npm start` 명령어를 입력하면 8080 포트에서 해당 프로젝트가 실행된다.
- `bundle.js` 파일이 애플리케이션 src 폴더의 모든 js 파일들을 하나로 뭉친 파일이다.
- `app.js` 파일을 건드리면 메인 페이지가 수정된다.

## 2. About React

- HTML DOM을 만드는 js 라이브러리
- `JSX`: js 코드 안에 HTML DOM이 있다. 이런 문법을 JSX라고 하고 react에서 사용한다. 그리고 babel이 이를 해석해서 브라우저가 이해하고 같은 동작을 하는 일반적인 js 코드로 바꿔준다. [babeljs.io](http://babeljs.io/)에서 테스트해볼 수 있다.

    ```js
    ////////////////
    // 이 코드가
    const App = function() {
      return <ol>
        <li>1</li>
        <li>2</li>
        <li>3</li>
      </ol>;
    }

    ////////////////
    // 이렇게 바뀐다.
    "use strict";

    var App = function App() {
      return React.createElement(
        "ol",
        null,
        React.createElement(
          "li",
          null,
          "1"
        ),
        React.createElement(
          "li",
          null,
          "2"
        ),
        React.createElement(
          "li",
          null,
          "3"
        )
      );
    };
    ```

- 내가 만든 일반 js 코드 파일에서 다른 파일의 객체를 가져와서 사용하려면 `import`하면 된다. 자바스크립트에선 원래 이런 모듈 개념이 없었지만 npm과 webpack이 이를 가능하게 했다.
    + 폴더 트리에 보면 `node_modules`가 있다. `npm install` 명령어를 통해 설치한 dependency들이다.
    + `import React from 'react';`를 내가 만든 app.js에서 맨 위에 적어주면 된다. node_modules 폴더의 react 폴더에서 React를 가져오겠다는 의미다.
- `React`, `ReactDOM`의 차이
    + `React`는 component를 만들고 관리하는데 사용하고
    + `ReactDOM`은 실제 DOM과 인터랙션할 때 사용한다.
- render할 때는 `ReactDOM`을 이용한다.
    + `React`와 마찬가지로 `ReactDOM`을 import하고
    + 마지막 줄에 render할 때 사용한다.

    ```js
    import React from 'react';
    import ReactDOM from 'react-dom';

    // Create a new component.
    // This component should produce some HTML.
    const App = function() {
      return <ol>
        <li>AAA</li>
        <li>BBB</li>
        <li>CCC</li>
      </ol>;
    }

    // Take this component's generated HTML and put it ont the page in the DOM.
    ReactDOM.render(<App />);
    ```

- Component class: 바로 위 코드에서 `App`이다.
    + 위 코드처럼 함수를 만들면 이것은 component는 클래스 혹은 factory 등의 의미로 사용된다. React에서 하나의 component class로 여겨진다는 의미다.
    + 그래서 render할 때 App 자체를 넘기는게 아니라 instance를 만들어서 넘겨야한다.
    + `React.createElement` 함수가 그 역할을 하고 이 함수를 만드는 JSX 문법이 `<App />` 형태다. babeljs.io에서 테스트를 해보면 다음처럼 나온다. 그리고 `<App></App>` 할 필요 없이 `<App />`하면 편하다.

    ```js
    /////////////
    // 이렇게 쓰면
    const App = function() {
      return <ol>
        <li>AAA</li>
      </ol>;
    }

    <App />

    /////////////
    // 이렇게 바뀐다.
    "use strict";

    var App = function App() {
      return React.createElement(
        "ol",
        null,
        React.createElement(
          "li",
          null,
          "AAA"
        )
      );
    };

    React.createElement(App, null);
    ```



