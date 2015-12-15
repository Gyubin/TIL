# #40 Common Denominators

'2개 원소를 가진 리스트'를 원소로 가진 리스트를 매개변수로 받는다. 예를 들어 `[[1, 2], [1, 3], [1, 4]]`를 받는다고 하자. 그리고 같은 길이의 `[[N1, D], [N2, D], [N3, D]]` 형태를 리턴해야 한다. 다만 1/2, 1/3, 1/4와 N1/D, N2/D, N3/D의 값이 같아야 한다.

## 1. 내 코드

이 [gist](https://gist.github.com/endolith/114336)를 참고해서 gcd(great common denominator)와 lcm(least common multiple)을 구했다. 그 후론 특별할게 없었다. 매개변수로 받은 리스트에서 원소인 각 리스트의 두 번째 원소들의 lcm을 구했고, 바로 문제의 연산을 적용해서 리스트를 리턴했다. 최고 득표 해답과 동일한 답이다. 그리고 이 문제를 풀고 `4kyu`가 되었다.

```py
def gcd(numbers):
    from fractions import gcd
    return reduce(gcd, numbers)

def lcm(numbers):
    def lcm(a, b):
        return (a * b) // gcd([a, b])
    return reduce(lcm, numbers, 1)

def convertFracts(lst):
    D = lcm([j for i, j in lst])
    return [[n * D / de, D] for n, de in lst]
```
