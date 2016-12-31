# ECMAScript6 기초 정리

BSIDESOFT 스터디에서 ES6를 주로 사용한다. 이전 버전과 많은 부분이 달라져서 어차피 올 흐름이기도 하고 제대로 공부해보기로 했다. 그러다가 ES6를 깊게 파보는 연구스터디가 있어서 참여했다. 아직 너무도 아는게 없는 초보지만 최대한 폐가 되지 않게 열심히 따라가보려 한다. 우선은 기초 정리다.

## 0. 기본

- 엔진이 업그레이드 되었다. 하지만 아직 옛날 코드들이 대부분이니 어쩔 수 없이 ES5 엔진을 포함한 superset이 되었다. ES5의 것들 중 삭제된 것은 아무것도 없다.

## 1. 문법

### 1.1 let

- scope
    + `var`는 안쓰는게 좋다. 만약 쓴다면 ES5 에뮬레이터가 실행되기 때문에 ES6를 제대로 사용하고싶다면 `let`을 쓰자.
    + `var`는 함수 스코프 변수라서 오직 function의 블록 내에서만 지역변수처럼 작동한다. 즉 if, for, while 등의 `{ }` 블록 안에서 선언하면 블록 바깥에서도 사용 가능하다. 이렇게 블록 안에서 var로 선언한 것을 가장 바깥의 scope로 이동시켜 선언하는 것을 `hoisting`이라고 한다.
    + `let`은 모든 블락에서 지역변수처럼 작용하게 한다. 즉 함수 스코프 변수가 아니라 블록 스코프 변수다. if의 블락에서도 내에서 선언하면 조건절이 끝났을 때 변수는 사라진다.
- declaration
    + `var`는 재선언하면 덮어쓴다. 즉 `var a = 1`을 한 후에 또 다시 `var a = 10` 이런식으로 호출할 수 있다. 에러 안난다.
    + `let`은 위처럼 못쓴다. 덮어쓰려고 하면 TypeError 발생한다. `let a = 1`을 한 후엔 앞에 let을 빼고 `a = 10` 이런 식으로만 가능하다.

### 1.2 const

- 예전엔 상수 개념이 없었다. 그냥 변수 이름을 const_something 같이 표시해주는 정도였고 실제 상수 기능은 없었다. ES6부터 `const` 키워드로 상수 선언 가능해졌다.
- 역시 let처럼 block scope로 작동한다.
- 변수에 객체를 할당한다는 의미는 객체의 참조값을 변수가 가진다는 의미다. 즉 const를 쓰면 그 참조값이 고정된다. 변수가 가지는 참조값은 변할 수 없지만 참조값의 객체는 변할 수 있다.

### 1.3 parameter default value

- ES5에서는 기본값 지정할 수 있는 기능이 따로 없었다. 그래서 매개변수의 기본값을 지정하려면 함수 내부에서 '만약 매개변수가 undefined라면 특정 값을 대입'하는 코드가 들어갔다. ES6에선 다른 언어들과 마찬가지로 함수를 선언할 때 `func(a=1, b=2)` 처럼 기본값을 지정할 수 있다.
- 만약 방금 전 코드에서 `func(10)`처럼 하나만 지정해주면 첫 번째 매개변수 a에 10이 들어간다. b는 디폴트값인 2가 들어간다. 만약 a는 디폴트값으로 주고 b에만 값을 지정해주고싶으면 `func(undefined, 20)`같이 undefined를 이용한다. 그런데 이런식으로 `func(b=20)` 매개변수를 특정해서 값을 넣을 수는 없다. 이럴 땐 b 값으로 들어가는게 아니라 a에 20이 들어가는 거고, b라는 전역변수가 생긴다. 함수 스코프 변수도 아니고 블록 스코프 변수도 아닌 전역변수다.
- 함수를 선언할 때 매개변수에 표현식을 넣을 수도 있다.

### 1.4 `...` spread operator(펼침 연산자)

- 매개변수로 넣을 때 활용: iterable 앞에 붙어서 속한 원소들을 풀어놓는다. 어떤 함수의 매개변수가 array를 받는게 아니라 개별 값을 받는 형태라면 예전엔 apply를 썼어야했다. 이젠 매개변수에 `...my_arr`을 넣어주면 알아서 풀어헤쳐져서 매개변수로 들어간다. 내부 처리가 apply를 호출하는 형태는 아니다.
- 배열 연결 및 추가: 펼침 연산자를 통해서 배열을 연결할 수 있다. 배열 내에 펼침연산자를 쓴 배열을 원소처럼 넣으면 자연스럽게 원소들이 쭉 나열된다. 아래처럼 깔끔하게 연결이 가능하다.

    ```js
    let arr1 = [1];
    let arr2 = [2, 3, 4];
    // Array.prototype.push.apply(arr1, arr2); // 예전 코드
    arr1.push(...arr2);
    ```

