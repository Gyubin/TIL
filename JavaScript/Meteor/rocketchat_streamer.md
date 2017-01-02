# RocketChat Streamer

참고링크: [github readme](https://github.com/RocketChat/meteor-streamer/blob/master/packages%2Frocketchat-streamer%2FREADME.md)

서버와 클라이언트 간 통신을 위한 패키지다. subscription으로 클라이언트에 데이터를 보내는 것이 어려울 때가 있다. 이벤트 다루듯 할 수 있게 쉽게 만든 패키지다. server to client, client to server 어느 방향으로도 가능하다.

## 0. 설치

```sh
meteor add rocketchat:streamer
```

프로젝트 디렉토리에서 위 명령어로 추가

## 1. 사용

```js
const streamer = new Meteor.Streamer('chat');

if(Meteor.isClient) {
  sendMessage = function(message) {
    streamer.emit('message', message);
    console.log('me: ' + message);
  };

  streamer.on('message', function(message) {
    console.log('user: ' + message);
  });
}

if (Meteor.isServer) {
  streamer.allowRead('all');
  streamer.allowWrite('all');
}
```

- 위 예는 한 클라이언트에서 메시지를 보내면(`emit`) -> 서버를 거쳐서 -> 모든 다른 클라이언트들에게 retransmit 되는(`on`) 예제다.
- 먼저 Streamer 객체를 만든다. 매개변수로 들어가는 문자열은 여러 Streamer가 있을 때 각각을 구분하기 위해 지정되고 unique하게 설정하면 된다.
- `emit` : 데이터를 보낼 때 사용. 클라이언트에서 보내면 서버가 받고, 서버가 보내면 모든 클라이언트가 받는다. 만약 서버에서 재송신 설정이 되어있다면 클라이언트에서 보냈을 때 모든 다른 클라이언트에게 이벤트를 보낼 수 있다. 이 설정은 아래에서 다시 설명.
    + 첫 번째 매개변수는 해당 이벤트의 이름이고 streamer의 name과는 다르다.
    + 두 번째 매개변수는 보낼 데이터
- `on` : `emit`으로 보낸 데이터를 받을 때 사용
    + 첫 번째 매개변수는 이벤트명. 같은 이벤트라면 `emit`에서와 같은 이름을 지정해야한다.
    + 두 번째 매개변수는 콜백 함수. 받는 데이터를 매개변수로 받는다.
- `streamer.allowRead([eventName], permission);` : 서버에서만 쓰이고, 클라이언트 당 한 번만 설정되는데 데이터에 따라서 permission을 다르게 조절할 수 없다.
    + 이벤트명은 옵션. 써주면 특정하는거고, 안 쓰면 모든 이벤트다.
    + permission은 함수나 문자열을 넣는다. 함수는 event명을 매개변수로 받고 boolean을 리턴한다. 문자열은 `all`, `logged`, `none` 세 가지가 있는데 순서대로 모두 허용, 로그인한 유저에게만 허용, 허용하지 않음의 의미.
- `streamer.allowEmit([eventName], permission);`: 서버에서만 쓰인다. `allowRead`와 다르게 매 번 permission을 설정하기 때문에 데이터에 따라서 다르게 적용이 가능하다. 대신 연산량이 많다. 상세 정보는 allowRead와 같음.
- `streamer.allowWrite([eventName], permission);`: 서버에서만 쓰이고 이벤트를 쓸 수 있는지의 권한이다. 즉 이벤트를 만들 수 있는지, 보낼 수 있는지에 대한 권한.
