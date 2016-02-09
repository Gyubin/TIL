# #23 Bit Calculator

(parseInt 메소드를 쓰지 않고)두 개의 문자열 이진수를 10진법으로 변환하고 더한 결과를 리턴하는 문제다.

## 1. 내 코드

```js
function calculate(num1,num2){
  function convert(p, c, i) {
    return p + c * Math.pow(2, i);
  }
  var result1 = num1.split('').reverse().reduce(convert, 0);
  var result2 = num2.split('').reverse().reduce(convert, 0);
  return result1 + result2;
}
```

- 내부에 이진수를 10진수로 바꾸는 함수를 만들었다. reduce의 콜백 함수를 만들거라서 매개변수를 p, c, i를 주었다. 순서대로 이전 값, 현재값, 현재값의 인덱스이다.
- num1, num2가 문자열이므로 split, reverse, reduce 함수를 조합해서 바로 결과를 구했고 더해서 리턴했다.
- 다른 해답은 for 문으로 이진수 변환하는 단순한 코드라서 따로 적지 않았다.
