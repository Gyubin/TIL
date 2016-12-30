# apply, bind, call 함수 정리

셋 모두 특정 함수를 실행할 때 `this`를 바꿔서 적용할 수 있게 한다. 즉 어떤 함수가 내부 구현에서 `this`를 활용한다면, 이 함수를 호출하는 scope를 다양하게 바꿀 수 있다는 의미다.

## 1. 함수 원형

- `fun.apply(thisArg, [argsArray])`
- `fun.bind(thisArg[, arg1[, arg2[, ...]]])`
- `fun.call(thisArg[, arg1[, arg2[, ...]]])`

## 2. 차이점

- apply와 call의 차이점은 두 번째 변수가 한 번에 모여서 array로 들어가느냐, 변수 하나하나로 들어가느냐의 차이다.
- apply, call과 bind의 차이점은 앞의 두 함수는 호출했을 때 바로 함수를 '실행'하지만 bind는 scope를 변경한 함수를 리턴한다는 점이다.

## 3. 예제

```js
// 재사용하기 =====================================
function Student(name, age, gender) {
    this.name = name
    this.age = age
    this.gender = gender
}

var gyubin = {};
Student.apply(gyubin, ["Gyubin Son", 28, "male"])

var jordan = {};
Student.call(jordan, "Michael Jordan", 54, "male")

// scope가 다른 같은 이름의 변수들 =================
window.color = "red"
var o = {color: "blue"}

function sayColor() {
  alert(this.color)
}

sayColor() // red
sayColor.call(this)     // red
sayColor.call(window)   // red
sayColor.call(o)        // blue         
```

- 함수 하나를 scope 변환해서 여러번 재사용할 수 있다.
- 다만 위와 같은 예제에선 `gyubin`, `jordan`이란 변수에 empty object가 대입되어있어야 한다.
- 상속 개념 쉽게 구현할 수 있다. 클래스 내부에서 실행하면 된다.
