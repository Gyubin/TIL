# #9 Replace With Alphabet Position

매개변수로 받은 문자열에서 알파벳만 뽑아내서 숫자로 치환한다.

## 1. 내 코드

```js
function alphabetPosition(text) {
  text = text.toUpperCase().split('').filter(function(e) {
    return e.charCodeAt(0) >= 65 && e.charCodeAt(0) <= 90;
  });
  return text.map(function(e) {
    return e.charCodeAt(0) - 64
  }).join(' ');
}
```

- 우선 filter를 활용해서 알파벳만 골라냈다.
- map을 활용해서 알파벳을 아스키코드 값 - 64를 적용해서 순서를 나타내는 숫자로 바꿨다.
- 최종적으로 ' ' 공백을 기준으로 array의 원소들을 문자열로 연결시켰다.

## 2. 다른 해답

### A. 최고 득표

```js
function alphabetPosition(text) {
  var result = "";
  for (var i = 0; i < text.length; i++){
    var code = text.toUpperCase().charCodeAt(i)
    if (code > 64 && code < 91) result += (code - 64) + " ";
  }
  return result.slice(0, result.length-1);
}
```

- `charCodeAt(i)` 함수는 문자열에서 호출되어 i 인덱스가 가리키는 문자의 아스키코드를 리턴하는 함수다. 만약 아스키코드가 A-Z 중에 하나라면 결과 문자열에 그 숫자를 추가하고 뒤에 공백을 넣는다.
- 반복이 끝나면 마지막에 필요없는 공백이 하나 있으므로 `slice`를 활용하여 마지막 공백은 제외하고 리턴한다.

### B. 정규표현식

```js
let alphabetPosition = (text) => text.toUpperCase().replace(/[^A-Z]/g, '').split('').map(ch => ch.charCodeAt(0) - 64).join(' ');
```

- arrrow function 활용했다. A-Z가 아닌 것들은 모두 빈 문자열로 바꿔서 없애버렸다.
- split을 활용해서 리스트로 만들고 아스키코드로 만들어 join했다.
- 나는 filter를 썼지만 이 사람은 정규표현식을 활용했다. 이게 더 깔끔하다.
