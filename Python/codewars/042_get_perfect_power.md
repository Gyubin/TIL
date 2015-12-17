# #42 What's a Perfect Power anyway?

매개변수로 받은 숫자가 제곱수인지 판별하는 함수다. 수를 `m의 k승` 형태로 표현해서 `[m, k]`를 리턴한다. 예를 들어 125라면 [5, 3]을 리턴하고 36이라면 [6, 2]를 리턴한다.

## 1. 내 코드

```py
from functools import reduce # python 3.x
from fractions import gcd
from operator import mul

def isPP(n):
    primes = get_primes(n)
    g = reduce(lambda x, y: gcd(x, y), primes.values())
    if g == 1: return None
    base = reduce(mul, [k**(v/g) for k, v in primes.items()])
    return [base, g]

def get_primes(n):
    k = 2
    result = {}
    while n != 1:
        while True:
            if n % k == 0:
                if k in result:
                    result[k] += 1
                else:
                    result[k] = 1
                n /= k
            else:
                break
        k += 1
    return result
```

- 소인수분해하는 함수를 만들었다. 예를 들어 100을 입력받으면 `{2:2, 5:2}`를 리턴하는 형태다.
- 여기서 value에 해당하는 지수들의 최대공약수를 구했다. 최대 공약수가 1이 아니라면 완전 제곱수로 나타낼 수 있다.
- 소인수 분해한 딕셔너리에서 각 키 값에 밸류를 g로 나눈 값을 곱해준다. 이렇게 구해진 키값들을 모두 곱하면 최종 리턴값의 첫 번째 원소인 밑 수가 된다.

## 2. 다른 해답

```py
from math import log, sqrt

def isPP(n):
    for b in xrange(2, int(sqrt(n))+1): # python 3.x -> use 'range'
        e = int(round(log(n, b)))
        if b ** e == n:
            return [b, e]
    return None
```

- 어떤 큰 수의 경우에선 내 코드가 바로 답을 내놓는데 반해, 이 코드는 몇 초가 걸리는 등의 성능 차이가 있기도 했다. 하지만 내 경우에도 느린 경우가 있어서 큰 차이는 없어보인다.
- 에라토스테네스의 체의 원리에서처럼 딱 제곱근 숫자까지만 for 반복했다. log 함수를 써서 매개변수로 받은 n이 b의 제곱수라면 [b, e]를 리턴했다. 나도 처음에 이 방식을 썼었는데 round를 쓸 생각을 못했다. 내 경우 로그함수의 리턴값이 3.0000004가 나올 때가 있었는데 이 때 이 값으로 제곱해봤더니 원래 값과 달랐다. 그래서 이 방식이 아니구나 싶어서 넘겼는데 이렇게 오차를 피해갔다. 기억해두자.