- 당연하게도 펼침 연산자가 적용된 배열을 `,`로 여러개 연결시킬 수도 있다.

### 1.5 `...` rest parameter

- spread operator와 형태는 같지만 다르다. 함수를 선언할 때 매개변수로 몇 개 값을 받을지 모를 때 `...`을 쓴다. 즉 가변적인 함수 인자일 때 사용한다.
- 매개변수 앞에 `...`을 붙이면 되고, 붙여진 매개변수는 무조건 맨 마지막에 써야하고, 한 함수 당 한 번만 쓰일 수 있다.
- 예전엔 매개변수로 들어온 모든 값을 갖고 있는 `arguments` 객체를 썼다. 이젠 `...`을 붙인 매개변수, 즉 배열 객체를 사용하면 된다.

### 1.6 destructing

- 하나의 '문'으로 여러 변수의 값을 대입할 수 있는 방식이다.
- 배열 해체 할당 예제
    + 배열 원소가 더 많이 들어오면 뒷부분은 무시된다.
    + 건너뛰어야 할 때는 콤마로 빈 부분을 표현해주면 된다.
    + 여러 원소를 배열로 받을 때는 rest parameter를 쓰면 된다.
    + 역시 기본값을 지정해줄 수 있다.
    + 중첩 배열도 똑같이 모양만 맞춰주면 변수에 값 할당이 가능하고, 함수의 파라미터를 배열로 두면 역시 매개변수로 들어온 배열의 값 하나하나를 특정해서 사용할 수 있다. 배열의 기본값을 둘 수 있는 것도 마찬가지다.

    ```js
    let myArray = [1, 2, 3];
    let a, b, c;
    [a, b, c] = myArray; // 해체 표현식

    // 더 짧게 하면 다음처럼
    let [a, b, c] = [1, 2, 3];

    // 넘겨야 할 때
    let [a, , c] = [1, 2, 3];

    // 여러 값. b는 2~6 값이 들어가있는 array
    let [a, ...b] = [1, 2, 3, 4, 5, 6];
    console.log(Array.isArray(b));

    // 기본값 지정
    let [a, b, c = 3] = [1, 2];

    // 중첩배열과 함수 예제
    let [a, b, [c, d]] = [1, 2, [3, 4]];

    // 배열을 매개변수로 받는데 배열 내에서 기본값 할당.
    function myFunction([a, b, c=3]){
        console.log(a, b, c);
    }

    // 배열 매개변수에 기본값 할당
    function myFunction([a, b, c=3] = [1, 2, 3]) {
        console.log(a, b,c);
    }
    ```

- 객체 해체 할당 예제다.
    + 전체를 괄호로 감싸고, 대입할 변수들을 중괄호 `{ }`로 묶어서 객체를 대입하면 각 변수에 객체의 value가 들어간다.
    + 객체 property 이름과 variable 이름이 같을 때는 대입될 변수를 그냥 중괄호에 넣어주면 된다.
    + 이름이 다르면 객체 형태와 똑같이 적어주되 value 부분에 변수를 적어주면 된다. 자연스럽게 매칭되어서 변수에 값이 대입된다.
    + 한 줄로 적어준다면 전체를 괄호로 감싸줄 필요가 없다.
    + 역시 배열에서처럼 중괄호로 감싸진 변수들에 기본값을 줄 수 있다.
    + 객체의 property name을 동적으로 표현할 수 있는데 `[ ]` 대괄호로 감싸줘야 한다.
    + 함수의 파라미터로 객체를 사용할 수 있으며 기본값 할당도 가능하다.

    ```js
    let object = {"name" : "민호", "age" : 23};

    // 같은 이름일 때
    let name, age;
    ({name, age} = object);

    // 다른 이름일 때
    let x, y;
    ({name: x, age: y} = object);

    // 가장 짧게 한 줄로
    let {name:x, age:y} = {"name":"민호", "age":23};

    // 기본값 할당
    let {a, b, c = 3} = {a:1, b:2}

    // property name 동적 할당
    let {['first'+'Name']: x} = {firstName: "안녕"}

    // 중첩 객체
    let {name, otherInfo : {age}} = {name : "수지", otherInfo: {age: 23}};

    // 함수 파라미터로 사용
    function myFunction ({name = "수지", age = 23, profession = "연예인"} = {}) {
        console.log(name, age, profession);)  
    }
    myFunction({name:"민호", age:23});
    ```

