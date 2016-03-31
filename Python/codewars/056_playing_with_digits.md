# #56 Playing with digits

89라는 숫자는 `8^1 + 9^2 = 89*1`로 표현될 수 있다. 즉 n이라는 숫자가 `a*100 + b*10 + c*1`일 때 `a^p + b^(p+1) + c^(p+2) = n*k`로 표현될 수 있다면 k를 리턴하는 문제다.

## 1. 내 코드

```py
def dig_pow(n, p):
    result = 0
    for i, d in enumerate(str(n)):
        result += int(d) ** (p+i)
    return -1 if result % n else result / n
```

- n을 문자열로 해서 하나하나 for 반복을 돌린다. p 값을 1씩 증가시켜야하므로 enumerate를 사용했다.
- result 값을 두고 계산한 전체 수를 더하고, n으로 딱 나눠떨어지는지 여부에 따라 -1 혹은 k 값(result / n)을 리턴한다.
- 최고 득표 답과 같다.
