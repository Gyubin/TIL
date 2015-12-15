# #41 Least Common Multiple

운 좋게 40번 문제와 겹친 문제다. 최소 공배수를 구하는 문제다.

# 1. 내 코드

```py
def gcd(*args):
    from fractions import gcd
    return reduce(gcd, args)

def lcm(*args):
    return reduce(lambda x, y: (x * y) // gcd(x, y), args)
```

# 2. 다른 해답

어차피 2개 수만 gcd로 구할거라서 아래처럼 바로 gcd를 활용해도 괜찮겠다.

```py
from fractions import gcd
def lcm(*args):
    return reduce(lambda x,y: x * y / gcd(x,y), args)
```
