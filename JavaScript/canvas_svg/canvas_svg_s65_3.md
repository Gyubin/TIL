# Canvas & SVG S65 3회차

## 1. svg

- path data
    + M
    + Z
    + LHV
    + Cubic Bezier curveto
    + Bezier
    + ?
- command case
    + uppercase: absolute coordinates
    + lowercase: relative coordinates
- Bezier curve
    + publicized by Pierre Bezier
    + applied in
        * computer graphics
        * animation
        * fonts

## 2. ES6

- destructing. 해체식. 좌변엔 무조건 식별자만 있어야 하는데 식이 오게 됨.

```js
let [a, b] = [10, 20];
arr = [1, 2];
a = arr[0], b = arr[1];
[a, b] = arr

let [a=3, b] = [1, 2, 3];
let [a,,b] = [1, 2, 3];
```

```js
let {a:c, b:d} = {a:1, b:2};
let {a:c, b:d} = {a,b}
let {c, d } = {c:a, d:b};
let {a:c, d=3} = {a,b};
({c, d} = {c:a, d:b});

obj = {a:1, b:2};

let c = obj.a
let d = obj.b

let {a:c, b:d} = obj;
```

콜론 앞이 키, 뒤가 변수 이름.

이제 역따옴표가 escape 문자열이 됨. 이 안에 모든걸 기술할 수 있다. 마크다운 문법인거네. 그리고 ${} 안에 표현식을 쓸 수 있다. 값이기만 하면. 일종의 eval

자바스크립트에는 값이라는 개념. 하나로 떨어지는 것. 반대로 문이라는 개념도 있음. if 문. 할당할 수 있는건 값. ${} 안에는 값으로 떨어지면 다 됨. expression은 안된다.

```
let a = [1, 2, 3];
let b = {a:1, b:3};
let c = `000${a}
111${b.a + b.b}
222`;

console.log(c);
```

```
let a = `${[1, 2, 3]}` // "1, 2, 3"
```

```
let a = `${(() => 3))()}`;
```

```
let tag = [str, ...ex] => str.reduce(
    (prev, curr, idx) => prev + curr + (ex[idx]?ex[idx].toString():''), ''
    );
```

```
let a = 'abcabc';
a.replace(/(a|b)c(a)/g, function(v0, v1, v2){
    return '';
    });
```

```
console.log(tag`1111
${1}
22
${2}
`);

let tag = (stringArray, ...values) => 'aaa';
```

```js
let tag = (str, ...ex) => (ex.forEach((v) => console.log(v)), 'aa');
```
