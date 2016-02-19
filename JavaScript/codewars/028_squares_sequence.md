# #28 Squares sequence

며칠 몸이 안 좋아서 오늘은 쉬어가는 겸 쉬운 문제 풀었다. 또 ECMAScript 6가 나오면서 문법이 엄청나게 바뀌었는데.. 그 부분 다시 정리해야겠다. 결국엔 이쪽으로 다 바뀔 것 같다.

매개변수 x, n을 받는다. 배열에 x를 시작으로 총 n개를 집어넣게 되는데 각 원소는 이전 원소의 제곱이다.

## 1. 내 코드

```js
function squares(x, n) {
  var result = [x];
  for (var i = 0; i < n-1; i++) {
    result.push(Math.pow(result[i], 2));
  }
  return result;
}
```

다른 코드와 같다. Math.pow() 함수 대신 x를 두 번 곱한 점이나, 반복문 종류를 다른 것을 쓰는 등만 다를 뿐이다.

다만 다른 코드를 보면서 배열 생성에 대해서 새로운 것을 알게됐다. 파이썬은 일정 길이의 리스트를 쉽게 정의할 수 있다(`arr = [0] * 10`) 자바스크립트는 그런게 없는 것 같아 가끔 불편할 때가 있었는데 너무도 쉽게 다음처럼 정의가 가능했다. `var arr = Array(10)` 물론 값은 모두 undefined지만 길이 자체는 10이다. 이걸 활용하면 위 문제를 다음처럼 해결할 수도 있다. 다른 해답이다.

```js
function squares(x, n) {
  return Array.apply(0, Array(n)).map(function(_,i){return i? x=x*x : x})
}
```
