# Canvas & SVG S65 2회차: svg 기초, 뷰 시스템

## 1. SVG

### A. viewBox

- SVG 요소를 표현할 가상의 좌표계
- min-x, min-y는 음수가 될 수도 있다.
- width, height는 음수 안됨

### B. vector shapes

- rect : x, y, width, height, rx, ry(round 표현)
- circle: cx, cy, r
- ellipse: cx, cy, rx, ry 타원형
- polygon: points
- path: d

관련 예제: [http://jsfiddle.net/oveRock/07fewwpt/1/](http://jsfiddle.net/oveRock/07fewwpt/1/) 뒷부분 16번까지 바꿔가면서 보기

- text: x, y, dx, dy, text-anchor = strt | middle | end | inherit
- image : x, y, width, height(안하면 안그려짐), xlink:href, preserveAspectRatio

관련 예제: [http://jsfiddle.net/oveRock/wqocobq0/0/](http://jsfiddle.net/oveRock/wqocobq0/0/) 뒷부분 3까지 바꿔가며 보기

```
<svg viewBox="0 0 95 50"
     xmlns="http://www.w3.org/2000/svg">
   <g stroke="green" fill="white" stroke-width="5">
     <circle cx="25" cy="25" r="15"/>
     <circle cx="40" cy="25" r="15"/>
     <circle cx="55" cy="25" r="15" stroke="red"/>
     <circle cx="70" cy="25" r="15"/>
   </g>
</svg>
```

- g : svg 그룹
- defs : 반복
- foreignObject: 

## 2. ES6

- 이제 js는 브라우저 벤더가 적용하든 안하든 연단위로 릴리즈한다. 이름도 ECMAScript2015다. 압박 주겠다는 의도다. 실제로 점점 적용하는데 걸리는 시간이 줄어들고 있다.
- ES5와 굉장히 많이 달라졌다. `var` 키워드는 레거시가 됐다. 만약 쓰게된다면 강제로 브라우저 컴파일러(?)가 ES5 모드로 에뮬레이터가 작동된다. 대신 let, const가 생겼다. 각각 변수와 상수다. const로 객체를 할당하더라도 내부의 값들은 변경 가능하다.
- no var, no hoisting, no scope(중괄호 나오면 let 발동), no overlap 등
- 변수 혹은 함수 호출이 스코프가 체이닝되면서 타고타고 올라갔는데 이젠 environoment recorder가 쓰인다고 한다. `for(let i = 0; i < 10; i++)` 예를 들어 왼쪽 같은 for문에서 원래라면 i가 바뀌는 것이 바뀔 때마다 모든 그 때의 this(기억이 맞나)가 바뀌면서 저장이 되는데 environment recorder에서는 그 i 값만 바꾸게 된다.
- 아래는 새롭게 바뀐 예시들이다. 문법을 찬찬히 정리해야겠다.

    ```js
    let a = 0;
    let b = {
      ['k'+(a++)]:5,
      ['k'+(a++)]:3
    };

    b.k0 == 3
    b.k1 == 5;

    obj[Symbol.for('com.a.method1')](1,3);


    let obj = {
      [Symbol.iterator]() {
        return [1, 2, 3];
      }
    };
    for(let v of obj) console.log(v);


    let a = {
      method(a, b){}
      get field() {}
      set field(v) {}
    };

    var a = {
      method:function method(a, b){}
    }
    Object.defineProperty(a, 'field', {get:function(){}})

    let obj = {
      [Symbol.iterator() ]
    };
    ```

- 덕타입: 니가 만약 어떤 메소드가 있다면 무엇으로 인정할게. run 메소드 가지고 있으면 달리기 선수로 인정해줄게. Symbol.iterator를 인정한다면 이터레이터로 인정해줄게가 된다.
- 배열은 ES6부터 무조건 iterator. 

```js
# function 쓰지마라. ES6부터.
let f1 = () => 3;
let f1 = function(){return 3;}
let f2 = (a, b) => a + b;
let f2 = function(a, b){return a+b;}

let f1 = (a, b) => {
  let c = a+b *2;
  return c;
}

let f1 = (a,b) => {
  return a + b + this.a;
};
// arrow는 function과 동치가 아니다. 경량화.
// arrow에서 this는 정적바인딩. 훨씬 빨라졌다. 클래스 목적이 아니라 함수 목적이라면 무조건 arrow를 써야 한다. 함수가 만들어진 시점이 this
// arrow는 기본적으로 return을 포함하게 되었다.
```

- class에서 get, set 사용 가능

```js
class Test extends Parent{
    constructor(){super()}
    get field(){super.field}
    set field(v){super.field}
    static util(){super.util()}
    method(){super.method()}
    generator(){yield 1}
}
```

## 3. View System

step1 - Geometry

그림을 그릴 때 먼저 영역을 잡는 행위.

reflow : html 엔진이 엘리먼트의 관련을 계산해서 수치적으로 그려주는 행위

객체 정보 누가 위에가고 아래에 가고 등등 이걸 계산해서 청사진을 그리는 행위가 geometry다. 일단 자리를 잡아야 칠할거니까.

이 모든 관계는 오프셋이라 표현한다. 자기를 감싸는 부모로부터 얼마나 떨어져있는가. 무엇 기준으로부터 얼마나 멀어져있는지가 오프셋. 지오메트리는 자기의 부모로부터 얼마나 떨어져있고, 자기의 기준으로부터 얼마나 그려야하는지. 부모 레벨에서 자식 그려주면 되는 것.

width, height는 부모가 아니라 자식이 알려준 것. 자식은 내 크기가 얼마라고 알려줌. 그리고 부모가 듣고 오프셋 얼마고 어떤 크기로 그려라! 알려줌.

html elements coordinates
div.offsetParent = body element
부모보다 자식이 더 크면 스크롤 개념이 생기는 것.

오프셋 하려면 자식과 부모가 통신해야함. 자식이 내 크기가 얼만지 알려줘야함. 자식이 자기 크기 결정할 때 부모의 크기를 참조해야 한다.

부모 크기랑 똑같애. = inherit

앱솔루트가 포지션이면 부모 계속 타고 올라가다가 앱솔루트 만나면 그놈이 부모다.

step2 Fragment

채우기.

```
class stage {
    constructor() {
        this.width this.height, this.root = Container;
    }
    render() {
        this.root.measure(this.width, this.height);
        this.root.fragment();
    }
}
```

뷰 시스템은 composite pattern으로 되어있다. 

부모로부터 자식을 그려가는 과정 capturing.

그 다음이 bubling
