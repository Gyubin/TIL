# force layout

화면의 요소를 처리하는 데 물리 역학(physical force)을 사용하기 때문에 포스 레이아웃(force directed layout)이라고 부른다. 여기서 물리역학이란 원소들이 서로 밀어내지만 스프링으로 연결된 것처럼 멀리 떨어지지는 않는 것을 의미한다.

각각의 원소를 node라고 부르고 연결하는 선을 edge라고 한다. 혹은 vertices-links 쌍으로 부르기도 한다. 주로 노드는 원, 엣지는 선으로 표시한다.

## 1. 주요 요소 설명

### 1.1 데이터 형태

dataset이라는 object가 있고 두 개의 키(nodes, edges)가 있다. 각 키에 대한 값은 리스트인데 내부에 여러 nodes와 edges를 의미하는 object들이 들어간다.

```js
var dataset = {
    nodes: [{name:"Adam"}, {name:"Bob"}, {name:"Jerry"}],
    edges: [{source:0, target:1}, {source: 0, target: 2 }, {source:1, target:2}]
};
```

### 1.2 layout

nodes와 edges를 정해준 후에 다른 특성들을 지정한다. 전체 영역 크기, 거리, 반발력, 튕기는 정도 조절, 로딩 시 시작점 지정 등이 가능하다.

```js
var force = d3.layout.force()
        .nodes(dataset.nodes)           //노드 설정
        .links(dataset.edges)           //링크 선을 지정
        .size([w, h])                   //표시 영역의 크기를 지정
        .linkDistance([50])             //거리 지정
        .charge([-100])                 //반발력 지정
        .start();                       //force.start()를 호출해 계산을 수행
```

### 1.3 nodes, edge 생성

```js
var edges = svg.selectAll("line")       //선 생성
    .data(dataset.edges)                //edges 배열을 데이터셋으로 지정
    .enter()
    .append("line")                     //선 추가
    .style("stroke", "#ccc")            //선의 스타일 지정
    .style("stroke-width", 1);

var nodes = svg.selectAll("circle")     //원 생성
    .data(dataset.nodes)                //nodes 배열을 데이터셋으로 지정
    .enter()
    .append("circle")                   //원 추가
    .attr("r", 10)                      //반지름 설정
    .style("fill", function(d, i) {     //원 색상 설정
        return colors(i);
    })
    .call(force.drag);                  //노드를 드래그할 수 있도록 함

```

### 1.4 이벤트 설정

tick이 일어날 때 함수를 호출하여 새로운 좌표값으로 노드와 에지를 그림

```js
force.on("tick", function() {
    edges.attr("x1", function(d) { return d.source.x; })
         .attr("y1", function(d) { return d.source.y; })
         .attr("x2", function(d) { return d.target.x; })
         .attr("y2", function(d) { return d.target.y; });
    nodes.attr("cx", function(d) { return d.x; })
         .attr("cy", function(d) { return d.y; });
});
```

## 2. 전체 JavaScript 코드

html, css는 아예 쓰지 않은 예제다. d3.js 파일과 내 js 파일만 링크시킨다.

```js
//넓이와 폭 설정
var w = 500;
var h = 300;

//원본 데이터셋 설정
var dataset = {
    //노드 리스트
    nodes: [
        { name: "Adam" },           //0번
        { name: "Bob" },            //1번
        { name: "Carrie" },         //2번
        { name: "Donovan" },        //3번
        { name: "Edward" },         //4번
        { name: "Felicity" },       //5번
        { name: "George" },         //6번
        { name: "Hannah" },         //7번
        { name: "Iris" },           //8번
        { name: "Jerry" }           //9번
    ],
    //노드와 노드를 연결하는 에지의 관계. 배열 요소의 순서를 ID 참조 번호로 이용
    edges: [
        { source: 0, target: 1 },
        { source: 0, target: 2 },
        { source: 0, target: 3 },
        { source: 0, target: 4 },
        { source: 1, target: 5 },
        { source: 2, target: 5 },
        { source: 2, target: 5 },
        { source: 3, target: 4 },
        { source: 5, target: 8 },
        { source: 5, target: 9 },
        { source: 6, target: 7 },
        { source: 7, target: 8 },
        { source: 8, target: 9 }
    ]
};

//포스 레이아웃 설정. 데이터셋에 있는 노드와 에지를 사용하여 기본 포스 레이아웃을 초기화
var force = d3.layout.force()
        .nodes(dataset.nodes)           //노드 설정
        .links(dataset.edges)           //링크 선을 지정
        .size([w, h])                   //표시 영역의 크기를 지정
        .linkDistance([50])             //거리 지정
        .charge([-100])                 //반발력 지정
        .start();                       //force.start()를 호출해 계산을 수행

var colors = d3.scale.category10();

//SVG 요소를 생성
var svg = d3.select("body")
            .append("svg")              //SVG 영역 생성
            .attr("width", w)
            .attr("height", h);

//line을 이용하여 에지를 생성
var edges = svg.selectAll("line")       //선 생성
    .data(dataset.edges)                //edges 배열을 데이터셋으로 지정
    .enter()
    .append("line")                     //선 추가
    .style("stroke", "#ccc")            //선의 스타일 지정
    .style("stroke-width", 1);

//circle을 이용하여 노드를 생성
var nodes = svg.selectAll("circle")     //원 생성
    .data(dataset.nodes)                //nodes 배열을 데이터셋으로 지정
    .enter()
    .append("circle")                   //원 추가
    .attr("r", 10)                      //반지름 설정
    .style("fill", function(d, i) {     //원 색상 설정
        return colors(i);
    })
    .call(force.drag);                  //노드를 드래그할 수 있도록 함

//다시 그릴 때(tick이벤트가 발생할 때)마다 함수를 호출하여 새로운 좌표값으로 노드와 에지를 그
force.on("tick", function() {
    //에지의 소스와 타겟 요소의 좌표를 지정
    edges.attr("x1", function(d) { return d.source.x; })
         .attr("y1", function(d) { return d.source.y; })
         .attr("x2", function(d) { return d.target.x; })
         .attr("y2", function(d) { return d.target.y; });
    //노드의 좌표를 지정
    nodes.attr("cx", function(d) { return d.x; })
         .attr("cy", function(d) { return d.y; });

});
```
