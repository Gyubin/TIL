# #43 Hamming Numbers

매개변수로 받은 숫자 번째의 hamming number를 구하는 문제다. 성능 이슈 때문에 어려웠다. 돌아가는 코드는 두 방법으로 짰지만 결국 6초 제한을 못 이겼다. 검색을 해서 답을 찾을 수 밖에 없었다. 피라미드, power-modulo 문제에 이어 세 번째다. 부끄럽다. 그래도 4시간 이상 고민했다.

## 1. 내 코드

### A. 저성능 코드

186번째에서 6초 제한 걸림

```py
def hamming(n):
    num, cnt = 0, 0
    while cnt < n:
        num += 1
        if is_hamming(num):
            cnt += 1
    return num

def is_hamming(num):
    denominators = [2, 3, 5]
    for d in denominators:
        while not num % d:
            num /= d
    return True if num == 1 else False
```

### B. 살짝 성능 개선

559번째에서 6초 제한 걸림

- A 저성능 방식은 단순 무식하게 1에서부터 숫자 하나하나를 해밍인지 아닌지 검사하는 방식이었다. 그래서 검사 수를 줄이고자 했다.
- 결국 2, 3, 5가 곱해지는 것이므로 세 수 중 하나를 곱해가며 순서를 넘어갔다. 모든 수를 검사하는 것보단 hamming number를 직접 하나하나 찾아가는 것이기 때문에 훨씬 빨라졌다.
- dict를 사용했다. hamming number가 key고, 0-2 숫자가 value로 들어간다. 0-2 수의 의미는 아직 이 hamming에서 2, 3, 5가 곱해진 수가 나왔는지 아닌지를 나타낸다. 당연히 2, 3, 5 순서대로 수가 커지므로 value가 0이면 아직 2가 곱해진 수가 안나온 것이고, 2를 곱하면 된다. 1이면 2가 곱해진 수는 이미 나왔으므로 3이 곱해지고 5도 마찬가지다.
- result 딕셔너리에 이 조합을 하나하나 추가해나가고 2, 3, 5가 곱해질 때마다 value를 1씩 더해준다. 3이 되면 그 key-value 객체는 del 함수를 통해 제거한다. 그래서 temp 딕셔너리의 크기를 줄여서 성능을 개선한다.
- temp에 추가하는 것은 result 딕셔너리에서 최소값을 추가하면 되고 n번째에 도달했을 때 temp 딕셔너리의 max 값을 리턴해주면 된다.

```py
def hamming(n):
    cnt = 1
    temp = {1:0}
    while cnt < n:
        result = {}
        for k, v in temp.items():
            if v == 0:
                result[k] = k * 2
            elif v == 1:
                result[k] = k * 3
            elif v == 2:
                result[k] = k * 5
        minimum = min(result.values())
        temp[minimum] = 0
        for k, v in result.items():
            if v == minimum:
                if temp[k] == 2:
                    del temp[k]
                else:
                    temp[k] += 1
        cnt += 1
    return max(temp)
```

## 2. 다른 해답

### A. 로제타코드 해답

엄청나게 빠르다. 설명에 메모리를 많이 잡아먹는다고 적혀있다. 그만큼 빠르다.

```py
def hamming(limit):
    h = [1] * limit
    x2, x3, x5 = 2, 3, 5
    i = j = k = 0

    for n in xrange(1, limit):
        h[n] = min(x2, x3, x5)
        if x2 == h[n]:
            i += 1
            x2 = 2 * h[i]
        if x3 == h[n]:
            j += 1
            x3 = 3 * h[j]
        if x5 == h[n]:
            k += 1
            x5 = 5 * h[k]

    return h[-1]
```

### B. 코드워 최고 득표

```py
from itertools import islice
 
def hamming2():
    h = 1
    _h=[h]    # memoized
    multipliers  = (2, 3, 5)
    multindeces  = [0 for i in multipliers] # index into _h for multipliers
    multvalues   = [x * _h[i] for x,i in zip(multipliers, multindeces)]
    yield h
    while True:
        h = min(multvalues)
        _h.append(h)
        for (n,(v,x,i)) in enumerate(zip(multvalues, multipliers, multindeces)):
            if v == h:
                i += 1
                multindeces[n] = i
                multvalues[n]  = x * _h[i]
        # cap the memoization
        mini = min(multindeces)
        if mini >= 1000:
            del _h[:mini]
            multindeces = [i - mini for i in multindeces]
        yield h

def hamming(n):
    return list(islice(hamming2(), n))[-1]
```
