# d3.js 시작하기

참고 링크: [웹Frameworks](http://webframeworks.kr/getstarted/d3js/), [nacyot님 블로그](http://blog.nacyot.com/articles/2015-02-02-d3-selection/)

## 1. 설치 순서

- Homebrew 설치
    + [BACK TO THE MAC](http://macnews.tistory.com/3728) 블로그에서 엘 캐피탄일 때 Homebrew 설치 방법을 잘 설명했다. 설치후 다음을 순서대로 행한다.
    + Homebrew 버전 업데이트 : `brew update`
    + Homebrew 트러블 슈팅: `brew doctor`
    + Homebrew 통해 받은 패키지 업그레이드 : `brew upgrade`
- Hombrew 이용해서 node, npm 설치 : `brew install node` (node를 깔면 npm 자동으로 깔린다.)
- npm 이용해서 bower 설치: `npm install -g bower`
- bower 이용해서 d3 설치: `bower install d3 --save`
- bower_components 폴더가 $HOME 디렉토리에 만들어질 것이고 html 파일에서 호출하여 사용하면 된다. 아래 예제 코드 참조.

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
