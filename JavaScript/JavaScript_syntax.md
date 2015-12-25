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
- `prompt('string');` : 매개변수로 들어간 문자열을 보여주면서 입력 상자가 띄워진다. 유저가 어떤 텍스트를 입력하면 그것을 리턴한다.

## 3. 함수

```js
var divideByThree = function (number) {
    var val = number / 3;
    console.log(val);
};
```

- 함수가 저장될 객체를 선언하고, 함수를 대입한다. 괄호 안엔 매개변수, {} 안엔 내용이 들어간다. 기본적으로 위와 같은 형태다. 모든 라인에 `;` 붙이는 것 유의

## 4. 반복문

- `for` loop
    + c언어에서의 for 문과 형태가 같다. () 안에서 바로 변수를 선언해서 쓸 수도 있고, 이미 있는 변수를 활용할 수도 있다.
    + () 안에서 선언한 변수, {} 안에서 선언한 변수 모두 반복이 끝난 후에도 없어지지 않고 사용할 수 있다. scope가 변하지 않는 것 같다. local 변수는 함수 내에서 선언된 것만으로 한정된다.

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

- `while`, `do while`

```js
while (condition) {
}

do {
} while (condiiton);
```

## 5. array

- 원소 추가: `push`를 쓴다. array.push(something)
