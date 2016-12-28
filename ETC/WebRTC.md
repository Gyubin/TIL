# WebRTC - Web Real Time Communication

참고링크: [tutorials point](https://www.tutorialspoint.com/webrtc/webrtc_media_stream_apis.htm), [coiiee blog](https://coiiee.com/blog.php?idx=2), [html5rocks](https://www.html5rocks.com/ko/tutorials/webrtc/basics/#toc-mediastream)

## 0. 정의

- 어떤 플랫폼에서든 플러그인 없이 실시간 통신을 할 수 있는 기술. 특히 웹에서 영상, 음성 통화를 할 수 있는 것이 대표적이다.

## 1. Signaling

- P2P 통신이지만 서버가 필요하다. Signaling을 위해.
- 시그널링은 통신 조정하는 과정이다. call을 만들기 위해 Signaling은 3가지 정보를 교환한다.
    + Session control messages: 통신의 초기화, 종료 그리고 에러 리포트
    + Network configuration: 내 컴퓨터의 IP 주소와 Port 정보, 보안 연결을 수립하기 위해 사용되는 키 데이터 등
    + Media capabilities: 내 브라우저와 상대브라우저가 사용 가능한 코덱들과 해상도들은 어떻게 되는지에 대해. 예로 코덱이나 코덱 설정, 대역폭, 미디어 타입 같은 미디어 메타데이터 등.

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
