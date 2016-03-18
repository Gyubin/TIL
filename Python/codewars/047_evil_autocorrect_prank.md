# 47 Evil Autocorrect Prank

사람을 앞에 두고 자꾸 여자친구와 문자를 하는  친구를 고깝게 여긴 한 프로그래머가 'you', 'u'를 'your sister'로 바꿔버리는 스크립트를 짜도록 문제를 냈다. 'I love you'가 'I love your sister'가 돼버리는 무시무시한 코드다. 대소문자는 무시하고, 'you'는 'youuuuu'처럼 뒤에 u가 더 붙어도 상관없고, 어느 단어의 일부가 아닌 것만 허용된다.

## 1. 내 코드

```py
import re
def autocorrect(input):
    REGEX = re.compile(r'^you+$|^u$', re.IGNORECASE)
    input = REGEX.sub('your sister', input)
    REGEX = re.compile(r'^you+(\W+)', re.IGNORECASE)
    input = REGEX.sub('your sister\g<1>', input)
    REGEX = re.compile(r'^u(\W+)', re.IGNORECASE)
    input = REGEX.sub('your sister\g<1>', input)
    REGEX = re.compile(r' you+(\W+)', re.IGNORECASE)
    input = REGEX.sub(' your sister\g<1>', input)
    REGEX = re.compile(r' u(\W+)', re.IGNORECASE)
    input = REGEX.sub(' your sister\g<1>', input)
    REGEX = re.compile(r'(\W+)you+$', re.IGNORECASE)
    input = REGEX.sub('\g<1>your sister', input)
    REGEX = re.compile(r'(\W+)u$', re.IGNORECASE)
    return REGEX.sub('\g<1>your sister', input)
```

- 전방탐색이 내 뜻대로 잘 안돼서 하드코딩했다.
- 'you', 'u'가 홀로 딱 있는 경우, 맨 앞에 있는 경우, 중간에 있는 경우, 맨 뒤에 있는 경우를 각각 나눠서 모두 작업했다.
- `sub` 함수에서 뒤 혹은 앞에 특수문자가 붙어나오는 경우가 있어서 단순히 ' ' 공백 한 칸으로 처리하면 안됐다. 그래서 grouping으로 그 부분만 집어서 추가해줬다.
- 매우 무식한 코드다. 부끄럽다.. 그래도 통과는 했다.

## 2. 다른 해답

```py
import re
def autocorrect(input):
    return re.sub(r'(?i)\b(u|you+)\b', "your sister", input)
```

- `\b`
    + backreference가 아니다. backreference가 되려면 `( )` 속에서 맨 앞에 위치해야한다.
    + 여기서는 단어 구분자다. 패턴을 `r'\bcode\b'` 라고 쓴다면 'code'만 딱 매칭되고 'xcode', 'supercodefighter' 이것들은 매칭 안된다. 주로 whitespace로 구분되지만 `- , : . @`같은 거도 구분된다. `\b`를 파이썬 컴파일러가 백스페이스로 인식하므로 이것을 쓸 땐 꼭 raw string으로 써야한다.
- `(?i)` : case insensitive를 의미한다. sub에선 대소문자 무시를 어떻게 지정해줄지 몰랐었는데 패턴 문자열에서 저런식으로 붙여주면 되는거였다.
