# #62 Linked Lists - Length & Count

링크드 리스트 시리즈 2번째. 61번째 푼 문제에서 이어진다. 길이와, 특정 데이터의 개수를 구하는 문제다.

## 1. 내 코드

```py
class Node(object):
    def __init__(self, data):
        self.data = data
        self.next = None
    
def length(node):
    if node == None: return 0
    cnt = 1
    while(node.next):
        node = node.next
        cnt += 1
    return cnt

def count(node, data):
    if node == None: return 0
    cnt = 1 if node.data == data else 0
    while(node.next):
        node = node.next
        if node.data == data:
            cnt += 1
    return cnt
```

- 만약 None이 매개변수로 들어오면 분기해준다.
- node의 next가 있을 때를 조건으로 줬는데 아래 다른 해답처럼 node 자체를 조건으로 주는게 더 깔끔했을 것.

## 2. 다른 해답

### 2.1 내 코드를 더 깔끔하게

Node 클래스 객체 자체를 조건으로 두니까 다 해결됐다.

```py
class Node(object):
    def __init__(self, data):
        self.data = data
        self.next = None
    
def length(node):
    leng = 0
    while node:
        leng += 1
        node = node.next
    return leng
  
def count(node, data):
    c = 0
    while node:
        if node.data==data:
            c += 1
        node = node.next
    return c
```

## 2.2 재귀

```py
class Node(object):
  def __init__(self, data):
    self.data = data
    self.next = None
    
def length(node):
  if node:
    return 1 + length(node.next)
  return 0
  
def count(node, data):
  if node:
    if node.data == data:
      return 1 + count(node.next, data)
    return count(node.next, data)
  return 0
```

- length, count 함수 모두 재귀로 짰다. 정말 깔끔하다.
- 재귀가 잘 짜면 정말 아름답다.
