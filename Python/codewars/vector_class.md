# #18 Vector Class
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

정말 정석적으로 짰기 때문이 아닐까. 아직 모르는 구문들이 많다.

- ```__iter__``` : 
- ```__getitem__``` : 
- oprator
- 

```python
from math import sqrt
import operator as op
from itertools import imap

class Vector:
  # TODO: Finish the Vector class.
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

- assert, isinstance
- combine

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
