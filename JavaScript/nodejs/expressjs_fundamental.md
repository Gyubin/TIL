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

### 2.2 정적 파일 서비스

- `app.use(express.static('public'));` : app.js 파일에 public이란 디렉토리를 만들고 앞의 코드를 입력한다. 해당 디렉토리에 정적 파일이 위치한 것으로 지정하겠다는 의미다. 주로 디렉토리명을 `public`으로 한다.
- 이후 public 디렉토리에 텍스트 파일이든 이미지파일이든 파일 자체는 `도메인/파일명`으로 브라우저에서 접근할 수 있게 된다.
- img 태그에서 소스로 접근할 때도 역시 다음처럼 루트에서 파일명으로 바로 접근하면 된다.

    ```js
    app.get('/ny', function(req, res){
      res.send('<h2>I Love NY!</h2> <img src="/ny.png"/>');
    });
    ```
