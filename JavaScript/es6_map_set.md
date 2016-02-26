# ECMAScript6 Map, Set, WeakMap, WeakSet

ES6에서 새롭게 생긴 4가지 자료구조다.

## 1. Maps

Map의 key는 임의의 값이 될 수 있다.

```js
const map = new Map(); // create an empty Map
const KEY = {};

map.set(KEY, 123);
map.get(KEY) // 123
map.has(KEY) // true
map.delete(KEY); // true
map.has(KEY) // false
```

Map을 선언할 때는 아래처럼 생성자 안에 [key, value] pair로 여러개를 집어넣을 수 있다. 이차원 배열 형태다.

```js
const map = new Map([
    [ 1, 'one' ],
    [ 2, 'two' ],
    [ 3, 'three' ], // trailing comma is ignored
]);
```

## 2. Sets

unique한 값들의 집합이다. 생성자의 매개변수로는 무조건 iterable을 넣어야 한다. 원소를 여러개 넣는건 안된다. 세 번째 코드는 `...`을 사용해서 새롭게 만들어진 Set을 배열의 원소로 바로 넣었다. `...` 용법은 다시 정리하겠다.

```js
const arr = [5, 1, 5, 7, 7, 5];
const arr_set = new Set(arr);
const unique = [...new Set(arr)]; // [ 5, 1, 7 ]
```
