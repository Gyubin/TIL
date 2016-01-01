# #2 Sort with arrow function

age, name 속성을 가진 Objects가 들어있는 리스트를 매개변수로 받고, age 속성에 따라서 Objects를 오름차순으로 정렬하는 함수다.

## 1. 내 코드

```js
var OrderPeople = function(people){
  return people.sort(function(a, b){return a.age - b.age});
}
```

## 2. 다른 해답

```js
var OrderPeople = function(people){
  return people.sort((a,b) => a.age - b.age );
}
```

- sort 함수의 매개변수에 순서 정렬 기준을 의미하는 함수를 넣을 수 있다.
- arrow function: 함수 표현식의 축약형이다. 아래처럼 쓰면 된다. [참고링크](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Functions/%EC%95%A0%EB%A1%9C%EC%9A%B0_%ED%8E%91%EC%85%98)

```js
// 기본 문법:
(파라미터1, 파라미터2, 파라미터N) => { 구문 }
(파라미터1, 파라미터2, 파라미터N) => 표현식
   // 괄호 생략시, 표현식은 return 구문으로 취급된다: => { return 표현식; }

// 파라미터가 한 개인 경우, 파라미터의 괄호는 생략될 수 있다:
유일파라미터 => { 구문 }
유일파라미터 => 표현식

// 파라미터가 하나가 없는 경우, 파라미터 괄호는 반드시 표기해야 한다:
() => { 구문 }

// 고급:
// 본문을 괄호로 감싸 객체 표현식을 린턴하게 할 수 있다:
파라미터들 => ({foo: bar})

// 레스트 파라미터(가변 파라미터)를 사용할 수 있다.
(파라미터1, 파라미터2, ...가변파라미터) => { 구문 }
```
