# #64 Linked Lists - Sorted Insert

이미 데이터를 기준으로 오름차순 정렬이 되어있는 링크드 리스트다. 여기서 data 하나를 올바른 위치에 끼워넣는 함수를 짜는 문제.

## 1. 내 코드

```py
class Node(object):
    def __init__(self, data):
        self.data = data
        self.next = None
    
def sorted_insert(head, data):
    if not head: return Node(data)
    if head.data <= data:
        if head.next:
            head.next = sorted_insert(head.next, data)
            return head
        else:
            head.next = Node(data)
            return head
    else:
        tmp = Node(data)
        tmp.next = head
        return tmp
```

- head가 None일 경우 바로 Node를 생성해서 리턴.
- head의 데이터가 주어진 data보다 작은 경우, 즉 올바른 순서인 경우 재귀를 호출해서 다음 턴으로 넘긴다.
    + 다만 다음 노드가 있을 경우에만 넘긴다.
    + 만약 해당 노드가 마지막 노드였다면 다음 노드를 주어진 data로 새롭게 생성해서 next를 연결해 준 다음 리턴한다.
    + 재귀로 호출된 것은 이후의 링크드리스트이므로, 현재 시점의 head의 next로 정해주면 된다.
- 주어진 data보다 큰 경우, 새롭게 Node를 생성하고, next를 현재 head로 지정해준 다음, 생성한 Node를 리턴해준다.
