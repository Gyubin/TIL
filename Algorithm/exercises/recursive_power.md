# Power function with recursion

## 1. 재귀용법으로 거듭제곱 구하기

```py
def getPower(m, n):
    if n == 0:
        return 1
    tmp = getPower(m, n // 2)
    if n % 2 == 0:
        return tmp * tmp
    else:
        return m * tmp * tmp
```

- `A^2 * A^4`는 `A^(2+4)` 로 표현할 수 있다. 이 원리를 구현한 것이다.
- 만약 2의 10 제곱을 구한다 하면: `2^5`의 제곱을 구하고, `2^5`는 `2^2`의 제곱에 2를 한 번 곱해주는 것으로 구하는 식으로 계속 아래로 내려가면 된다.
- 즉 지수가 짝수인지 홀수인지 따라 분기해서 처리하면 됨. 간단하지만 강력한 알고리즘

## 2. 거듭제곱의 나머지 구하기

```py
LIMIT_NUMBER = 1000000007

def getPower(m, n):
    if n == 0:
        return 1
    tmp = getPower(m, n // 2)
    if n % 2 == 0:
        return tmp * tmp % LIMIT_NUMBER
    else:
        return m * tmp * tmp % LIMIT_NUMBER
```

- m의 n 제곱을 LIMIT_NUMBER로 나눈 나머지를 구하는 것이다.
- 위 1번 코드와 같은 원리인데 매번 리턴할 때 나머지만 리턴한다.
- 원리는 다음과 같다. 예를 들어 2의 5제곱을 5로 나눈다고 하자.
    + 2의 3제곱부터 5보다 커지게 된다. `2^3 = 8 = 5 + 3`
    + 2의 4제곱이라면 위 식에서 `2^4 = 16 = 5*2 + 3*2` 처럼 양 변에 2를 곱해준 것이 된다. 보면 어차피 나머지가 아닌 부분은 5의 배수이므로 계산할 필요가 없다. 계속 나머지만 계산해나가면 됨
