# 큐 구현

- 클래스 형태로 만들어서 다음 메소드 추가
- push : 원소 추가
- pop : 맨 앞의 원소 제거 
- size : 총 사이즈 리턴
- empty : 비었는지 여부 리턴
- front : 맨 앞 원소 리턴
- back : 맨 뒤 원소 리턴

```py
class Queue:
    def __init__(self) :
        self.myQueue = []

    def push(self, n) :
        self.myQueue.append(n)

    def pop(self) :
        if len(self.myQueue) != 0:
            del self.myQueue[0]

    def size(self) :
        return len(self.myQueue)

    def empty(self) :
        if len(self.myQueue) == 0:
            return 1
        else:
            return 0

    def front(self) :
        if len(self.myQueue) == 0:
            return -1
        else:
            return self.myQueue[0]

    def back(self) :
        if len(self.myQueue) == 0:
            return -1
        else:
            return self.myQueue[-1]
```