### 1.7 Arrow Function

- 함수를 선언할 때 쓰는 간결한 표현이고, anonymous function을 선언할 때도 쓰인다.
- 기본형: `(a, b, c) => { code something }` 과 같은 형태다. 괄호 안에 매개변수를 넣고, arrow를 쓴 다음, 중괄호에 함수 내용을 쓴다.
- 함수 내용이 한 줄이면 `{ }` 중괄호를 생략할 수 있고, 중괄호가 없다면 그 유일한 '문'의 값이 리턴된다. `return`을 생략할 수 있다.

    ```js
    let circleArea = (pi, r) => {
        let area = pi * r * r;
        return area;
    }

    // 간단한 익명 함수
    () => {console.log('hi')}
    ```

- `function`과 `=>`에서 this 스코프 차이
    + `function`: this는 context object를 가리킨다.
    + `=>` : this는 arrow function을 정의한 시점의 스코프
    + 아래 예제에서 function을 썼다면 결과가 `Object, Window, Window`가 나왔겠지만 arrow를 썼을 땐 `Window, Window, Window`가 나온다.

    ```js
    var object = {
        f1: () => {
            console.log(this);
            var f2 = () => { console.log(this); }
            f2();
            setTimeout(f2, 1000);
        }
    }
    ```

- arrow function은 new 연산자를 못 쓴다. function을 썼을 때는 function의 인스턴스를 new로 찍어낼 수 있는데 `=>`는 불가능하다.
- ES5에 비해서 call, apply, bind 함수를 쓸 필요가 많이 줄었다.

### 1.8 객체 리터럴

- 객체를 정의하는 것이 좀 더 쉬워졌다.
- 객체 내부에 변수나 메소드를 추가할 때, 만약 이미 선언되어있다면 `:`을 쓸 필요 없이 `{ }` 안에 바로 변수명을 써주면 된다.
- 함수는 바로 declaration notation에서 맨 앞에 쓰는 `function`을 제외한 부분만 써도 바로 선언 및 객체에 값 추가가 가능하다.

    ```js
    // 변수 명이 이미 존재할 떄
    let x = 1, y = 2;
    let object1 = {x, y};

    // 함수 선언과 동시에 객체에 값 추가
    let object2 = {
        myFunction() { console.log('hi'); }
    }
    ```

- computed property name : 런타임 시점에 property name을 조합하는 것으로 표현식의 동적 계산 결과를 property 이름으로 쓴다. ES5에서와 다르게 ES6에선 객체 생성할 때부터 동적으로 property 이름을 추가할 수 있다. 아래처럼 생성할 때 표현식을 `[ ]`로 감싸주면 된다.

    ```js
    // 생성할 때 key 표현식을 대괄호로 감싸기
    let object = {
        ["first" + "Name"]: "수지", 
    };
    console.log(object["first" + "Name"]);
    ```

## 2. Number

### 2.1 진법

- 2진수: 숫자 상수 앞에 `0b`를 붙이면 된다.

    ```js
    let a = 0b00001111;
    let b = 15;
    console.log(a === b); // true
    console.log(a); // 15
    ```

- 8진수: ES5까지는 숫자 앞에 `0`을 붙이면 됐다. 그런데 혼동이 일어날 수 있어서 ES6부터는 앞에 `0o`를 붙이는 것으로 바뀌었다.

    ```js
    let a = 0o17;
    let b = 15;
    console.log(a === b); // true
    console.log(a); // 15
    ```

### 2.2 함수

- `Number.isInteger(number)` : js는 모든 숫자가 64비트 부동 소수점 형태로 저장된다. 이번에 정수 판별 함수 새로 생겼다.
- `Number.isNaN(value)` : 전역 `isNaN` 함수는 숫자가 아니면 true. 숫자면 false를 리턴했다. 하지만 새로 생긴 Number의 isNaN은 정확히 `NaN` 값인지 여부를 반환한다.
- `Number.isFinite(value)` : 전역 `isFinite` 함수가 있었지만 숫자가 아닌 값들까지 알아서 형변환하여 여부를 체크했다. 즉 null, [] 같은 것도 true를 리턴했다. 이걸 고쳐서 새로 만들어진 함수다.
