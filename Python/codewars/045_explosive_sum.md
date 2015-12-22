# #45 Explosive Sum

매개변수로 받은 수를 다른 자연수의 합으로 나타낼 수 있는 가짓수를 구하는 문제다. 3이라면 1+1+1, 1+2, 3 이렇게 3가지가 있겠다.

## 1. 내 코드

참고 링크: [위키피디아](https://en.wikipedia.org/wiki/Partition_(number_theory))

```py
def exp_sum(n):
  if n < 0:
    return 0
  dp = [1]+[0]*n

  for num in xrange(1, n+1):
    for i in xrange(num, n+1):
      dp[i] += dp[i-num]

  return dp[-1]
```

## 2. 다른 해답

```py
class Memoize:
    def __init__(self, func): 
        self.func = func
        self.cache = {}
    def __call__(self, arg):
        if arg not in self.cache: 
            self.cache[arg] = self.func(arg)
        return self.cache[arg]

@Memoize
def exp_sum(n):
    if n == 0: return 1
    result = 0; k = 1; sign = 1; 
    while True:
        pent = (3*k**2 - k) // 2        
        if pent > n: break
        result += sign * exp_sum(n - pent) 
        pent += k
        if pent > n: break
        result += sign * exp_sum(n - pent) 
        k += 1; sign = -sign; 
    return result
```

```py
def exp_sum(n):
    if n < 0: return 0
    A = [1] + [0]*n
    for i in range(n):
        A = [sum(A[:k+1][::-i-1]) for k in range(n+1)]
    return A[-1]
```
