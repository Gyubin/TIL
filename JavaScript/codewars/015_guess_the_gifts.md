# #15 Guess the gifts!

wishlist array에는 name, size, clatters, weight 키를 가진 object들이 여러개 들어있고 presents array에는 wishlist의 object에서 name 키가 없는 object들이 들어있다. presents array의 object가 무엇인지 맞추는 함수다.

## 1. 내 코드

```js
function guessGifts(wishlist, presents) {
  var result = [];
  wishlist.forEach(function(eWish) {
    presents.forEach(function(ePre) {
      if (eWish['size'] === ePre['size'] &&
          eWish['clatters'] === ePre['clatters'] &&
          eWish['weight'] === ePre['weight'])
        if (!result.contains(eWish['name']))
          result.push(eWish['name']);
    });
  });
  return result;
}

Array.prototype.contains = function(obj) {
    var i = this.length;
    while (i--)
        if (this[i] === obj)
            return true;
    return false;
}
```

- 내 코드는 왜 이렇게 긴가.
- wishlist의 원소를 하나하나 돌고, 그 원소마다 presents 리스트에 있는 원소인지를 확인해서 맞으면 result에 넣었다.
- 확인 조건은 size, clatters, weight 값이 똑같아야 하는 것. 그리고 중복 방지를 위해 contains 함수를 새로 만들어서 result array에 있는지 없는지 확인했다.

## 2. 다른 해답

```js
function guessGifts(wishlist, presents) {
  return wishlist.filter(function(x){
    return presents.some(function(y){
      return x.size == y.size && x.clatters == y.clatters && x.weight == y.weight;
    });
  }).map(function(x){ return x.name; });
}
```

- 원리는 내 코드와 같지만 `filter`와 `some` 함수를 통해 코드를 간결하게 했다. 자주 이 함수들 써서 익숙해져야겠다. 그래야 문제를 보면 바로 생각이 난다. 이 함수를 쓸 생각도 못했다.
- filter를 써서 조건에 맞는 object를 골라내고, map으로 이름만 뽑아 리턴했다.
- 사이에 조건은 나와 같고 some 함수로 중복을 제거했다. presents array에서 하나라도 조건을 만족하는게 있으면 true를 리턴하기 때문에 자연스럽게 중복이 제거된다. `==` 대신 `===` 를 쓰는게 더 나았을 것 같다.
