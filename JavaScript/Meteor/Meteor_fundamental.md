# Meteor.js

프론트, 백, 데이터베이스 모두를 다룰 수 있는 풀스택 플랫폼.

## 0. 기본

- 프레임워크라기보단 프론트부터 백엔드까지 여러 라이브러리들을 포괄하는 플랫폼이다. [ATMOSPHERE](https://atmospherejs.com/)에서 골라 쓸 수 있다.
- MongoDB 내장
- publish/subscribe 구조로 브라우저, 서버 데이터 교환 일어남
- [CORDOVA](http://cordova.apache.org/)를 이용해서 기존 웹앱을 하이브리드 형태로 바꿀 수 있음

## 1. 설치

- Meteor.js 설치

    ```sh
    curl https://install.meteor.com/ | sh
    ```

- 프로젝트 생성

    ```sh
    meteor create test # test란 이름으로 프로젝트 생성
    cd test # 해당 프로젝트 디렉토리로 들어가서
    meteor npm install # 의존성 라이브러리 설치하고
    meteor # 개발용 로컬 서버 3000 port. meteor run 명령이 디폴트로 실행
    ```

- 프로젝트 생성 방식 종류. `.meteor` 숨김 폴더에 들어가있는 파일들이 매우 다르다.
    + `meteor create my-prj` : 기본 형태
    + `meteor create --bare my-prj` : 빈 프로젝트 생성. 필요한거 하나하나 직접 추가.
    + `meteor create --full my-prj` : 웬만한거 다 갖춰진 보일러플레이트로 생성
- `meteor --help` : 자주 쓰게될 도움말.

## 2. 빌드 규칙

- 미티어는 프로젝트의 파일들을 컴파일해서 실제 프로그램을 `.meteor` 디렉토리에 담는다. 이 폴더를 직접 만질 일은 거의 없다.
- 디렉토리 정보
    + `/lib` : js 유틸, collection, 프론트와 백엔드 공통 메소드들 등이 위치한다. `if(Meteor.isClient){ … }` 구문으로 시작하면 클라이언트, `if(Meteor.isServer){ … }` 구문으로 시작하면 서버 관련 코드들이다.
    + `/client` : 프론트엔드 관련 코드 위치.
    + `/server` : 서버 관련 코드 위치
    + `/private` : 서버에서만 접근할 수 있는 리소스
    + `/public` : 웹서버로서 정적 리소스를 서비스하는 폴더. favicon.ico나 robots.txt 파일을 위치시키면 좋음.
- 로딩 순서
    + lib 폴더 가장 먼저 로딩
    + 하위디렉토리부터 위로 올라오며 로딩. 즉 루트 디렉토리는 가장 마지막
    + 같은 레벨에선 알파벳 순으로 로딩
    + `main.*` 파일은 가장 마지막에 로딩
- 폴더 구조
    + 업무별로 나눠서 협업할 때: 주요 업무별 혹은 DB에서 테이블 기준(?)으로 나눠서 하위에 `lib`, `client`, `server` 디렉토리를 둔다.
    + 서버/클라이언트로 구분해서 소스 관리하고싶을 때: `client`, `server` 디렉토리를 두고 하위에 업무별 디렉토리를 둔다.

    ```sh
    # 협업 유용
    /customer/lib
    /customer/client
    /customer/server
    /posts/lib
    /posts/client
    /posts/server

    # 소스 관리 유용
    /lib/customer
    /lib/posts
    /client/customer
    /client/posts
    /server/customer
    /server/posts
    ```
    
## 3. Template - `Blaze`

### 3.1 html 파일

- `/client` 디렉토리에 `main.html`과 `myList.html` 파일을 만든다.
- `template` 태그를 만들고 `name` 속성을 지정해준다. name 속성 명으로 `main.html` 파일에서 불러와 쓸 수 있다.
- `{{> templateName }}` 형태로 불러와 쓴다.

```html
<!-- myList.html -->
<template name="myList">
  <p>Hello World!</p>
</template>
```

```html
<!-- main.html -->
<!DOCTYPE html>
<html>
<head>
  <title>main</title>
</head>
<body>
  {{>myList}}
</body>
</html>
```

### 3.2 js 파일

- 역시 `/client` 디렉토리에 `myList.js` 파일을 만든다.
- `helpers`, `events`, `onCreated`, `onRendered`, `onDestroyed` 함수를 구현해서 사용한다.

```js
Template.myList.helpers({
});

Template.myList.events({
});

Template.myList.onCreated(function() {
});

Template.myList.onRendered(function() {
});

Template.myList.onDestroyed(function() {
});
```

#### 3.2.1 helpers

- 템플릿에서 변수활용할 때 사용한다.
- 메소드에 object를 매개변수로 넣고 property의 key를 변수명으로 활용한다. value는 해당 값을 리턴하는 function으로 할당한다.
- `{{ propertyName }}` 처럼 활용.
- 반복을 돌릴 때는 `{{#each iterable}} ... {{/each}}` 로 열고 닫고 내부에 코드를 작성한다. 배열의 원소가 object이고 key로 접근할 수 있다.

```js
Template.myList.helpers({
  listName: function() {
    return "To-do List";
  },
  list: function() {
    var arr = [
      {no:4, name:"박승현", email:"ppillip@gmail.com"},
      {no:3, name:"전지현", email:"jjh@gmail.com"},
      {no:1, name:"김완선", email:"kws@gmail.com"},
      {no:2, name:"카라", email:"kara@gmail.com"}
    ];
    arr = _.sortBy(arr, function(obj) { return obj.no; });
    return arr;
  }
});
```

```html
<!-- myList.html -->
<template name="myList">
  <p>{{ listName }}</p>
  <table>
    {{#each list}} 
      <tr>
        <td>{{ no }}</td>
        <td>{{ name }}</td>
        <td>{{ email }}</td>
        <td><button name="remove">삭제</button></td>
      </tr>
    {{/each}} 
  </table>
</template>
```
