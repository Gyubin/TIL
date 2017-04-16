# Tree Data Structure

## 0. Tree

- Tree는 Node, Edge의 집합이다. Node는 데이터를 저장하고, 표현하려는 것의 주요 객체를 나타낸다. Edge는 노드 간의 위계 정보를 나타낸다.
- Node 위치로 구분
    + 첫 번째 노드는 Root node. 부모 없는 노드
    + 자식이 없는 노드는 Leaf node 또는 Terminal node
    + 자식이 있는 노드는 Internal node
- Node 관계로 구분
    + Edge로 연결된 Parent, Child node
    + 내 위로 연결된 부모 노드부터 루트 노드까지를 Ancestor node
    + 자식 이하로 연결된 모든 노드를 Descendant node
    + 같은 부모 하의 자식들인 Sibling node
- 주요 속성
    + Length: 출발 노드에서 목적 노드까지의 거리, 즉 노드 개수를 말한다.
    + Depht: 루트에서 해당 노드까지의 경로의 길이. 
    + Height: 자식 노드 중 가장 깊은 노드와 루트와의 거리. 즉 자식 노드들의 height 중 가장 높은 height에 +1 한 값. leaf node의 높이는 1이다.
    + Level: 루트 노드로부터의 깊이. 루트 노드의 레벨은 1이다.
    + Degree(차수): 자식 노드의 개수
- Sub tree, Forest
    + 트리의 자식 노드 중 하나를 루트 노드로 생각했을 때 만들어지는 트리를 서브 트리라고 한다.(재귀적 성질)
    + 트리의 집합을 Forest라고 함.
- 트리 순회
    + 전위: root node 읽은 후, left subtree, right subtree 순서
    + 중위: left -> root -> right
    + 후위: left -> right -> root
- 컴퓨터에서 함수 호출이 트리 구조의 후위 순회 형태다. 스택과 재귀로도 구현 가능

## 1. Binary tree

### 1.1 개념

- tree 중에서도 자식노드를 최대 2개까지만 가질 수 있는 트리 구조다.
- 노드 구성: 데이터 + left, right 자식 노드를 가리키는 포인터
- 데이터가 순서대로 배치되어있기 때문에 일반 선형 배열보다 훨씬 속도가 빠르다.
- 이진 트리 종류
    + Full Binary Tree: 모든 노드가 꽉 차있다.
    + Complete Binary Tree: 마지막 레벨을 빼고는 꽉 차 있어야 한다. 마지막 레벨은 꽉 차 있을 수도 있지만 비어있을 수도 있는데 적어도 왼쪽 끝부터 채워져있어야 한다.
    + Skewed Binary Tree: 한 쪽으로만 채워져있다. 모든 레벨의 차수가 1인 그냥 배열 같이 생긴 일자 트리다.
- DFS, BFS 모두 사용할 수 있다.
    + BFS인 경우 데이터의 순서는 직관적으로 배치된다. 현재 노드를 먼저 계산하고, 자식 노드를 왼쪽부터 순서대로 모두 계산한 다음, 그 다음 자식노드로 넘어간다.
    + DFS인 경우는 먼저 왼쪽 끝까지 내려가서 가장 아래, 가장 왼쪽에 있는 노드가 첫 번쨰 노드다. 그 다음 그 노드의 부모 노드, 그 다음에 오른쪽 자식 노드의 순이다. 즉 크게 그림을 그렸을 때 좌->우 순서인 것.

```c
typedef struct      s_btree
{
    struct s_btree  *parent;
    struct s_btree  *right;
    struct s_btree  *left;
    void            *data;
}                   t_btree;
```

### 1.2 추상 자료형

- `makeBinTree(element)`: 데이터 받아서 이진트리 리턴. 루트 노드만 존재
- `getRootNode( )`: 이진 트리를 받아서 루트 노드 리턴
- `inserLeftChildNode( )`: 부모 노드 포인터와 데이터 받아서 왼쪽 자식 추가하고 추가된 노드 리턴
- `inserRightChildNode( )`: 오른쪽 자식 추가. 내용 위와 같음.
- `getLeftChildNode( )`: 부모 노드 받아서 왼쪽 자식 리턴
- `getRightChildNode( )`: 부모 노드 받아서 오른쪽 자식 리턴
- `getData( )`: 트리를 받아서 루트 노드 데이터 반환하든지, 특정 노드를 받아서 그 노드의 데이터를 반환
- `deleteBinTree( )`: 이진트리 삭제. 메모리 해제해야함.

### 1.3 Complete Binary Tree

- 2개 이하의 자식을 가진 이진트리에서 마지막 레벨 빼고는 꽉 차있다. 마지막 레벨도 왼쪽부터 순서대로 차 있는 트리를 완전이진트리라고 한다.
- Traverse
    + 아래 예제는 후위 순회의 예제다. 순서만 바꾸면 전위, 중위도 가능
    + 완전 이진트리에서 왼쪽 자식의 인덱스는 무조건 `2*r`이고 오른쪽 자식은 `2*r+1`이다.

    ```py
    def completeBinTraverse(n, r):
        if r > n:
            return []
        # 후위 순회
        result = postOrderBin(n, 2*r)
        result += postOrderBin(n, 2*r + 1)
        result.append(r)
        return result

    def main():
        n = int(input())
        print(*completeBinTraverse(n, 1))

    if __name__ == "__main__":
        main()
    ```

## 2. Red-black tree

이진 트리의 특수한 형태로 일정한 실행 시간을 보장하고, 새로운 데이터가 삽입, 삭제되더라도 쉽게 트리 구조를 유지할 수 있다.
