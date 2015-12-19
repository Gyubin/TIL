# #43 Hamming Numbers

매개변수로 받은 숫자 번째의 hamming number를 구하는 문제다. 성능 이슈 때문에 어려웠다. 돌아가는 코드는 두 방법으로 짰지만 결국 6초 제한을 못 이겼다. 검색을 해서 답을 찾을 수 밖에 없었다. 피라미드, power-modulo 문제에 이어 세 번째다. 부끄럽다. 그래도 4시간 이상 고민했다. 확실히 4급 문제는 어렵다.

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

엄청나게 빠르다. 설명에 메모리를 많이 잡아먹는다고 적혀있다. 그만큼 빠르다. [링크](http://rosettacode.org/wiki/Hamming_numbers#Python)에 나온 답이고 해석해보려 했지만 왜 저런식으로 짰는지, 왜 결과값이 정확하게 나오는지 잘 모르겠다. 링크에 다른 답변들도 있는데 역시 해석이 잘 안된다. 말 그대로 '수학'이다.

- 매개변수로 받은 수의 길이만큼 리스트 설정한다. hamming number 리스트다.
- 2, 3, 5의 배수를 저장할 변수인 `x2`, `x3`, `x5`가 있고, 각 변수와 연관되는 인덱스인 `i`, `j`, `k`다.
- 1부터 매개변수로 받은 수 바로 전까지 for 반복을 돌고 변수는 `cnt`로 둔다. x2, x3, x5 중 최소값을 hamming list의 cnt 번째 원소에 대입한다. 대입된 최소값이 x2, x3, x5이냐에 따라서 아래 조건문을 실행하는데 `elif`를 쓰지 않는 이유는 x2, x3, x5가 같은 수일 수도 있기 때문이다. 그렇기 때문에 모두 적용하기 위해서 따로 if 문을 각각 써줬다.
- 조건문 내부는 각 변수 별 인덱스를 1 더해주고, hamming number 리스트에서 그 인덱스의 수를 변수의 배수(2 or 3 or 5)와 곱해준다. 이 결과값을 변수에 대입한다.(이 부분이 가장 이해가 안된다. 왜 이게 정확하게 hamming number를 뽑아내는지 모르겠다.)
- 반복을 모두 돌면 리스트에 해밍 넘버가 기록되어있다. 마지막 원소를 리턴하면 된다.

```py
def hamming(limit):
    h = [1] * limit
    x2, x3, x5 = 2, 3, 5
    i = j = k = 0

    for cnt in range(1, limit):
        h[cnt] = min(x2, x3, x5)
        if x2 == h[cnt]:
            i += 1
            x2 = 2 * h[i]
        if x3 == h[cnt]:
            j += 1
            x3 = 3 * h[j]
        if x5 == h[cnt]:
            k += 1
            x5 = 5 * h[k]

    return h[-1]
```

### B. 코드워 최고 득표

```py
def hamming(n):
    bases = [2, 3, 5]
    expos = [0, 0, 0]
    hamms = [1]
    for _ in range(1, n):
        next_hamms = [bases[i] * hamms[expos[i]] for i in range(3)]
        next_hamm = min(next_hamms)
        hamms.append(next_hamm)
        for i in range(3):
            expos[i] += int(next_hamms[i] == next_hamm)
    return hamms[-1]
```

```py
import itertools

H = sorted([
  2**i * 3**j * 5**k
  for i, j, k in itertools.product(xrange(50), xrange(50), xrange(50))
])
hamming = lambda n, H=H: H[n-1]
```
