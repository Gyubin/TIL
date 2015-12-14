# #39 RGB To Hex Conversion

RGB 값을 받아서 문자열로 바꾼다. `0, 0, 0`을 받으면 '000000'을, `255, 255, 255`를 받으면 'FFFFFF'를 리턴하는 식이다.

## 1. 내 코드

간단하게 숫자 범위를 나누어서 16진수로 바꿔주었다.

```py
def change(n):
    if n >= 0 and n <= 9: return '0' + str(n)
    elif n < 0: return '00'
    elif n > 255: return 'FF'
    else: return hex(n)[2:].upper()
def rgb(r, g, b):
    r, g, b = change(r), change(g), change(b)
    return r + g + b
```

## 2. 다른 답

- 최고득표 해답이다. 훨씬 세련된 방식이다. round라는 람다를 만들었는데 min, max 함수를 적절히 활용해서 조건 분기를 대신했다.
- format 활용 : `"{:02X}"`
    + `02` : 2칸 간격인데 공백은 0으로 채우겠다.
    + `X`는 16진수를 나타낸다.
    + [공식문서](https://docs.python.org/3/library/string.html#string-formatting)에 자세히 나와있다. format을 활용할 때 중괄호 `{ }` 안에 `:` 콜론 뒤는 스펙을 나타낸다. 즉 `'{:02X}'`는 `'%02X'`와 같은 의미다.

```py
def rgb(r, g, b):
    round = lambda x: min(255, max(x, 0))
    return ("{:02X}" * 3).format(round(r), round(g), round(b))
```
