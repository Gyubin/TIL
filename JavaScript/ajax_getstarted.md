# ajax 시작하기

참고 링크: [MDN](https://developer.mozilla.org/ko/docs/AJAX/Getting_Started)

AJAX는 웹 개발에서 필수다. 가장 잘 쓰이는 것은 페이지 전체를 리프레쉬 하지 않고 화면의 특정 부분을 변경할 수 있는 것이다. JavaScript를 통해 json이나 HTML 등의 텍스트 파일을 받아오고 변경할 수 있다.

## 1. 간단한 예제

출처: [w3schools](http://www.w3schools.com/ajax/)

```html
<!DOCTYPE html>
<html>
    <body>
        <div id="demo"><h2>Let AJAX change this text</h2></div>
        <button type="button" onclick="loadDoc()">Change Content</button>
        <script>
            function loadDoc() {
              var xhttp;
              if (window.XMLHttpRequest) { // 모질라, 사파리 등...
                xhttp = new XMLHttpRequest();
              } else if (window.ActiveXObject) { // IE 8 이상
                xhttp = new ActiveXObject("Microsoft.XMLHTTP");
              }

              xhttp.onreadystatechange = function() {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                  document.getElementById("demo").innerHTML = xhttp.responseText;
                }
              };
              xhttp.open("GET", "ajax_info.txt", true);
              xhttp.send();
            }
        </script>
    </body>
</html>
```

- html
    + 변경할 요소를 만든다. 예제에선 div#demo 요소다.
    + 이벤트를 일으키는 버튼을 만들고 onclick 속성을 내 함수로 지정해뒀다.
- js
    + 버튼을 눌렀을 때 실행할 `loadDoc` 함수를 만든다.
    + `XMLHttpRequest` 객체 생성. IE와 다른 브라우저들을 분기한다.
    + `xhttp.onreadystatechange` : 요청을 보낸 후 응답을 받았을 때 어떤 행동을 할지 onreadystatechange property에 함수 형태로 대입한다. 정상적으로 동작할 때만 스크립트가 실행되도록 if문으로 감싼다.
    + onreadystatechange에 할당되는 함수에서 내부 코드는 원하는 형태로 짜면 되는데 XMLHttpRequest 객체의 다양한 속성을 활용할 수 있다. 위 예제에는 텍스트를 바꾸는거라서 `xhttp.responseText`를 활용했다.
    + XMLHttpRequest 객체를 활용해 GET 방식으로 `open()`하고, 마지막에 `send()` 해준다. open 함수엔 GET, POST 지정하고(모두 대문자), 두 번째 매개변수로 URL을 적으면 된다. 세번째로 비동기(Asynchronous) 식으로 수행될건지 여부를 넣는데 당연히 true를 적어준다.
