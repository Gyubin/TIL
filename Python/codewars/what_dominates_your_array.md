# #4 What dominates your array?
정수로 이루어진 배열을 받는다. 원소 전체 개수의 과반수를 차지하는 원소를 리턴하면 된다. 과반수가 없다면 -1을 리턴한다.

## 1. 내 코드
arr 원소 하나하나를 반복문으로 돌면서 count 메소드로 과반수 이상인지 체크한다. 맞으면 바로 리턴하고 없으면 반복문이 끝나고 -1을 리턴한다.

```python
def dominator(arr):
    for i in arr:
        if arr.count(i) > len(arr)/2:
            return i
    return -1
```

## 2. 다른 코드
모두 비슷한 결과물이라서 나랑 달랐던 해답을 골랐다.

Counter는 hashable object에서 수를 세아리는데 특화된 클래스다. 아래 코드는 arr을 매개변수로 Counter 객체를 만들고, most_common 함수를 통해 가장 많이 나타나는 원소를 고른 것이다. 매개변수로 1이 들어갔기 때문에 하나만 뽑은 것이고, 리스트를 리턴하기 때문에 [0]로 첫 번째 원소를 뽑았다. 변수 두 개로 받은 것은 리스트의 원소 하나 하나가 '값'과 '값의 개수'를 튜플로 리턴하기 때문이다. 마지막엔 과반수인지 체크하고 리턴한다. 

```python
from collections import Counter

def dominator(arr):
    if not arr:
        return -1
    k, v = Counter(arr).most_common(1)[0]
    return k if v > len(arr) / 2 else -1
```
