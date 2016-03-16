# #1 Monotone travel

array의 원소들이 갈 수록 올라가는지 확인하는 함수를 짜는 것이다. 내 코드는 설명이 필요없을 정도로 간단한 코드다.

## 1. 내 코드

```js
var isMonotone = function(arr){
  for (var i = 0; i < arr.length - 1; i++) {
    if (arr[i+1] < arr[i]) return false;
  }
  return true;
}
```

## 2. 다른 해답

### A. every 활용(설명참고 [MDN](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Array/every))

```js
var isMonotone = function(arr){
  return arr.every(function(x, idx) {
    return idx === 0 ? true : arr[idx] >= arr[idx-1];
  });
}
```

모든 요소가 전달한 콜백 함수의 조건에 만족하는지 확인하는 것이다. 콜백 함수에는 세 가지 매개변수가 들어갈 수 있는데 순서대로 '하나씩 뽑을 원소', '원소의 인덱스', '현재 처리 중인 배열'이다. 위 경우는 앞의 2가지 매개변수만 활용했다. 인덱스가 0이면 그냥 true를 리턴하고 아니라면 현재 원소가 이전 원소보다 같거나 큰지를 확인한다.

### B. reduce 활용

```js
var isMonotone = function(arr){
  return arr.reduce(function(p, c, i, arr){
    return p && (c <= arr[i+1] || i == arr.length - 1);
  }, true);
}
```

다른 언어에서의 reduce 함수와 비슷하다. 역시 원소를 하나하나 가져와서 누적하고 최종 적으로 하나의 값을 리턴하는 함수다. 기본적으로 다음 `arr.reduce(callback[, initialValue])` 형태를 가지며 콜백함수의 매개변수로는 순서대로 previousValue, currentValue, currentIndex, array를 받을 수 있다. 콜백함수는 이전값과 현재값을 어떻게 연산할 것인지를 정의해준다.

위 경우는 initialValue를 true로 넣었다. 그리고 현재값이 다음 값보다 같거나 작은지 boolean 값을 이전값과 and 연산했다. 다음 값을 뽑아올 때 인덱스를 +1 했기 때문에 마지막엔 존재하지 않는 값을 뽑아올 것이다. 이 때 undefined가 리턴되는데 `||`를 활용해서 인덱스가 마지막 인덱스면 true를 리턴한다. A 답과 달리 매번 인덱스값을 비교하지 않고 마지막에 한 번만 비교하기 때문에 연산 수를 줄였다.
