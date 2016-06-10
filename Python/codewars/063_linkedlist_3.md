# #63 Linked Lists - Insert Nth Node

링크드 리스트에서 특정 위치에 원소를 추가하는 문제

## 1. 내 코드

```py
class Node(object):
    def __init__(self, data, nxt = None):
        self.data = data
        self.next = nxt
    
def insert_nth(head, index, data):
    if index == 0: return Node(data, head)
    if head and index > 0:
        head.next = insert_nth(head.next, index - 1, data)
        return head
    raise ValueError
```

- 재귀를 이용

## 2. 다른 코드

```py
def insert_nth(head, n, data):
    if n==0:
        head=Node(data,head)
    else:
        head.next=insert_nth(head.next,n-1,data)
    if not head: raise "Something's fucky!"
    return head
```
