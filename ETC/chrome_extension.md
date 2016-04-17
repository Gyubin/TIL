# Chrome Extension

참고 링크: [extension tutorial](https://developer.chrome.com/extensions/getstarted)

## 1. Getting started tutorial

기본적으로 웹 개발과 같은 언어를 사용한다. HTML, CSS, JavaScript에 익숙하다면 쉽게 확장 프로그램을 만들 수 있다고 한다.

### 1.1 manifest.json

```js
{
  "manifest_version": 2,

  "name": "Getting started example",
  "description": "This extension shows a Google Image search result for the current page",
  "version": "1.0",

  "browser_action": {
    "default_icon": "icon.png",
    "default_popup": "popup.html"
  },
  "permissions": [
    "activeTab",
    "https://ajax.googleapis.com/"
  ]
}
```

- 확장 프로그램에 대한 메타데이터를 기록하는 파일이다. `manifest.json`에 대한 더 자세한 설명은 다음 [링크](https://developer.chrome.com/extensions/manifest)에 있다.
- `browser_action`: 자세한 내용은 [링크](https://developer.chrome.com/extensions/browserAction)에 있다. 브라우저에 아이콘을 달고 배지를 넣거나 어떤 GUI를 추가할 때 사용한다.
    + icon.png, popup.html 파일은 그냥 working directory에 만들면 된다.
    + icon의 크기는 19px의 정사각형이다.
    + default_popup 키에다 html 파일을 넣어두면 눌렀을 때 팝업으로 해당 내용이 뜨게된다.
- `permission`: 크롬에서 어떤 부분까지 접근할건지 기록한다. 처음 웹스토어에서 확장프로그램을 선택할 때 유저들이 동의하고 시작하게 된다.
    + `activeTab`: 현재 활성화된 탭에 접근할 수 있는 것
    + url을 적으면: 외부 API에 접근할 수 있음을 나타낸다.

### 1.2 코드

자바스크립트는 꼭 다른 파일로 분리해야한다. 관련 정책 [링크](https://developer.chrome.com/extensions/contentSecurityPolicy)

- popup.html

```html
<!doctype html>
<html>
  <head>
    <title>Getting Started Extension's Popup</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="popup.js"></script>
  </head>
  <body>
    <div id="status"></div>
    <img id="image-result" hidden>
  </body>
</html>
```

- style.css

```css
body {
    font-family: "Segoe UI", "Lucida Grande", Tahoma, sans-serif;
    font-size: 100%;
}

#status {
/* avoid an excessively wide status text */
    white-space: pre;
    text-overflow: ellipsis;
    overflow: hidden;
    max-width: 400px;
}
```

- popup.js

```js
// 현재 탭의 URL을 가져오는 함수
// 매개변수: 문자열(URL)을 매개변수로 받는 callback함수. 탭이 찾아지면 실행.
function getCurrentTabUrl(callback) {
  // Query filter다. chrome.tabs.query에 매개변수로 들어가게 된다.
  // 관련 링크: https://developer.chrome.com/extensions/tabs#method-query
  var queryInfo = {
    active: true,
    currentWindow: true
  };

  chrome.tabs.query(queryInfo, function(tabs) {
    // 쿼리와 매칭되는 탭을 고르고, callback 함수를 실행하는 역할.
    // 팝업이 열릴 때 탭이 하나는 열려있어야 'tabs'가 빈 배열이 아니게 된다.
    
    var tab = tabs[0];
    // 쿼리 필터에서 active:true로 해놨다. 한 번에 한 탭만 active되므로
    // tabs은 한 개 탭으로 구성된 배열이 된다.
    // 배열의 원소는 tab의 정보를 나타내는 기본 object다.
    // 관련 링크: https://developer.chrome.com/extensions/tabs#type-Tab
    
    var url = tab.url;
    // tab.url은 "activeTab" permission이 선언되었을 때만 사용 가능하다.
    // 다른 탭들의 링크를 알려면 Query filter에서 active:true를 없앤다.

    console.assert(typeof url == 'string', 'tab.url should be a string');
    callback(url);
  });

  // 대부분의 크롬 extension의 API는 비동기다. 그래서 다음처럼 못한다.
  // var url;
  // chrome.tabs.query(queryInfo, function(tabs) {
  //   url = tabs[0].url;
  // });
  // alert(url); // Shows "undefined", because chrome.tabs.query is async.
}

// 이미지 URL을 찾아내는 함수다.
// - searchTerm: 문자열 매개변수.
// - callback: func(string,number,number) 형태. 이미지가 찾아질 때 call되고
// 이미지의 width, height를 구한다.
// - errorCallback: func(string) 형태. 이미지를 못찾으면 호출된다. 실패 이유를 문자열로 받는 함수다.
function getImageUrl(searchTerm, callback, errorCallback) {
  // 아래 URL은 Google image search를 활용했는데 현재 deprecated되었다.
  // 참고 링크: https://developers.google.com/image-search/
  // Google custom search를 활용해야 한다. 알아보는 중.
  var searchUrl = 'https://ajax.googleapis.com/ajax/services/search/images' +
    '?v=1.0&q=' + encodeURIComponent(searchTerm);

  // ajax를 활용하기 위해 XMLHttpRequest 객체를 만들고, GET으로 연다.
  var x = new XMLHttpRequest();
  x.open('GET', searchUrl);

  // 크롬 파싱을 json으로 지정해준다. Google image search API가 json이다.
  x.responseType = 'json';

  // x가 로드될 때 실행될 함수를 정의한다.
  x.onload = function() {
    var response = x.response;
    // response, response의 데이터, 결과 등에 모두 값이 없다면 에러콜백
    if (!response || !response.responseData || !response.responseData.results || response.responseData.results.length === 0) {
      errorCallback('No response from Google Image search!');
      return;
    }
    var firstResult = response.responseData.results[0];
    // full이 아닌 썸네일을 가져온다. 그래야 대략적인 가로세로를 알 수 있다.
    var imageUrl = firstResult.tbUrl;
    var width = parseInt(firstResult.tbWidth);
    var height = parseInt(firstResult.tbHeight);

    // 만약 URL이 문자열이 아니거나 가로세로가 숫자가 아니라면 에러콜백
    console.assert(
        typeof imageUrl == 'string' && !isNaN(width) && !isNaN(height),
        'Unexpected respose from the Google Image Search API!');
    callback(imageUrl, width, height);
  };
  // 역시 onerror일 때 에러 콜백
  x.onerror = function() {
    errorCallback('Network error.');
  };
  // send해서 ajax 통신한다.
  x.send();
}

function renderStatus(statusText) {
  document.getElementById('status').textContent = statusText;
}

document.addEventListener('DOMContentLoaded', function() {
  getCurrentTabUrl(function(url) {
    // Put the image URL in Google search.
    renderStatus('Performing Google Image search for ' + url);

    getImageUrl(url, function(imageUrl, width, height) {

      renderStatus('Search term: ' + url + '\n' +
          'Google image search result: ' + imageUrl);
      var imageResult = document.getElementById('image-result');
      // Explicitly set the width/height to minimize the number of reflows. For
      // a single image, this does not matter, but if you're going to embed
      // multiple external images in your page, then the absence of width/height
      // attributes causes the popup to resize multiple times.
      imageResult.width = width;
      imageResult.height = height;
      imageResult.src = imageUrl;
      imageResult.hidden = false;

    }, function(errorMessage) {
      renderStatus('Cannot display image. ' + errorMessage);
    });
  });
});
```

### 1.3 크롬에서 로드하기

웹스토어에선 extension들을 `.crx` 확장자로 배포한다. 하지만 개발할 때 매번 묶고 테스트하긴 힘들다. 그래서 그냥 파일을 크롬에서 로드할 수 있다.

- 크롬 설정창(`command + ,`)에서 확장프로그램 메뉴로 들어간다.
- 우측 상단에 개발자 모드에 체크
- `Load unpacked extension`를 클릭하고 해당 파일들이 들어있는 폴더를 선택하면 된다.

### 1.4 툴팁 띄우기

익스텐션 아이콘에 커서 가져다댔을 때 팁을 보여줄 수 있다. manifest.json에 `default_title`에 문자열을 넣어주면 된다. 아래와 같다. 적용은 브라우저가 새로고침되면 적용된다.

```js
{
  ...
  "browser_action": {
    "default_icon": "icon.png",
    "default_popup": "popup.html",
    "default_title": "Click here!"
  },
  ...
}
```
