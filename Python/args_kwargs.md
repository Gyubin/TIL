# *args, **kwargs

참고링크: [stackoverflow](http://stackoverflow.com/questions/3394835/args-and-kwargs), [JH PROJECT](http://jhproject.tistory.com/109), [HANGAR . RUNWAY 7](http://hangar.herokuapp.com/python/packing-unpacking-arguments)

## 1. *args

어떤 함수의 매개변수가 몇 개 들어올지 모를 때 *args를 사용한다. 매개변수 중 마지막 순서에 위치해야 한다. 함수 내에서 *를 뗀 `args` 형태로 사용하며 타입은 tuple이다.

```python
def print_param(*args):
    print args
    for p in args:
        print p
 
print_param('a', 'b', 'c', 'd')
#('a', 'b', 'c', 'd')
#a
#b
#c
#d
```

## 2. **kwargs

아래 예와 같이 매개변수의 변수명과 값을 같이 입력받을 수 있다. kwargs의 타입은 딕셔너리. 매개변수 명은 변수명이므로 변수 이름 지을 때 원칙을 따른다. '문자열' = value 이런식으로 적으면 에러 난다. 그냥 변수명 자체를 적어야 한다.

```python
def print_param2(**kwargs):
    print kwargs
    print kwargs.keys()
    print kwargs.values()

    for name, value in kwargs.items():
        print "%s : %s" % (name, value)
 
print_param2(first = 'a', second = 'b', third = 'c', fourth = 'd')
 
#{'second': 'b', 'fourth': 'd', 'third': 'c', 'first': 'a'}
#['second', 'fourth', 'third', 'first']
#['b', 'd', 'c', 'a']
#second : b
#fourth : d
#third : c
#first : a
```

## 3. 같이 쓰는 경우 (*args, **kwargs)

아래 예처럼 그냥 값만 쓰면 args로 들어가고, 매개변수명과 함께 쓰면 kwargs에 들어간다. 다만 동시에 매개변수로 들어갈 경우엔 값만 쓰는 것과, 변수명과 함께 쓰는 것의 순서를 지켜줘야 한다. 섞이면 안되고 kwargs가 args 앞으로 오면 안된다. 무조건 args 쭉 끝까지 적어주고 끝나면 kwargs 쭉 적어줘야 한다.

```python
def print_param3(*args, **kwargs):
    print args
    print kwargs
 
print_param3('a', 'b')
#('a', 'b')
#{}
 
print_param3(third = 'c', fourth = 'd')
#()
#{'fourth': 'd', 'third': 'c'}
 
print_param3('a', 'b', third = 'c', fourth = 'd')
#('a', 'b')
#{'fourth': 'd', 'third': 'c'}
```

## 4. *, ** 문법: unpacking argument lists

[공식문서 링크](https://docs.python.org/2/tutorial/controlflow.html#arbitrary-argument-lists). 애초에 함수 정의에서 매개변수를 `*args`, `**kwargs`로 해놓지 않았더라도 함수 실행할 때 매개변수에 리스트 앞에는 `*`, 딕셔너리 앞에는 `**`를 붙이면 그 객체의 원소들이 하나하나 매개변수로 들어간다. 신기하다.

```python
def print_param4(a, b, c):
    print a, b, c
 
p = ['a', 'b', 'c']
print_param4(*p)
#a b c
 
p2 = {'c' : '1', 'a' : '2', 'b' : '3'}
print_param4(**p2)
#2 3 1
```
