# #31 Object extend

매개변수로 입력받은 모든 값 중 Object만 뽑아서 합친다. property name이 겹치면 먼저 넣어진 매개변수 Object의 property 값을 선택하면 된다. 문제에서 `isObject` 함수를 정의해서 쓰게 해줬다.

## 1. 내 코드

```js
var extend = function() {
  if (arguments.length === 0) return {}
  var result = {};
  for (var i = 0; i < arguments.length; i++) {
    var target = arguments[i];
    if (!isObject(target)) continue;
    for (var j in target) {
      if (!(j in result)) { result[j] = target[j]; } // 이 부분.
    }
  }
  return result;
}
```

문제는 단순한데 생각치 못한 곳에서 버그가 있었다. 위 코드에 '이 부분'이라고 표시해둔 곳에 조건 부분이다. `if(!(j in result))` 이렇게 `in` 을 쓰려면 전체를 괄호로 감싸줘야한다. 괄호 없이 `if(!j in result)` 이렇게 쓰면 `!j` 값이 조건절의 값으로 들어가기 때문에 매 번 false가 나올 수 밖에 없다. result object에 계속 값이 안들어가서 확인해보니 저 부분이 문제였다.

## 2. 다른 해답

```js
var extend = function() {
  var combined = {};
  Array.prototype.slice.call(arguments).filter(isObject).reduceRight(function(i,obj){
    Object.keys(obj).forEach(function(k){combined[k] = obj[k]})
  },null);
  return combined;
}
```

- 나와 원리 자체는 같은데 `filter` 함수로 `isObject`를 쓴 점,
- 역방향 reduce인 `reduceRight` 함수를 써서 단순히 순서대로 대입하면 알아서 첫 객체의 property 값이 최종 선택된다는 점이 다르다.
