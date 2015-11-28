# #33 Efficient Power Modulo n

성능 이슈로 4시간 동안 고민하다가 밥 먹고 와서 또 1시간 고민하고, 결국 인터넷에서 알고리즘 힌트를 본 후 직접 구현했다. 힌트를 받은건 아쉽지만 알고리즘을 내가 직접 구현했다는 점과, 성능 이슈를 해결하는 방식 하나를 알게 되서 진심으로 뿌듯하다.

문제는 단순하다. x, y, n 세 자연수를 입력받아서 x의 y제곱을 n으로 나눈 나머지를 구하는 문제다. 정말 단순하게 짤 수 있지만 성능 이슈에 계속 걸린다.

## 1. 내 코드

### A. 저성능 코드

```python
# 제일 간단한 코드고 답은 제대로 나오지만 성능이 최악이다.
def power_mod(x, y, n):
    return x ** y % n

# 혹시 나머지가 반복되는 수열이지 않을까 싶어서 시도했다. 아닌 경우가 많더라. 실패.
def power_mod(x, y, n):
    repetition = []
    i = 1
    pm = x ** i % n
    while pm not in repetition:
        repetition.append(pm)
        i += 1
        pm = x ** i % n
    index = (y-1) % len(repetition)
    return repetition[index]

# 결국 전체 수식의 나머지 값은 x%n 나머지값에만 좌우되더라. 식으로 증명했다.
# 그래서 아래와 같이 짰는데 역시 6초 제한에 걸렸다.
# 문제는 지수였다. y를 줄일 수 있는 방식을 찾아야했다.
def power_mod(x, y, n):
    return ((x % n) ** y) % n
```

### B. 최종 코드

결국 지수인 y를 'divide and conquer'하는 방법이었다. y를 2의 제곱수들로 분해한다음 가장 작은 수부터 차례대로 계산하고 마지막에 합쳐서 계산하는 방식이다. 차례대로 계산한다는 것의 의미는 내 저성능 코드 마지막 답에서 알아냈던 x%n에 좌우된다는 것과 연관된다. 나머지값만 계속 계산하면 되고, 2의 제곱수로 구분했기 때문에 2의 제곱수로 나눈 y값들을 제곱하면서 넘어가면 되는 것이다. 연산 수는 늘어났겠지만 숫자 크기가 엄청나게 줄어들었다. 예를 들어 설명해보면

- x = 15, y = 23, n = 120 라고 할 때
- y를 2진수로 바꾸면 0b10111 이다. 즉 y는 2^0 + 2^1 + 2^2 + 2^4 인 것이다.
- 나는 10111을 순서를 반대로 해서 리스트로 만들었다. 즉 [1, 1, 1, 0, 1]로 만들어서 for문으로 원소를 하나하나 뽑아냈다.
- 2^0부터 시작하므로 바로 x%n을 해줬다. 만약 이 때 원소가 1이라면 그 경우가 존재하는 것이므로 result 리스트에 추가해줬다. 다음으로 넘어가기 전에 mod 값을 제곱해줬다. 제곱해주는 이유는 y를 2의 제곱수로 구분해놨기 때문이다.
- result에는 모든 mod값을 저장해놓았고, 최종적으로 이 mod값들을 곱한 값을 다시 mod n 해주면 된다. 그 결과를 리턴한다.

```python
from operator import mul
from functools import reduce    # python3에선 reduce를 사용하기 위해 써줘야함.
def power_mod(x, y, n):
    bin_y = list(bin(y)[:1:-1])
    result = []
    for i in bin_y:
        x %= n
        if int(i):
            result.append(x)
        x = x ** 2
    return reduce(mul, result) % n
```

## 2. 다른 해답

내가 고민한 것이 허무할 정도로 간단하고 멋지게 짠 코드들이 많다.

### A. 최고 득표

비트 연산을 이용했다. 나와 원리는 같지만 훨씬 세련된 방식이다.

```python
def power_mod(b, e, m):
    res = 1     # 결과값
    b %= m      # b mod m을 해서 시작하는 mod값으로 활용한다.
    # e 지수가 0보다 클 때만 반복한다. 즉 비트연산을 했을 때 계속 1/2씩 작아지면서 마지막엔 0이 되므로 그 전까지 반복하는 의미다.
    while e > 0:
        if e & 1: res = res * b % m     # 1과 비트연산 and를 해서 1이라면, 즉 e의 2진수형태에서 마지막 2^0 부분 값이 1이라면의 의미와 같다. 그 때 b mod m 값을 곱해준다.
        e >>= 1     # e를 우측으로 shift한다.
        b = b * b % m   # 나머지 값을 똑같이 제곱해 준다음 바로 mod m을 매 번 해줬다. 그래서 나처럼 마지막에 mod m 해줄 필요가 없다.
    return res
```

### B. 내 코드 업그레이드판

비트연산을 사용하진 않았지만 내 코드가 깔끔해지면 이런 모양이 될 것이다.

```python
def power_mod(x, a, n):
    ret = 1
    x = x % n
    while a:
        (a, r) = divmod(a, 2)
        if r:
            ret = ret * x % n
        x = x ** 2 % n
    return ret
```
