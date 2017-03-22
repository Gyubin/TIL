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
    + `meteor create --bare my-prj` : 빈 프로젝트 생성. 필요한거 하나하나 직접 추가. 이 옵션으로 했을 때 최소한 `npm install --save-dev babel-core` 또는 `meteor npm install --save babel-runtime`으로 바벨은 설치해줘야 로컬서버가 돌아간다.
    + `meteor create --full my-prj` : 웬만한거 다 갖춰진 보일러플레이트로 생성
- `meteor --help` : 자주 쓰게될 도움말.
- Meteor에 Deploy하기(하지만 유료다.)
    + `myapp.meteor.com`에 호스트할 수 있다.
    + `meteor deploy myapp.meteor.com` 명령어로 가능.

## 2. 빌드 규칙

- 미티어는 프로젝트의 파일들을 컴파일해서 실제 프로그램을 `.meteor` 디렉토리에 담는다. 이 폴더는 직접 수정하지 않는 것을 권장한다. 하지만 `.meteor/packages`와 `.meteor/release` 파일들은 괜찮다.
- 디렉토리 정보
    + `/client`, `/server` : 각각 클라이언트, 서버 관련 코드 위치한다. 해당 디렉토리들은 맞는 위치에서만 실행된다. 즉 클라이언트 폴더에 있는 파일들이 서버에서 실행되지는 않는다는 의미.
    + `/lib` : js 유틸, collection, 프론트와 백엔드 공통 메소드들 등이 위치한다. 프론트, 백 어디서든 실행할 수 있기 때문에 분기문을 써줘야 한다. `if(Meteor.isClient){ … }` 또는 `if(Meteor.isServer){ … }` 으로.
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

- `/client` 디렉토리에는 `main.html` 파일이 있을 것이다.
- 하위 디렉토리로 `client/templates`를 만들고 그 하위에 종류별로 디렉토리를 다시 생성해서 파일들을 관리한다.
- `template` 태그를 만들고 `name` 속성을 지정해준다. name 속성 명으로 `main.html` 파일에서 불러와 쓸 수 있다.
- `{{> templateName }}` 형태로 불러와 쓴다. 이를 Inclusions라고 한다.

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

참고: `main.html`에 `<!DOCTYPE html>`, `<html>` 태그 있으면 에러난다. 미티어가 알아서 정의해주므로 `head`, `body만` 있으면 됨

### 3.2 js 파일

- 역시 `/client` 디렉토리에 `myList.js` 파일을 만든다.
- `helpers`, `events`, `onCreated`, `onRendered`, `onDestroyed` 함수를 구현해서 사용한다.
- `Template`은 Blaze 프레임워크의 하위 object다.

```js
Template.myList.helpers({});
Template.myList.events({});
Template.myList.onCreated(function() {});
Template.myList.onRendered(function() {});
Template.myList.onDestroyed(function() {});
```

#### 3.2.1 helpers

- 템플릿에서 변수활용할 때 사용한다.
- 메소드에 object를 매개변수로 넣고 property의 key를 변수명으로 활용한다. value는 해당 값을 리턴하는 function으로 할당한다.
- `{{ propertyName }}` 처럼 활용. 이를 Expressions 라고 한다.
- 반복을 돌릴 때는 `{{#each iterable}} ... {{/each}}` 로 열고 닫고 내부에 코드를 작성한다. 배열의 원소가 object이고 key로 접근할 수 있다. 이를 block helpers 라고 한다.

