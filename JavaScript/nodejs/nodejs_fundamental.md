# Node.js 기초 정리

- 2008년 구글이 V8 엔진을 만들면서 자바스크립트가 웹의 굴레를 벗어던졌다. 그러면서 비동기, 이벤트 드리븐 방식으로 만들어진 프레임워크 혹은 런타임이 Node.js이다.
- 프로그래밍 언어를 "언어"와 "런타임"으로 구분한다면 언어는 JavaScript가 될 것이고 런타임이 Web browser, Node.js가 된다. 쉽게 비유하자면 한국어를 쓰는데 한국어를 병원에서 쓰거나 법원에서 쓰는 것과 같다. 목적과 용도가 다른 것. 예를 들어 `alert`라는 함수는 JavaScript의 문법에 속해있지만 Web browser에서만 사용가능하고 Node.js에서는 지원하지 않는다.
- 구글의 V8엔진을 이용하므로 속도가 매우 빠르다.

## 1. 설치와 간단히 띄워보기

### 1.1 설치

- 데비안 계열

    ```sh
    sudo apt-get update
    sudo apt-get install nodejs
    sudo apt-get install npm
    sudo ln -s /usr/bin/nodejs /usr/bin/node
    ```

- 레드햇 계열

    ```sh
    sudo yum install epel-release
    sudo yum install nodejs
    sudo yum install npm
    ```

- macOS
    + 공식 홈페이지에서 설치 패키지를 받어 설치하든지
    + `brew install node` 명령어로 homebrew를 이용해서 설치하면 된다.

설치가 되었다면 콘솔에 문자열을 찍는 js 파일을 만들어보고 `node file_name.js` 명령어로 실행해본다.

### 1.2 Hello world 찍어보기

아래 코드가 들어있는 js 파일을 만들고 node로 실행시켜본다.

```js
const http = require('http');

const hostname = '127.0.0.1';
const port = 1337;

http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello World\n');
}).listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
```

- `require`: node의 모듈을 가져와서 사용할 수 있도록 한다.
- `createServer` : `http.Server` 객체를 리턴한다. 매개변수는 콜백함수가 들어가는데 request, response 두 매개변수를 받아서 작업하는 함수다.
- `listen` : port, hostname을 받아서 정말 말 그대로 그 호스트와 포트를 리스닝하고 있게 하는 것.

## 2. NPM

### 2.1 기본

