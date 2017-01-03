# Promise

비동기 프로그래밍을 위한 콜백이 아닌 새로운 패턴이다. Promise를 지원하는 함수에서 해당 함수가 성공, 실패했을 때 어떻게 할지 정의해놓는다. 기존 콜백 함수에서처럼 자유로운게 아니라 같은 방식으로 통일된다.

## 1. API

### 1.1 Constructor

```js
var promise = new Promise(function(resolve, reject) {
  // 작업 코드. 작업이 끝나면 resolve 또는 reject를 호출
});
```

### 1.2 Instance Method

```js
promise.then(onFulfilled, onRejected)
```

성공했을 때는 `onFulfilled`, 실패하면 `onRejected`가 호출된다.

### 1.3 Static Method

`Promise.all()`, `Promise.resolve()` 처럼 호출할 수 있는 정적 메소드가 존재.
