# #30 Math Issues

Math 모듈에서 올림, 내림, 반올림 함수를 각각 구현하는 것.

## 1. 내 코드

```js
Math.hasNoDot = function(number) {
  var re = /[.]/;
  if (!re.exec(String(number))) return true;
  return false;
}

Math.round = function(number) {
  if (Math.hasNoDot(number)) return number;
  var re = /[.](\d)/;  
  return Number(re.exec(String(number))[1]) >= 5 ? Math.ceil(number) : Math.floor(number);
};

Math.ceil = function(number) {
  if (Math.hasNoDot(number)) return number;
  var re = /(\d+)[.]/;
  return Number(re.exec(String(number))[1]) + 1;
};

Math.floor = function(number) {
  if (Math.hasNoDot(number)) return number;
  var re = /(\d+)[.]/;
  return Number(re.exec(String(number))[1]);
};
```

- 정규표현식을 활용했다.
- `.`이 있는지 없는지에 따라 다르기 때문에 점이 있는지 확인하는 함수 `hasNoDot`을 만들었다. `.`이 없으면 true를 리턴한다. 각 함수마다 맨 앞에서 호출되고 `.`이 없다면 숫자를 바로 리턴한다.
- 자연수가 아니라면
    + `ceil`, `floor` : 올림과 내림이기 때문에 `.` 바로 앞 숫자를 뽑아서 활용한다. 올림이면 뽑은 수에 1을 더하고, 내림이면 그대로 둬서 리턴한다.
    + `round` : `.` 바로 뒤에 있는 숫자가 5보다 크면 ceil 함수를 호출하고, 작으면 floor 함수를 호출한다.

## 2. 다른 해답

```js
Math.round = function(number) {
  return (number - parseInt(number) >= 0.5) ? parseInt(number) + 1 : parseInt(number) ;
};

Math.ceil = function(number) {
  return (parseInt(number) === number) ? number : parseInt(number) + 1;
};

Math.floor = function(number) {
  return parseInt(number);
};
```

`parseInt` 함수로 굉장히 쉽게 해결했다. 굳이 나처럼 정규표현식 쓸 필요가 없었다.
