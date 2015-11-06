#decorator(a.k.a. wrapper) 사용법

참고 링크: [HANGAR . RUNWAY 7](http://hangar.runway7.net/python/decorators-and-wrappers), [trowind](http://trowind.tistory.com/72), [shoveller gist](https://gist.github.com/shoveller/b4d2e1e6d33906f2a667), [khanrc's blog](http://khanrc.tistory.com/entry/decorator%EC%99%80-closure)

## 1. 배경

- 파이썬에서 함수는 first citizen이다. 즉 함수를 다른 함수의 매개변수로 전달할 수도 있고, 리턴값으로 사용할 수도 있다. sort 함수에서 key값으로 정렬 기준을 정할 때 람다를 쓰는 것이 한 예다. 어쨌든 이런 특성 덕분에 새로운 용법이 여럿 생겼는데 그 중 하나가 decorator다.

```python
# 함수를 인자로 전달하는 예
def verbose(func):
    print "Begin", func.__name__;
    func();
    print "End", func.__name__;
```

> C도 함수를 포인터를 활용해 매개변수로 전달할 수 있지만 함수 자체를 전달하는 것은 아니다.

## 2. 사전 요약 정리

- 타입: 함수 또는 클래스 형태로 존재한다. 디자인 패턴이다.
- 생김새
    + 함수형: decorator 함수가 함수를 인자로 받고, 다른 내용들로 꾸며서(wrapping), 새로운 함수를 만든 후, 새 함수를 리턴한다.
    + 클래스: 함수를 매개변수로 받는 init 함수를 정의하고, `__call__` 함수 내부에서 인스턴스 변수(함수 타입)를 decorate 한다.
- 의미: 기존 함수의 본래 기능은 건드리지 않는다. 기존 함수 전 후로 진입 루틴, 출구 루틴을 추가한다.
- 용법: decorator 앞에 @를 붙여서 타겟 함수 코드 def 바로 위에 적어준다.
- 플로우
    + 함수형: 컴파일러가 `@verbose`를 만나면 바로 다음 함수를 매개변수로 받아서 decorator인 verbose 함수 실행 -> decorated function을 리턴 -> 타겟 함수가 실행될 때 decorated function이 대신 실행된다. 
    + 클래스: 컴파일러가 `@Verbose`를 만나면 Verbose 클래스의 인스턴스 생성되면서 `__init__` 함수 실행 -> 타겟 함수 실행 코드 만남 -> 타겟 함수가 아닌 decorated function이 실행됨

## 3. decorator 생성, 적용

### A. 함수형 데코레이터

decorator를 활용할 때 매 번 타겟 함수를 verbose 함수에 넣어서 바꾼 후 다시 대입해줄 순 없다. 귀찮은 작업일뿐더러 시각적으로 목적이 명확하게 드러나지도 않는다. 그래서 @ 기호를 사용하여 타겟 함수 위에서 decorate 해준다.

```python
def verbose(func):  # 함수를 인자로 받는 verbose decorator
    def new_func(): # 새롭게 만들어지는 함수다.
        print "Begin", func.__name__   # 꾸밈
        func()                         # 인자로 받은 함수
        print "End", func.__name__     # 꾸밈
    return new_func    # 인자로 받은 함수를 꾸민 함수를 만들어 리턴

# 미사용
def my_function():
    print "hello, world."
my_function = verbose(my_function)
my_function()

# decorator 사용
@verbose
def my_function():
    print "hello, world."
my_function()
```

### B. 클래스형 데코레이터

클래스형 데코레이터는 아래처럼 구현해주면 된다. `__call__` 함수가 함수형 데코레이터처럼 되는 것이다. 함수형 데코레이터와는 다르게 리턴값은 필요하지 않다.

```python
class Verbose:
    def __init__(self, f):
        print "Initializing Verbose."
        self.func = f;

    def __call__(self):
        print "Begin", self.func.__name__
        self.func();
        print "End", self.func.__name__

@Verbose
def my_function():
    print "hello, world."

print "Program start"
my_function();

# Initializing Verbose.
# Program start
# Begin my_function
# hello, world.
# End my_function
```

**실행 순서**

1. 파이썬 컴파일러가 `@Verbose`를 만나면 Verbose 클래스의 인스턴스를 만든다. 그래서 `__init__` 함수가 실행되고 'Initializing Verbose.'가 출력되는 것이다.
2. print문 실행한다.
3. my_function() 코드를 만나면 my_function 그 자체가 아닌 decorated function이 실행된다. 그래서 'Begin~', 'hello~', 'End~'가 차례로 출력되는 것이다. `__call__` 함수의 내용처럼.

## 4. 매개변수를 갖는 타겟 함수

decorated function이나, call 함수에 변수를 추가해주면 된다. 만약 이름 하나를 입력받아서 출력하는 타겟함수라면 decorated function, call 함수의 매개변수로 하나 더 추가해주면 된다. 그 매개변수가 내부에서 타겟함수 실행될 때 매개변수로 들어가주면 되고. 하지만 이렇게 만들면 오로지 매개변수가 하나인 타겟함수만 decorate할 수 있다. 그래서 나온게 `*args`, `**kwargs`다.

다음처럼 2줄만 수정해주면 된다. `__call__` 함수와 call 내부의 타겟함수 실행 부분에 `*args`, `**kwargs` 추가.

```python
class Verbose:
    def __init__(self, f):
        print "Initializing Verbose."
        self.func = f

    def __call__(self, *args, **kwargs):    #여기 
        print "Begin", self.func.__name__
        self.func(*args, **kwargs)          #여기
        print "End", self.func.__name__

@Verbose
def my_function(name):   #l 인자를 갖는 함수
    print "hello,", name
```

## 5. Multiple decorators

```python
@decorator2
@decorator1
def some_method():
    # do stuff
# 위 코드는 아래와 똑같다.
wrapped_method = decorator2(decorator1(some_method))
```

## 6. [중요] @wraps 데코레이터 추가 활용

shoveller 님의 설명이다. 정말 중요한 팁이다. 한 마디로 말해서 wraps를 쓰면 디버깅할 때 어디서 오류났는지 정확한 위치를 알 수 있다. wraps가 없이 데코레이터를 쓰면 실행 위치를 원래 함수가 아니라 데코레이터 안의 새롭게 만들어지는 함수로 인식한다. 다음 코드를 통해서 확인

```python
from functools import wraps

def without_wraps(func):
    def __wrapper(*args, **kwargs):
        return func(*args, **kwargs)
    return __wrapper
 
def with_wraps(func):
    @wraps(func)
    def __wrapper(*args, **kwargs):
        return func(*args, **kwargs)
    return __wrapper
 
@without_wraps
def my_func_a():
    """Here is my_func_a doc string text."""
    pass
 
@with_wraps
def my_func_b():
    """Here is my_func_b doc string text."""
    pass
 
# Below are the results without using @wraps decorator
print my_func_a.__doc__
# >>> None
print my_func_a.__name__
# >>> __wrapper
 
# Below are the results with using @wraps decorator
print my_func_b.__doc__
# >>> Here is my_func_b doc string text.
print my_func_b.__name__
# >>> my_func_b
```

## 7. 주 사용 형태

- Caching: 메모리 최적화 용도로 사용한다.
- Logging / Debugging: 함수 실행을 로깅하거나, 데코레이터에 매개변수를 넣어서 테스트를 할 수도 있다.
- Authentication / Authorization: 유저가 접속해 있는지, 그리고 이 유저에게 해당 타겟 메소드에 대한 권한이 있는지 확인
- Audit trails: 메소드가 호출되는 맥락이나 인스턴스 추적
- Namespacing: 메소드가 실행될 데이터베이스 네임스페이스나 context를 만들기.

> 마지막 namespacing은 확실히 이해되진 않지만 아마도 파이썬의 클로져 특징을 활용한다는 의미가 아닐까 싶다.

###A. 사용자 확인

예를 들어 웹 앱을 개발할 때 로그인 상태를 항상 체크해야 할 경우가 많다. 로그인 되어있다면 이렇게 보여주고, 안돼있다면 저렇게 보여주는 형태로 말이다. 이 때 주로 하는 방법은 다음처럼 authenticator를 사용하는 것이다.

```python
def show_page(request):
    authenticator.authenticate(request)
    # do stuff
    return response
```

하지만 매번 저 코드를 쳐넣는것은 보기도 안좋을 뿐더러 나중에 하나하나 고치기도 힘들다. 그래서 decorator를 사용한다. 다음처럼.

```python
def authenticate(func):
    def authenticate_and_call(*args, **kwargs):
        if not Account.is_authentic(request): 
            raise Exception('Authentication Failed.')
        return func(*args, **kwargs)
    return authenticate_and_call

@authenticate
def show_page(request):
    # do stuff
    return response
```

### B. 권한 확인(meta decorator)

```python
def authorize(role):
    def wrapper(func):
        def authorize_and_call(*args, **kwargs):
            if not current_user.has(role): 
                raise Exception('Unauthorized Access!')
            return func(*args, **kwargs)
        return authorize_and_call
    return wrapper

@authorize('admin')
@authenticate
def show_page(request):
    # do stuff

# 위 코드는 아래 한 줄과 똑같은 의미다.
authorized_show_page = authorize('admin')(authenticate(show_page))
```

위 코드를 클래스 형태로 만들면 다음과 같다. 클래스가 좀 더 이해하기 쉬움.

```python
class Authorize(object):
    def __init__(self, role):
        self.role = role
    def __call__(self, func):
        def authorize_and_call(*args, **kwargs):
            if not current_user.has(role): 
                raise Exception('Unauthorized Access!')
            return func(*args, **kwargs)
        return authorize_and_call
```
