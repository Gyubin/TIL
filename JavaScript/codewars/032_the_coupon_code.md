# #32 The Coupon Code

쿠폰이 올바른지 아닌지를 체크하는 문제다. 코드가 일치하는지 확인하고, 만료일보다 이전인지 확인하면 된다.

## 1. 코드

```js
function checkCoupon(enteredCode, correctCode, currentDate, expirationDate){
  return enteredCode === correctCode && Date.parse(expirationDate) >= Date.parse(currentDate)
}
```

- 쿠폰 코드는 단순히 `===`를 써서 같은지 확인한다.
- 날짜는 찾아보니 `Date.parse(dateString)` 함수가 있었다. 날짜 형태의 문자열을 매개변수로 넣으면 Date 객체를 만들어낸다. 만들어진 객체는 부등호 연산이 가능하다.
- 다른 해답을 보니 그냥 `new Date(datestring)` 형태로 객체를 생성해서 비교할 수도 있었다.
