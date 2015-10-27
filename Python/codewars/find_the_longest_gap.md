# Find the longest gap
정수를 매개변수로 받아서 2진수로 변환한 후 1과 1 사이의 간격 중 가장 큰 수치를 리턴하는 함수를 짜는 문제.

## 1. 내 코드
매우 길다. 10진수를 2진수로 만드는 코드를 직접 하나하나 짰다.

```python
def gap(num):
    # binary 숫자가 담긴 binary_list 만들기
    binary_list = []
    while True:
        binary_list.append(num % 2)
        num /= 2
        if num < 2:
            if num == 1:
                binary_list.append(num)
            break
    binary_list.reverse()

    # 1이 위치한 인덱스 구해서 리스트에 넣기
    indices = []
    cnt = 0
    for i in binary_list:
        if i == 1:
            indices.append(cnt)
        cnt += 1

    # 인덱스 간의 차를 리스트에 넣기
    difference = []
    for i in range(len(indices)-1):
        difference.append(indices[i+1] - indices[i])

    # 차이값이 1보다 큰 것만 남기기. 원소가 있으면 최대값-1 리턴, 없으면 0 리턴
    result = filter(lambda x: x > 1, difference)
    if result:
        return max(result) - 1
    else:
        return 0
```

## 2. 다른 해답

### A. bin, strip, split
특히 split을 통해 gap을 구하는 것을 보고 정말 기발하다 생각했다.

- 첫 줄: bin 함수로 2진수를 나타내는 문자열을 만든다. 앞에 붙는 '0b' 제거하고, 양 끝의 0들은 있어봤자 gap과 의미가 없으니 strip으로 없앤다.
- 둘 째: "1"을 기준으로 split하면 "100101"일 경우 ["", "00", "0", ""] 이렇게 리턴된다. 즉 여기서 가장 길이가 긴 원소의 길이를 리턴하면 된다. map 함수를 통해 len 함수를 원소마다 적용해서 리스트로 만들고, 거기서 max 함수로 최대 길이를 리턴한다.

```python
def gap(num):
    s = bin(num)[2:].strip("0")
    return max(map(len, s.split("1")))
```

### B. 정규표현식 활용
정규표현식을 빨리 숙달해야겠다. 무궁무진한 활용도다. 감탄.

- 1과 1 사이에 0이 0개 이상 들어가는 패턴을 만들었다.
- 리스트 내포 for문을 활용했다.
    - iterable: findall(REGEX, bin(num)) + [''] => 마지막에 None 문자열이 들어있는 리스트를 추가해주는 이유는 정규표현식과 매칭되는 패턴이 없을 때 빈 리스트가 리턴되기 때문이다. for문 자체가 돌질 않는다. 0을 리턴하기 위함이다.
    - iterable의 원소 하나하나를 a로 받고 len(a) 값을 리스트에 저장했다. 그리고 원소 중 최대값을 리턴

```python
from re import compile, findall
REGEX = compile(r'(?=1(0+)1)')
def gap(num):
    return max(len(a) for a in findall(REGEX, bin(num)) + [''])
```
