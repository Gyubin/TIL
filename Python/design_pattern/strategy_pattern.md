# Strategy Pattern

참고: 헤드퍼스트 디자인패턴, [hyeonstorage 블로그](http://hyeonstorage.tistory.com/m/post/146)

- 디자인 원칙: 변하는 부분과, 변하지 않는 부분 분리하기.
- strategy pattern: 변하는 부분을 캡슐화하고, 인터페이스에 위임해서 어떤 행동을 할지 결정한다.

```python
class Duck(object):
    def quack(self):
        print("꽉꽉!")
    def swim(self):
        print("I'm swimming.")
    def display(self):
        print("I am DUCK.")
    def fly(self):
        print("I can fly.")

class MallardDuck(Duck):
    def display(self):
        print("I am Mallard Duck.")

class RedheadDuck(Duck):
    def display(self):
        print("I am Red head Duck.")

class RubberDuck(Duck):
    def quack(self):
        print("삑삑")
    def display(self):
        print("I am Rubber duck.")
    def fly(self):
        print("I can't fly.")

class DecoyDuck(Duck):
    def display(self):
        print("I am decoy duck")
    def fly(self):
        print("I can't fly.")
```

