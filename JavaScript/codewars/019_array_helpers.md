# #19 Array Helpers

Array에서 바로 dot notation으로 호출할 수 있는 함수들을 만드는 것. square, sum, cube, average, even, odd를 새로 내가 만들면 된다.

## 1. 내 코드

```js
Array.prototype.square = function() {
  return this.map(function(e) {
    return e*e;
  });
}

Array.prototype.cube = function() {
  return this.map(function(e) {
    return e*e*e;
  });
}

Array.prototype.average = function() {
  if (this.length === 0) return NaN;
  return this.sum() / this.length;
}

Array.prototype.even = function() {
  return this.filter(function(e){
    if (!(e % 2)) return e;
  });
}

Array.prototype.sum = function() {
  return this.reduce(function(prev, cur) {
    return prev + cur;
  });
}

Array.prototype.odd = function() {
  return this.filter(function(e){
    if (e % 2) return e;
  });
}
```

- Array의 prototype에다가 함수를 하나하나 만들면 된다.
- map, reduce, filter를 적절하게 썼고 다른 답과 똑같았다.
- 하나 달랐던건 average 함수에서 Array 원소가 없을 때 예외처리인데 굳이 NaN을 따로 리턴하지 않아도 계산식에서 자연스럽게 NaN 결과가 나간다.
