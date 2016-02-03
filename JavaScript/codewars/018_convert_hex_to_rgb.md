# #18 Convert A Hex String To RGB

5급 짜리 문젠데 엄청 쉬운거 나왔다. `#124232` 같은 색을 나타내는 rgb 문자열을 받아서 r, g, b int 값을 가지는 객체로 리턴하는 문제다.

## 1. 내 코드

```js
function hexStringToRGB(hexString) {
  return {
    r : parseInt(hexString.slice(1, 3), 16),
    g : parseInt(hexString.slice(3, 5), 16),
    b : parseInt(hexString.slice(5), 16)
  }
}
```

단순하게 slice로 부분 부분 끊어서 16진수로 parseInt 썼다.

## 2. 다른 해답

가장 많이 나온 해답, 최고 득표 해답은 나와 같았고 아래와 같은 해답도 있었다.

```js
function hexStringToRGB(hexString) {
  var rgb = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hexString);
  return {
    r: parseInt(rgb[1], 16),
    g: parseInt(rgb[2], 16),
    b: parseInt(rgb[3], 16)
  };
}
```

- 정규표현식 활용했다. `#` 이후부터 탐색을 시작하고, `a-f` 그리고 `숫자`가 2개만 나오는 그룹을 세 개 찾았다. 마지막에 `$`을 넣어서 문장의 끝임을 명시했고, `i`로 대소문자 구분을 없앴다.
- `REGEX.exec(str)` : 정규표현식을 매개변수의 문자열에 적용시키는 함수다.
- 그래서 결과값을 하나씩 객체에 담아 리턴한다. rgb의 첫 번째 원소는 매칭된 전체 문자열이다. 그래서 인덱스가 1, 2, 3이다.
