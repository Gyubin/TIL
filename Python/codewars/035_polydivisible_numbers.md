# #35 Polydivisible Numbers

숫자를 입력받아서 이 숫자가 polydivisible한지 구하는 함수와, 주어진 진법에서 n번째 polydivisible 숫자를 리턴하는 문제다. 여기서 polydivisible이란 예를 들어 123일 경우와 같다. 123일 경우 1, 12, 123이 각각 1, 2, 3으로 온전히 나누어떨어지기 때문에 polydivisible이라 할 수 있다. 방금 예는 10진법에서 예였고 만약 123이 6진법이라면 1, 12, 123을 각각 6진법 수로 바꾼 1, 8, 51이 1, 2, 3으로 나누어떨어지면 된다. 역시 나누어떨어지므로 6진법에서도 polydivisible이다.

## 1. 내 코드

처음에 쉽게 생각했다가 된통 당했다. 진법의 수가 무려 62진법까지 있으며 범위가 `[0-9A-Za-z]` 순서라서 이거 하나하나 잡아내야했다. 도대체 왜 이런 문제를 낸건지 모르겠다. 풀기 시작했으니 어떻게든 끝은 봤지만 애초에 이런 문제인 줄 알았다면 절대 안 풀었을 것이다.

- `convert_base`
    + 1번: divmod를 활용해서 입력받은 수를 b진법으로 바꿨다. 아직 10이 넘어가는 수를 알파벳으로 바꾸진 않았다.
    + 2번: 10이 넘는 수를 알파벳으로 바꿨다. 10보다 작으면 바로 문자열로, 10이상 36미만은 대문자 A에서 Z까지이므로 아스키코드값 55를 더했고 그 이상은 소문자이므로 61을 더해줬다.
- `is_ploydivisible`
    + 문자열 길이만큼 반복을 돌았다. 123에서 1, 12, 123을 문자열 슬라이싱으로 뽑아내기 위해서다.
    + 문자열 슬라이싱으로 뽑아낸 문자열에서 또 반복을 돌았다. enumerate을 이용해서 뽑아낸 인덱스 j와 i를 활용해 진법의 지수를 정했다. 여기서 만약 알파벳일 경우 처리해줬다.
    + 변환된 수를 i+1로 나눠서 나머지가 있으면 바로 False를 리턴했다.
- `get_polydivisible`: 위 두 함수를 이용해서 쉽게 계산함.

```python
def convert_base(num, b):
    # 1번
    result = []
    while True:
        div, mod = divmod(num, b)
        if div >= b:
            result.append(mod)
            num = div
        else:
            if div == 0: result.append(mod)
            else: result.extend([mod, div])
            break
    result.reverse()

    # 2번
    temp = []
    for i in result:
        if i < 10:
            temp.append(str(i))
        elif i < 36:
            temp.append(chr(i+55))
        else:
            temp.append(chr(i+61))
    return ''.join(temp)

def is_polydivisible(s, b):
    for i in range(len(s)):
        convert = 0
        for j, d in enumerate(s[:i+1]):
            if d.isalpha(): d = ord(d.upper()) - 55
            convert += int(d)*(b**(i-j))
        if convert % (i+1): return False
    return True

def get_polydivisible(n, b):
    cnt, num = 0, -1
    while cnt < n:
        num += 1
        if is_polydivisible(convert_base(num, b), b): cnt += 1
    return convert_base(num, b)
```
