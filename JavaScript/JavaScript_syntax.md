# JavaScript 문법

몰랐던 것만 가볍게 정리한다. int, string 같은 기본적인 것들 제외하고 몰랐던 것들, 다른 언어와 다른 점들(주로 Python과 다른 점)을 헷갈리지 않기 위하여 정리한다.

참고 자료: [Eloquent JavaScript](http://eloquentjavascript.net/), [코드카데미](https://www.codecademy.com/learn/javascript)

## 1. 기본

- 문자열 길이: `'string'.length;`
- 한 줄 끝에 `;` 붙이기. 안 붙여도 되는 경우도 있지만 속 편하게 다 붙이기.
- 주석 : `//`
- 참 거짓은 소문자로: `true`, `false`
- 출력: `console.log(context)`
- 블록: `{ }`로 표현. if ( 조건 ) { } 형태
- 문자열 슬라이싱: `'string'.substring(i, j)`
- 변수명: 첫 글자는 소문자, 이후로 CamelCase. 예를 들어 `myAge` 같은 식. 이게 JavaScript에서 컨벤션인 듯 하다.
- `scope`은 변수가 유효한 범위를 의미한다. global, local 두 가지가 있으며 함수 안에서 선언되면 local이다. 최대한 local 변수를 쓰도록 노력. global은 최대한 쓰지말자.
- 객체 선언은 모두 앞에 `var`를 붙인다. 예로 `var myAge = 12`
- `++`, `--` 연산자 존재한다. 전위, 후위 연산자 모두 가능하다.
- 논리연산자 종류: `&&`, `||`, `!` 순서대로 and, or, not
- array 원소 추가: `push`를 쓴다. array.push(something)
- `typeof thing` 형태로 쓰면 타입을 리턴한다. number, string, function, object가 대부분이다. array도 type은 object다.
- `==`, `===` 차이: 다음 표에서 `===`을 쓰면 모두 false로 나오는 예제다. 무조건 `===`를 쓰는걸 추천.

|         식         |  결과 |
|--------------------|-------|
| '' == '0'          | false |
| 0 == ''            | true  |
| 0 == '0'           | true  |
| false == 'false'   | false |
| false == '0'       | true  |
| false == undefined | false |
| false == null      | false |
| null == undefined  | true  |
| ' \t\r\n ' == 0    | true  |

## 2. 브라우저 확인 창 관련

- `confirm('string');` : 확인, 취소 버튼과 함께 문자열을 띄워준다. 확인 버튼을 누르면 `true`, 취소 버튼을 누르면 `false`를 리턴한다.
- `prompt('question', 'placeholder');` : 첫 번째 매개변수는 입력상자에서 보여질 질문이다. 두 번째 매개변수는 입력창에 기본적으로 입력이 된다. 리턴값은 유저가 입력한 텍스트다.

## 3. 함수

```js
var divideByThree = function (number) {
    var val = number / 3;
    console.log(val);
};
```

- 함수가 저장될 객체를 선언하고, 함수를 대입한다. 괄호 안엔 매개변수, {} 안엔 내용이 들어간다. 기본적으로 위와 같은 형태다. 모든 라인에 `;` 붙이는 것 유의

## 4. 반복, 조건문

- `for` loop
    + c언어에서의 for 문과 형태가 같다. () 안에서 바로 변수를 선언해서 쓸 수도 있고, 이미 있는 변수를 활용할 수도 있다.
    + () 안에서 선언한 변수, {} 안에서 선언한 변수 모두 반복이 끝난 후에도 없어지지 않고 사용할 수 있다. scope가 변하지 않는 것 같다. local 변수는 함수 내에서 선언된 것만으로 한정된다.
    + 모든 반복에 적용: `continue`는 아래 코드 실행하지 않고 다음 반복으로 넘어가는 것, `break`은 가장 가까운 반복에서 나오는 것.

```js
// () 안에서 선언. 끝나고도 변수 살아있음
for (var a = 0; a < 5; a++) {
    console.log(a)
}

// 미리 선언된 변수 for 문에서 활용
var b = 10
for (b; b > 5; b--) {
    console.log(b)
}

// {} 내부에서 선언한 변수 반복 끝나고도 존재
for (var c = 0; c < 5; c++) {
    var myVar = "I'm alive"
}
console.log(myVar)  // I'm alive
```

- `for / in ` loop: 아래 syntax로 쓰면 된다. object에서 in을 쓰면 키 값이 하나하나 뽑혀지고, array에서 하면 인덱스가 하나씩 뽑힌다. 결국 object든 array든 사용 방법은 `object[key]` 형태다.

```js
for (var key in object) {
  // code
}
```

- `while`, `do while`

```js
while (condition) {
}

do {
} while (condiiton);
```

- if: `if (condition) { code }`
- switch

```js
switch (object) {
    case something:
        //code
        break;
    case nextthing:
        //code
        break;
    default:
        //code
}
```

## 5. Object

### A. hash로서의 Object

Python의 dict, Ruby의 Hash처럼 쓰이는 것을 js에선 object라고 한다. 다음 예시처럼 사용하면 된다. 용법은 다들 비슷하다. 아래처럼 Dot notation으로 접근하는 것 말고도 `var myObj = {'a':'aaa', 'b':'bbb'}` 처럼 선언할 수도 있다. 이 때는 `;`을 쓰면 안된다.

```js
var phonebookEntry = {};
// var phonebookEntry = new Object(); 같은 의미

phonebookEntry.name = 'Oxnard Montalvo';
phonebookEntry.number = '(555) 555-5555';
phonebookEntry.phone = function() {
  console.log('Calling ' + this.name + ' at ' + this.number + '...');
};

phonebookEntry.phone();
```

### B. this

메소드가 호출된 객체를 의미한다. 메소드를 객체 외부에서 선언하더라도 this를 활용하면 어떤 object에서도 property를 수정할 수 있다. 다만 `myObj.myMethod = outerMethod` 처럼 대입해줘야하고, 내부의 변수명도 일치해야한다.

### C. 클래스로서의 Object

```js
function Person(name,age) {
  this.name = name;
  this.age = age;
  this.setAge = function (newAge) {
    this.age = newAge
  }
}
var george = new Person("George Washington", 275);
```

- 위 형태가 기본이다. function인데 매개변수 () 앞에 클래스명이 붙고 this를 활용한다.
- 객체에서 호출되는 메소드로 쓰려면 앞에 this를 붙여준다. 즉 로컬 메소드다.

### D. prototype

```js
function Dog (breed) {
    this.breed = breed;
}
var mong = new Dog("mongmong");
Dog.prototype.bark = function () {
    console.log('wang');
}
mong.bark()
```

위의 경우로 설명하면 Dog 클래스의 모든 객체에 동일하게 수정하고싶을 경우 prototype을 사용한다. 이미 생성된, 앞으로 생성할 모든 Dog의 객체에 적용된다.

### E. inheritance

```js
function Animal(name, numLegs) {
    this.name = name;
    this.numLegs = numLegs;
    this.hi = function() {
        console.log('hi');
    };
}

function Penguin(name, numLegs) {
    this.name = name;
    this.numLegs = 2;
};

// set its prototype to be a new instance of Animal
Penguin.prototype = new Animal();
var pg = new Penguin();
pg.hi();
```

`ChildClass.prototype = new ParentClass();` 형태로 사용한다.

## 자주 쓰이는 함수

- `isNaN(object)` : Not a Number라는 뜻이다. 숫자가 아닌 것이 매개변수로 들어가면 true를 리턴한다. 다만 `'42'`의 경우 문자열이지만 자동 변환해서 42로 인식하기 때문에 false를 리턴한다.
- `toUpperCase()`, `toLowerCase()`: 대, 소문자화 함수
- `hasOwnProperty(property)` : Object에서 호출해서 매개변수의 property가 있는지 true, false를 리턴해주는 함수다.
