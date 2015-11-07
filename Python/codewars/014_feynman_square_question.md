# #14 Feynman's square question
정사각형으로 이루어진 정사각형에서 총 정사각형 개수를 구하는 문제다. 1개짜리 정사각형이면 1개, 4개로 이루어진 정사각형이면 5개 같은 식이다.

## 1. 내 코드
n*n 정사각형에서 1*1 정사각형은 n*n개만큼 있다. 2*2 정사각형은 (n-1)*(n-1)개 만큼 있고. 각 크기의 정사각형 개수를 리스트에 넣어서 sum 한 후 리턴했다.

```python
def count_squares(n):
    return sum((n-i)**2 for i in xrange(n))
```


## 2. 다른 해답
다행히 최고 득표의 해답은 나와 똑같은 코드였다. 하지만 역시 수학 문제이다보니 수학 공식을 알고리즘으로 택한 답변도 있었고, 재귀를 사용한 예도 있었다. 재귀를 사용한 예는 구하는 방식 자체는 내 답과 동일했다.

```python
# 수학 공식
def count_squares(n):
    return n*(n+1)*(2*n+1)/6

# 재귀 사용
def count_squares(n):  
    if n == 1: return 1
    else: return n**2 + count_squares(n - 1)
```
