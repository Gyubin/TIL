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

    app.get('/', function(req, res){
      res.send('Hello home page');
    });

    app.listen(3000, function(){
      console.log('Connected to 3000 port.');
    });
    ```

## 3. 라우팅

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

## 4. 템플릿 엔진

### 4.1 정적 파일 서비스

- `app.use(express.static('public'));` : app.js 파일에 public이란 디렉토리를 만들고 앞의 코드를 입력한다. 해당 디렉토리에 정적 파일이 위치한 것으로 지정하겠다는 의미다. 주로 디렉토리명을 `public`으로 한다.
- 이후 public 디렉토리에 텍스트 파일이든 이미지파일이든 파일 자체는 `도메인/파일명`으로 브라우저에서 접근할 수 있게 된다.
- img 태그에서 소스로 접근할 때도 역시 다음처럼 루트에서 파일명으로 바로 접근하면 된다.

    ```js
    app.get('/ny', function(req, res){
      res.send('<h2>I Love NY!</h2> <img src="/ny.png"/>');
    });
    ```

### 4.2 템플릿 엔진 pug

2016년 초에 템플릿 엔진 이름이 jade에서 pug로 바뀌었다.

#### 4.2.1 사용법

- 내 프로젝트 디렉토리에서 명령어 실행: `npm install pug --save`
- app.js 파일에 다음 코드 추가
    + `app.set('view engine', 'pug');`
    + `app.set('views', './views');` -> 생략해도 기본값으로 지정되어있긴 하다.
- 프로젝트 디렉토리에 views 디렉토리 만들고 그 안에 pug 파일을 넣으면 된다.
- 템플릿 엔진을 이용할 땐 res.send가 아니라 render를 사용한다. 라우터는 다음처럼 쓴다. temp.pug 파일을 띄운다는 의미다.

    ```js
    app.get('/template', function(req, res){
      res.render('temp');
    });
    ```

- 참고로 `node app.js`로 하면 계속 껐다 켰다해야하기 때문에 귀찮다. `supervisor app.js`라고 실행하면 변경을 supervisor가 감지해서 알아서 껐다 켜준다. 나중에 상세하게 볼 것.

#### 4.2.2 pug 문법

- 브라우저에서 view-sorce 모드로 띄우면 쉽게 볼 수 있다. 하지만 그냥 띄우면 모든 공백이 사라져서 나올 것이기 때문에 만약 예쁘게 보고싶다면 `app.locals.pretty = true;` 코드를 app.js 파일에 추가해주면 된다.
- 들여쓰기를 이용해서 부모 자식 관계를 표현한다.
- 출력되면 안되는 for 문같은 것을 활용할 때는 앞에 `-`를 붙여준다.

    ```pug
    -for(var i = 0; i < 5; i++)
      li coding
    ```

- 변수를 활용할 땐 `=`를 활용한다 : `div= time` 형태에서 time이 변수다.
    + app.js에서 render 함수의 두 번째 매개변수로 object를 전달하면 된다. Object 안에 여러가지 값을 넣을 수 있다.
    + `res.render('tmp', {time:Date()});` 여기서 key인 time으로 사용 가능.

## 5. URL 구조

### 5.1 쿼리 스트링

- `프로토콜://도메인/패쓰?쿼리스트링` : ? 뒤에 위치하는 키밸류 쌍을 말한다.
- app.js에서 리퀘스트의 값을 불러오면 된다. `req.query.query_key` 형태다. 만약 쿼리 스트링의 키가 id라면 `req.query.id` 로 불러올 수 있다.

```js
// GET /search?q=tobi+ferret
req.query.q // => "tobi ferret"

// GET /shoes?order=desc&shoe[color]=blue&shoe[type]=converse
req.query.order // => "desc"
req.query.shoe.color // => "blue"
req.query.shoe.type // => "converse"
```

### 5.2 Semantic URL

- 현대적인 웹 애플리케이션들은 대부분 이 URL을 사용한다. 예를 들면 `hello.com/topic/1` 같은 형태다. 쿼리스트링이었다면 `hello.com/topic?id=1` 같은 형태였을 것.
- app.js에서 라우터에 `/:param` 형태로 추가해주고, 사용할 때는 `req.params.param` 로 불러오면 된다.
- 만약 params를 두 개 이상 동시에 사용하고싶다면 라우터를 그만큼 만들어주면 된다.

```js
app.get('/topic/:id', function(req, res) {
  res.send(req.params.id);
});

app.get('/topic/:id/:mode', function(req, res) {
  res.send(req.params.id + ', ' + req.params.mode);
});
```
