# iterator, generator
참고링크: [pymbook](http://pymbook.readthedocs.org/en/latest/igd.html), 공식 문서

## 1. iterator

iterate 단어 자체의 의미가 '반복하다'이다. 주로 쓰이는 다음 세 가지 단어들에 기본 의미만 적용해도 무엇을 의미하는지 유추할 수 있다.

```python
# iterable
list_ex = [0, 1, 2]

# iterator
iterator_ex = iter(list_ex)

# iteration 동작 python3.x
next(iterator_ex) # 출력: 0
next(iterator_ex) # 출력: 1
next(iterator_ex) # 출력: 2
next(iterator_ex) # StopIteration

# iteration 동작 python2.x
iterator_ex.next()
```

- iterable: 반복이 되는 객체다. 일반적으로 생각했을 때 `for i in iterable:` 형태로 사용할 수 있었던 것들이다. 리스트, 딕셔너리, 세트, 튜플 등등이다.
- iterator: 반복을 하게 하는 객체다. 위 iterable 객체를 `iter()`의 매개변수로 넣어서 만든다. iterator를 가지고 iterable을 반복시키는 것이다. iterator 자체를 출력해보면 `<list_iterator object at 0x10bc06358>`라고 뜬다. 튜플이라면 list 대신 tuple이 된다.
- iteration: 반복하는 그 동작 자체를 말한다. `next()`를 실행할 때마다 iterable의 원소 하나하나를 계속 리턴한다. 끝에 도달하면 반복을 멈춘다. 파이썬 버전 2와 버전 3에서 next 실행 방식이 바뀌었다.

## 2. generator

### A. 기본

- generator는 쉽게 iterator를 생성할 수 있는 수단이다. yield만 쓰면 generator가 된다. yield는 일반함수 쓰듯이 사용하면 되는데 뒤에 괄호는 안 붙는다. `next()`가 실행될 때마다 `yield` 가 실행됐던 그 순간으로 되돌아가서 다음 코드를 실행한다. 즉 yield는 마지막 실행했던 그 순간을 기억하고 있는 것이다.
- 이런 방식이 필요한 이유는 대량의 데이터를 처리할 때 한 번에 모든 것을 처리하는 것은 시간이 오래걸리기 때문에 데이터를 소량씩 중간 중간 처리해야할 때가 있기 때문이다. 소량의 데이터라면 상관 없지만 이렇게 대량일 경우엔 모든 작업이 다 끝나기를 마냥 기다릴 수만은 없다. 물론 그 때 그 때 중간 상황을 변수로 저장해서 통째로 넘길 수도 있지만 이보단 generator를 써서 상태를 유지하고 제어권만 넘기는 방식이 더 유용하다.

```python
def reverse(data):
    for index in range(len(data)-1, -1, -1):
        yield data[index]
for char in reverse('golf'):
    print(char, end=' ')
# 출력: f l o g
######################################
def gen_num():
    i = 0
    while 1:
        yield i
        i += 1
a = gen_num()
for x in range(10) :
    print(a.next())
# 출력: 0 1 2 3 4 5 6 7 8 9
```

> `iter()`가 고정된 순서(시작부터 마지막까지)의 iterator를 만드는거라면 generator는 내가 순서와 전후 처리에 있어서 마음껏 customize를 할 수 있는 iterator 생성기라고 할 수 있다.

### B. 응용

- 위 예시처럼 함수가 아니라 클래스에서도 `__iter__()`와 `__next__()`를 구현해주면 된다.
    + `__iter__()`: 이 메소드는 클래스 내에서 iterator 객체를 리턴해주면 된다. 즉 원하는 데이터를 선택하고 `return iter(data)` 하면 된다. 당연한 말이지만 만약 객체의 데이터가 딕셔너리라면 키 데이터를 iter의 매개변수로 넣어주면 된다.
    + `__next__()`: 제너레이터를 시작하고, 중단 지점에서 다시 재시작하게 해준다. 만약 제너레이터가 다른 값을 yield하지 않고 끝나게될 땐 StopIteration exception을 raise하면 된다. 실제로 `yield` 코드를 쓰는게 아니라 그냥 `return`하면 된다. 이 메소드는 for 반복 등에서 내부적으로 자동으로 실행된다.

#### 1) 그냥 `next()` 구현 예

다음은 그냥 사용자가 만든 next라는 메소드를 호출할 수 있는 예다. `y = yrange(3)` 으로 객체를 만들고 `y.next()`를 호출하면 순서대로 0, 1, 2가 나오고 마지막에 Exception이 raise된다. 이 때는 `next(y)` 하면 오류난다.

```python
class yrange:
    def __init__(self, n):
        self.i = 0
        self.n = n

    def __iter__(self):
        return self

    def next(self):
        if self.i < self.n:
            i = self.i
            self.i += 1
            return i
        else:
            raise StopIteration()
```

#### 2) `__next__()` 구현 예
위 1)에서와 달리 `next(counter)` 하면 정상적으로 순서대로 출력이 된다.

```python
class Counter(object):
    def __init__(self, low, high):
        self.current = low
        self.high = high

    def __iter__(self):
        'Returns itself as an iterator object'
        return self

    def __next__(self):
        'Returns the next value till current is lower than high'
        if self.current > self.high:
            raise StopIteration
        else:
            self.current += 1
            return self.current - 1
```

## 3. 최종 정리
next(something) 형태로 쓸 수 있으려면, 즉 iterator 객체를 만들려면

- 함수 형태: 내부에서 `yield`를 쓰면 된다.
- 클래스: `__next__()` 메소드가 구현되면 된다.
- 객체: `iter(iterable)` 함수의 리턴값을 사용한다.
