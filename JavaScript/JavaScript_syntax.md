# JavaScript 문법

몰랐던 것만 가볍게 정리한다. int, string 같은 기본적인 것들 제외하고 몰랐던 것들, 다른 언어와 다른 점들(주로 Python과 다른 점)을 헷갈리지 않기 위하여 정리한다.

참고 자료: [Eloquent JavaScript](http://eloquentjavascript.net/), [코드카데미](https://www.codecademy.com/learn/javascript)

## 1. 기본

- 한 줄 끝에 `;` 붙이기. 안 붙여도 되는 경우도 있지만 속 편하게 다 붙이기.
- 주석 : `//`, `/* */`
- 참 거짓은 소문자로: `true`, `false`
- 변수명: 첫 글자는 소문자, 이후로 CamelCase. 예를 들어 `myAge` 같은 식. 이게 JavaScript에서 컨벤션인 듯 하다.
- `scope`은 변수가 유효한 범위를 의미한다. global, local 두 가지가 있으며 함수 안에서 선언되면 local이다. 최대한 local 변수를 쓰도록 노력. global은 최대한 쓰지말자. 만약 function 안에서 var을 안 쓰고 변수를 쓰면 글로벌 변수다. 그리고 function이 scope을 만드는 유일한 수단이다.
- 객체 선언은 모두 앞에 `var`를 붙인다. 예로 `var myAge = 12`
- `++`, `--` 연산자 존재한다. 전위, 후위 연산자 모두 가능하다.
- 논리연산자 종류: `&&`, `||`, `!` 순서대로 and, or, not
- 대부분의 연산자는 2개 값을 비교한다. binary operator. 그런데 한 개 값만 비교하는 연산자도 있는데 unary operator라고 한다. `typeof`, `-`, `!`가 있다. minus operator의 경우 예를 들어 다음이 가능하다. `-(10-2)`
- 문자열끼리 `<`, `>` 비교할 수 있다. 첫 글자부터 아스키코드값으로 비교한다. 첫 글자가 같으면 두 번째것을 비교하는 식.
- 연산자 우선순위 낮은 순: `||` -> `&&` -> `comparison(>, ===...)` -> `나머지`
- 삼항연산자(ternary or conditional operator): `something ? 1 : 2` something이 true면 1이고 false면 2다.
- 기본 타입 6개: number, string, boolean, function, object, undefined
- number e 표현 : `2.998e5` = 299,800
- `NaN`은 Not a Number의 의미지만 type은 number다. 0을 0으로 나눌 때 리턴하기도 하지만 계산식에서 정확한 값을 산출할 수 없을 때도 쓰인다. 유일하게 자신과 자신이 같지 않은 객체다. `NaN === NaN`은 false
- 개행문자를 출력하려면 앞에 `\` 하나 붙여주면 된다. `\\n`
- 자동 형변환 : 다른 타입끼리 연산을 하면 자바스크립트는 알아서 형 변환을 시킨다. 이것을 `type coercion`이라고 함. 다음은 예시

|     식     | 결과값 |
|------------|--------|
| 8 * null   | 0      |
| "5" - 1    | 4      |
| "5" + 1    | 51     |
| "five" * 2 | NaN    |
| false == 0 | true   |

- `==`, `===` 차이: 위 예시의 type coercion을 원치 않을 땐 `===`과 `!==`을 쓴다. 다음 예제는 `==`을 썼을 때 모두 false로 나오는 예제

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

- 변하지 않는 값 상수: `const name = value;` 형태로 선언하면 절대 바뀌지 않는다. 꼭 초기값이 필요하다. 그냥 const name; 식으로 하면 에러.
- reserved words: 의미를 모르는거 뭔지 알기. `break case catch class const continue debugger default delete do else enum export extends false finally for function if implements import in instanceof interface let new null package private protected public return static super switch this throw true try typeof var void while with yield`
- 반복이나 분기문에서 실행문이 한 줄이면 { } 안 써도 된다. 쭉 나열하면 됨. `if (condition) code;`
- 

## 2. 브라우저 팝업 창 관련

- `confirm('string');` : 확인, 취소 버튼과 함께 문자열을 띄워준다. 확인 버튼을 누르면 `true`, 취소 버튼을 누르면 `false`를 리턴한다.
- `prompt('question', 'placeholder');` : 첫 번째 매개변수는 입력상자에서 보여질 질문이다. 두 번째 매개변수는 입력창에 기본적으로 입력이 된다. 리턴값은 유저가 입력한 텍스트다.
- `alert('string')` : 단순하게 메시지만 띄워준다. 리턴 값 없다.

## 3. 함수

### A. 기본

```js
var divideByThree = function (number) {
    var val = number / 3;
    console.log(val);
};
```

- 함수가 저장될 객체를 선언하고, 함수를 대입한다. 괄호 안엔 매개변수, {} 안엔 내용이 들어간다. 기본적으로 위와 같은 형태다. 모든 라인에 `;` 붙이는 것 유의
- 하지만 마치 클래스처럼 함수를 선언할 수도 있다. declaration notation이라 하는데 `function square(x) { return x * x; }` 처럼 한다. 가능한 방식이다.
- 위처럼 declaration notation을 활용할 경우 코드의 위치와 상관없이 프로그램이 시작되자마자 선언된다. 그래서 scope에 상관없이 쓰일 수 있다. 하지만 조건, 반복문의 block 내에선 쓰지 않는게 좋다. 브라우저마다 달라진다. 예를 들어 다음 코드는 권장되지 않음.

```
function example() {
    if (false) {
        function a () {
            console.log('hi');
        }
    }
}
```

### B. The call stack

```js
function greet(who) {
    console.log("Hello " + who);
}
greet("Harry");
console.log("Bye");
```

위 코드에서 보면 `greet` 함수가 실행되는 순간 2번째 줄 코드로 컨트롤이 넘어간다. 그리고 `console.log` 빌트인 함수를 만나는 순간 또 컨트롤이 넘어가고, 일을 다 한 후에 다시 컨트롤은 2번 줄로 넘어온다. 그리고 greet 함수가 끝남과 동시에 다시 불려진 부분으로 컨트롤이 넘어온다.(4번 줄) 다음 마지막줄의 `console.log`가 실행된다.

이렇게 컨트롤이 왔다갔다 하기 때문에 컴퓨터는 함수가 불려진 context를 기억해야하는데 stack 형태로 저장한다. 서로 call하는 함수가 있다면 메모리 많이 쓴다고 에러 난다.

### C. Optional Arguments

함수에서 정해진 매개변수가 있는데 그거보다 더 많이 넣으면 에러 없이 알아서 무시하고, 더 적게 넣으면 알아서 `undefined`가 들어간다. 에러가 안난다. 그래서 원치 않는 결과가 나오더라도 에러메시지가 없기 때문에 디버깅이 어렵다.

하지만 이 특성을 이용해서 매개변수의 기본값을 설정할 수 있다. 함수 내부에서 특정 매개변수가 `undefined`라면 기본값을 대입해주는 방식이다.

### D. Closure

```js
function multiplier(factor) {
    return function(number) {
        return number * factor;
    };
}
var twice = multiplier(2);
console.log(twice(5));
// → 10
```

함수가 종료되더라도 함수가 호출될 때의 local variable에 접근할 수 있는 방식을 클로저라고 한다. 함수 내에서 함수를 만들어 리턴하면 만들어진 함수는 그 scope을 기억하고 있다. 위의 예에서 `multiplier`의 매개변수로 들어가는 `factor` 변수는 함수가 호출되고 종료되는 순간 사라져야 하지만 게속 사용되는 것을 볼 수 있다.

### E. Recursion

```js
function findSolution(target) {
    function find(start , history) {
        if (start == target)
            return history;
        else if (start > target)
            return null;
        else
            return find(start + 5, "(" + history + " + 5)") ||
                   find(start * 3, "(" + history + " * 3)");
    }
    return find(1, "1");
}

console.log(findSolution(24));
//→ (((1*3)+5)*3)
```

탄성을 지른 코드다. Eluquent JavaScript 53page 아래에서 나온 코드다. 어떤 수를 `+5`와 `*3`으로 나타낼 수 있는지 알아보는 건데 `||`의 활용이 기가막힌다. 이런 식으로도 재귀를 짤 수 있구나 감탄 또 감탄했다. 그리고 확실히 {}을 생략할 수 있을 땐 생략하는게 깔끔하고 좋은 것 같다.

## 4. 반복, 조건문

- `for` loop
    + c언어에서의 for 문과 형태가 같다. () 안에서 바로 변수를 선언해서 쓸 수도 있고, 이미 있는 변수를 활용할 수도 있다.
    + () 안에서 선언한 변수, {} 안에서 선언한 변수 모두 반복이 끝난 후에도 없어지지 않고 사용할 수 있다. scope를 바꾸는 것은 function이 유일.
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
// 다음처럼도 가능하다.
// Dog.prototype = {
//    bark: function() {
//        console.log('wang');
//    }
//}
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

## 6. Class에서 public, private 속성

- 개념
    + public : 클래스 밖에서도 속성에 접근할 수 있는 것. `this`를 쓴다.
    + private : 클래스 밖에서 dot notation으로 속성에 접근할 수 없다. `var` 사용.
- 사용법
    + private property, method를 사용하려면 이 property와 method를 리턴하는 public method를 작성하면 된다.
    + 주로 private property를 바로 직접 리턴하는 public method를 만들고 이 method 내부에서 인증 같은 처리를 한다.
    + private method를 만드는 경우 private method를 리턴하는 public method를 만든다. method를 리턴할 때는 뒤에 `( )` 쓰지 않는다.
    + 만약 어떤 Class로 만든 객체에서 private property 혹은 method가 있다면 `for/in` loop에서 잡아오지 않는다. 즉 private은 아예 반복에서 제외된다.

> 다른 언어에 있는 클래스 변수는 존재하지 않는다.

```js
function Person(first,last,age) {
   this.firstname = first;
   this.lastname = last;
   this.age = age;
   var bankBalance = 7500;
   var returnBalance = function() {
      return bankBalance;
   };
   this.askTeller = function() {
       return returnBalance;
   };
}
```

## 자주 쓰이는 함수

- `isNaN(object)` : Not a Number라는 뜻이다. 숫자가 아닌 것이 매개변수로 들어가면 true를 리턴한다. 다만 `'42'`의 경우 문자열이지만 자동 변환해서 42로 인식하기 때문에 false를 리턴한다.
- `toUpperCase()`, `toLowerCase()`: 대, 소문자화 함수
- `hasOwnProperty(property)` : Object에서 호출해서 매개변수의 property가 있는지 true, false를 리턴해주는 함수다.
- `'string'.length;` : 문자열 길이
- `'string'.substring(i, j)` : 문자열 슬라이싱
- `myArray.push(something)` : array 원소 추가
- `typeof thing` : thing의 타입을 리턴한다.
