# WebRTC - Web Real Time Communication

## 0. 정의

- 어떤 플랫폼에서든 플러그인 없이 실시간 통신을 할 수 있는 기술. 특히 웹에서 영상, 음성 통화를 할 수 있는 것이 대표적이다.

## 1. 개념

### 1.1 Signaling

- 통신 조정하는 과정을 말한다.
- call 연결을 위해 Signaling은 3가지 정보를 교환한다.
    + Session control messages: 통신의 초기화, 종료 그리고 에러 리포트
    + Network configuration: 내 컴퓨터의 IP 주소와 Port 정보, 보안 연결을 수립하기 위해 사용되는 키 데이터 등
    + Media capabilities: 내 브라우저와 상대브라우저가 사용 가능한 코덱들과 해상도들은 어떻게 되는지에 대해. 예로 코덱이나 코덱 설정, 대역폭, 미디어 타입 같은 미디어 메타데이터 등.

### 2.2 STUN, TURN 서버

참고링크: [nexpert blog](http://www.nexpert.net/424), [html5rocks infra](https://www.html5rocks.com/ko/tutorials/webrtc/infrastructure/)

- P2P 통신인데 서버가 필요한 이유
    + 사용자 탐색과 통신
    + Signaling
    + NAT/firewall 탐색
    + P2P 실패시의 중계서버들
- [ICE](https://en.wikipedia.org/wiki/Interactive_Connectivity_Establishment)(Interactive Connectivity Establishment) 프레임워크의 동작 순서
    + ICE는 먼저 디바이스의 OS와 Network 카드를 통해 알아낸 호스트 주소로 연결을 시도한다. 하지만 대개 NAT로 막혀있을 것이다.
    + 실패하면 STUN 서버를 이용해서 다시 시도하고([통계](http://webrtcstats.com/)에 따르면 86퍼센트 성공) 그래도 안되면 TURN 중계 서버를 통해 실행한다.
    + - `finding candidates`란 표현은 네트워크 장치와 포트들을 찾는 과정을 의미
- [STUN](https://en.wikipedia.org/wiki/STUN)(Session Traversal Utilities for NAT) 서버는 NAT 뒤에 있는 피어들의 public IP와 port를 찾는 역할을 한다. NAT는 일종의 공유기 개념으로 한정된 IP주소를 효율적으로 사용하기 위해 public IP 주소에 사설 IP 주소를 여럿 할당하고 인터넷에 접속할 수 있도록 하는 프로그램이다. public IP만 인터넷 접속이 가능하기 때문에 이런 방식을 취한다. 구글의 STUN 서버를 사용하면 된다.
    + STUN server에서 프로토콜 시도 과정은 처음엔 UDP를 통해 연결을 시도하고, 실패하면 HTTP TCP를, 또 실패하면 HTTPS TCP를 활용한다.
- 만약 STUN을 활용한 위 시도가 모두 실패하면 중계를 위해 [TURN](https://en.wikipedia.org/wiki/Traversal_Using_Relays_around_NAT)(Traversal Using Relay around NAT) 서버를 사용한다. 스트리밍 릴레이를 하므로 가장 좋은 성능을 필요로한다.

## 2. MediaStream APIs

- 속성
    + `MediaStream.active` (read only) − 활성화 상태인지 아닌지 true, false 리턴
    + `MediaStream.id` (read only) − 유니크 id
- 이벤트 핸들러
    + `MediaStream.onactive` − 활성화 상태 될 때
    + `MediaStream.onaddtrack` − 새로운 MediaStreamStrack 객체가 추가될 때
    + `MediaStream.oninactive` − 비활성화될 때
    + `MediaStream.onremovetrack` − MediaStreamTrack 객체가 삭제될 때
- 메소드
    + `MediaStream.addTrack()` − 매개변수로 들어가는 MediaStreamTrack 객체를 추가한다. 이미 추가돼있으면 아무 일도 일어나지 않음.
    + `MediaStream.clone()` − 새로운 유니크 id 값으로 MediaStream 객체를 복사
    + `MediaStream.getAudioTracks()` − 미디어스트림에서 오디오 트랙만 가져옴
    + `MediaStream.getTrackById()` − 매개변수 안 넣거나, id에 매칭되는 객체가 없으면 null 리턴. 같은 아이디로 매칭되는 객체가 여러개라면 첫 번째꺼 리턴.
    + `MediaStream.getTracks()` − 모든 미디어스트림트랙을 리스트로 리턴
    + `MediaStream.getVideoTracks()` − 비디오 미디어스트림 트랙 리턴
    + `MediaStream.removeTrack()` − 매개변수로 주어지는 미디어스트림트랙 객체를 미디어스트림에서 제거. 이미 제거되어있으면 아무 일도 일어나지 않는다.

- 내장 카메라 사용해보기

```html
<!-- index.html -->
<!DOCTYPE html>
<html lang = "en">
  <head>
    <meta charset = "utf-8" />
  </head>
  <body>
    <video autoplay></video>
    <div>
      <button id = "btnGetAudioTracks">getAudioTracks()</button>
    </div>
    <div>
      <button id = "btnGetTrackById">getTrackById()</button>
    </div>
    <div>
      <button id = "btnGetTracks">getTracks()</button>
    </div>
    <div>
      <button id = "btnGetVideoTracks">getVideoTracks()</button>
    </div>
    <div>
      <button id = "btnRemoveAudioTrack">removeTrack() - audio</button>
    </div>
    <div>
      <button id = "btnRemoveVideoTrack">removeTrack() - video</button>
    </div>
    <script src = "client.js"></script>
   </body>
</html>
```

```js
// client.js
var stream;

function hasUserMedia() { // 해당 브라우저가 WebRTC를 지원하는지 체크
  return !!(navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia);
}
if (hasUserMedia()) {
  navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;

  //enabling video and audio channels
  navigator.getUserMedia({ video: true, audio: true }, function (s) {
    stream = s;
    var video = document.querySelector('video');
    video.src = window.URL.createObjectURL(stream);
  }, function (err) {});
} else {
  alert("WebRTC is not supported");
}
btnGetAudioTracks.addEventListener("click", function(){
  console.log("getAudioTracks");
  console.log(stream.getAudioTracks());
});
btnGetTrackById.addEventListener("click", function(){
  console.log("getTrackById");
  console.log(stream.getTrackById(stream.getAudioTracks()[0].id));
});
btnGetTracks.addEventListener("click", function(){
  console.log("getTracks()");
  console.log(stream.getTracks());
});
btnGetVideoTracks.addEventListener("click", function(){
  console.log("getVideoTracks()");
  console.log(stream.getVideoTracks());
});
btnRemoveAudioTrack.addEventListener("click", function(){
  console.log("removeAudioTrack()");
  stream.removeTrack(stream.getAudioTracks()[0]);
});
btnRemoveVideoTrack.addEventListener("click", function(){
  console.log("removeVideoTrack()");
  stream.removeTrack(stream.getVideoTracks()[0]);
});
```

## 추가 링크

- [html5rocks 한글 튜토리얼](https://www.html5rocks.com/ko/tutorials/webrtc/basics/)
- [html5rocks audio/video capture](https://www.html5rocks.com/ko/tutorials/getusermedia/intro/)
- [2013 Google I/O slide](http://io13webrtc.appspot.com/#1)
- [2013 Google I/O video](https://youtu.be/p2HzZkd2A40)
- [WebRTC codelab](https://bitbucket.org/webrtc/codelab)
- [Web Audio Demos](http://webaudiodemos.appspot.com/)
- [tutorials point](https://www.tutorialspoint.com/webrtc/webrtc_media_stream_apis.htm)
- [coiiee blog](https://coiiee.com/blog.php?idx=2)
