# Promise

비동기 프로그래밍을 위한 콜백이 아닌 새로운 패턴이다. Promise를 지원하는 함수에서 해당 함수가 성공, 실패했을 때 어떻게 할지 정의해놓는다. 기존 콜백 함수에서처럼 자유로운게 아니라 같은 방식으로 통일된다.

## 1. API

- Constructor: 프로미스를 지원하는 함수를 만드는 방법이다.

    ```js
    var promise = new Promise(function(resolve, reject) {
      // 작업 코드. 작업이 끝나면 resolve 또는 reject를 호출
    });
    ```

- Instance Method: 성공 또는 실패했을 때 호출되는 `then` 메소드
    + 매개변수는 optional이다.
    + 오류 처리만 하려면 아래 코드의 2, 3번째처럼 하면 된다. 같은 의미다.

    ```js
    promise.then(onFulfilled, onRejected)

    promise.then(undefined, onRejected)
    promise.catch(onRejected)
    ```

- Static Method: `Promise.all()`, `Promise.resolve()` 등 존재

## 2. 예제

```js
function asyncFunction() {
  return new Promise(function (resolve, reject) {
    setTimeout(function () {
      resolve('Async Hello world');
    }, 2000);
  });
}

asyncFunction().then(function (value) {
  console.log(value); // 'Async Hello world'
}).catch(function (error) {
  console.log(error);
});
```

- `asyncFunction`: Promise 객체를 생성해서 리턴하는 함수.
- 2000ms 이후 성공했을 때의 함수를 호출하게된다. 문자열 매개변수를 넣어서.
- `then`으로 성공했을 때의 함수를 정의하고, `catch`로 에러가 났을 때의 작업을 정의한다.
