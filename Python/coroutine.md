# 코루틴(coroutine)

참조 링크: [공식 문서](https://docs.python.org/2.5/whatsnew/pep-342.html), [PythonEngine](http://pyengine.blogspot.kr/2011/07/python-coroutine-2.html), [dabeaz](http://www.dabeaz.com/coroutines/index.html)

## 1. 개념

- 일반적인 함수끼리의 관계는 '부르고', '불려지는' 관계이다. 예를 들어 A, B 함수가 있는데 A 내부에서 B 함수를 사용하는 경우다. 대부분이 이러한 종속적인 관계다. 코루틴은 이런 caller와 callee의 종속 관계가 아니라 대등하게 서로 대화하는 형태를 말한다.
- 대화는 상대방의 말에 반응하는 것이다. 그리고 했던 말 또 반복할 필요가 없다. 이미 말한 말은 상대가 당연히 기억하고 있으니까 말이다. 그래서 프로그램에선 yield를 사용하여 두 함수가 서로의 결과물을 주거니 받거니하면서 턴을 넘긴 그 순간을 계속 기억하고 있는다. 즉 코루틴은 generator의 한 사용 형태라고도 할 수 있겠다.

## 2. 예제

```python
def coroutine(func):
    def start(*args, **kwargs):
        cr = func(*args, **kwargs)
        next(cr)
        return cr
    return start

@coroutine
def grep(pattern):
    print("Looking for %s" % pattern)
    while True:
        line = (yield)
        if pattern in line:
            print(line)

g = grep("python")

# Notice how you don't need a next() call here
g.send("Yeah, but no, but yeah, but no")
g.send("A series of tubes")
g.send("python generators rock!")

# 출력: Looking for python\n python generators rock!
```

- 코루틴을 데코레이터로 사용했다.
- 컴파일러가 `@coroutine` 코드를 만나는 순간 coroutine 함수가 실행된다. 바로 아래 코드인 grep 함수를 매개변수로 받아서 start 함수를 만들고 리턴한다. 다음에 grep 함수가 실행될 때 이 start 함수가 실행되게 된다.
- `g = grep("pytohn")` 코드가 실행된다. grep은 안에 yield가 구현되어있으므로 generator다. 즉 이 함수에 next()를 실행하면 중간 중간 멈춰가며 데이터를 받아오고 다시 그 지점에서 실행할 수 있다. 즉 coroutine 함수는 제너레이터 객체를 한 번씩 iteration 시키는 함수인 것이다.
- 우선 첫 실행이다. 'Looking for python'이 출력된다. 그리고 무한반복을 돈다. `line = (yield)` 코드가 생소하다. 일반적으로 'yield something'으로 리턴하는 형태로 쓰인다. 그런데 이렇게 yield가 뒤에 쓰이면 입력으로 받는다는 의미다. 입력으로 받아서 line 변수에 저장한다.
- 만약 입력받은 패턴인 'python'이 line 안에 있으면 line을 출력한다. `send` 함수는 입력으로 받는 형태로 구현되어있을 yield에 값을 전달하는 함수다.

## 3. 입력과 리턴을 동시에 하는 예제

- 2.3까지는 yield가 statement였지만 2.5부터 expression으로 바뀌었다. 이 때부터 yield가 값을 입력받을 수도 있게 됐다.
- 동시에 yield를 괄호로 감싸는걸 추천한다고 문서에 나와있다. 2번 예제에서는 그저 입력만 받고 있지만, 입력과 리턴을 동시에 하는 경우엔 괄호로 감싸야 다른 오류를 방지할 수 있기 때문이다. 그래서 그냥 입력을 받지 않더라도 괄호로 감싸는게 정신 안사납고 좋다고 한다.
- 재밌는 것은 next를 쓰면 당연히 yield 뒤의 i 값이 반환되는 거지만 send를 사용하더라도 그 send에 사용된 값이 반환된다. 입력받아서 val에 저장한 후 그 val을 리턴하는 코드는 없지만 자동으로 입력받으면서 이뤄지는 것 같다.
- 이거 외에도 `a.close()`하면 제너레이터가 바로 닫히고 다시 next를 호출하면 StopIteration이 뜬다. 그리고 `throw(type, value=None, traceback=None)` 형태로 a.throw(AttributeError)를 입력하면 입력한 에러나 exception이 raise되고 제너레이터는 닫힌다.

```python
def counter (maximum):
    i = 0
    while i < maximum:
        val = (yield i)
        # If value provided, change counter
        if val is not None:
            i = val
        else:
            i += 1

a = counter(10)
print(next(a))   # => 0
print(next(a))   # => 1
print(a.send(8)) # => 8
print(next(a))   # => 9
print(next(a))   # => StopIteration Exception
```

## 4. dabeaz.com 예제들

[dabeaz.com](http://www.dabeaz.com/coroutines/index.html) 사이트에 코루틴 예제들이 엄청 많다. 여기 걸로 연습 해봐야겠다.
