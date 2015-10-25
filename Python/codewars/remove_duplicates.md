#Remove Duplicates
정수 배열을 받아서 중복된 숫자만 제거하는 함수를 만들라는 문제다.

## A. 내 코드
카이스트 기계학습 과정에서 Bag of Words 기본 개념 배울 때 dict를 썼던 것이 생각나서 필요한 것만 뽑아서 해봤다. 막상 하다보니 'not in'만 쓰면 됐던 것 같다. dict까지 쓸 필요도 없이.

```python
# 다시 고친거
def unique(integers):
    result = []
    for num in integers:
        if num not in result:
            result.append(num)
    return result

# 원래 코드
def unique(integers):
    result = []
    integers_dict = {}
    for num in integers:
        if num not in integers_dict:
            integers_dict[num] = 0
            result.append(num)
    return result
```

## B. 다른사람 코드

### 1. OrderedDict 활용
collections 모듈에 들어있는 dict의 서브클래스다. 리스트 안에 key, value 쌍으로 이루어진 튜플이 여러개 들어있는 구조다. 완전 새로운 데이터타입이 아니라 기존 것을 활용해서 만든 것으로 보인다.

fromkeys 메소드로 정수형 리스트를 받으면 value 값은 None이 되고 리스트의 원소가 키가 된다. 아래 해답은 이 OrderedList 객체를 list 화 해서 리턴했다.

```python
from collections import OrderedDict
def unique(integers):
    return list(OrderedDict.fromkeys(integers))
```

### 2. reduce, lambda 활용

#### a. 해답 코드 해석

- reduce: 함수, iterable, initializer 세 가지 인자를 받는다. 함수는 lambda를, iterable은 integers를, initializer는 []로 받았다.
- lambda: acc, val을 인자로 받는다. val이 acc에 속해있으면 acc를 리턴하고, 아니면 acc에 val을 append시켜서 리턴한다. initializer가 빈 리스트 [] 이므로 첫 acc, val은 [], integers[0]이고 다음부터 차례로 결과값, integers[1] 식으로 넘어간다.

```python
# from functools import reduce # python3에선 적어줘야 한다.
def unique(integers):
    return reduce(lambda acc, val: acc if val in acc else acc + [val], integers, [])
```

#### b. lambda에 대하여
anonymous function이다. (인자: 표현식) 형태로 구성되며 아래 코드처럼 뒤에 괄호로 인자를 받을 수 있다. 인자를 설정한 만큼만 넣어야되고 만약 아래 코드에서 인자를 3개 이상 넣으면 너무 많이 넣었다고 에러 뜬다.

```python
(lambda x, y: x + y)(10, 20)
```

#### c. reduce 함수 사용법

```python
def reduce(function, iterable, initializer=None):
    it = iter(iterable)
    if initializer is None:
        try:
            initializer = next(it)
        except StopIteration:
            raise TypeError('reduce() of empty sequence with no initial value')
    accum_value = initializer
    for x in it:
        accum_value = function(accum_value, x)
    return accum_value
```
reduce 함수는 위처럼 만들어져있다. 두 번째 인자로 받은 iterable 객체의 첫 번째 원소를 변수 accum_value로 받아놓고 그 다음 원소와 함께 function의 매개변수로 들어간다. 즉 function에 (0, 1) 인덱스 적용, (1, 2) 인덱스 적용 식으로 하나 하나 올라가면서 값을 축적한다. (~, last) 인덱스까지 적용됐을 때 그만 두고 축적된 결과값을 리턴한다.

reduce 함수의 세 번째 인자로 들어가는 initializer는 디폴트 값이 None이다. 즉 accum_value 값을 의미한다.

```python
reduce(lambda x, y: x + y, [0, 1, 2, 3, 4]) # => 10
reduce(lambda x, y: y + x, 'abcde') # => 'edcba'
```

