# Express.js 기초

Node.js의 웹 프레임워크다.

## 1. 설치

- 프로젝트 디렉토리에서 `npm init` 한다.
- `npm install express --save` 로 해당 프로젝트의 dependency로 express를 추가해준다.

## 2. 간단한 Webapp 만들어보기

- 프로젝트 디렉토리를 만들고 express를 설치한다.
- entry file이란 내 앱이 구동되기 위해 어떤 파일이 가장 먼저 실행되어야하느냐다. `app.js` 라는 이름이 자주 사용된다.
- app.js를 다음 처럼 입력한다.

    ```js
    const express = require('express');
    const app = express();

    // some code

    app.listen(3000, function(){
      console.log('Connected to 3000 port.');
    });
    ```

### 2.1 라우팅

- 사용자가 접근하는 URL마다 각각 다른 작업을 해주는 것을 의미
- 아래처럼 `get` 함수에 URL과 콜백함수를 지정해주면 된다.

```js
app.get('/', function(req, res){
  res.send('Hello home page');
});
app.get('login', function(req, res){
  res.send("Login please.");
})
```
