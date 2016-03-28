# Canvas & SVG S65 4회차

## 1. ..

자바스크립트의 배열은 링크드리스트다. (자료구조는 두 개. 정적, 링크드리스트)

arraybuffer? 이건 정적 배열.

linkedHashMap. 키로도 돌릴 수 있지만. 마치 2차원 value처럼. 키로도 부를 수 있을 뿐. 순서 보장 안한다고 하는데 실제로는 보장되는듯.

es6에서는 더이상 arguments 쓰지 않기를 원한다. 

```js
function a(a,b) {
    a = 3;
    arguments[0] = 5;
    console.log(a);
}

function (a, b, ...arg, c) {
    a = 3;
    arg[0] = 5;
}
```

rest는 마지막에만 쓸 수 있고, 한 함수에 하나만 쓸 수 있다. 

...이 대괄호 안에 들어오면 spread, 함수에 들어가면 rest
객체를 펼치면 어떻게 될까? 다 망한다고 그럼. 확인해볼것

```js
style($(id)[0], ...a);
style($(id)[0], [~, ~], [~, ~])
```

모든 리스너, 이벤트 다 사라진다. promise를 전달하는 방식이 될 것임.

내부에 execution thread가 있다. 계속 무한 루프. 실행할 코드가 있으면 실행하고 아니면 넘어가고. 이번 큐에. 코드 안에 setTimeout같은거 걸면 3초 후 큐에 넣는 것. 클릭을 하면 클릭한 순간 다음 프레임에 실행기 큐에 넣는 것. 슬라이드 사각형들. frame이라고 부른다. 실행 코드를 진행하는 단위. 더 정확하게는 동기화 명령이 진행되는 단위.

우리가 넣은 코드는 위에서 아래로 한 방에 시장됨. 셋타임아웃, 이벤트 넣어놓은 코드가 아닌 모든 코드들이 프레임 단위다. 한 번에 실행될 모든 코드. 애초에 자바스크립트는 싱글 스레드. 저런식으로 돌아간다.
한 프레임이 실해되면 렌더링도 하나씩 걸려있다. js 실행, 렌더링, js실행, 렌더링 이런식으로 계속 반복됨. 렌더링하고 실행하고 렌더링하고 실행하고. 그래서 렌더링 빨리 하려면 js 코드가 가벼워야 한다.
각 프레임은 큐임.

```js
let i = 100;

while(i--) {
    requestAnimationFrame(() => ...);x
}
```

지금까지 설명한걸로 프로미스를 이해해보자.

```js
// console. 직고 뒤에꺼가 리턴됨. Promise 연달아 쭉 쓸 수 있다.
let a = new Promise((resolve, reject) => setTimeout(resolve, 200))
    .then(() => (console.log('complite'), new Promise(
        (resolve, reject) => setTimeout(resolve, 200)
    )))
    .then(() => console.log('complete2'))

a = 1, 2; // 이러면 2다.
```
성공했을 때 호출하는 resolve, 실패하면 reject
resolve라면 then의 함수가 작동한다.

```js
let c = new Promise(ok => $(id).click(ok)).then(v => console.log(v))
el.click.then()// 뭐 이런 식으로 될거라는

let b = new Promise(ok => ok(3)).then(v => console.log(v))
```

setTimeout setRequestFrame, set~interval, event 이것만 가능했었음.

job Queue. inner slot. 순서가 프레임 순으로 1 3 2 이런게 아니다. 1 2 3. 대신 잡 큐 생김.

```js
let a = Promise.resolve(3)
```

즉발 프로미스. 

어레이버퍼. 바이트어레이. 이거 사용하면 모든걸 끊어버릴 수 있다. APNG라고 animation png 할 수도 있고, mp3 파일 받아서 1분가지만 재생하는거 리턴할 수도 있고 뭐.

Map은 키에 객체 넣을 수 없다. 그냥 문자열로 바뀌어서 들어감.

위크맵은 가능. gc 때문에 키를 죽일 수도 있고 아니면 느려진다.

맵과 우크맵은 용도가 틀리다. 맵은 키로 찾는 편리함, 반복 돌리는 편리함 때문에 쓰는거고 위크맵은 객체를 키로 쓰기 위해.

```js
let a = {
    111: true,
    222: true,
    333: true
}
if(a[학번]) return;
a[학번] = true;
// 문자열만 넣을 수 있다.

// 다 넣을 수 있다.
let b = new Set();
b.add(111);
b.add('abc');
b.add(() => ...);
b.add({a:3});

if(b.has(target)) {}
```
DOM에서 원래 이벤트리스너 동일한데 걸면 중복으로 안걸린다. 원래 있던걸 밖으로 빼냄.

```js
let classA;
{
    let privateVar = new WeakMap();
    classA = class {
        constructor(v) {
            privateVar[this] = {v};
        }
        get v() { return privateVar[this].v; } 
    }
}
let a = new ClassA(3);
a.v // 3
// a를 뒤져봐도 3이란 값을 찾을 순 없다.
// 객체에서 아예 값을 사라지게 하는 private pattern이 위의 것과 같다.
```

template 안에 template 가능. react 유리. 원래 다른 스크립트 불러와서 했었는데 이제 템플릿 쓰면 가능해짐.

차크라 엔진

여기서 a 값은 무얼까. 예전엔 이랬다.
```js
function a(a,b) {
    a = 3;
    arguments[0] = 5;
    console.log(a);
}
```

```js
let a = new Map();
a.set('width', '100px');
a.set('height', '200px');

for (let v of a) console.log(v);
// Array [ "width", "100px" ]
// Array [ "height", "200px" ]

let c = [...a];
c[1]
// Array [ "height", "200px" ]
```
