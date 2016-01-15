# d3.js 시작하기

참고 링크: [웹Frameworks](http://webframeworks.kr/getstarted/d3js/)

## 1. 설치 순서

- Homebrew 설치
    + [BACK TO THE MAC](http://macnews.tistory.com/3728) 블로그에서 엘 캐피탄일 때 Homebrew 설치 방법을 잘 설명했다. 설치후 다음을 순서대로 행한다.
    + Homebrew 버전 업데이트 : `brew update`
    + Homebrew 트러블 슈팅: `brew doctor`
    + Homebrew 통해 받은 패키지 업그레이드 : `brew upgrade`
- Hombrew 이용해서 node, npm 설치 : `brew install node` (node를 깔면 npm 자동으로 깔린다.)
- npm 이용해서 bower 설치: `npm install -g bower`
- bower 이용해서 d3 설치: `bower install d3 --save`

## 2. 예제 코드

```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>d3js</title>
    <link rel="stylesheet" href="style.css"/>
</head>
<body>
    <h1>Hello d3</h1>
    <script src="/Users/gyubin/bower_components/d3/d3.min.js"></script>
    <script src="app.js"></script>
</body>
</html>
```

```css
.bar-chart {
  display: inline-block;
  margin-right: 1px;
  background-color: hotpink;
}
```

```js
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
