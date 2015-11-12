# 정적 메소드(static)와 클래스 메소드(class)

참고: [Youngjae](http://blog.naver.com/PostView.nhn?blogId=dudwo567890&logNo=130164152571)

## 1. 개념

- 정적 메소드는 인스턴스객체를 통하지 않고 클래스를 통해 직접 호출할수 있는 메소드이다. 이 경우 메소드 정의시 인스턴스 객체를 참조하는 'self'라는 인자를 선언하지 않는다.
- 클래스메소드의 경우 암묵적으로 첫 인자로 클래스 객체가 전달된다.
- 두 경우 모두 아래와 같은 형태로 클래스내에서 등록해야 한다.
    + <호출할 메소드이름> = staticmethod(클래스내 정의한 메소드이름)
    + <호출할 메소드이름> = classmethod(클래스내 정의한 메소드이름)
- 예를 들어 클래스부터 생성되는 인스턴스의 개수를 관리하고 싶은 경우, 클래스 영역에서 그 정보를 관리하는 것이 가장 효율적일것이다. 이러한 정보가 저장/출력될수 있도록 다음과 같이 클래스를 정의하였다.

```python
class Come:
    cnt=0
    def __init__(self):
        Come.cnt+=1

    def print_cnt():
        print('Instance count: ' + str(Come.cnt))

if __name__ == "__main__":
    instance_a = Come()
    instance_b = Come()
    instance_c = Come()

    Come.print_cnt()
    instance_c.print_cnt()

    # 실행결과
    # Instance count : 3
    # Traceback (most recent call last):
    # instance_c.print_cnt()
    # TypeError: print_cnt() takes no arguments (1 given)
```


```python
class Come:
    cnt = 0

    def __init__(self):
        Come.cnt += 1

    def static_print_cnt(): #정적메소드정의
        print("Instance count: " + str(Come.cnt))
    static_print = staticmethod(static_print_cnt)
 
    def class_print_cnt(cls): #클래스메소드정의(암묵적으로 첫인자는 클래스를받음)
        print("Instance count: " + str(cls.cnt))
    class_print = classmethod(class_print_cnt)

if __name__ == "__main__":
    instance_a = Come()
    instance_b = Come()
    instance_c = Come()

    Come.static_print() #staticmethod로 인스턴스객체개수 출력
    instance_c.static_print()

    Come.class_print() #classmethod로 인스턴스객체개수 출력
    instance_c.class_print()

    # 실행결과
    # Instance count : 3
    # Instance count : 3
    # Instance count : 3
    # Instance count : 3
```

- 정적메소드로 출력하는 경우 암묵적으로 받는 첫 인자가 필요하지 않다. 이렇게 정의한 메소드는 정적메소드로 등록을 해야하며, 호출시 등록된 이름으로 호출하여야 한다.
- 클래스메소드의 경우 첫인자는 암묵적으로 클래스 객체가 되며, 이 역시 클래스 메소드로 등록을 하여야 호출시 암묵적으로 클래스객체를 전달한다.
- 이렇게 정의된 정적메소드와 클래스메소드는 클래스뿐만 아니라 인스턴스 객체를 통해서도 호출이 가능하다.

```python
class Come:
    cnt = 0

    def __init__(self):
        Come.cnt += 1

    @staticmethod
    def static_print_cnt(): #정적메소드정의
        print("Instance count: " + str(Come.cnt))
    static_print = staticmethod(static_print_cnt)

    @classmethod
    def class_print_cnt(cls): #클래스메소드정의(암묵적으로 첫인자는 클래스를받음)
        print("Instance count: " + str(cls.cnt))
    class_print = classmethod(class_print_cnt)

if __name__ == "__main__":
    instance_a = Come()
    instance_b = Come()
    instance_c = Come()

    Come.static_print() #staticmethod로 인스턴스객체개수 출력
    instance_c.static_print()

    Come.class_print() #classmethod로 인스턴스객체개수 출력
    instance_c.class_print()

    # 실행결과
    # Instance count : 3
    # Instance count : 3
    # Instance count : 3
    # Instance count : 3
```

※ 이름변경(Naming Mangling )
위 클래스에서 멤버변수 'cnt'는 인스턴스객체의 개수를 저장하는것으로 매우 중요한 변수이다. 그러나 파이썬에서는 기본적으로 'public'속성을 갖기때문에 다음과 같이 클래스의 외부에서 접근, 변경이 가능하다.

```python
print(Come.cnt) #클래스외부에서 변수에 접근하는 경우
3

Come.cnt=999 #클래스외부에서 변수의 값을 변경하는 경우
Come.class_print()
Instance count: 999
```

파이썬에서는 '이름변경(Naming Mangling)'으로 그 문제점을 해결하였다. 즉 클래스 내의 멤버변수나 함수를 정의할때 `__`로 이름을 시작하는 경우, 클래스 외부에서 참조할때 자동적으로 `_[클래스이름]__[멤버이름]`으로 변경된다. 물론 클래스 내에서는 정의한 이름인 `__[멤버이름]`만으로 사용이 가능하다.

```python
class Come:
    __cnt = 0 #이름변경을 위하여 '__'를 변수명 앞에 사용
    def __init__(self):
        Come.__cnt += 1

    @staticmethod
    def static_print_cnt():
        print('Instance count: %d' % Come.__cnt) #클래스내부에서 사용시 선언한 이름과 동일하게 사용

if __name__ == "__main__":
    instance_a = Come()
    instance_b = Come()
    instance_c = Come()

    Come.static_print_cnt()
    instance_c.static_print_cnt()

    # 실행결과
    # Instance count: 3
    # Instance count: 3
```

이렇게 이름변경이 적용된 멤버변수에 그 이름을 사용하여 외부에서 접근하는 경우, 클래스 내에 동일한 이름이 없다는 NameError가 발생한다.
물론 변경된 이름(`_Come__cnt`)으로 접근하는 경우 그 변수에 대한 읽기, 쓰기가 가능하다.
즉 파이썬에서는 문법의 제약사항으로 정보은닉기능을 제공하기 보다는 이름변경으로 개발자의 의도를 나타내도록 하였다. 그렇기 때문에 변경된 이름으로 그 변수에 접근하여 사용하는 것을 장려하지는 않는다.

```python
print(Come.__cnt) #NameError발생
#Traceback (most recent call last):
#  File "<pyshell#38>", line 1, in <module>
#    print(Come.__cnt)
# AttributeError: type object 'Come' has no attribute '__cnt'

print(Come._Come__cnt)
# 3

dir(Come)
# [생략 '_Come__cnt', 'static_print_cnt'] 
```
