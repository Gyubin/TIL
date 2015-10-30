# #9 Linked Lists - Get Nth Node
Node라는 클래스가 있다. 인스턴스 변수로 data와 next를 가지고 있고 next는 다음 노드를 가리킨다. 즉 linked list이다. get_nth 함수는 노드 객체와 index 정수 변수를 받아서 linked list의 index 번째 노드를 리턴하는 함수다.

추가로 리스트에 없는 인덱스를 입력하는 경우, node 객체 대신 빈 객체를 입력하는 경우엔 에러를 띄워야한다.

## 1. 내 코드

- 우선 index가 0보다 작은 경우와 node가 None인 경우에 각각 에러를 발생시켰다.
- cnt 변수에 현재 node 객체 순서를 저장했고, 매 반복마다 1씩 증가시켜서 원하는 index까지 반복문을 돌렸다.
- 리스트 인덱스가 3까지인데 더 큰 수가 인덱스로 입력했을 경우는 node.next 자체를 조건문으로 삼아서 없는 경우엔 인덱스 에러를 발생시켰다.
- 최종까지 아무 에러도 나지 않았으면 node를 리턴했다.

```python
class Node(object):
    def __init__(self, data):
        self.data = data
        self.next = None
    
def get_nth(node, index):
    if index < 0: raise IndexError
    if node == None: raise Error
    cnt = 0
    while cnt < index:
        if node.next:
            node = node.next
            cnt += 1
        else: raise IndexError
    return node
```

## 2. 다른 해답
대부분 재귀를 사용했고 비슷한 흐름이었다. 그 중에서 가장 깔끔한 코드를 골랐다.

```python
def get_nth(node, index):
    if node and index >= 0:
        return node if index < 1 else get_nth(node.next, index - 1)
    raise ValueError
```
> 나는 재귀 사용은 생각도 못했는데 아쉽다. 후..

- and 연산자는 가장 우선순위가 낮다. index>=0과 node를 and 연산한다. node도 None이 아니어야 하고, index도 0 이상이어야 한다.
- index가 1보다 작으면 node를 리턴하는데 아니라면 get_nth 함수를 다시 재귀로 호출한다. 다만 node는 다음 노드를, index 값은 1을 빼서 넣는다.
- 재귀로 호출될 때마다 if 조건으로 검사하게 되는데 통과하지 못하면 ValueError를 띄운다. 되게 깔끔한 코드다.