- https://www.npmjs.com
- npm은 homebrew로 node 설치하면 자동으로 설치된다.
- `npm install <module_name>` : 모듈 설치 명령어. 예를 들어 `npm install express`를 한다면 js 파일에서 `var express = require('express');`로 사용할 수 있다.
- 기본적으로 로컬 설치다. 즉 명령어를 실행한 경로에 모듈 파일들이 다운로드된다.
- 글로벌에 설치하려면 설치 명령어에 `-g` 옵션을 추가하면 되고, `/usr/lib/node_modules` 경로에 파일이 다운로드된다. 그 후 해당 프로젝트 디렉토리에서 `npm link <module_name>` 명령어를 실행해주면 사용할 수 있다.
- `npm uninstall <module>`, `npm update <module>` `npm search <module>: 삭제와 업데이트, 검색
- NPM과 package.json: 어떤 모듈이 설치되어있는지 기록되어있다. 쉽게 이동 가능

    ```js
    {
      "name": "myapp",
      "version": "0.0.0",
      "private": true,
      "scripts": {
        "start": "node ./bin/www"
      },
      "dependencies": {
        "body-parser": "~1.13.2",
        "cookie-parser": "~1.3.5",
        "debug": "~2.2.0",
        "express": "~4.13.1",
        "jade": "~1.11.0",
        "morgan": "~1.6.1",
        "serve-favicon": "~2.3.0"
      }
    }
    ```

- 내 파일을 패키지 형태로 만들고 싶다면 해당 디렉토리에서 `npm init` 하면 된다.
    + 이름, git 등을 설정하는데 test command는 테스트를 할 때 사용할 명령어라는 의미다.
    + 과정을 모두 끝내면 package.json이라는 파일이 만들어진다.
    + init을 한 후에야 내 패키지를 npm에 등록할 수 있고, 다른 사람이 만든 패키지를 다운로드받았을 때 패키지에 의존성으로 추가해줄 수 있다.
    + 의존성을 추가할 때는 npm install에서 `--save` 옵션을 꼭 넣어주어야 한다. 그래야 package.json에 의존성으로 기록이 된다.

### 2.2 유용한 모듈

- `uglify-js`
    + 자바스크립트 모듈을 받아보면 일반 파일이 있고, min 파일이 있을 것이다. 이 min 파일을 만들어주는 모듈이다.
    + `npm install uglify-js -g` : 글로벌로 설치한다.
    + `uglifyjs mine.js` : mine.js 파일에서 필요없는 공백들을 다 지워준다.
    + `uglifyjs mine.js -m` : mangle이라는 의미다. 바뀌어도 상관없는 지역변수명을 최대한 짧게 바꿔줘서 코드량을 줄여준다.
    + `uglifyjs mine.js -o mine.min.js -m` : -o 옵션을 활용해서 결과를 파일로 저장할 수 있다. 관습적으로 min을 붙여준다.
- `underscore.js` : http://underscorejs.org/
    + 설치: `npm install underscore`

## 3. 기본

- REPL: 터미널에서 `node`를 입력하면 진입할 수 있다.
    + `_` 는 가장 최근 결과값을 지칭한다. 변수처럼 사용 가능.
    + Ctrl+C 2번 누르고나 Ctrl+D로 빠져나올 수 있다.
    + `.help` : 모든 커맨드 목록을 확인
    + `.save filename` : 현재 Node REPL 세션을 파일로 저장
    + `.load filename` : Node REPL 세션을 파일에서 로드
- Node.js에선 callback function을 많이 쓴다. 다음 코드는 파일 관련 모듈을 활용한 예다.
    + 아래의 Program has ended 문장이 먼저 출력된다.

    ```js
    var fs = require("fs");
    fs.readFile('input.txt', function (err, data) {
      if (err) return console.error(err);
      console.log(data.toString());
    });
    console.log("Program has ended");
    ```

- `fs` 파일 관리 모듈
    + `fs.readdir(path, function)` : path의 모든 파일들의 이름을 얻어낼 수 있는 함수. function은 error와 file 배열을 매개변수로 받는다.
    + `fs.writeFile(file_name, data, function)` : file_name은 경로와 파일명까지 포함하는 값이고, data는 그 파일에 기록할 데이터, function은 error를 매개변수로 받아서 쓰기에 실패했을 때 실행된다.
    + `fs.readFile(file_name, encoding, function)` : 역시 file_name은 경로까지 포함하고, encoding은 utf-8로 맞춰주면 편하다. 콜백함수는 error, data를 매개변수로 받고 위 다른 함수와 방식이 같다.

    ```js
    fs.readdir('./data', (err, files) => {
      if (err) {
        console.log(err);
        res.status(500).send('Internal Server Error');
      }
      res.render('home', {topics:files});
    });

    fs.writeFile('./data/' + title, desc, (err) => {
      if (err){
        res.status(500).send('Internal Server Error');
      }
      res.redirect('/topic/' + title);
    });

    fs.readFile('./data/' + id, 'utf-8', (err, data) => {
      if (err) {
        console.log(err);
        res.status(500).send('Internal Server Error');
      }
      res.send(data);
    });
    ```

- `console.dir(object)` : object의 속성 전체 출력
- `time(id)`, `timeEnd(id)`: 실행시간 측정 시작과 끝을 측정하는 메소드
- `__filename`, `__dirname` : 실행한 파일의 path와 이름, 실행한 파일의 path를 나타내는 전역 변수
- `process.argv` : node가 파일을 실행하면서 받는 매개변수들이 array 형태로 담겨있다. C에서 argv 받는 것과 같다. 첫 번째 원소는 "node"이고 두 번째부터 매개변수가 담겨있다.
- `os` 모듈
    + `hostname()`: 호스트이름 리턴
    + `totalmem()`: 전체 메모리 용량
    + `freemem()`: 가용 메모리 용량
    + `cpus()`: CPU의 정보 리턴
    + `networkInterfaces()`: 네트워크 인터페이스 정보를 담은 배열 리턴
- `path` 모듈: 파일 다루는 모듈이다.
    + `join()`: 문자열들이 들어있는 배열을 받아서 지정해준 구분자로 합친다.
    + `dirname()`: 파일의 path 리턴
    + `basename()`: 파일명 리턴(확장자 제외)
    + `extname()`: 확장자명을 리턴
- Port에 대해서
    + 총 65536개의 포트가 있다.
    + 웹 서버를 80번 포트에 열어두고 listening하게 둔다.
    + 사용자가 `http://a.com:80` 이라고 웹브라우저 주소창에 치면 해당 포트에서 리스닝하고 있는 웹서버가 응답하는 것.
    + 80번 포트는 디폴트라서 안 치면 자동으로 80번으로 연결된다.
