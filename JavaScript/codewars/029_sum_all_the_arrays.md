# #29 Sum ALL the arrays

배열의 원소를 모두 합한 결과를 리턴한다. 매개변수로 들어오는 배열의 원소가 배열일 수도 있고, 문자열일 수도 있다.

## 1. 내 코드

```js
function arraySum(arr) {
  return arr.reduce(function (p, c) {
    if (typeof c === 'string' || typeof c === 'function') { c = 0; }
    if (typeof c === "object") { c = arraySum(c); }
    return p+c;
  }, 0);
}
```

- `reduce` 함수를 활용해서 합한 값을 리턴했다. 가장 기본적인 것이고 모든 원소가 숫자면 이것으로도 동작한다.
- 하지만 원소에 문자열, 배열, 함수가 들어올 수도 있다. 그래서 배열일 경우엔 재귀로 함수를 다시 호출했고, 다른 경우엔 값을 0으로 해서 결국 더하는 값을 없게 했다.

## 2. 다른 해답

### 2.1

```js
function arraySum(arr) {
  var output = 0;
  for (var i in arr) {
    var item = arr[i];
    if ( typeof(item) === "number"  )  { output += item;           }
    if ( item.constructor === Array )  { output += arraySum(item); }
  }
  return output;
}
```

내부 원리는 똑같고, 내가 reduce를 쓴 것과 다르게 for 문으로 반복 돌렸다.

### 2.2

```js
function arraySum(arr) {
  return arr.reduce((n, x) => n + (Array.isArray(x) ? arraySum(x) : isNaN(x) ? 0 : x), 0)
}
```

내 코드를 짧게 줄인 것.
