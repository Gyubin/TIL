# Node.js 기초 정리

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
var http = require("http");

http.createServer(function(request, response){
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("Hello World\n");
}).listen(8081);
console.log("Server running at http://127.0.0.1:8081");
```

## 2. 기본

- REPL: 터미널에서 `node`를 입력하면 진입할 수 있다.
    + `_` 는 가장 최근 결과값을 지칭한다. 변수처럼 사용 가능.
    + Ctrl+C 2번 누르고나 Ctrl+D로 빠져나올 수 있다.
    + `.help` : 모든 커맨드 목록을 확인
    + `.save filename` : 현재 Node REPL 세션을 파일로 저장
    + `.load filename` : Node REPL 세션을 파일에서 로드
- NPM: homebrew로 node 설치하면 자동으로 설치된다.
    + `npm install <module_name>` : 모듈 설치 명령어. 예를 들어 `npm install express`를 한다면 js 파일에서 `var express = require('express');`로 사용할 수 있다.
    + 기본적으로 로컬 설치다. 즉 명령어를 실행한 경로에 모듈 파일들이 다운로드된다.
    + 글로벌에 설치하려면 설치 명령어에 `-g` 옵션을 추가하면 되고, `/usr/lib/node_modules` 경로에 파일이 다운로드된다. 그 후 해당 프로젝트 디렉토리에서 `npm link <module_name>` 명령어를 실행해주면 사용할 수 있다.
    + `npm uninstall <module>`, `npm update <module>` `npm search <module>: 삭제와 업데이트, 검색
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
