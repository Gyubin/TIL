# BFS 최단경로 탐색

BFS를 활용해 최단 경로 찾는 알고리즘이다. [algocoding](http://www.algocoding.net/graph/shortest_path/brute_force.html) 사이트에서 원리를 참고했다.

## 1. Queue 활용

- 노드들이 서로 양방향으로 이어진 것이라 가정한다.
- 시작지점(정점)에서 시작해서 연결된 노드들을 큐에 추가하는 것을 반복한다. 
    + 예를 들어 1 -> 2, 3이고 2, 3이 각각 4로 연결되있는 경로라면
    + 1을 큐에 넣고, 1을 큐에서 빼면서 2와 3을 큐에 넣는다.
    + 다음으로 2를 큐에서 빼면서 연결된 4를 큐에 넣는다.
    + 다음 3을 큐에서 빼면서 연결된 4를 큐에 넣는다.
    + 다음 4를 큐에서 빼지만 연결된 노드가 없어서 큐에 넣는 것은 없다.
    + 마지막 남은 4도 마찬가지

## 2. 경로 탐색

```py
def get_path(path, dest):
    if dest == 0:
        return [0]
    result = get_path(path, path[dest])
    result.append(dest)
    return result

def calculate_path(nodes):
    queue = []
    distance = [999] * len(nodes)
    path = [i for i in range(len(nodes))]

    queue.append(0)
    distance[0] = 0
    while(len(queue)):
        v = queue.pop(0)
        for elem in nodes[v]:
            if distance[elem] > distance[v] + 1:
                distance[elem] = distance[v] + 1
                path[elem] = v
                queue.append(elem)
    result = map(str, get_path(path, len(nodes) - 1))
    return " ".join(result)
```

- 노드 간의 거리는 1이라고 가정한다.
- `get_path(path, dest)` : path가 기록된 배열 `path`를 넣고 원하는 목적지 인덱스를 넣으면 재귀 용법으로 0부터 dest까지 이동하는 경로를 담은 리스트를 반환한다.
- `nodes` 데이터 형태
    + 1차원 배열
    + 각 인덱스에는 인덱스값의 노드에서 이동할 수 있는 다른 노드의 번호가 담겨있다.
    + 예를 들어 nodes[3]의 값이 `(1, 2, 4)`라면 노드3에서 노드1, 2, 4로 길이 이어져있다는 의미
- `calculate_path(nodes)`: 1에서 설명했던 queue를 활용해 경로를 계산하는 함수
- 세 가지 배열 존재
    + `queue`: BFS 방식으로 풀기 위해 노드들이 순서대로 들어갈 queue이다.
    + `distance`: 0에서 시작해서 해당 인덱스의 노드까지의 거리를 저장한다. 만약 0, 1, 2 노드가 있고 거리가 3, 4라면 distance 배열은 `[0, 3, 7]`이 될 것이다.
    + `path`: 해당 인덱스 노드로 오기 직전의 노드를 값으로 가진 배열이다.
- 일반적으로는 `visited`이란 배열을 만들어서 지나온 길은 제외하는데 여기선 안그런다. 최단 경로를 구하는거라서 어떤 노드의 distance 값이 바뀌면 최단경로도 바뀔 수 있기 때문에 큐가 빌 때까지 계속 반복한다.
- 정점과 연결된 노드들이 큐에 추가되는 조건은 '정점까지의 거리 + 1' 값보다 해당 노드의 거리가 더 클 때이다. 즉 정점에서 연결되는 것이 거리가 더 짧을 경우 그 연결된 노드부터의 모든 노드의 계산을 다시 하겠다는 의미.
- 그렇기 때문에 미리 distance 배열의 원소들의 값은 충분히 큰 값으로 해줘야한다.
- 계산할 때 경로가 바뀌므로 path 배열의 값도 변경해준다.
