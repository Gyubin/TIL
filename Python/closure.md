# closure

출처: [khanrc's blog](http://khanrc.tistory.com/entry/decorator%EC%99%80-closure), [JONNUNG](http://jonnung.blogspot.kr/2014/09/python-easy-closure.html)

## 1. 클로저 개념

- nested function 혹은 wrapper같은 개념이다.
- 함수 안에서 nested function이 선언, 정의되고 이 내부 함수가 리턴된다.
- [중요] function closure: 함수가 정의될 때 그 때 속한 namespace를 기억한다. 즉 내부 함수가 외부 함수의 맥락을 기억하고 있는 것이다.
- 첫 번째 outer() 함수 예제에서 마지막에 foo()를 실행하면 1이 출력된다. 사실 inner 함수가 사용하는 x변수는 outer 안에 있기 때문에 outer()가 정의되고 끝난 순간 x 값은 지역변수이므로 사라져야 한다. 하지만 foo()라고 실행하면 1이 출력된다. 이것이 function closure다.
- `foo.func_closure`를 실행해서 foo를 감싸고 있는 scope의 변수를 볼 수 있다.

```python
# 첫 번째 예제
def outer():
    x = 1
    def inner():
        print x # 1
    return inner
foo = outer()
foo()
# 출력: 1

foo.func_closure
# 출력: (<cell at 0x1055e97c0: int object at 0x7fde916057d8>,)

# 두 번째 예제
def outer(x):
    def inner():
        print x # 1
    return inner
print1 = outer(1)
print2 = outer(2)
print1()
# 출력: 1
print2()
# 출력: 2
```

정리하면 다음과 같다.

- 중첩 함수(Nested Function)를 갖는다.
- 중첩 함수는 자신을 감싸고 있는 함수 영역(부모함수)의 변수를 참조하고 있다. 즉 어떠한 함수를 객체로 받을 때 그 함수를 감싸는 scope의 변수들 또한 같이 가져간다는 의미다.
- 부모함수는 중첩 함수(자식 함수)를 반환한다.

## 2. 어디서 사용되는가

- 가장 많이 쓰이는 케이스: 내부 데이터를 은닉할 때.
    + 즉 private 데이터를 만들 때 사용한다.
    + 변수명을 통해 데이터를 직접 통제하는 것이 아니라 변수에 접근하는 메소드만 갖고 있는 것이다.
    + 예를 들어 자바같은 경우엔 private이나 public같은 것으로 변수의 속성을 정해줄 수 있지만 파이썬엔 이런 용법이 없다. 그렇기 때문에 클로저라는 형식으로 구현하는 것이다.
    + 데이터를 지역변수 형태로 만들어서 함수의 정의가 끝나면 사라지도록 했지만, 그 변수를 기억하는 get, set 메소드를 정해두는 것이다.
- 전역 변수를 사용하지 않으려고 할 때
- 모든 것을 객체로 만드는 것은 때때로 비효율적일 수 있다. 메소드가 하나 밖에 없는 객체같은 경우는 클로저를 활용하는 것이 더 우아한 방법이다.

## 3. 주요 예제

참고 글에서 js로 구현돼있던 예제를 파이썬으로 바꿔봤다.

```python
test = [0]*5
for i in range(5):
    def inner():
        return i
    test[i] = inner

for j in range(5):
    print(test[j]())
# => 4 4 4 4 4

test = [0]*5
for i in range(5):
    def outer(i):
        def inner():
            return i
        return inner
    test[i] = outer(i)

for j in range(5):
    print(test[j]())
# => 0 1 2 3 4
```

- 첫 예제에서 4가 5번 출력되는 것은 test 리스트에 들어가있는 inner function이 i를 리턴하려고 할 때 최종적으로 글로벌 변수인 i까지 갔기 때문이다. i는 for 반복을 돌아서 4까지 갔기 때문에 결국 4가 5번 출력된다.
- 둘 째 예제에서는 test 리스트에 들어있는 inner function이 i를 리턴하려고 할 때 function closure로 기억하고 있는 outer function의 scope에서 지역변수(매개변수로 들어온)인 i를 찾게된다. 그래서 각각의 inner 함수가 갖고 있는 scope의 i를 출력하게 되므로 0 1 2 3 4 가 출력되는 것이다.
- 어쩌다가 알게된 것은 파이썬에서 for문 내에서 선언된 변수는 global 변수 취급된다는 것이다. 즉 for 문은 block이 아니라는 것? 루비에서도 마찬가지다. 루비에서도 일반적인 `for i in iterable ~~ end` 형태로 사용하면 내부 선언된 변수는 전역변수 취급된다. 그런데 만약 `(1..5).each do |x| ~~ end` 형태로 do-end block을 사용한다면 내부 선언된 변수는 저 반복이 끝나면 사라진다. 왜 이런걸까.
