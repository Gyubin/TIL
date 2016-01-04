# #5 Descending Order

숫자를 입력받아서 숫자들을 역순으로 재배치해서 리턴한다.

## 1. 내 코드

```js
function descendingOrder(n){
  return n.toString().split('').sort().reverse().join('') * 1;
}
```

다 이전 문제에서 설명했던 함수들이다. 특별한 건 문자열을 숫자로 바꿀 때 `*1`을 해주면 된다는 것. 숫자를 문자열로 바꿀 때 `+ ''`를 하는 것과 비슷

## 2. 다른 해답

- 다른 답들도 똑같은 형태를 취했다. 다만 사용한 함수가 조금 달랐다.
- `reverse` 대신 `sort` 매개변수로 함수 지정 `sort(function(a,b){b-a})`
- `*1` 대신 `parseInt()` 사용. 비슷한걸로 `parseFloat`도 있다.