```js
// myList.js
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

#### 3.2.2 events

- `Template.myListItem.events({})` 매개변수로 들어가는 object에 설정한다.
    + key: 문자열로 "이벤트 셀렉터" 형태로 한 칸 공백으로 구분해서 적는다.
    + value: 콜백 함수. 이벤트와 해당 템플릿을 매개변수로 받을 수 있다. 이벤트 매개변수는 JQuery `$(evt.target)` 코드로 실제 object를 제어할 수 있고, 템플릿 매개변수는 `tmpl.find("selector code")` 코드로 다른 html object를 찾아낼 수 있다.
- 위 helpers 예제에서 list item을 따로 빼서 파일을 만든다.
- `{{#each list}` 블록에서 자동으로 `myListItem`의 컨텍스트로 객체가 주입된다. 전달을 신경쓰지 않아도 된다.

```html
<!-- myList.html -->
<template name="myList">
  <p>{{ listName }}</p>
  <table>
    {{#each list}} 
      {{> myListItem }}
    {{/each}} 
  </table>
</template>
```

```html
<!-- myListItem.html -->
<template name="myListItem">
  <tr>
    <td>{{ no }}</td>
    <td>{{ name }}</td>
    <td>{{ email }}</td>
    <td><button name="remove">삭제</button></td>
  </tr>
</template>
```

```js
// myListItem.js
Template.myListItem.events({
  "click button[name=remove]": function(evt, tmpl){
    console.log(this);
  }
});
```

#### 3.3.3 onSomething

```js
Template.myList.onCreated(function() {});
Template.myList.onRendered(function() {});
Template.myList.onDestroyed(function() {});
```

- `onCreated` : Template.instance가 만들어질 때 최초로 한 번 호출된다. 즉 여기서 추가된 callback 함수들은 template의 로직이 적용되기 전, 그리고 렌더링되기 전에 호출되므로 `Template.instance()`에 데이터를 추가하기 좋다. 이후에 다른 helper에서 추가된 데이터를 활용할 수 있다. 페이지를 새로고침하면 새로 호출된다.
- `onRendered` : 내부의 callback 함수들은 Template의 instance가 DOM에 render된 직후에 최초로 한 번 호출된다. 같은 페이지가 다시 DOM에 렌더링되어도 호출되지 않는다. 페이지 새로고침하면 새로 호출된다. 렌더링된 후에 호출되는 것이므로 `this.finidAll`같은 것으로 DOM nodes를 조작할 수 있다.

#### 3.3.4 템플릿 간 데이터 전달

- `{{> childTemplate money=100}}` : 부모 템플릿(or Caller 템플릿)에서 자식 템플릿으로 데이터를 전달할 수 있다.
- `Template.currentData()` : 자식 템플릿의 js 파일에서 전달받은 데이터가 Object의 key-value 쌍으로 currentData에 들어있게 된다.

## 4. Collection

MongoDB를 다루기 위해 필요하다. `/lib/collections.js` 파일을 만든다.

### 4.1 Insert

```js
// /lib/collections.js
Units = new Mongo.Collection("units");
if (Meteor.isServer) {
  Meteor.startup(function(){
    if( Units.find().count() == 0 ) {
      Units.insert({no: 1, name: "Golem", prop: "Super tank"});
      Units.insert({no: 2, name: "Mega Minion", prop: "Dealer"});
      Units.insert({no: 3, name: "Archer", prop: "Dealing small unit"});
      Units.insert({no: 4, name: "Lightning", prop: "Magic spell"});
    }
  });
}
```

- collection을 만드는 코드부터 시작. 테이블과 비슷한 개념일 것 같다.
- `meteor mongo` 명령어를 이용하면 콘솔에서 DB 작업을 할 수 있다. 예를 들어 `db.units.find()` 같은 명령어 사용 가능.
- db에는 우리가 insert하지 않은 `_id` key가 있을텐데 이것은 unique identifier이다.
- 서버에서만 동작하도록 `Meteor.isServer` 조건 구문 안에서작업한다. 즉 그 밖에 있는 Collectioin 생성 첫 코드는 클라이언트에서도 실행된다. 클라이언트에서 실행될 땐 미니몽고에서 매칭되는 콜렉션을 만든다고 볼 수 있다.
- `Meteor.startup(function(){})` : 미티어가 구동할 때, 시작할 때 처음 한 번만 작동한다.
- `meteor reset` : 데이터베이스 초기화. 개발 때 유용.

### 4.2 Find

```js
Template.myList.helpers({
  listName: function() {
    return "To-do List";
  },
  list: function() {
    return Units.find({} , { sort : {no:-1} });
  }
});

```

- helpers의 list 부분을 바꿔보자. 원래는 MongoDB에서 불러오는게 아니라 코드에서 배열을 선언했었다. 함수가 DB의 값을 리턴하도록 바꿔본다.
- `no` 속성을 기준으로 역순 정렬하는 코드다.

### 4.3 Remove

```js
Template.myListItem.events({
  "click button[name=remove]" : function(evt , tmpl){
    console.log(this);
    Units.remove({_id:this._id});
  }
});
```

- unique id 값 기준으로 DB에서 삭제하는 코드

## 5. Publish, Subscribe

![db](http://s3.amazonaws.com/info-mongodb-com/_com_assets/blog/meteor/image05.png)
![Imgur](http://i.imgur.com/fdvzffv.jpg)

- 미티어는 서버측 데이터베이스 MongoDB를 주 데이터베이스로 쓰지만 클라이언트측에도 Mini Mongo라는 데이터베이스가 존재한다.
- 메테오를 통해 서버측 데이터의 "일부분"을 받아와서 미니몽고에 싱크해두고, 그 데이터를 질의해서 사용하는 개념이다.

### 5.1 autopublish 패키지 삭제

```sh
meteor remove autopulish
```

- 지금까지는 디폴트 깔려있는 `autopublish`라는 패키지를 통해 DB 전체를 싱크해두고 사용해왔다. 이건 전체 DB를 가져오는거라서 실제 서비스에서는 사용하면 안되고 개발용으로만 쓴다.
-   프로젝트 디렉토리에서 해당 패키지를 삭제하면 아무것도 기존 투두 리스트에서 아무것도 보이지 않을 것이다. 미니몽고에 싱크해놓은 데이터가 없기 때문에 그렇다.

### 5.2 publish, subscribe

- publish는 미니몽고에서 데이터를 받아오고 반환해서 사용하게 하는 함수, subscribe는 서버로부터 미니몽고로 데이터를 받아오는 함수다.
- `server/publish.js` 파일을 만든다.
    + 아래 condition1은 이 조건에 맞는 데이터만 불러오라는 필터이고
    + condition2는 condition1으로 걸러낸 데이터 중 date 속성은 빼고 받아온다.

    ```js
    // publish.js
    Meteor.publish("myList",function(obj){
      var condition1 = obj || {};
      if (!condition) {
        condition = {'author':'Tom'};
      }
      var condition2 = {fields: {
        date: false
      }};
      return Units.find(condition1, condition2);
    });
    ```

- `client/myList.js` 파일에 다음 코드 추가한다. onCreated 함수는 템플릿 인스턴스가 생성되는 시점에 한 번 호출된다. 템플릿이 사라질 때까지 변경사항을 계속 주고받는다.
    + `subscribe` 메소드의 두 번째 매개변수를 활용해 변수를 전달할 수 있다. 이 때 전달되는 객체는 `publish` 메소드의 콜백함수의 매개변수로 들어가며 쿼리의 조건으로 활용할 수 있다.

    ```js
    Template.myList.onCreated(function () {
      this.subscribe("myList", {});
    });
    ```

- `Meteor.subscribe` 함수와 템플릿 내부의 `this.subscribe`는 동일하다. 하지만 전자는 `onCreated`에서 호출했으면 `onDestroyed`에서 `stop` 메소드로 중지해줘야한다. 하지만 템플릿 내부의 것을 사용하면 중지할 필요 없다.

## 6. Mobile

가장 먼저 [링크](https://guide.meteor.com/mobile.html#installing-prerequisites)에서 미리 설치해야할 것들을 먼저 설치한다.

### 6.1 iOS

아래 코드 순서대로 실행하면 된다. 맥에 Xcode 미리 설치되어있어야 함

```sh
meteor install-sdk ios
meteor add-platform ios
meteor run ios
```

아이폰에서 돌려보려면 애플 개발자 계정이 있어야하고 `meteor run ios-device` 명령어를 실행한다.

### 6.2 Android

역시 아래 코드 실행하면 된다.

```sh
# Android
meteor install-sdk android
meteor add-platform android
meteor run android
```

실제 폰에서 실행해보려면 개발자 세팅에서 USB 디버깅모드를 설정해두고 컴퓨터와 연결한 다음, `meteor run android-device` 명령어를 실행한다. 

## 7. Test

- Mocha 설치: `meteor add practicalmeteor:mocha`
- 설치 후 테스트 모드로 서버를 구동할 수 있다. `meteor test --driver-package practicalmeteor:mocha`
- Mocha에선 arrow functions 사용이 권장되지 않는다.(그런데 아래 샘플 코드에선 썼다)
- `imports/api/tasks.tests.js` 파일을 만들고 task에 대해서 테스트한다.

```js
/* eslint-env mocha */

import { Meteor } from 'meteor/meteor';
import { Random } from 'meteor/random';
import { assert } from 'meteor/practicalmeteor:chai';

import { Tasks } from './tasks.js';

if (Meteor.isServer) {
  describe('Tasks', () => {
    describe('methods', () => {
      const userId = Random.id();
      let taskId;

      beforeEach(() => {
        Tasks.remove({});
        taskId = Tasks.insert({
          text: 'test task',
          createdAt: new Date(),
          owner: userId,
          username: 'tmeasday',
        });
      });

      it('can delete owned task', () => {
        const deleteTask = Meteor.server.method_handlers['tasks.remove'];
        const invocation = { userId };
        deleteTask.apply(invocation, [taskId]);
        assert.equal(Tasks.find().count(), 0); // 원하는대로 동작했는지 검사
      });
    });
  });
}
```

## 8. Session

- 현재 사용자에게만 적용되는 일시적인 상태 정보(UI 상태같은)를 저장하기에 편리하다.
- Global singleton object: 하나만 존재하고 어디서든 접근 가능
- 같은 이용자라도 브라우저의 탭 간에서 공유되진 않는다.

```js
Session.set('pageTitle', 'A different title');
Session.get('pageTitle');
```

## 9. 라우팅

- 용어
    + Routes: URL에 따라 무엇을 할지 정하는 정의들의 집합
    + Paths: 경로(동적, 정적 모두)와 쿼리를 모두 포함
    + Segments: `'/'`로 구분되는 path의 일부
    + Hooks: 라우팅 전, 후, 중간에서 실행될 수 있는 것들. 사용자가 페이지를 열기 전 권한이 있는지 확인 가능
    + Filters: Routes에서 정의하는 전역 hook이다.
    + Route Templates: Routes와 매핑되는 템플릿
    + Layouts: 템플릿을 감싸는 모든 HTML 코드. 레이아웃 html 파일 안에 템플릿들이 포함된다. 템플릿이 바뀌어도 변경되지 않는다.
    + Controllers: 로직이 담긴 파일
- `meteor add iron:router` : 패키지 설치
- `/lib/router.js` 파일을 만든다.

    ```js
    // layout.html을 레이아웃으로 사용하겠다고 설정
    Router.configure({
      layoutTemplate: 'layout'
    });

    // 루트(/) 패스로 들어왔을 때 postsLsit와 매핑
    Router.map(function() {
      this.route('postsList', {path: '/'});
    });
    ```
