# #14 Largest 5 digit number in a series

문자열 타입의 숫자를 받아서 5자리의 연속된 수 중 가장 큰 수를 리턴하는 문제.

## 1. 내 코드

```js
function solution(digits){
  var result = 0;
  for (var i = 0; i < digits.length-4; i++) {
    var temp = digits.slice(i, i+5) * 1;
    result = result >= temp ? result : temp;
  }
  return result;
}
```

- for 반복을 돌아서 모든 substring을 구해서 이전 값과 큰지, 다른지 판단하고 마지막에 리턴했다.

## 2. 다른 해답

```js
function solution(digits){
  if (digits.length <= 5) return Number(digits);
  return Math.max(Number(digits.substr(0, 5)), solution(digits.substr(1)));
}
```

- 재귀 사용.
- `String.prototype.substr(start, end)` : substring을 만드는 함수다. 뒤에 end 수를 입력하지 않으면 자동으로 끝까지 자른다.
