# #8 Sequence Sum
0부터 입력받은 정수까지 각 숫자 당 합을 원소로 하는 리스트를 리턴한다. 설명이 어렵다. 즉 3을 입력 받으면 [0, 1, 3, 6]이고, -2를 입력받으면 [0, -1, -3]을 리턴해야 한다.

## 1. 내 코드

원래는 n이 0 이상인지 if 문으로 분기해서 코드를 따로 썼었는데 절대값으로 바꾸는 abs()를 써서 한 줄로 쓰는 것으로 바꿨다. 그런데 꼭 한 줄로 짧게 적는게 이해하기 좋은 코드는 아닐 수도 있겠다.

리스트 내포를 사용했다. 정수를 절대값으로 바꿔서 range 함수로 리스트를 만들었다. 만들어진 리스트의 원소를 i로 받아서 다시 range 리스트를 만들어서 합을 구했다.

```python
def sum_of_n(n):
    return [sum(range(i+1)) * (1 if n >= 0 else -1) for i in range(abs(n)+1)]

#    원래 코드
#    if n >= 0:
#        return [sum(range(i+1)) for i in range(n+1)]
#    else:
#        return [sum(range(i+1))*-1 for i in range((n-1)*-1)]
```

## 2. 다른 해답

내가 참고한 코드. abs 사용한 것을 내 코드에도 적용했다. 이 분은 xrange를 썼는데 range와 거의 활용도는 같지만 list를 리턴하는게 아니라 xrange 객체를 리턴하는 함수다. 메모리를 절약할 수 있다고 한다. 즐겨 써야겠다.

- xrange(stop): 이 형태로 쓰면 range와 똑같다.
- xrange(start, stop[, step]): 이 형태로 쓰면 시작과 끝을 지정할 수 있고, 간격도 설정할 수 있다. 간격은 써도 되고 안 써도 된다.

```python
def sum_of_n(n):
    return [(-1 if n < 0 else 1) * sum(xrange(i+1)) for i in xrange(abs(n)+1)]
```
