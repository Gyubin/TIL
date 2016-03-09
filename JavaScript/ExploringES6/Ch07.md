# 7. Symbols

심볼은 ES6에서 새로운 원시 타입이다. 이 챕터는 심볼이 어떻게 동작하는지 다룬다.

> Symbols are a new primitive type in ECMAScript 6. This chapter explains how they work.

## 7.1 Overview

### 7.1.1 Use case 1: unique property keys

심볼은 주로 unique property keys로 이용된다. 심볼은 절대 다른 property key(심볼과 문자열)와 충돌하지 않는다. 예를 들어 `Symbol.iterator` 안에 저장되어있는 symbol을 method의 key로 활용하여 object iterable을 만들 수 있다.(object iterable은 `for-of` 루프와 다른 언어 메카니즘을 활용할 수 있는 객체다). iterable에 대한 더 자세한 정보는 [iteration chapter](http://exploringjs.com/es6/ch_iteration.html#ch_iteration)에서 다룬다.

> Symbols are mainly used as unique property keys – a symbol never clashes with any other property key (symbol or string). For example, you can make an object iterable (usable via the for-of loop and other language mechanisms), by using the symbol stored in Symbol.iterator as the key of a method (more information on iterables is given in the chapter on iteration):

```js
const iterableObject = {
    [Symbol.iterator]() { // (A)
        const data = ['hello', 'world'];
        let index = 0;
        return {
            next() {
                if (index < data.length) {
                    return { value: data[index++] };
                } else {
                    return { done: true };
                }
            }
        };
    }
}
for (const x of iterableObject) {
    console.log(x);
}
// Output:
// hello
// world
```

A 라인에서 심볼은 method의 key로 이용되었다. 이 유일한 marker는 object iterable을 만들고, 우리가 for-of 루프를 사용할 수 있도록 해준다.

> In line A, a symbol is used as the key of the method. This unique marker makes the object iterable and enables us to use the for-of loop.

### 7.1.2 Use case 2: constants representing concepts

ES5에서는 색깔같은 콘셉트를 표현하기 위해 문자열을 주로 썼다. ES6에선 심볼을 쓸 수 있고, 심볼은 항상 unique한 것으로 생각하면 된다.

> In ECMAScript 5, you may have used strings to represent concepts such as colors. In ES6, you can use symbols and be sure that they are always unique:

```js
const COLOR_RED    = Symbol('Red');
const COLOR_ORANGE = Symbol('Orange');
const COLOR_YELLOW = Symbol('Yellow');
const COLOR_GREEN  = Symbol('Green');
const COLOR_BLUE   = Symbol('Blue');
const COLOR_VIOLET = Symbol('Violet');

function getComplement(color) {
    switch (color) {
        case COLOR_RED:
            return COLOR_GREEN;
        case COLOR_ORANGE:
            return COLOR_BLUE;
        case COLOR_YELLOW:
            return COLOR_VIOLET;
        case COLOR_GREEN:
            return COLOR_RED;
        case COLOR_BLUE:
            return COLOR_ORANGE;
        case COLOR_VIOLET:
            return COLOR_YELLOW;
        default:
            throw new Exception('Unknown color: '+color);
    }
}
```

### 7.1.3 Pitfall: you can’t coerce symbols to strings

심볼을 문자열로 형변환(암묵적인 변환)하면 예외가 발생한다.

> Coercing (implicitly converting) symbols to strings throws exceptions:

```js
const sym = Symbol('desc');

const str1 = '' + sym; // TypeError
const str2 = `${sym}`; // TypeError
The only solution is to convert explicitly:

const str2 = String(sym); // 'Symbol(desc)'
const str3 = sym.toString(); // 'Symbol(desc)'
```

형변환을 막는 것은 몇 몇 에러를 방지한다. 하지만 심볼을 사용하는 것을 더 복잡하게 만들기도 한다.

> Forbidding coercion prevents some errors, but also makes working with symbols more complicated.

### 7.1.4 Which operations related to property keys are aware of symbols?

다음 operation은 심볼을 property key로 인식한다.

> The following operations are aware of symbols as property keys:

- Reflect.ownKeys()
- Property access via []
- Object.assign()

다음 operation은 심볼은 property key로 받아들이지 않는다.

> The following operations ignore symbols as property keys:

- Object.keys()
- Object.getOwnPropertyNames()
- for-in loop

## 7.2 A new primitive type

ES6는 symbol이라는 새로운 원시 타입을 소개한다. 심볼은 unique ID로 작동하는 token이다. factory 함수인 `Symbol()`로 심볼을 만들 수 있다. (함수로 호출될 때는 문자열을 리턴한다는 점에서 `String`과 조금 비슷하다)

> ECMAScript 6 introduces a new primitive type: symbols. They are tokens that serve as unique IDs. You create symbols via the factory function Symbol() (which is loosely similar to String returning strings if called as a function):

```js
const symbol1 = Symbol();
```

`Symbol()`에 optinal로 문자열 매개변수를 넣을 수 있는데 이것은 심볼에 대한 설명이다. 이 설명은 심볼이 `toString()`, `String()` 함수를 통해 문자열로 바뀔 때 리턴되는 값이다.

> Symbol() has an optional string-valued parameter that lets you give the newly created Symbol a description. That description is used when the symbol is converted to a string (via toString() or String()):

```js
const symbol2 = Symbol('symbol2');
String(symbol2) //'Symbol(symbol2)'
```

`Symbol()` 함수를 통해 리턴된 모든 심볼은 unique하다. 모든 심볼은 각각 고유의 identity를 가지고 있다.

> Every symbol returned by Symbol() is unique, every symbol has its own identity:

```js
Symbol() === Symbol() // false
```

`typeof` 연산자에 심볼을 넣어보면 primitive type임을 알 수 있다. 심볼 전용의 결과를 리턴한다.

> You can see that symbols are primitive if you apply the typeof operator to one of them – it will return a new symbol-specific result:

```js
typeof Symbol() // 'symbol'
```

### 7.2.1 Symbols as property keys

심볼은 property key로 사용될 수 있다.

> Symbols can be used as property keys:

```js
const MY_KEY = Symbol();
const obj = {};

obj[MY_KEY] = 123;
console.log(obj[MY_KEY]); // 123
```

Class와 object는 'computed property key'라고 불리는 기능을 갖고있다. property의 key를 `[mySymbol]` 대괄호 사이에 심볼을 넣어서 설정할 수 있다. 아래 코드는 obj 객체에 MY_KEY 심볼을 키로 사용한 예제다.

> Classes and object literals have a feature called computed property keys: You can specify the key of a property via an expression, by putting it in square brackets. In the following object literal, we use a computed property key to make the value of MY_KEY the key of a property.

```js
const MY_KEY = Symbol();
const obj = {
    [MY_KEY]: 123
};
```

method 정의에서도 역시 method 이름을 computed key로 할 수 있다.

> A method definition can also have a computed key:

```js
const FOO = Symbol();
const obj = {
    [FOO]() {
        return 'bar';
    }
};
console.log(obj[FOO]()); // bar
```

### 7.2.2 Enumerating own property keys

property의 key가 될 수 있는 새로운 종류의 값이 있을 때, ES6에선 다음 규칙이 적용된다.

> Given that there is now a new kind of value that can become the key of a property, the following terminology is used for ECMAScript 6:

- property key는 문자열, 심볼 둘 다 가능하다.
    + Property keys are either strings or symbols
- 문자열인 property key는 property name이라고 불린다.
    + String-valued property keys are called property names
- 심볼인 property key는 property symbol이라고 불린다.
    + Symbol-valued property keys are called property symbols.

object를 새로 만들어서 property key를 열거하는 API를 살펴보자. obj의 nonEnum property에 enumerable 속성을 false로 바꾼다.(Let’s examine the API for enumerating own property keys by first creating an object.)

```js
const obj = {
    [Symbol('my_key')]: 1,
    enum: 2,
    nonEnum: 3
};
Object.defineProperty(obj, 'nonEnum', { enumerable: false });
```

`Object.getOwnPropertyNames()` 함수에서 symbol 타입의 property 키는 제외된다. 문자열 property key만 불러온다.(Object.getOwnPropertyNames() ignores symbol-valued property keys)

```js
Object.getOwnPropertyNames(obj) // ['enum', 'nonEnum']
```

`Object.getOwnPropertySymbols()` 함수는 심볼 타입의 property key만 불러온다.(Object.getOwnPropertySymbols() ignores string-valued property keys)

```js
Object.getOwnPropertySymbols(obj) // [Symbol(my_key)]
```

`Reflect.ownKeys()` 함수는 타입 구분 없이 모든 키 불러온다.(Reflect.ownKeys() considers all kinds of keys)

```js
Reflect.ownKeys(obj) // [Symbol(my_key), 'enum', 'nonEnum']
```

`Object.keys()` 함수는 문자열 key 중에서도 enumerable key만 불러온다. (Object.keys() only considers enumerable property keys that are strings)

```js
Object.keys(obj) // ['enum']
```

`Object.keys` 라는 키워드는 새로운 용어들과 충돌하기 때문에 쓰지말자. `Object.names`, `Object.getEnumerableOwnPropertyNames` 쓰는 것을 추천한다.

> The name Object.keys clashes with the new terminology (only string keys are listed). Object.names or Object.getEnumerableOwnPropertyNames would be a better choice now.

## 7.3 Using symbols to represent concepts

ES5에서는 일반적으로 문자열을 통해 개념을 나타낸다. 예를 들어 다음 코드를 보면

> In ECMAScript 5, one often represents concepts (think enum constants) via strings. For example:

```js
var COLOR_RED    = 'Red';
var COLOR_ORANGE = 'Orange';
var COLOR_YELLOW = 'Yellow';
var COLOR_GREEN  = 'Green';
var COLOR_BLUE   = 'Blue';
var COLOR_VIOLET = 'Violet';
```

하지만 문자열은 우리가 원하는 바와 다르게 unique하지 못하다. 왜 그런지를 아래 코드의 함수를 보며 알아보자.

> However, strings are not as unique as we’d like them to be. To see why, let’s look at the following function.

```js
function getComplement(color) {
    switch (color) {
        case COLOR_RED:
            return COLOR_GREEN;
        case COLOR_ORANGE:
            return COLOR_BLUE;
        case COLOR_YELLOW:
            return COLOR_VIOLET;
        case COLOR_GREEN:
            return COLOR_RED;
        case COLOR_BLUE:
            return COLOR_ORANGE;
        case COLOR_VIOLET:
            return COLOR_YELLOW;
        default:
            throw new Exception('Unknown color: '+color);
    }
}
```

위 함수는 어떤 표현이든 제한없이 switch문의 case로 쓸 수 있다는 점을 잘 나타낸다.

> It is noteworthy that you can use arbitrary expressions as switch cases, you are not limited in any way. For example:

```js
function isThree(x) {
    switch (x) {
        case 1 + 1 + 1:
            return true;
        default:
            return false;
    }
}
```

우리는 switch 문이 제공하는 기능을 유연하게 사용하고, 색깔을 하드코딩하는 것이 아니라 우리의 상수값을 통해 쉽게 표현한다. 

> We use the flexibility that switch offers us and refer to the colors via our constants (COLOR_RED etc.) instead of hard-coding them ('RED' etc.).

재밌게도 우리가 이렇게 할지라도 여전히 혼동은 있을 수 있다. 예를 들어 어떤 사람은 그 날의 기분에 따라 상수 값을 정의할 수도 있다.

> Interestingly, even though we do so, there can still be mix-ups. For example, someone may define a constant for a mood:

```js
var MOOD_BLUE = 'BLUE';
```

이제 BLUE의 값은 unique하지 않게 됐고, MOOD_BLUE는 오해할 소지가 있다. 만약 위 변수를 `getComplement()` 함수의 매개변수로 사용한다면 함수는 exception을 throw해야 할 상황이지만 'ORANGE' 값을 리턴할 것이다. 

> Now the value of BLUE is not unique anymore and MOOD_BLUE can be mistaken for it. If you use it as a parameter for getComplement(), it returns 'ORANGE' where it should throw an exception.

이제 이 예제를 symbol을 사용해서 고쳐보자. 게다가 ES6부터 나온 const 기능을 이용해서 진짜 상수값을 만들 수 있다.(변수가 가지는 참조값은 bind되지만 value 자체는 변경 가능하다.)

> Let’s use symbols to fix this example. Now we can also use the ES6 feature const, which lets us declare actual constants (you can’t change what value is bound to a constant, but the value itself may be mutable).

```js
const COLOR_RED    = Symbol('Red');
const COLOR_ORANGE = Symbol('Orange');
const COLOR_YELLOW = Symbol('Yellow');
const COLOR_GREEN  = Symbol('Green');
const COLOR_BLUE   = Symbol('Blue');
const COLOR_VIOLET = Symbol('Violet');
```

`Symbol`로 리턴되는 각각의 값들은 unique하다. 이제 BLUE는 오해될 소지가 없어졌다. 흥미롭게도 `getComplement()` 함수의 내부 코드는 우리가 문자열 대신 심볼을 사용함에도 불구하고 전혀 변하지 않았다. 이는 심볼과 문자열이 얼마나 비슷한지 알려준다.

> Each value returned by Symbol is unique, which is why no other value can be mistaken for BLUE now. Intriguingly, the code of getComplement() doesn’t change at all if we use symbols instead of strings, which shows how similar they are.

## 7.4 Symbols as keys of properties

property를 만들 때 속한 키가 다른 어떤 키와도 충돌하지 않는다는 것은 두 가지 상황에서 유용하다.

> Being able to create properties whose keys never clash with other keys is useful in two situations:

- 상속 구조에서 non-public 변수를 사용할 때
    + For non-public properties in inheritance hierarchies.
- base-level의 property와 새로 만든 meta-level의 property를 충돌하지 않도록 할 때
    + To keep meta-level properties from clashing with base-level properties.

### 7.4.1 Symbols as keys of non-public properties

JavaScript에서 상속 구조가 있을 땐 언제나(class, mixin, prototype 등을 활용해서 상속 구조를 만든 경우) 2가지 종류의 property가 있을 것이다.

> Whenever there are inheritance hierarchies in JavaScript (e.g. created via classes, mixins or a purely prototypal approach), you have two kinds of properties:

- public property는 code의 클라이언트에서 볼 수 있는 것
    + Public properties are seen by clients of the code.
- private property는 상속 구조를 만드는 class나 mixin, object 등에서 내부적으로 사용된다.(protected property는 몇 개의 조각(class, mixin, object)들 사이에만 걸쳐서 사용되며, private과 같은 이슈를 갖는다.)
    + Private properties are used internally within the pieces (e.g. classes, mixins or objects) that make up the inheritance hierarchy. (Protected properties are shared between several pieces and face the same issues as private properties.)

사용성을 위해 public property는 주로 문자열 키를 갖는다. 하지만 private property에서 문자열 키를 사용하면 이름 충돌이 발생한다. 그래서 심볼이 아주 좋은 선택이 된다. 예를 들어 아래 코드에서 심볼은 private property인 `_counter`, `_action`에서 사용되었다.

> For usability’s sake, public properties usually have string keys. But for private properties with string keys, accidental name clashes can become a problem. Therefore, symbols are a good choice. For example, in the following code, symbols are used for the private properties _counter and _action.

```js
const _counter = Symbol('counter');
const _action = Symbol('action');
class Countdown {
    constructor(counter, action) {
        this[_counter] = counter;
        this[_action] = action;
    }
    dec() {
        let counter = this[_counter];
        if (counter < 1) return;
        counter--;
        this[_counter] = counter;
        if (counter === 0) {
            this[_action]();
        }
    }
}
```

심볼은 '인증되지 않는 접근'이 아니라 '이름 충돌'에서만 우리를 보호해준다는 점을 명심하자. 왜냐면 `Reflect.ownKeys()` 함수를 통해 심볼을 포함한 모든 own property key가 접근 가능하기 때문이다. 보호가 필요하다면 다음 [Private data for classes](http://exploringjs.com/es6/ch_classes.html#sec_private-data-for-classes) 챕터를 참조하자.

> Note that symbols only protect you from name clashes, not from unauthorized access, because you can find out all own property keys – including symbols – of an object via Reflect.ownKeys(). If you want protection there, as well, you can use one of the approaches listed in Sect. “Private data for classes”.

### 7.4.2 Symbols as keys of meta-level properties

symbol은 unique한 정체성을 지니기 때문에 서로 다른 level에 존재하는 public property의 키로 활용하기에 적합하다. normal property key(문자열 키)보다 더 그렇다. 왜냐하면 meta-level의 key와 normal key는 절대 충돌하면 안되기 때문이다.(meta-level의 키와 base-level의 키가 둘 다 문자열일 때 충돌할 수 있음을 경계하는 듯) meta-level property의 예는 '객체가 라이브러리에 의해 어떻게 다뤄질지를 customize 하기 위해 가지는 method'를 들 수 있다. symbol 키를 사용하면 라이브러리가 normal method와 customize한 메소드를 착각하지 않도록 해준다.

> Symbols having unique identities makes them ideal as keys of public properties that exist on a different level than “normal” property keys, because meta-level keys and normal keys must not clash. One example of meta-level properties are methods that objects can implement to customize how they are treated by a library. Using symbol keys protects the library from mistaking normal methods as customization methods.

ES6에서 iterability는 일종의 customization이다. 객체가 symbol key를 가진 메소드를 가지고 있다면 그 객체는 iterable하다고 말할 수 있다. 이 때 symbol key는 `Symbol.iterator`에 저장되어있는 symbol이다. 아래 코드에서 obj는 iterable이다.

> Iterability in ECMAScript 6 is one such customization. An object is iterable if it has a method whose key is the symbol (stored in) Symbol.iterator. In the following code, obj is iterable.

```js
const obj = {
    data: [ 'hello', 'world' ],
    [Symbol.iterator]() {
        const self = this;
        let index = 0;
        return {
            next() {
                if (index < self.data.length) {
                    return {
                        value: self.data[index++]
                    };
                } else {
                    return { done: true };
                }
            }
        };
    }
};
```

obj의 iterability는 `for-of` 구문과 비슷한 다른 기능들을 쓸 수 있도록 해준다.

> The iterability of obj enables you to use the for-of loop and similar JavaScript features:

```js
for (const x of obj) {
    console.log(x);
}
// hello
// world
```

### 7.4.3 Examples of name clashes in JavaScript’s standard library

이름이 충돌하는 것을 별거 아니라고 생각할 수 있다. 그래서 이름 충돌이 야기하는 문제 3가지를 준비했다. 자바스크립트의 표준 라이브러리의 발전 모습과 함께 살펴보자.

> In case you think that name clashes don’t matter, here are three examples of where name clashes caused problems in the evolution of the JavaScript standard library:

- `Array.prototype.values()`라는 새로운 method가 만들어졌을 때, 이 코드는 Array와 함께 쓰여지던 `with` 부분의 기존 코드를 망가뜨렸고, 바깥 스코프의 변수 `values`를 덮어썼다.(shadowed). 그래서 `with`에서 property를 숨기기 위해 [Symbol.unscopables](http://exploringjs.com/es6/ch_oop-besides-classes.html#Symbol_unscopables)라는 메커니즘이 소개되었다.
    + When the new method `Array.prototype.values()` was created, it broke existing code where `with` was used with an Array and shadowed a variable `values` in an outer scope (bug report 1, bug report 2). Therefore, a mechanism was introduced to hide properties from `with` (Symbol.unscopables).
- `String.prototype.contains`는 MooTools에 의해 추가된 method와 충돌해서 `String.prototype.includes`로 이름을 변경해야했다.
    + `String.prototype.contains` clashed with a method added by MooTools and had to be renamed to `String.prototype.includes` (bug report).
- ES2016의 method인 `Array.prototype.contains` 역시 MooTools의 method와 충돌해서 `Array.prototype.includes`으로 이름을 변경해야 했다.
    + The ES2016 method `Array.prototype.contains` also clashed with a method added by MooTools and had to be renamed to `Array.prototype.includes` (bug report).

대조적으로, `Symbol.iterator`이라는 property key를 통해 iterability 속성을 객체에 추가하는 것은 전혀 문제를 일으키지 않는다. 키가 symbol이라서 그 어떤 것과도 충돌하지 않기 때문이다.

> In contrast, [adding iterability to an object via the property key](http://exploringjs.com/es6/ch_iteration.html#ch_iteration) `Symbol.iterator` can’t cause problems, because that key doesn’t clash with anything.

위 예들은 web 언어가 되는 것이 어떤 것인지를 증명한다. 하위 호환성은 매우 중요하며, 이것은 언어의 진화에서 왜 타협과 절충이 종종 필요해지는지를 잘 말해준다. 부수적인 이득으로 구식 JavaScript 코드를 발전시키는 것은 더 쉽다. ECMAScript 버전은 절대 이전 코드를 망가뜨리지 않기 때문이다.

> These examples demonstrate what it means to be a web language: backward compatibility is crucial, which is why compromises are occasionally necessary when evolving the language. As a side benefit, evolving old JavaScript code bases is simpler, too, because new ECMAScript versions never (well, hardly ever) break them.

## 7.5 Crossing realms with symbols

code realm은 code가 존재하는 context를 말한다. realm은 전역변수, 로드된 모듈 등을 포함한다. code가 정확히 하나의 realm 안에 존재하더라도 다른 realm의 코드에 접근할 수 있다. 예를 들어 브라우저의 각 frame은 고유의 realm을 갖고 있다. 그리고 frame의 execution은 frame과 frame을 뛰어넘을 수 있다. 다음 코드로 살펴보자.

> A code realm (short: realm) is a context in which pieces of code exist. It includes global variables, loaded modules and more. Even though code exists “inside” exactly one realm, it may have access to code in other realms. For example, each frame in a browser has its own realm. And execution can jump from one frame to another, as the following HTML demonstrates.

```html
<head>
    <script>
        function test(arr) {
            var iframe = frames[0];
            // 이 코드와 iframe의 코드는 다른 realm에 존재.
            // 그러므로 Array같은 전역변수는 다른 것들이다.
            console.log(Array === iframe.Array); // false
            console.log(arr instanceof Array); // false
            console.log(arr instanceof iframe.Array); // true

            // 하지만 symbol은 똑같다.
            console.log(Symbol.iterator === iframe.Symbol.iterator); // true
        }
    </script>
</head>
<body>
    <iframe srcdoc="<script>window.parent.test([])</script>">
</iframe>
</body>
```

문제는 각 realm이 Array에 대한 고유의 local 복제본을 가지고 있다는 것이고, 객체는 각각의 identity가 있기 때문에 local 복제본들은 다른 것으로 여겨진다. 본질적으로는 같은 객체임에도 불구하고 말이다. 비슷하게 라이브러리와 사용자의 코드는 realm마다 한 번씩 로드되며 각 realm에서 같은 객체지만 다른 버전을 갖게된다.

> The problem is that each realm has its own local copy of Array and, because objects have individual identities, those local copies are considered different, even though they are essentially the same object. Similarly, libraries and user code are loaded once per realm and each realm has a different version of the same object.

대조적으로 boolean, number, string 같은 원시타입의 멤버는 개별적인 정체성을 갖지않기 때문에, 같은 값의 여러 복제본들이 문제가 되지 않는다. 복제본은 '값'에 의해서 비교되며(content가 중요하지 identity가 아니다.) 똑같은 것이라 여겨진다.

> In contrast, members of the primitive types boolean, number and string don’t have individual identities and multiple copies of the same value are not a problem: The copies are compared “by value” (by looking at the content, not at the identity) and are considered equal.

symbol은 각각 고유의 정체성을 지니기 때문에 다른 원시타입들처럼 부드럽게 realm 간의 이동이 되지 않는다. 그래서 `Symbol.iterator`같은 realm 사이에서 작동해야하는 것들에서 문제가 발생한다. 만약 객체가 한 realm에서 iterable이라면 다른 realm에서도 iterable이어야 한다. 만약 realm들 사이에서 작동하는 symbol이 JavaScript Engine에서 관리된다면 엔진은 각 realm에서 그 심볼이 같은 값임을 확인해줄 수 있다. 하지만 라이브러리에서는 global symbol registry라는 형태로 추가 지원이 필요하다. 이 레지스트리는 모든 realm에게 global이며 문자열을 심볼에 매핑한다. 라이브러리는 각각의 심볼에 대해 최대한 unique한 문자열들을 찾아내야 한다. 라이브러리는 심볼을 생성하기 위해 `Symbol()`을 쓰지 않고 레지스트리에 문자열에 맞는 심볼을 요청한다. 문자열에 맞는 심볼이 이미 있을 경우엔 그 심볼을 리턴하고, 없다면 심볼이 만들어진다.

> Symbols have individual identities and thus don’t travel across realms as smoothly as other primitive values. That is a problem for symbols such as `Symbol.iterator` that should work across realms: If an object is iterable in one realm, it should be iterable in others, too. If a cross-realm symbol is managed by the JavaScript engine, the engine can make sure that the same value is used in each realm. For libraries, however, we need extra support, which comes in the form of the global symbol registry: This registry is global to all realms and maps strings to symbols. For each symbol, libraries need to come up with a string that is as unique as possible. To create the symbol, they don’t use Symbol(), they ask the registry for the symbol that the string is mapped to. If the registry already has an entry for the string, the associated symbol is returned. Otherwise, entry and symbol are created first.

레지스트리에 `Symbol.for()` 함수를 통해 심볼을 요청할 수 있고, `Symbol.keyFor()` 함수를 통해 심볼과 연관된 문자열을 받을 수 있다.

> You ask the registry for a symbol via Symbol.for() and retrieve the string associated with a symbol (its key) via Symbol.keyFor():

```js
const sym = Symbol.for('Hello everybody!');
Symbol.keyFor(sym) // 'Hello everybody!'
```

예상했던 것처럼 `Symbol.iterator`같은 cross-realm(realm을 넘나드는) 심볼은 자바스크립트 엔진에 의해 제공되는데 이것은 레지스트리에 없다. 

> As expected, cross-realm symbols, such as Symbol.iterator, that are provided by the JavaScript engine are not in the registry:

```js
Symbol.keyFor(Symbol.iterator) // undefined
```

## 7.6 Wrapper objects for symbols

모든 원시 값이 literal을 가지고 있는 반면, 심볼은 `Symbol`이라는 함수를 호출해서 생성해야 한다. 즉 `Symbol`을 생성자처럼 잘못 여기고 호출하기 쉽다. 그렇게 되면 `Symbol`의 인스턴스를 생성하게되고 매우 안좋은 방법이다. 즉 다음 코드처럼 실행하게 되면 에러가 발생한다. 

> While all other primitive values have literals, you need to create symbols by function-calling Symbol. Thus, it is relatively easy to accidentally invoke Symbol as a constructor. That produces instances of Symbol and is not very useful. Therefore, an exception is thrown when you try to do that:

```js
new Symbol() // TypeError: Symbol is not a constructor
```

여전히 `Symbol`의 인스턴스를 wrapper 객체로 생성할 수 있는 방법은 있다. `Object`를 함수처럼 호출해서 심볼을 포함한 모든 값을 object로 바꾸면 된다.

> There is still a way to create wrapper objects, instances of Symbol: Object, called as a function, converts all values to objects, including symbols.

```js
const sym = Symbol();
typeof sym // 'symbol'

const wrapper = Object(sym);
typeof wrapper // 'object'
wrapper instanceof Symbol // true
```

### 7.6.1 Accessing properties via [ ] and wrapped keys

property에 접근할 때 대괄호 `[ ]` 연산자는 문자열 wrapper 객체와 심볼 wrapper 객체를 unwrap 한다.(문자열, 심볼을 그냥 글자 그대로 쓸 수 있다는 의미인듯) 다음 객체를 이 현상을 이해하는데 사용해보자.

> The square bracket operator [ ] for accessing properties unwraps string wrapper objects and symbol wrapper objects. Let’s use the following object to examine this phenomenon.

```js
const sym = Symbol('yes');
const obj = {
    [sym]: 'a',
    str: 'b',
};
```

Interaction:

```js
const wrappedSymbol = Object(sym);
typeof wrappedSymbol // 'object'
obj[wrappedSymbol] // 'a'

const wrappedString = new String('str');
typeof wrappedString // 'object'
obj[wrappedString] // 'b'
```

#### 7.6.1.1 Property access in the spec

property를 get, set하는 것은 `ToPropertyKey()` 함수를 쓴다.

> The operator for getting and setting properties uses the internal operation `ToPropertyKey()`, which works as follows:

- `ToPrimitive()` 함수로 원시타입으로 바꾸는데 선호되는 타입은 문자열이다.(Convert the operand to a primitive via ToPrimitive() with the preferred type `string`):
    + 원시 타입이 그대로 리턴된다.(Primitive values are returned as is.)
    + 대부분의 객체는 `ToString()`을 통해 변환되는데 아니라면 `valueOf()` 함수가 호출되고 이 때도 아니라면 TypeError가 난다.(Most objects are converted via the method toString() – if it returns a primitive value. Otherwise, valueOf() is used – if it returns a primitive value. Otherwise, a TypeError is thrown.)
    + 심볼 객체는 단 하나의 예외다. wrap 되는 것에 따라 타입이 변환된다.(Symbol objects are one exception: they are converted to the symbols that they wrap.)
- 만약 결과가 심볼이라면 심볼을 리턴한다.(If the result is a symbol, return it.)
- 아니라면 결과를 `ToString()`으로 형변환한다.(Otherwise, coerce the result to string via ToString().)

## 7.7 Converting symbols to other primitive types

다음 테이블은 명시적 혹은 암묵적으로 심볼을 다른 원시 타입으로 형변환할 때 생기는 결과들이다.

> The following table shows what happens if you explicitly or implicitly convert symbols to other primitive types:

| Conversion to |     Explicit conversion      | Coercion(Implicit conversion)  |
|---------------|------------------------------|--------------------------------|
| boolean       | `Boolean(sym)` -> OK         | `!sym` -> OK                   |
| number        | `Number(sym)` -> `TypeError` | `sym*2` >- `TypeError`         |
| string        | `String(sym)` -> OK          | `''+sym` -> `TypeError`        |
|               | `sym.toString()` -> OK       | ``` `${sym}` ```-> `TypeError` |

### 7.7.1 Pitfall: coercion to string

문자열로 형변환하는 것은 종종 실수를 유발한다.

> Coercion to string being forbidden can easily trip you up:

```js
const sym = Symbol();

console.log('A symbol: '+sym); // TypeError
console.log(`A symbol: ${sym}`); // TypeError
```

이 문제를 해결하려면 명시적으로 문자열 형변환해줘야 한다.

> To fix these problems, you need an explicit conversion to string:

```js
console.log('A symbol: '+String(sym)); // OK
console.log(`A symbol: ${String(sym)}`); // OK
```

### 7.7.2 Making sense of the coercion rules

암묵적 형변환은 종종 심볼에서 금지된다. 이번 섹션은 이유에 대해서 설명한다.

> Coercion (implicit conversion) is often forbidden for symbols. This section explains why.

#### 7.7.2.1 Truthiness checks are allowed

boolean으로 암묵적 형변환은 항상 허용된다. 주로 if 문 또는 다른 위치에서 진실인지 체크하기 위해 사용된다.

> Coercion to boolean is always allowed, mainly to enable truthiness checks in if statements and other locations:

```js
if (value) { ··· }
param = param || 0;
```

#### 7.7.2.2 Accidentally turning symbols into property keys

심볼은 특별한 property key다. 그래서 실수로라도 심볼을 완전히 다른 타입인 문자열로 바꾸고싶지 않을 것이다. 이것은 `+` 연산자를 사용해서 property name을 동적으로 연산할 때 발생할 수 있다.

> Symbols are special property keys, which is why you want to avoid accidentally converting them to strings, which are a different kind of property keys. This could happen if you use the addition operator to compute the name of a property:

```js
myObject['__' + value]
```

이것이 value가 심볼일 때 TypeError가 발생하는 이유다.

> That’s why a TypeError is thrown if value is a symbol.

#### 7.7.2.3 Accidentally turning symbols into Array indices

실수로 심볼을 배열의 인덱스로 바꾸는 것도 원치 않을 것이다. 다음 코드는 value가 심볼일 때 일어날 수 있는 일들이다.

> You also don’t want to accidentally turn symbols into Array indices. The following is code where that could happen if value is a symbol:

```js
myArray[1 + value]
```

이것이 value가 심볼일 때 TypeError가 발생하는 이유다.

> That’s why the addition operator throws an error in this case.

### 7.7.3 Explicit and implicit conversion in the spec

#### 7.7.3.1 Converting to boolean

명시적으로 심볼을 boolean으로 바꾸려면 `Boolean()`을 호출한다. 심볼을 true로 바꿔줄 것이다.

> To explicitly convert a symbol to boolean, you call Boolean(), which returns true for symbols:

```js
const sym = Symbol('hello');
Boolean(sym) // true
```

`Boolean()`은 내부 함수인 `ToBoolean()`을 통해서 결과를 연산한다. 함수는 심볼과 다른 true인 값들을 true로 바꾼다.

> `Boolean()` computes its result via the internal operation ToBoolean(), which returns true for symbols and other truthy values.

암묵적 변환 역시 `ToBoolean()` 함수를 사용한다.

> Coercion also uses ToBoolean():

```js
!sym // false
```

#### 7.7.3.2 Converting to number

명시적으로 심볼을 숫자로 변환하려면 `Number()` 함수를 호출한다.

> To explicitly convert a symbol to number, you call Number():

```js
const sym = Symbol('hello');
Number(sym) // TypeError: can't convert symbol to number
```

`Number()` 함수는 결과를 `ToNumber()` 함수를 통해 연산하는데 symbol이 매개변수로 들어오면 TypeError를 일으킨다.

> Number() computes its result via the internal operation ToNumber(), which throws a TypeError for symbols.

암묵적 변환 역시 `ToNumber()`를 이용한다.

> Coercion also uses ToNumber():

```js
+sym // TypeError: can't convert symbol to number
```

#### 7.7.3.3 Converting to string

명시적으로 심볼을 문자열로 바꾸려면 `String()`을 이용한다.

> To explicitly convert a symbol to string, you call String():

```js
const sym = Symbol('hello');
String(sym) // 'Symbol(hello)'
```

만약 `String()`의 매개변수가 심볼이라면 문자열로 전환하는데 심볼이 생성될 때 괄호 안에 들어갔던 description 부분을 리턴한다. 만약 설명 부분이 없었다면 빈 문자열이 사용된다.

> If the parameter of String() is a symbol then it handles the conversion to string itself and returns the string Symbol() wrapped around the description that was provided when creating the symbol. If no description was given, the empty string is used:

```js
String(Symbol()) // 'Symbol()'
```

`toString()` method는 `String()` 함수와 같은 문자열을 리턴한다. 다른 함수임에도 내부적으로는 같은 함수인 `SymbolDescriptiveString()` 함수를 호출한다.

> The toString() method returns the same string as String(), but neither of these two operations calls the other one, they both call the same internal operation SymbolDescriptiveString().

```js
Symbol('hello').toString() // 'Symbol(hello)'
```

암묵적 변환은 내부적으로 `ToString()`이 활용된다. 심볼에 대해서는 TypeError를 일으킨다. 매개변수를 암묵적으로 문자열로 형변환시키는 함수 중 하나가 `Number.parseInt()`다.

> Coercion is handled via the internal operation ToString(), which throws a TypeError for symbols. One method that coerces its parameter to string is Number.parseInt():

```js
Number.parseInt(Symbol()) // TypeError: can't convert symbol to string
```

#### 7.7.3.4 Not allowed: converting via the binary addition operator (+)

`+` 연산자는 다음처럼 작동한다.

> The addition operator works as follows:

- 양쪽 피연산자를 모두 원시타입으로 변환한다.
    + Convert both operands to primitives.
- 한쪽 피연산자가 문자열이면 양쪽 모두를 암묵적으로 `ToString()`을 활용해서 문자열화한다. 그리고 둘을 연결해서 리턴한다.
    + If one of the operands is a string, coerce both operands to strings (via ToString()), concatenate them and return the result.
- 어느 한 쪽도 문자열이 아니라면 두 피연산자 모두를 숫자로 암묵적 변환하여 더하고, 결과를 리턴한다.
    + Otherwise, coerce both operands to numbers, add them and return the result.

심볼을 문자열과 숫자로 암묵적 형변환하는 것은 예외를 일으킨다. 이것은 심볼에 대해서 `+` 연산자를 '바로' 사용할 수는 없음을 의미한다.

> Coercion to either string or number throws an exception, which means that you can’t (directly) use the addition operator for symbols:

```js
'' + Symbol() // TypeError: can't convert symbol to string
1 + Symbol() // TypeError: can't convert symbol to number
```

## 7.8 JSON and symbols

### 7.8.1 Generating JSON via JSON.stringify()

`JSON.stringify()` 함수는 자바스크립트 데이터를 JSON 문자열로 변환한다. 전처리 단계는 변환을 customize 할 수 있게 한다. callback 함수, 즉 replacer라고도 불리는 것은 자바스크립트 데이터 안에 있는 어떤 값이라도 다른 것으로 대체할 수 있다. 이는 replacer가 JSON과 맞지 않는 값(심볼이나 date 객체)을 JSON 친화적인 값(문자열)으로 인코딩할 수 있음을 의미한다. `JSON.parse()`는 이 과정을 비슷한 메커니즘으로 반대로 실행한다. 자세한 것은 [링크](http://speakingjs.com/es5/ch22.html#JSON.stringify) 참조

> JSON.stringify() converts JavaScript data to JSON strings. A preprocessing step lets you customize that conversion: a callback, a so-called replacer, can replace any value inside the JavaScript data with another one. That means that it can encode JSON-incompatible values (such as symbols and dates) as JSON-compatible values (such as strings). JSON.parse() lets you reverse this process via a similar mechanism([details](http://speakingjs.com/es5/ch22.html#JSON.stringify))

하지만 `stringify`는 문자열이 아닌 property key를 무시한다. 그래서 아래 코드와 같은 접근은 오직 심볼이 property 값일 때에만 작동한다.

> However, stringify ignores non-string property keys, so this approach works only if symbols are property values. For example, like this:

```js
function symbolReplacer(key, value) {
    if (typeof value === 'symbol') {
        return '@@' + Symbol.keyFor(value) + '@@';
    }
    return value;
}
const MY_SYMBOL = Symbol.for('http://example.com/my_symbol');
const obj = { myKey: MY_SYMBOL };

const str = JSON.stringify(obj, symbolReplacer);
console.log(str); // {"myKey":"@@http://example.com/my_symbol@@"}
```

위 코드에서 심볼은 키 앞뒤로 '@@'가 붙여지면서 문자열로 바뀐다. 오직 `Symbol.for()` 함수로 생성된 심볼만 그러한 키가 있음을 명심한다.

> A symbol is encoded as a string by putting '@@' before and after the symbol’s key. Note that only symbols that were created via Symbol.for() have such a key.

### 7.8.2 Parsing JSON via JSON.parse()

`JSON.parse()`는 JSON 문자열을 JavaScript 데이터로 변환한다. 전처리 과정은 역시 callback 함수, reviver라고 불리는 것을 통해 변환을 customize 할 수 있는데 어떤 값이라도 가능하다. 이는 JSON data(문자열) 안에 들어있는 JSON이 아닌 데이터(symbol, date)도 변환이 가능함을 말한다. 다음 코드를 보자.

> JSON.parse() converts JSON strings to JavaScript data. A postprocessing step lets you customize that conversion: a callback, a so-called reviver, can replace any value inside the initial output with another one. That means that it can decode non-JSON data (such as symbols and dates) stored in JSON data ([such as strings](http://speakingjs.com/es5/ch22.html#JSON.parse)). This looks as follows.

```js
const REGEX_SYMBOL_STRING = /^@@(.*)@@$/;
function symbolReviver(key, value) {
    if (typeof value === 'string') {
        const match = REGEX_SYMBOL_STRING.test(value);
        if (match) {
            const symbolKey = match[1];
            return Symbol.for(symbolKey);
        }
    }
    return value;
}

const parsed = JSON.parse(str, symbolReviver);
console.log(parse);
```

'@@'로 시작하고 끝나는 문자열은 @@ 사이의 값을 심볼 키로 해서 심볼로 변환되었다.

> Strings that start and end with '@@' are converted to symbols by extracting the symbol key in the middle.

## 7.9 FAQ: symbols

### 7.9.1 Can I use symbols to define private properties?

심볼의 원래 계획은 private property를 지원하는 것이었다. public, private 심볼이 있었다. 하지만 이 기능은 기각됐다. 왜냐하면 private 데이터를 관리하는 get, set(meta-object 프로토콜 연산)을 사용하는 것은 프록시와 잘 상호작용하지 못했기 때문이다.

> The original plan was for symbols to support private properties (there would have been public and private symbols). But that feature was dropped, because using “get” and “set” (two meta-object protocol operations) for managing private data does not interact well with proxies:

- 우선 당신은 프록시가 타겟을 완전히 고립시키고, 모든 MOP 연산이 타겟에 적용되는 것을 중간에서 가로채길 원할 것이다.
    + On one hand, you want a proxy to be able to completely isolate its target (for membranes) and to intercept all MOP operations applied to its target.
- 동시에 프록시는 private 데이터를 객체에서 추출할 수 없어야하고 private 데이터는 private으로 남아야 한다.
    + On the other hand, proxies should not be able to extract private data from an object; private data should remain private.

이 두 목표는 있음직한 일이다.

> These two goals are at odds.

class에 관한 챕터에서 private 데이터를 관리하는 옵션에 대해서 설명할 것이다.

> The chapter on classes explains your options for managing their private data.

### 7.9.2 Are symbols primitives or objects?

어떤 면에서는 심볼은 원시값이고, 어떤 점에서는 객체다.

> In some ways, symbols are like primitive values, in other ways, they are like objects:

- 콘셉트를 나타내는 것과 property key로 사용된다는 점에서 심볼은 원시값인 문자열과 비슷하다.
    + Symbols are like strings (primitive values) w.r.t. what they are used for: as representations of concepts and as property keys.
- 각각의 symbol이 고유한 정체성을 지닌다는 점에서 객체와 비슷하다.
    + Symbols are like objects in that each symbol has its own identity.

그러면 심볼은 무엇일까. 원시값인가 객체인가. 결국 두 가지 이유로 원시값이 되었다.

> What are symbols then – primitive values or objects? In the end, they were turned into primitives, for two reasons.

첫째로 심볼은 객체보단 문자열과 더 닮았다. 심볼은 언어의 가장 기본적인 값이다. 불변성을 지니고 property key로 사용된다. unique한 정체성을 지니는 심볼은 문자열과 비슷하다는 점을 부정할 필요가 없다. UUID 알고리즘은 준-unique한 문자열들을 만들어낸다.

> First, symbols are more like strings than like objects: They are a fundamental value of the language, they are immutable and they can be used as property keys. Symbols having unique identities doesn’t necessarily contradict them being like strings: UUID algorithms produce strings that are quasi-unique.

둘째로 심볼은 property key로서 가장 자주 사용된다. 그래서 심볼은 자바스크립트 명세를 최적화하고, 그런 용례들을 구현하기에 가장 적합하다. 그래서 많은 객체의 기능들, 다음에서 나열하는 것들이 불필요해졌다.

> Second, symbols are most often used as property keys, so it makes sense to optimize the JavaScript specification and the implementations for that use case. Then many abilities of objects are unnecessary:

- 객체는 다른 객체의 prototype이 될 수 있다.
    + Objects can become prototypes of other objects.
- 객체를 프록시로 wrapping하는 것은 객체가 사용될 수 있는 기능들을 바꾸지 않는다.
    + Wrapping an object with a proxy doesn’t change what it can be used for.
- 객체는 `instanceof`, `Object.keys()` 등의 함수를 통해 속성을 볼 수 있다.
    + Objects can be introspected: via instanceof, Object.keys(), etc.

이러한 기능들을 가지지 않는 것은 명세와 그것의 구현을 쉽게 한다. V8 팀에서 나온 리포트를 보면 property key를 다룰 때 원시값이 객체보다 더 다루기가 쉽고 간단했다고 한다.

> Them not having these abilities makes life easier for the specification and the implementations. There are also reports from the V8 team that when handling property keys, it is simpler to treat primitives differently than objects.

### 7.9.3 Do we really need symbols? Aren’t strings enough?

문자열과 다르게 심볼은 unique하고 이름 충돌을 방지한다. 그래서 색깔을 나타내는 token을 사용할 때 편리하다. 하지만 `Symbol.iterator`를 키로 가지는 meta-level의 method들을 꼭 지원해야 한다. 파이썬은 `__iter__`라는 특별한 이름을 사용해서 이름 충돌을 막는다. 언어 메커니즘에 따라 언더스코어를 2개 써서 쓸 수 있지만 라이브러리에선 어떻게 하는가? 심볼을 쓰면 모든 것에 대해서 사용할 수 있는 확장성 있는 메커니즘을 가지게 된다. 나중에 알 수 있겠지만 public symbol에 대한 섹션에서 자바스크립트는 그 자체로 이미 이러한 메커니즘을 충분히 사용하고 있다.

> In contrast to strings, symbols are unique and prevent name clashes. That is nice to have for tokens such as colors, but it is essential for supporting meta-level methods such as the one whose key is `Symbol.iterator`. Python uses the special name `__iter__` to avoid clashes. You can reserve double underscore names for programming language mechanisms, but what is a library to do? With symbols, we have an extensibility mechanism that works for everyone. As you can see later, in the section on public symbols, JavaScript itself already makes ample use of this mechanism.

충돌이 없는 property key로서 심볼의 가설상의(논리적, 이론적인) 대안이 존재한다. 이름 짓는 convention(관습)을 사용하는 것이다. 예를 들어 URL을 나타내는 문자열(e.g. 'http://example.com/iterator')이 있다. 하지만 이것은 두 번째 property key 카테고리를 만드는 것에 불과하다. 결국 심볼의 기본적인 기능이기도 하고 말이다. 문자열 normal property name은 대개 유효한 구분자로서 작용하긴 하지만 `:`, `/`, `.` 등의 것을 포함하지 않는다. 즉 명시적으로 키를 다른 값으로 바꾸는 것이 더 우아한 방식이다.

> There is one hypothetical alternative to symbols when it comes to clash-free property keys: use a naming convention. For example, strings with URLs (e.g. 'http://example.com/iterator'). But that would introduce a second category of property keys (versus “normal” property names that are usually valid identifiers and don’t contain colons, slashes, dots, etc.), which is basically what symbols are, anyway. Thus it is more elegant to explicitly turn those keys into a different kind of value.

### 7.9.4 Are JavaScript’s symbols like Ruby’s symbols?

자바스크립트의 심볼과 루비의 심볼은 비슷하지 않다.

> No, they are not.

루비의 심볼은 기본적으로 값을 생성하는 literal이다. 루비에서 같은 심볼을 두 번 정의하는 것은 같은 값을 두 번 만들어내는 것이다.

> Ruby’s symbols are basically literals for creating values. Mentioning the same symbol twice produces the same value twice:

```ruby
:foo == :foo # true
```

자바스크립트의 `Symbol()` 함수는 심볼을 만들어내는 factory다. 리턴되는 각 값은 unique하다.

> The JavaScript function Symbol() is a factory for symbols – each value it returns is unique:

```js
Symbol('foo') !== Symbol('foo')
```

## 7.10 The spelling of well-known symbols: why Symbol.iterator and not Symbol.ITERATOR (etc.)?

well-known 심볼은 소문자로 시작하고 camel-case인 이름의 property에 저장돼있다. 대개 property들은 상수이고 관습적으로 모두 대문자로 쓴다. 하지만 이 심볼의 경우엔 이름을 짓는 이유가 다르다. well-known 심볼은 normal property key 대신 쓰이고, 그렇기 때문에 이름이 상수가 아닌 property key의 규칙으로 정해지는 것이다.

> Well-known symbols are stored in properties whose names start with lowercase characters and are camel-cased. In a way, these properties are constants and it is customary for constants to have all-caps names (Math.PI etc.). But the reasoning for their spelling is different: Well-known symbols are used instead of normal property keys, which is why their “names” follow the rules for property keys, not the rules for constants.

## 7.11 The symbol API

이 섹션은 심볼에 대한 ES6 API의 전반적인 개론을 다룬다.

> This section gives an overview of the ECMAScript 6 API for symbols.

### 7.11.1 The function Symbol

- `Symbol(description?)` : `symbol`
    - 새로운 심볼을 만든다. optional 매개변수인 `description`을 지정하면 심볼을 설명할 수 있다. 설명 값에 접근하는 유일한 방법은 `toString()` 혹은 `String()`을 통해 심볼을 문자열로 바꾸는 것이다. 바꾼 결과는 `Symbol(decription)` 형태다.
    + Creates a new symbol. The optional parameter description allows you to give the symbol a description. The only way to access the description is to convert the symbol to a string (via toString() or String()). The result of such a conversion is 'Symbol('+description+')'.

`Symbol`은 생성자로 사용될 수 없다. new를 쓰면 예외가 발생한다.

> Symbol is can’t be used as a constructor – an exception is thrown if you invoke it via new.

### 7.11.2 Methods of symbols

심볼에서 유일하게 유용한 method는 `toString()` 이다. `Symbol.prototype.toString()` 형태로 제공된다.

> The only useful method that symbols have is toString() (as provided via `Symbol.prototype.toString()`).

### 7.11.3 Converting symbols to other values

| Conversion to |     Explicit conversion      | Coercion(Implicit conversion)  |
|---------------|------------------------------|--------------------------------|
| boolean       | `Boolean(sym)` -> OK         | `!sym` -> OK                   |
| number        | `Number(sym)` -> `TypeError` | `sym*2` >- `TypeError`         |
| string        | `String(sym)` -> OK          | `''+sym` -> `TypeError`        |
|               | `sym.toString()` -> OK       | ``` `${sym}` ```-> `TypeError` |
| object        | `Object(sym)` -> OK          | `Object.keys(sym)` -> OK       |

### 7.11.4 Well-known symbols

글로벌 객체인 `Symbol`은 몇 개의 property를 가지고 있는데 `well-known symbols`라고 불리며 상수처럼 작동한다. 이 심볼을 property key로 사용하면 ES6가 객체를 다루는 방식을 수정할 수 있다. 모든 well-known symbols에 대해 알아보려면 [링크](http://www.ecma-international.org/ecma-262/6.0/#sec-well-known-symbols)를 참조한다.

> The global object Symbol has several properties that serve as constants for so-called well-known symbols. These symbols let you configure how ES6 treats an object, by using them as property keys. This is a list of all well-known symbols:

- Customizing basic language operations ([explained in Chap. “New OOP features besides classes”](http://exploringjs.com/es6/ch_oop-besides-classes.html#sec_customizing-oop-via-well-known-symbols)):
    + `Symbol.hasInstance` (method)
        * Lets an object C customize the behavior of x instanceof C.
        * 객체 C가 자신의 인스턴스인 x의 행동을 customize할 수 있다.
    + `Symbol.toPrimitive` (method)
        * Lets an object customize how it is converted to a primitive value. This is the first step whenever something is coerced to a primitive type (via operators etc.).
        * 객체가 어떻게 원시타입으로 변환될 것인지를 customize한다. 뭔가가 암묵적으로 원시타입으로 변환될 때 언제나 일어나는 첫 단계이다.
    + `Symbol.toStringTag` (string)
        * Called by `Object.prototype.toString()` to compute the default string description of an object obj: `‘[object ‘+obj[Symbol.toStringTag]+’]’`.
        * `Object.prototype.toString()` 함수에 의해 호출되며 객체 obj의 경우에 속한 기본 문자열 설명값을 계산하여 다음 형태로 리턴한다. `‘[object ‘+obj[Symbol.toStringTag]+’]’`
    + `Symbol.unscopables` (Object)
        * Lets an object hide some properties from the with statement.
        * 객체가 어떤 property를 숨길 때 쓰인다.
- Iteration (explained in [the chapter on iteration](http://exploringjs.com/es6/ch_iteration.html#ch_iteration)):
    + `Symbol.iterator` (method)
        * A method with this key makes an object iterable (its elements can be iterated over by language constructs such as the for-of loop and the spread operator (...)); it returns an iterator. Details: chapter “Iterables and iterators”.
        * 이 함수를 키로 사용하는 메소드는 객체를 iterable로 만든다. iterable은 for-of 루프나 spread operator(펼침 연산자) 같은 것으로 iterate 할 수 있다.
- 문자열 메소드에서 call을 전달한다. 다음 나열되는 문자열 메소드들은 주로 정규표현식에서 매개변수를 통해 전달된다.(Forwarding calls from string methods: The following string methods are forwarded to methods of their parameters (usually regular expressions).)
    + `Symbol.match` is used by String.prototype.match.
    + `Symbol.replace` is used by String.prototype.replace.
    + `Symbol.search` is used by String.prototype.search.
    + `Symbol.split` is used by String.prototype.split.

세부 자료는 다음 [챕터](http://exploringjs.com/es6/ch_strings.html#sec_delegating-string-methods-regexp)에서 확인

> The details are explained in Sect. [“String methods that delegate regular expression work to their parameters”](http://exploringjs.com/es6/ch_strings.html#sec_delegating-string-methods-regexp) in the chapter on strings.

- Miscellaneous:
    + `Symbol.species` (method)
        * Configures how built-in methods (such as Array.prototype.map()) create objects that are similar to this. The details are explained in the chapter on classes.
        * `Array.prototype.map()` 같은 빌트인 함수들이 객체를 만드는 방식을 설정한다. 자세한 것은 클래스 [챕터](http://exploringjs.com/es6/ch_classes.html#sec_species-pattern) 참조
    + `Symbol.isConcatSpreadable` (boolean)
        * Configures whether Array.prototype.concat() adds the indexed elements of an object to its result (“spreading”) or the object as a single element (details are explained in the chapter on Arrays).
        * `Array.prototype.concat()` 함수가 객체의 인덱스된 요소를 결과에 추가하는지 단일 요소로서의 객체로 추가하는지 설정한다. 자세한 것은 [링크](http://exploringjs.com/es6/ch_arrays.html#Symbol_isConcatSpreadable) 참조

### 7.11.5 Global symbol registry

심볼을 모든 realm에서 동일하게 유지하고 싶다면 global symbol registry를 통해 심볼을 생성해야 한다. 다음 메소드들이 이를 가능하게 한다.

> If you want a symbol to be the same in all realms, you need to create it via the global symbol registry. The following method lets you do that:

- `Symbol.for(str)` : symbol
    + Returns the symbol whose key is the string str in the registry. If str isn’t in the registry yet, a new symbol is created and filed in the registry under the key str.
    + 레지스트리에서 문자열 `'str'`인 키를 찾고 그와 연관된 심볼을 리턴한다. `'str'`이 레지스트리에 없으면 새로운 심볼이 만들어지고 `'str'`을 키로 해서 심볼이 레지스트리에 저장된다.

다른 메소드는 '역 look up'이다. 즉 레지스트리에서 심볼을 가지고 그에 맞는 문자열 키를 찾아낸다. 심볼을 serializing 하는데서 유용하다.

> Another method lets you make the reverse look up and found out under which key a string is stored in the registry. This is may be useful for serializing symbols.

- `Symbol.keyFor(sym)` : string
    + returns the string that is associated with the symbol sym in the registry. If sym isn’t in the registry, this method returns undefined.
    + 레지스트리에서 symbol `sym`과 연관되어있는 문자열을 리턴한다. `sym`이 레지스트리에 없으면 undefined를 리턴한다.
