# #17 Human Readable Time

단순한 문제인데 꽤 헤맸다. '초'를 입력받아서 시, 분, 초 형태로 변환하는 문제다.

# 1. 내 코드

```js
function humanReadable(seconds) {
  var sec = seconds % 60
  var min = ((seconds - sec) / 60) % 60;
  var hour = (seconds - sec - min*60) / 3600;
  return [hour, min, sec].map(function (e) {
    return e < 10 ? '0' + e : e;
  }).join(':');
}
```

- js에선 `/`로 나눗셈을 하면 정수, 실수 할 거 없이 무조건 '제대로' 나눠버린다. 몫만 남겨주지 않는다. 예를 들어 `1/2`이든 `1.0/2`이든 간에 결과는 0.5다. 그래서 위처럼 나머지를 빼준 후에 나눗셈을 했다.
- `Math.floor(floatNum)`, `parseInt(floatNum)` 함수를 썼어야 했다. 소수점 자리를 '버림'해준다. 좀 더 깔끔하게 짤 수 있었다.
- 사실 `parseInt(str, rule)`는 문자열을 받아서 정수로 변환해주는 함수다. 두 번째 매개변수로 10, 8, 2 같은 진법 기준을 적용할 수도 있다. [outsider 블로그](https://blog.outsider.ne.kr/361)에 설명이 잘 나와있다.
- 마찬가지로 `parseFloat(str)`도 문자열을 받아서 실수로 변환해준다.

```js
parseInt("123.456");        // 123
parseInt("100mile");        // 100
parseInt("w25");               // NaN
parseInt("05");                  // 5
parseInt("09");                  // 0
parseInt("0x35");              // 53
parseInt("1101", 2);         // 13
parseInt("09", 10);            // 9
parseInt("10", 8);              // 8

parseFloat("123.456");       // 123.456
parseFloat("100.5mile");    // 100.5
parseFloat("w25");               // NaN
parseFloat("05");                  // 5
parseFloat("09");                  // 9
parseFloat("0x35");              // 0
```

# 2. 다른 해답

```js
function humanReadable(seconds) {
  var pad = function(x) { return (x < 10) ? "0"+x : x; }
  return pad(parseInt(seconds / (60*60))) + ":" +
         pad(parseInt(seconds / 60 % 60)) + ":" +
         pad(seconds % 60)
}
```

```js
function humanReadable(seconds) {
  return [seconds / 3600, seconds % 3600 / 60, seconds % 60].map(function(v) {
    v = Math.floor(v).toString();
    return v.length == 1 ? '0' + v : v;
  }).join(':');
}
```
