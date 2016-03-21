# #49 WeIrD StRiNg CaSe

문자열을 입력받아서 공백으로 구분된 단어 별로 문자 단위 CamelCase를 적용하는 문제다. 이 파일 제목같이.

## 1. 내 코드

```py
def to_weird_case(string):
    result = []
    for word in string.split(' '):
        for i, c in enumerate(word):
            if i % 2 : result.append(c.lower())
            else: result.append(c.upper())
        result.append(' ')
    return ''.join(result[:-1])
```

- 중첩 for 문을 사용했다. 우선 단어로 구분하고, 단어에서 인덱스에 따라 대문자화할지 소문자화할지 정했다.
- 합칠 때는 단어 간 공백도 필요하므로 내부 for 문이 끝날 때마다 공백을 추가해줬는데 마지막 리턴할 때는 끝의 공백은 필요없으므로 제외하고 붙여서 리턴했다.

## 2. 다른 해답

원리는 나와 같다. word 단위로 함수를 짜고, ' ' 단위로 join한 것이 나와 다르다.

```py
# 첫 번째
def to_weird_case_word(string):
    return "".join(c.upper() if i%2 == 0 else c for i, c in enumerate(string.lower()))
def to_weird_case(string):
    return " ".join(to_weird_case_word(str) for str in string.split())

# 두 번째
def to_weird_case(string):
    recase = lambda s: "".join([c.upper() if i % 2 == 0 else c.lower() for i, c in enumerate(s)])
    return " ".join([recase(word) for word in string.split(" ")])
```
