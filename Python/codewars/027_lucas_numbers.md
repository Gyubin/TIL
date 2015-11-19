# #27 Lucas numbers

- 디폴트 값으로 lucasnum(0) = 2, lucasnum(1) = 1이다.
- if n >= 2: lucasnum(n) = lucasnum(n-1) + lucasnum(n-2)
- if n <= -1: lucasnum(n) = lucasnum(n+2) - lucasnum(n+1)

## 1. 내 코드 3단계 변천사

### A. 첫 번째 성능 무시 재귀 코드

문제 설명 그대로 재귀함수를 활용했다. 그런데 숫자가 커지니 굉장히 느려져서 6초를 통과하지 못했다. 그래서 다시 짰다.

```python
def lucasnum(n):
    if n == 0: return 2
    if n == 1: return 1
    if n < 0: return lucasnum(n+2) - lucasnum(n+1)
    else: return lucasnum(n-1) + lucasnum(n-2)
```

### B. 두 번째 성능 고려 난잡한 코드

재귀를 쓰지 않으려면 디폴트값이 정해져있는 부분부터 차근차근 n까지 연산하면 된다. 즉 재귀가 역연산이라면 성능을 내기 위해선 정방향 연산을 해야하는 것이다.

n이 양수인 경우, 음수인 경우를 나누어서 임시 변수를 2개 두어 n에 다다를 때까지 값을 중첩시켰다. 시간 안에 통과된 코드다.

```python
def lucasnum(n):
    if n == 0: return 2
    if n == 1: return 1
    temp1 = 2
    temp2 = 1
    result = 0
    if n > 0:
        for i in range(2, n+1):
            result = temp1 + temp2
            temp1 = temp2
            temp2 = result
    else:
        for i in range(-1, n-1, -1):
            result = temp2 - temp1
            temp2 = temp1
            temp1 = result
    return result
```

### C. 세 번째 최종 알고리즘

두 번째 코드를 좀 간결하게 줄이고싶었다. 그래서 문제 자체를 조금 더 분석해보니 아래와 같은 법칙(?)이 나왔다. `lucasnum(0)` 의 값과 `lucasnum(1)`의 값이 계속 반복되어 등장했는데 그 순서가 피보나치 수열이었다.

| n 값 | lucasnum(0) 개수 | lucasnum(1) 개수 |
|------|------------------|------------------|
|   -5 |               -8 |                5 |
|   -4 |                5 |               -3 |
|   -3 |               -3 |                2 |
|   -2 |                2 |               -1 |
|   -1 |               -1 |                1 |
|    0 |                1 |                0 |
|    1 |                0 |                1 |
|    2 |                1 |                1 |
|    3 |                1 |                2 |
|    4 |                2 |                3 |
|    5 |                3 |                5 |
|    6 |                5 |                8 |

그래서 피보나치 함수를 따로 만들었고 lucasnum 함수는 한 줄로 마무리할 수 있었다. 그런데 한 줄이 너무 길어서 복잡하긴 하다.

```python
def fibonacci(n):
    a, b = 0, 1
    for i in range(n): a, b = b, a+b
    return a

def lucasnum(n):
    L0, L1 = 2, 1
    return L0*fibonacci(abs(n-1))*(pow(-1, n%2) if n<0 else 1) \
         + L1*fibonacci(abs(n))*(pow(-1, not n%2) if n<0 else 1)
```

## 2. 다른 해답

```python
def lucasnum(n):
    a, b = 2, 1
    flip = n < 0 and n % 2 != 0
    for _ in range(abs(n)):
        a, b = b, a + b    
    return -a if flip else a
```

코드를 해석해보니 n이 0일 때를 기준으로 음수 방향, 양수 방향의 lucasnum 함수 리턴값의 절대값이 똑같았다. `-11 7 -4 3 -1 2 1 3 4 7` 이걸 이용해서 마지막에 flip한 다음 리턴했다. 내 코드보다 낫다!


