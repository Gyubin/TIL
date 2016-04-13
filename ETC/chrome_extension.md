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

```html
<!doctype html>
<html>
  <head>
    <title>Getting Started Extension's Popup</title>
    <style>
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
    </style>
    <script src="popup.js"></script>
  </head>
  <body>
    <div id="status"></div>
    <img id="image-result" hidden>
  </body>
</html>
```

```js
// Copyright (c) 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/**
 * Get the current URL.
 *
 * @param {function(string)} callback - called when the URL of the current tab
 *   is found.
 */
function getCurrentTabUrl(callback) {
  // Query filter to be passed to chrome.tabs.query - see
  // https://developer.chrome.com/extensions/tabs#method-query
  var queryInfo = {
    active: true,
    currentWindow: true
  };

  chrome.tabs.query(queryInfo, function(tabs) {
    // chrome.tabs.query invokes the callback with a list of tabs that match the
    // query. When the popup is opened, there is certainly a window and at least
    // one tab, so we can safely assume that |tabs| is a non-empty array.
    // A window can only have one active tab at a time, so the array consists of
    // exactly one tab.
    var tab = tabs[0];

    // A tab is a plain object that provides information about the tab.
    // See https://developer.chrome.com/extensions/tabs#type-Tab
    var url = tab.url;

    // tab.url is only available if the "activeTab" permission is declared.
    // If you want to see the URL of other tabs (e.g. after removing active:true
    // from |queryInfo|), then the "tabs" permission is required to see their
    // "url" properties.
    console.assert(typeof url == 'string', 'tab.url should be a string');

    callback(url);
  });

  // Most methods of the Chrome extension APIs are asynchronous. This means that
  // you CANNOT do something like this:
  //
  // var url;
  // chrome.tabs.query(queryInfo, function(tabs) {
  //   url = tabs[0].url;
  // });
  // alert(url); // Shows "undefined", because chrome.tabs.query is async.
}

/**
 * @param {string} searchTerm - Search term for Google Image search.
 * @param {function(string,number,number)} callback - Called when an image has
 *   been found. The callback gets the URL, width and height of the image.
 * @param {function(string)} errorCallback - Called when the image is not found.
 *   The callback gets a string that describes the failure reason.
 */
function getImageUrl(searchTerm, callback, errorCallback) {
  // Google image search - 100 searches per day.
  // https://developers.google.com/image-search/
  var searchUrl = 'https://ajax.googleapis.com/ajax/services/search/images' +
    '?v=1.0&q=' + encodeURIComponent(searchTerm);
  var x = new XMLHttpRequest();
  x.open('GET', searchUrl);
  // The Google image search API responds with JSON, so let Chrome parse it.
  x.responseType = 'json';
  x.onload = function() {
    // Parse and process the response from Google Image Search.
    var response = x.response;
    if (!response || !response.responseData || !response.responseData.results ||
        response.responseData.results.length === 0) {
      errorCallback('No response from Google Image search!');
      return;
    }
    var firstResult = response.responseData.results[0];
    // Take the thumbnail instead of the full image to get an approximately
    // consistent image size.
    var imageUrl = firstResult.tbUrl;
    var width = parseInt(firstResult.tbWidth);
    var height = parseInt(firstResult.tbHeight);
    console.assert(
        typeof imageUrl == 'string' && !isNaN(width) && !isNaN(height),
        'Unexpected respose from the Google Image Search API!');
    callback(imageUrl, width, height);
  };
  x.onerror = function() {
    errorCallback('Network error.');
  };
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
