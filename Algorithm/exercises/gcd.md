# GCD, Greatest Common Divisor

유클리드 호제법을 이용해 최대 공약수를 재귀용법으로 풀었다.

유클리드 호제법이란 A, B가 있을 때 최대공약수는 A를 B로 나누었을 때 나머지와 B의 최대공약수가 같다는 정의다.

```py
def gcd(x, y) :
    if y == 0:
        return x
    else:
        return gcd(y, x % y)
```
