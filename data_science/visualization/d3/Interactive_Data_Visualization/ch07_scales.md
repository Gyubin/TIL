# Chapter 7 Scales

- 정의: 입력되는 domain과 출력되는 range를 매핑하는 함수
- 역할: 데이터가 시각화될 때 내가 원하는대로 
- input domain: 입력되는 데이터 값의 범위.
- output range: 출력값의 가능 범위. 어느정도 크기까지 보여질 수 있느냐. 주로 디스플레이 픽셀값을 나타낸다.

## Normalize

- 정규화다. 모든 데이터 값을 0과 1 사이의 값으로 바꾸는 과정.
- 데이터의 최소값을 0, 최대값을 1로 한다.
- input domain, output range 변환되는 중간에서 정규화가 이루어진다.
- domain, range 설정 안하고 scale 메소드 호출하면 1:1로 매핑된다.

```js
var scale = d3.scale.linear()
                    .domain([100, 500])
                    .range([10, 350]);
scale(100); // 10
scale(300); // 180
scale(500); // 350
```

## min, max

```js
d3.min(dataset, function(d) {
    return d[0]
});
```
