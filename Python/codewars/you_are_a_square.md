# You're a square!
매개변수로 받은 정수가 어떤 수의 제곱수인지 검증하는 함수

## 1. 내 코드
우선 0 이상인지 검증한다. 그 후 제곱근을 씌운 결과가 실수가 아닌 정수인지 검증한다. 제곱수라면 정수일 것이므로. 결과에 따라 True, False를 리턴한다.

```python
import math
def is_square(n):    
    if n < 0: return False
    square_root = pow(n, 0.5)
    if square_root == math.floor(square_root):
        return True
    else:
        return False
```

## 2. 다른 해답

### A. math.sqrt(num), is_integer()

정수인가? 문자열인가? 실수인가? 같은 검증 함수들은 대부분 존재하는 것 같다. is_integer()는 float 객체에 달려있는 함수다. Integer 타입에선 동작하지 않는다.

math.sqrt 함수는 제곱근을 해서 결과값을 float형으로 리턴한다.

n>0과 함께 and 연산자를 통해서 True, False를 최종 리턴한다. 간결!!

```python
from math import sqrt
def is_square(n):
    return n > 0 and sqrt(n).is_integer()
    # return n > -1 and math.sqrt(n) % 1 == 0; 
    # 이런 식으로 is_integer 대신 1로 나눈 나머지가 0인지 아닌지를 판별하는 코드도 있었다. 기발하네.
```