- Node.js의 함수들은 기본적으로 비동기 형태다. 함수명에 `Sync`가 붙어있으면 동기 방식. 필요하다면 쓰지만 웬만하면 쓰지 않는 것을 추천.
- 모듈을 불러오는 것은 `require`를 쓰면 되지만 내보낼 때는 `module.export`를 쓴다. 내가 만든 js 파일에서 내보낼 객체를 설정해주면 된다. 아래 코드에서 만약 require를 다른 파일에서 한다면 `console.log(require('./mine.js').furutirst)` 형태로 쓰는 것이 가능하다. 정확히 export 한 객체를 리턴한다.

    ```js
    var faveManifestos = {
      futurist: 'http://bit.ly/1lKuB2I',
      SCUM:     'http://bit.ly/1xWjvYc',
      cyborg:   'http://bit.ly/16sbeoI'
    };
    module.exports = faveManifestos;
    ```

## 4. URL 처리

### 4.1 url 모듈

- `var url = require('url');` : 모듈 불러오는 코드. URL을 쉽게 처리하는 모듈이다.
- `parse("URL")` : 주소 문자열을 파싱해서 URL 객체를 리턴
- `format(obj)` : URL 객체를 받아서 주소 문자열 만든다.
- 속성 종류. 주소가 `'https://m.search.naver.com/search.naver/query=steve+jobs'`일 때
    + `protocol` : 맨 처음 나오는 http, https, ftp 같은 것들. 콜론까지 리턴한다.
    + `slashes` : 프로토콜 뒤에 슬래쉬가 있는지 없는지 boolean으로 리턴
    + `auth` : 인증
    + `host` : 호스트는 도메인 앞에 붙는 www, dev 같은 것들을 말하는데 여기선 `m.search.naver.com` 전체를 리턴한다.
    + `port` : 포트
    + `hostname` : host와 같은것을 리턴.
    + `hash`
    + `search`
    + `query` : `?` 뒤의 쿼리 부분을 전체 리턴.
    + `pathname` : 도메인 뒤에 슬래시(`/`)와 함께 붙는 경로
    + `path` : pathname 뒤에 쿼리까지 전체 리턴
    + `href` : 전체

### 4.2 querystring 모듈

- `var querystring = require('querystring');` 쿼리를 처리할 수 있는 모듈이다.
- url 모듈에서 query만 뽑아낸 다음 그 쿠리 문자열을 `querystring.parse('..')` 메소드의 매개변수로 넣는다. 그러면 키 밸류 쌍을 모아서 object로 만들어 리턴한다.
- `querystring.stringify(param)` : 객체를 다시 쿼리 문자열로 변환
