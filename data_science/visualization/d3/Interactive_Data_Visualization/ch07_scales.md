# Chapter 7 Scales

- 정의: 입력되는 domain과 출력되는 range를 매핑하는 함수
- input domain: 입력되는 데이터 값의 범위.
- output range: 출력값의 가능 범위. 어느정도 크기까지 보여질 수 있느냐. 주로 디스플레이 픽셀값을 나타내는데 쓴다.

```js
var scale = d3.scale.linear()
                    .domain([100, 500])
                    .range([10, 350]);
scale(100); // 10
scale(300); // 180
scale(500); // 350
```

## 1. Normalize

- 정규화. 모든 데이터 값을 0과 1 사이의 값으로 바꾸는 과정.
- 데이터의 최소값을 0, 최대값을 1로 한다.
- input domain, output range 변환되는 중간에서 정규화가 이루어진다.
- domain, range 설정 안하고 scale 메소드 호출하면 1:1로 매핑된다.

## 2. min, max 활용

- 메소드 체인이 아니라 함수처럼 사용
- 데이터를 첫 번째 매개변수로 받고, 비교 기준을 함수로 적용해주면 된다.

```js
d3.min(dataset, function(d) {
  return d[0]    // 이차원 배열일 떄
});
d3.max(dataset);   // 단순 배열일 때
```

## 3. Dynamic Scales

```js
var xScale = d3.scale.linear()
                .domain([0, d3.max(dataset, function(d) {
                  return d[0];
                })])
                .range([0, w]);

var yScale = d3.scale.linear()
                .domain([0, d3.max(dataset, function(d) {
                    return d[1];
                })])
                .range([h, 0]);

.attr("cx", function(d) {
  return xScale(d[0]);
})

.attr("cy", function(d) {
  return yScale(d[1]);
})
```

- x좌표, y좌표와 관련된 scale 함수를 각각 만든다.
- domain은 x, y의 최대값을, range는 SVG의 width, height로 설정.
- 데이터를 바로 속성값으로 적용하는게 아니라 scale 함수를 거친 값을 넣는다.

## 4. 기타

### 4.1 팁

- scale의 `range` 메소드의 매개변수 순서를 바꾸면 x, y 좌표 값을 뒤집어서 적용할 수 있다.
- padding: 설정하고싶은 padding 값을 `range` 메소드에서 큰 값에선 빼주고, 작은 값에선 더해주면 된다. 하지만 이것보다 더 자주 사용되는 사용 방법이 margin convention이다.
- margin convention: [참고 링크](http://bl.ocks.org/mbostock/3019563)
    + `var margin = {top: 20, right: 10, bottom: 20, left: 10};`
    + 위처럼 값을 정의해주고, SVG의 width, height, translate 속성들을 지정할 때 활용하면 된다. 아래코드처럼 해두면 나머지는 원래 써왔던 것처럼 자연스럽게 쓰면 된다.

    ```js
    var width = 960 - margin.left - margin.right
    var height = 500 - margin.top - margin.bottom;
    var svg = d3.select("body").append("svg")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
    ```

### 4.2 `d3.scale.linear()`의 다른 메소드

```js
var scale = d3.scale.linear()
              .domain([0.123, 4.567])
              .rangeRound([15.83, 324.32])
              .nice()
              .clamp(true);
```

- `nice()` : domain에 지저분한 값이 입력되면 반올림해서 적당한 수로 바꿔준다. 정수로 바꿔주는 건 아니고 소수점 단위로 나타낼 수도 있다. 예를 들어 `[0.20147987687960267, 0.996679553296417]`이 domain으로 들어오면 `[0.2, 1]`로 바꿔주는 식이다.
- `rangeRound()`: `range` 자리에서 대신 쓰인다. scale 함수의 모든 출력값을 정수로 반올림해서 나타낸다. 픽셀 단위로 정확하게 표현하고 싶을 때 유용. antialiasing으로 주변이 흐려지는 것이 싫으면 사용한다.
- `clamp()`: linear scale은. 만약 주어진 domain 범위에서 벗어나는 값을 입력받으면 scale 메소드는 range 범위에서 벗어난 값을 리턴하게 된다. `clamp(true)`는 무조건 range 범위 내에서 출력하도록 한다. 즉 범위 외의 값은 range의 최소값 혹은 최대값이 되는 것.

### 4.3 `d3.scale.something()`

#### 4.3.1 불연속 적인 것들

참고 링크: [quantile, quantize, threshold](http://bl.ocks.org/syntagmatic/29bccce80df0f253c97e)

- `quantize`: linear scale이긴 한데 불연속적인 것. 크게 몇 가지로 구분하고 싶을 때 사용한다. 구분 간격 동일하게 알아서 bucket을 만들어준다.

    ```js
    var q = d3.scale.quantize().domain([0, 1]).range(['a', 'b', 'c']);
    //q(0.3) === 'a', q(0.4) === 'b', q(0.6) === 'b', q(0.7) ==='c';
    //q.invertExtent('a') returns [0, 0.3333333333333333]
    ```

- `quantile`: 이미 bucket이 있을 경우. 즉 이미 구분 간격이 정해져있을 경우 quantile 사용한다.

    ```js
    var div = d3.select("body").append("div");

    var scale1 = d3.scale.quantize().domain([0,0.1,0.2,0.3,1]).range([1,100]),
        scale2 = d3.scale.quantile().domain([0,0.1,0.2,0.3,1]).range([1,100]);

    div.text(scale1(0.2) + " " + scale2(0.2)); // 1, 100
    ```

- `threshold`: 일정 기준치 이하와 초과를 나눠서 값 적용

#### 4.3.2 나머지

- `sqrt`: 제곱근
- `pow`: 제곱
- `log`: 로그
- `ordinal`: 수량화될 수 없는, 혹은 순서를 매길 수 없는 스케일을 나타낼 때
- `d3.scale.category10()`, `d3.scale.category20()`, `d3.scale.category20b()`, `d3.scale.category20c()`: 색깔 나타냄.
- `d3.time.scale()`: 시간 관련
