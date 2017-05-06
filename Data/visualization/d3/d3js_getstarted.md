# d3.js 시작하기

참고 링크: [웹Frameworks](http://webframeworks.kr/getstarted/d3js/), [nacyot님 블로그](http://blog.nacyot.com/articles/2015-02-02-d3-selection/)

## 1. 설치 순서

1. Homebrew 설치
    + [BACK TO THE MAC](http://macnews.tistory.com/3728) 블로그에서 엘 캐피탄일 때 Homebrew 설치 방법을 잘 설명했다. 설치후 다음을 순서대로 행한다.
    + Homebrew 버전 업데이트 : `brew update`
    + Homebrew 트러블 슈팅: `brew doctor`
    + Homebrew 통해 받은 패키지 업그레이드 : `brew upgrade`
2. Hombrew 이용해서 node, npm 설치 : `brew install node` (node를 깔면 npm 자동으로 깔린다.)
3. npm 이용해서 bower 설치: `npm install -g bower`
4. bower 이용해서 d3 설치: `bower install d3 --save`
    + 명령어를 실행한 디렉토리에 bower_components 폴더가 생긴다. 이 경로를 html 파일에서 link에서 사용하면 된다.
    + d3.js와 d3.min.js 파일 2개가 있을 것이다. 내용은 동일하지만 min 파일은 공백을 제거해서 용량이 반 이상 줄었다. 실제 publish할 때 min 파일을 쓰면 로딩 시간이 준다. 개발할 땐 일반 파일을 쓰는게 디버깅하기 좋다.
5. 유의 사항: 실제 작업할 때는 html, css, js 파일을 로컬 서버로 열어서 작업해야 한다. 브라우저 보안 기능이 일반 파일로 열었을 때 js가 csv나 json 파일을 읽는 것을 막기 때문이다. 아래처럼 파이썬 로컬 서버로 열든가, pow.cx + anvil [조합](https://github.com/Gyubin/TIL/blob/master/ETC/localserver_pow_anvil.md)을 이용한다.
    + 파이썬2 : `python -m SimpleHTTPServer`
    + 파이썬3 : `python -m http.server`
    + 프로젝트 폴더 디렉토리에서 위 명령어를 실행하고, index.html 파일을 만들어두면 그 파일이 열린다.

## 2. 주요 함수 설명

`d3` 객체에서 `.`으로 호출된다. 순서대로 모두 chain해서 사용할 수 있다.

- `select('tag')` : tag 요소를 선택한다. 매치되지 않으면 빈 객체를 반환한다.
- `selectAll('tag')` : tag 요소를 모두 선택한다. 매치되지 않으면 빈 객체를 반환한다. 즉 `select`, `selectAll` 모두 빈 selection 객체를 반환할 수 있고 빈 객체에다가 가상으로 작업할 수 있다.
- `data(dataset)` : data 객체를 받아서 select나 selectAll로 선택한 selection 객체에 binding 한다.
- `enter()` : 선택된 selection보다 data가 더 많을 경우에는 매칭되지 못하고 남는 데이터가 있을 것이다. 이 데이터를 찾아내서 가상의 selection 객체를 만들어 데이터와 매칭시킨 다음 반환한다. 즉 여기서 반환되는 값은 남는 데이터와 매칭된는 selection 객체다. 이미 data 메소드를 통해 매칭된 selection 객체들은 반환값에 포함되어있지 않다. 그래서 뒤이어 호출될 수 있는 `append`, `text` 메소드가 이미 매칭된 객체엔 효력을 발휘하지 않는 것.
- `append('tag')` : `enter()`로 만들어진 가상 객체들을 실제 태그로 바꿔준다. 부모 요소는 처음 d3.select('tag')를 한 tag이며, 만약 지정되지 않았다면 html 태그가 부모 요소가 된다.
- `text('some text')` : 생성한 tag 안에 텍스트를 쓴다.

## 3. 예제 코드

```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>d3js</title>
    <link rel="stylesheet" href="style.css"/>
    <script src="/Users/gyubin/bower_components/d3/d3.min.js"></script>
</head>
<body>
    <h1>Hello d3</h1>
    <script src="app.js"></script>
</body>
</html>
```

> 여기서 d3 라이브러리는 그냥 import 시킨다는 의미이고 실제로 동작하는 코드는 없으니 head에 넣는다. 하지만 app.js 파일은 html에 모두 로딩된 이후에 동작해야하므로 body 태그의 가장 아래쪽에 위치시킴.

---

```css
/* css */
.bar-chart {
  display: inline-block;
  margin-right: 1px;
  background-color: hotpink;
}
```

---

```js
//JavaScript
var data = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

// div 이용해서 그래프 그리기
// d3.select("body").selectAll("div")
//   .data(data)
//   .enter()
//   .append("div")
//   .style("height", function (d) { // 높이 설정
//     return d + "px";
//   })
//   .style("width", function (d) { // 너비 설정
//     return "20px";
//   })
//   .attr("class", "bar-chart");

// svg 이용해서 그래프 그리기
var w = 200, h = 100;
var svg = d3.select("body")
            .append("svg")
            .attr("width", w)
            .attr("height", h);

svg.selectAll("rect")
    .data(data)
    .enter()
    .append("rect")
    .attr("x", function(d, i) { // x 좌표 설정
      return i * (w / data.length)
    })
    .attr("y", function(d) { // y 좌표 설정
      return h - d;
    })
    .attr("width", w / data.length - 1) // 너비 설정
    .attr("height", function(d) { // 높이 설정
      return d;
    })
    .attr("fill", function(d) { // 색상 설정
      return "hotpink";
    });

svg.selectAll("text")
    .data(data)
    .enter()
    .append("text")
    .text(function(d) {
      return d;
    })
    .attr("x", function(d, i) {
      return i * (w / data.length) + (w / data.length) / 2;
    })
    .attr("y", function(d) {
      return h - d + 10;
    })
    .attr("font-family", "sans-serif")
    .attr("font-size", "11px")
    .attr("fill", "black")
    .attr("text-anchor", "middle");
```
