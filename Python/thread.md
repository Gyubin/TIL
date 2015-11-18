# thread  활용하기

## 1. 개념

컴퓨터의 프로그램이 작동을 시작하면 SSD(또는 HDD)에서 램으로 옮겨가게 된다. 이런 시작된, 동작하는 프로그램을 프로세스라고 하며 일반적으론 한 가지 작업을 하지만, 스레드를 이용하면 2가지 이상의 작업을 할 수 있다.

### A. Thread 클래스 직접 사용([wikidocs 참조](https://wikidocs.net/33))

```python
import threading
import time

def say(msg):
    while True:
        time.sleep(1)
        print(msg)

for msg in ['you', 'need', 'python']:
    t = threading.Thread(target=say, args=(msg,))
    t.daemon = True
    t.start()

for i in range(100):
    time.sleep(0.1)
    print(i)
```

- daemon이란: [stackoverflow 참조](http://stackoverflow.com/questions/190010/daemon-threads-explanation) -> 코드를 설명하기 전에 daemon을 설명하겠다. 일반적으로 스레드는 background task를 담당한다. 패킷을 계속 전송하거나, 주기적으로 garbage collection을 하는 등이 있다. 이런 작업들은 메인 작업들이 작동하고 있을 때만 유용한 작업이다. 모든 작업이 끝났는데 garbage collection을 왜 하겠는가. 그래서 non-daemon thread들이 모두 종료되면 나머지 background 작업들을 담당하는 thread들은 자동으로 종료해줘도 되는데 이런 스레드를 daemon thread라고 한다. 이런 daemon thread가 없다면 프로그래머는 계속 어떤 스레드가 실행되고 있는지 기억하고 있어야 하고 프로그램이 끝났을 때 이런 스레드를 직접 다 종료시켜야 한다. daemon thread가 있다면 이런 귀찮음은 없어진다.
- 코드 간단 설명
    + say(msg): 1초 간격으로 매개변수로 받은 문자열을 계속 출력하는 함수
    + 첫 번째 for문: 스레드를 3개 만드는 단순 반복문이다. you, need, python이라는 세 개의 문자열을 say 함수로 실행하는 스레드를 3개 만든다. daemon을 True로 지정해준다. start()는 스레드를 시작하라는 것.
    + 두 번째 for문: 메인 스레드다. 이 반복문이 끝나면 전체 프로그램이 종료된다. 자연스럽게 첫 번째 for문에서 시작한 3개의 스레드는 daemon이기 때문에 종료된다. 0.1초 간격으로 숫자들을 출력한다.

### B. Thread 클래스 상속 예제

```python
import threading
import time

class MyThread(threading.Thread):
    def __init__(self, msg):
        threading.Thread.__init__(self)
        self.msg = msg
        self.daemon = True

    def run(self):
        while True:
            time.sleep(1)
            print(self.msg)

for msg in ['you', 'need', 'python']:
    t = MyThread(msg)
    t.start()

for i in range(100):
    time.sleep(0.1)
    print(i)
```

- threading 모듈의 Thread 클래스를 상속받은 MyThread 클래스를 만들었다. `__init__` 메소드와 `run` 메소드만 오버라이드했다.(아래에서 추가 설명) `__init__`에서 데몬을 설정해주고, `run`에서 동작을 정한다. start()했을 때 실행되는 것이 run이다.
- MyThread 클래스의 객체를 3개 만들고 시작시킨다.
- 함수 예제처럼 메인 실행 반복문을 적어준다. 종료되면 다른 데몬 스레드들도 종료

## 2. 사용 방법([공식 문서 참조](https://docs.python.org/3/library/threading.html))

- 두 가지 방법이 있다. 눈치 챘겠지만 위의 두 예제와 같다. Thread 클래스의 생성자에 callable 객체를 매개변수로 넣어 바로 객체를 생성하는 방법과, Thread 클래스를 상속해서 subclass를 만드는 방법이다. 두 번째 방법의 경우 오직 `__init__`과 `run()`만 오버라이드해야한다. 다른건 하면 안됨
- 객체를 생성하면 `start()` 메소드를 호출하면 스레드가 시작된다. 이 때 실행되는 함수가 첫 번째 방법에선 callable 객체인거고, 두 번째 방법에선 오버라이드한 run 메소드다.
- 스레드가 시작되면 이 스레드는 'alive'된 것으로 여겨진다. 그래서 `is_alive()` 메소드를 통해서 확인할 수 있다.
- Thread 클래스 활용 방법
    + 생성자 : `class threading.Thread(group=None, target=None, name=None, args=(), kwargs={}, *, daemon=None)`
    + 위 생성자는 꼭 keyword argument와 함께 쓰여야 한다. target=something 이런 식으로.
    + group: 무조건 None. 건드리지 않는다. 이건 미래의 확장에 쓰인다고 한다.
    + target: callable 객체다. run() 메소드에 의해 실행된다.
    + name: 스레드의 이름인데 직접 지을 수도 있고 None으로 두면 'Thread-N' 형태의 유니크한 이름으로 자동 설정된다. N은 decimal 값.
    + args: 튜플값이다. target으로 들어온 callable에 쓰인다.
    + kwargs: 딕셔너리 값이고 역시 target으로 들어온 callable에 쓰인다.
    + daemon: 명시적으로 데몬인지 아닌지 값을 지정할 수도 있다. 만약 아무 작업도 안해서 디폴트엔 None값이 들어간다면 daemonic 속성은 현재 스레드의 속성을 상속한다.(현재 스레드 속성을 상속한다는게 사실 무슨 말인지 잘 모르겠다.)
    + 만약 두 번째 방식으로 subclass를 만든다면 `__init__`함수에 꼭 다음 베이스 스레드 생성자 코드를 처음에 넣어줘야 한다. `Thread.__init__(self)` 

### A. 이해하기 어려웠던 `join()` 메소드

```python
from threading import Thread
import time

def printer():
    for _ in range(3):
        time.sleep(1.0)
        print("hello")

thread = Thread(target=printer)
thread.start()
thread.join() # 요놈요놈
print("goodbye")
```

- `join(timeout=None)` : 위 코드에 맞춰서 설명([stackoverflow 참조](http://stackoverflow.com/questions/19138219/use-of-threading-thread-join))
    + printer라는 함수를 만들었다. 딱 3번만 반복하는데 1초씩 먼저 쉬고 hello를 프린트하는 함수다.
    + join()이 있다면 출력 순서는 `(1초쉬고) hello -> (1초쉬고) hello -> (1초쉬고) hello -> goodbye`
    + join()이 없다면 순서는 `goodbye -> (1초쉬고) hello -> (1초쉬고) hello -> (1초쉬고) hello`
    + 만약 thread가 daemonic이고 join이 없다면 그냥 `goodbye` 출력하고 종료
    + daemonic이면서 join이 있다면 위의 join이 있을 때 출력 순서와 동일
- 공식 문서의 설명과 함께 생각해보면
    + `Wait until the thread terminates. This blocks the calling thread until the thread whose join() method is called terminates – either normally or through an unhandled exception –, or until the optional timeout occurs.`: 스레드가 종료될 때까지 기다린다. join을 호출한 스레드가 종료될 때까지 다른거 다 잠시 기다려! 란 의미다. 정상 종료뿐만 아니라 어떤 exception이 발생하거나 매개변수로 넣은 timeout의 시간이 다 됐을 때의 종료도 포함한다.
    + `When the timeout argument is present and not None, it should be a floating point number specifying a timeout for the operation in seconds (or fractions thereof). As join() always returns None, you must call is_alive() after join() to decide whether a timeout happened – if the thread is still alive, the join() call timed out.`: timeout 값은 float 타입으로 적어줘야한다.(1.5면 1.5초다.) join 메소드의 리턴값은 항상 None이기 만약 timeout이 실행됐는지 확인하고싶으면 is_alive()를 실행해보면 된다. timeout에 설정한 시간이 지나기도 전에 만약 스레드가 일을 다 하고 종료됐으면 join은 timed out을 호출하지 않는다. 시간이 지났는데도 스레드가 살아있으면 그 때 timed out을 호출한다.
    + `When the timeout argument is not present or None, the operation will block until the thread terminates.`: timeout 값을 설정하지 않으면 스레드가 종료될 때까지 블락한다.
    + `A thread can be join()ed many times.`: join 여러번 호출 가능하다.
    + `join() raises a RuntimeError if an attempt is made to join the current thread as that would cause a deadlock. It is also an error to join() a thread before it has been started and attempts to do so raise the same exception.`: current thread에 대해 join을 시도하면 런타임에러를 띄운다. 시작하지 않은 스레드에 join해도 에러 띄운다.

### B. 중요. join의 블락 범위

```python
from threading import Thread
import time

def printer():
    for _ in range(3):
        time.sleep(1.0)
        print("hello")

def printer2():
    for _ in range(3):
        time.sleep(1.0)
        print("hi")

thread = Thread(target=printer)
thread2 = Thread(target=printer2)
thread.start()
thread2.start()
thread.join(timeout=5.0)
print("goodbye")
time.sleep(1.0)
print(thread.is_alive())
```

만약 A.의 예제를 위처럼 고친다면 어떤 결과가 날까. 마지막 3줄은 테스트용이므로 다른 코드로 바꿔도 무방하다.

- 출력 결과는 다음과 같다.
    + hello
    + hi
    + hi
    + hello
    + hi
    + hello
    + goodbye
    + False
- 원래 예상은 hello만 연달아 3번 출력되는거였지만 아니었다. 즉 join은 **호출한 이후의 코드에 대해서만 정지시키는 것이다.**
- join 호출 이전에 이미 thread2를 start 시켰기 때문에 이 스레드를 정지시키진 않는다. 그 아래 3줄 코드를 정지시킨다.
- 당연하게도 3초만에 스레드가 끝나기 때문에 join에서 timeout 설정한 5초까지 기다리지 않고 정지는 바로 풀리게 된다.

### C. 성능

성능 향상은 없다고 한다. 병렬처리를 더 나은 성능으로 하고싶으면 gevent같은 라이브러리를 활용하라고 함. [gevent 한글 튜토리얼 - leekchan.com](http://leekchan.com/gevent-tutorial-ko/)
