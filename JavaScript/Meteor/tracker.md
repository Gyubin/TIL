# Meteor Tracker

참고 링크: [매뉴얼](https://github.com/meteor/docs/blob/version-NEXT/long-form/tracker-manual.md), [공식문서](https://docs.meteor.com/api/tracker.html)

어떤 값을 모니터링하다가 값이 변할 때 특정 행동을 취할 수 있게 하는 라이브러리다.

## 1. 일반적인 해결 수단

- `Poll and diff`: 얼마나 자주 확인할 것인지. 예를 들어 초단위. -> 렉 걸린다(laggy)
- `Events`: 값이 변할 때 발생하는 이벤트를 컨트롤러가 감지하고 작업 실행하는 것 -> 구조를 깔끔하게 짜기 어렵고, 값을 변화시키는 UI 마다 코드를 넣어야 하는 등 작업이 복잡하다.
- `Bindings`: Object 형태로 모니터링하는 값과 작업이 적용될 값이 바인딩된다. 한 값이 변할 때, 다른 값이 자동으로 변하게된다.

## 2. Tracker의 방법

기본적으로 Reactive Programming이다. spread sheets에서 특정 값들을 감지해서 sum 등의 함수를 사용하는 개념과 비슷한데 기존 것보다 더 가볍고, 단순하고, 빠르게 만들었다고 한다.

### 2.1 값 세팅

```js
var favoriteFood = "apples";
var favoriteFoodDep = new Tracker.Dependency;

var getFavoriteFood = function () {
  favoriteFoodDep.depend();
  return favoriteFood;
};

var setFavoriteFood = function (newValue) {
  favoriteFood = newValue;
  favoriteFoodDep.changed();
};

getFavoriteFood(); // "apples"
```

`get` 할 때는 `depend`를 호출해주고, `set` 할 때는 `changed`를 호출하면 된다.

### 2.2 작업 설정

```js
var handle = Tracker.autorun(function () {
  console.log("Your favorite food is " + getFavoriteFood());
});

setFavoriteFood("mangoes"); // "Your favorite food is mangoes"
setFavoriteFood("peaches"); // "Your favorite food is peaches"
handle.stop();
setFavoriteFood("cake"); // (nothing printed)
```

- `Tracker.autorun(func)`: 모니터링하는 값이 변하면 func가 바로 호출된다.
- `stop` 함수로 모니터링을 중지할 수 있다.

### 2.3 다양한 작업에 이용

```js
var getReversedFood = function () {
  return getFavoriteFood().split("").reverse().join("");
};
getReversedFood(); // "ekac"

var handle = Tracker.autorun(function () {
  console.log("Your favorite food is " + getReversedFood() + " when reversed");
}); // Your favorite food is ekac when reversed

setFavoriteFood("pizza"); // Your favorite food is azzip when reversed
```

- `depend`, `changed` 함수는 각각 모니터링하는 값을 바로 사용하는 getter, setter에만 쓰면 된다.
- 다른 작업을 하려면 위 코드처럼 getter, setter를 사용하는 다른 함수를 만들고, 새로 만든 함수를 `autorun`에 등록해주면 된다.
