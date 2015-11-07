# #19 Vector Class
Vector에 관한 클래스를 만드는 문제다. 리스트를 매개변수로 받는 것과 벡터 합, 뺄셈, 내적, norm 값을 구하는 메소드를 구현한다.

## 1. 내 코드

- init: 리스트를 받아서 인스턴스 변수로 대입한다. 만약 리스트를 입력하지 않으면 TypeError를 raise한다.
- 벡터의 합, 차, 내적은 길이가 같은 벡터끼리 적용된다. 그래서 벡터의 크기를 비교하는 check_length 메소드를 만들었다. 단순히 len 함수를 사용해서 크기를 비교했다.
- add, subtract, dot 메소드 모두 순서대로 원소를 뽑아내 더하고, 빼고, 곱했다.
- Vector 인스턴스를 문자열로 만드는 메소드와 equals 메소드를 구현하라고 해서 마지막에 메소드 2개를 추가했다.

```python
import math
class Vector:
    def __init__(self, vector):
        if type(vector) != type([]):
            raise TypeError
        self.vector = vector

    def check_length(self, other):
        if len(self.vector) != len(other.vector):
            raise BufferError
        return len(self.vector)

    def add(self, other):
        length = self.check_length(other)
        result_list = []
        for i in range(length):
            result_list.append(self.vector[i] + other.vector[i])
        return Vector(result_list)

    def subtract(self, other):
        length = self.check_length(other)
        result_list = []
        for i in range(length):
            result_list.append(self.vector[i] - other.vector[i])
        return Vector(result_list)

    def dot(self, other):
        length = self.check_length(other)
        return sum(self.vector[i] * other.vector[i] for i in range(length))

    def norm(self):
        return math.sqrt(sum(i**2 for i in self.vector))

    def __str__(self):
        return str(tuple(self.vector)).replace(' ', '')

    def equals(self, other):
        return True if str(self) == str(other) else False
```

## 2. 다른 해답

### A. 최고 득표

정말 클래스의 정석이라서? 사실 정석적으로 짠다는 게 어떤건지 잘 모른다. 최고 득표라서 그렇지 않을까 하는 것 뿐이다.

- oprator 모듈은 안에 사칙연산 뿐만 아니라 논리연산자 등 not, truth, is, abs, lshift(비트연산하는거), neg(-1을 곱함), pos 등 다양한 함수를 구현해놨다. map이나 reduce 함수를 사용하는데 +, * 이런 기호를 쓸 수가 없으니 이 모듈의 함수들을 사용하는 것 같다. 좋다.
- ```__len__(self)``` : 내부에서 원하는 데이터의 길이를 len 함수로 구한 후 리턴하면 된다. 그러면 인스턴스를 바로 len(instance) 해서 길이를 구할 수 있다.
- ```__iter__(self)``` : 내가 만든 클래스에서 iter 함수를 구현하면 클래스가 iterator가 된다. 아래 코드에서처럼 self를 매개변수에 넣고, 반복하고싶은 데이터를 iter 함수에 담아 리턴하면 된다.
- ```__getitem__(self, index)``` : iter와 마찬가지로 이 함수를 클래스 내에 구현하면 ```my_instance[index]``` 형태로 데이터를 꺼낼 수 있다. 딕셔너리든 리스트든 안에 getitem 함수 안에 구현하는 형태에 따른다.
- decorator(a.k.a. wrapper) 사용: [다른 글](https://github.com/Gyubin/TIL/blob/master/Python/decorator_wrapper.md)에서 설명

```python
from math import sqrt
import operator as op
from itertools import imap

class Vector:
  def __init__(self, array=[]):
    self.__data = array
  
  def __len__(self):
    return len(self.__data)
    
  def __iter__(self):
    return iter(self.__data)
    
  def __getitem__(self, i):
    return self.__data[i]
    
  def check_length(f):
    def wrapper(self, other):
      if len(self) != len(other):
        raise ValueError()
      return f(self, other)
    return wrapper
  
  @check_length
  def add(self, other):
    res = Vector(map(op.add, self, other))
    return res
  
  @check_length
  def subtract(self, other):
    res = Vector(map(op.sub, self, other))
    return res
    
  @check_length  
  def dot(self, other):
    res = reduce(op.add, imap(op.mul, self, other))
    return res
    
  def norm(self):
    return sqrt(self.dot(self))
    
  def equals(self, other):
    if len(self) != len(other):
      return False
    return all(map(op.eq, self, other))
    
  def __str__(self):
    return '(%s)' % ','.join(str(x) for x in self.__data)
```

### B. 두 번째
유용한 방식을 많이 사용해서 득표를 많이 얻었다. 특히 combine 아이디어 좋다.

- assert(boolean) : 매개변수로 boolean값을 집어넣었을 때 False라면 AssertionError을 raise한다. 검사할 때 유용하다. import 없이 바로 사용 가능. 근데 아래 코드에서 보면 list가 아니면 에러를 띄우게 되어있는데 왜 init 함수에서 굳이 매개변수를 list화하는 코드를 넣었을까. 그냥 넣어도 됐을텐데.
- isinstance(object, type): object가 type인지 검사하고 맞으면 True를 리턴한다. type에는 int, list, str, dict, tuple, float, set 같은 기본 자료형이 들어갈 수도 있고, 내가 만든 클래스의 클래스명을 넣을 수도 있다.
- combine: 두 가지 검사와, 하나의 실행코드를 combine 메소드에 넣어놨다. 객체가 벡터인지(생각도 못했다. 중요한 검사 요소), 길이가 같은지를 검사한 후, 에러가 없다면 입력받은 두 객체의 데이터를 operator 매개변수로 연산한다. 좋다 이런 형태!

```python
from operator import add, sub, mul
from math import sqrt

class Vector(object):
  def __init__(self, values):
    assert(isinstance(values, list))
    self.values = list(values)
  
  """ Combines elements pairwise w.r.t. given operator"""
  def __combine(self, other, operator):
    assert(isinstance(other, Vector))
    assert(len(self.values) == len(other.values))
    return map(operator, self.values, other.values)
  
  def add(self, other):
    return Vector(self.__combine(other, add))
     
  def subtract(self, other):
    return Vector(self.__combine(other, sub))
    
  def dot(self, other):
    return sum(self.__combine(other, mul))
  
  def norm(self):
    return sqrt(sum(i*i for i in self.values))
  
  def equals(self, other):
    return self.values == other.values
    
  def __str__(self):
    return '('+str(self.values).replace(' ','')[1:-1]+')'
```
