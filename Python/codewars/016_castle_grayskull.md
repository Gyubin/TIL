# #16 By the Power Set of Castle Grayskull
한 마디로 입력받은 리스트의 멱집합(power set)을 구하는 문제다. iterable 객체를 매개변수로 받아서 그 원소를 combination 한 모든 결과를 각각 리스트에 넣어서 결과값에 넣는다. 즉 [1, 2, 3]이면 [[], [1], [2], [3], [1, 2], [1, 3], [2, 3], [1, 2, 3]] 을 리턴해야 한다.

## 1. 내 코드
combinations라는 함수를 사용했다. 첫 번째 매개변수에 iterable을 넣고, 두 번째 매개변수에 몇 개를 뽑을 건지 넣어주면 된다. 0개부터 iterable 전체 수까지 뽑아야 하므로 전체 길이의 +1까지 xrange를 돌렸다. combinations 객체를 반복문으로 뽑아내면 결과물이 튜플이라서 list화 해줬다. (뿌듯한건 최고 득표 해답과 똑같았다. 다만 그 해답은 억지로 한 줄로 줄여놨는데 내 입장에선 가독성 안좋고 별로더라.)

```python
from itertools import combinations
def power(s):
    result = []
    for i in xrange(len(s)+1):
        result += [list(j) for j in combinations(s, i)]
    return result
```

## 2. 다른 해답: chain, chain.from_iterable
itertools 모듈에 chain 관련 함수들도 있었다. 이를 활용하면 따로 리스트 변수를 선언해서 합친 후 리턴할 필요 없이 바로 리턴할 수 있다.

- from itertools import chain: chain(*iterables) 형태로 사용된다. 여러 개의 iterable이 매개변수로 들어가면 그걸 다 연결시켜서 마치 하나의 연결된 iterable처럼 사용할 수 있다.
- 위 chain 클래스의 클래스 메소드다. chain.from_iterable(iterable) 형태로 사용된다. 매개변수로 들어온 iterable의 원소들을 chain한다는 의미다. 더 깊이 들어가진 않고 딱 매개변수로 받은 iterable의 원소까지만 chain한다. 즉 매개변수 iterable의 원소의 원소까지는 안들어간다.

```python
def power(s):
    from itertools import chain, combinations
    return chain.from_iterable(combinations(s, r) for r in range(len(s) + 1))
```
