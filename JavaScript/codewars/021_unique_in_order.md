# #21 Unique In Order

같은 문자가 반복되면 하나로 줄여서 리턴한다.

## 1. 내 코드

```js
var uniqueInOrder = function(iterable) {
  var result = [];
  var prev;
  for(var i = 0; i < iterable.length; i++){
    if(iterable[i] != prev) {
      result.push(iterable[i]);
    }
    prev = iterable[i];
  }
  return result;
}
```

단순하게 처음부터 끝까지 반복을 돌리는데 이전 값을 계속 저장했다. 비교해서 다를 때만 결과 리스트에 넣었다.

## 2. 다른 해답

```js
function uniqueInOrder(it) {
  var result = [];
  var last;
  for (var i = 0; i < it.length; i++) {
    if (it[i] !== last) {
      result.push(last = it[i]);
    }
  }
  return result;
}
```

나와 똑같은 방식이지만 이전 값과 다를 때만 prev 값을 바꿔줬다. 그리고 변수에다 값을 대입함과 동시에 매개변수로 넘길 수 있다. 이 점 기억.
