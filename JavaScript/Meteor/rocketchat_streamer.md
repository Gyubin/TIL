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

- 먼저 Streamer 객체를 만든다. 매개변수로 들어가는 문자열은 여러 Streamer가 있을 때 각각을 구분하기 위해 지정되고 unique하게 설정하면 된다.
- `emit` : 데이터를 보낼 때 사용한다.
- `on` : `emit`으로 보낸 데이터를 받을 때 사용
