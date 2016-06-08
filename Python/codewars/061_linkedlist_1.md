# Linked Lists - Push & BuildOneTwoThree

파이썬으로 링크드 리스트 만드는 문제.

```py
class Node(object):
  def __init__(self, data):
    self.data = data
    self.next = None
    
def push(head, data):
  n = Node(data)
  n.next = head
  return n
  
def build_one_two_three():
  return push(push(Node(3), 2), 1)
```

- `push`: 이건 쉽게했다. data를 가지고 Node 객체 생성한 후에 head를 연결해주는 것.
- `build_one_two_three`: 이해가 쉽지 않았다. 위 코드처럼 뭉쳐서 리턴해도 `Node(3)` 부분이 없어지지 않고 리턴되는건지 아직도 아리송하다.
