# #38 Convert PascalCase string into snake_case

CamelCase 문자열을 snake_case 문자열로 형태를 바꾸는 문제다. 5급 짜리 문젠데 의외로 쉬웠다.

## 1. 내 코드

```py
def to_underscore(string):
    if not isinstance(string, str): return str(string)
    result = [string[0].lower()]
    for c in string[1:]:
        if ord(c) >= 65 and ord(c) <= 90:
            result.append('_' + c.lower())
            continue
        result.append(c)
    return ''.join(result)
```

- 매개변수가 문자열인지 확인하고 아니라면 바로 문자열화해서 리턴했다.
- 첫 글자는 앞에 '_'를 붙일 필요가 없어서 소문자화해서 바로 결과 리스트에 넣었다.
- 두 번째 문자부터 반복을 돌아서 대문자라면 앞에 '_'를 붙였다.
- 만약 대문자가 아니면 바로 리스트에 넣었다.

## 2. 다른 해답

```py
import re
def to_underscore(string):
    return re.sub(r'(.)([A-Z])', r'\1_\2', str(string)).lower()
```

- 정규표현식 활용했다. 앞에 어떤 문자든 있어도 되는(개행문자 제외) 대문자 한 글자가 있다. 그 패턴을 찾는다. 앞에 글자를 넣는 이유는 첫 글자는 제외하기 위해서다.
- 그룹을 backreference해서 첫 번째 그룹과 두 번째 그룹 사이에, 즉 어떤 앞선 어떤 글자와 대문자 사이에 '_'를 삽입한다.
- 마지막에 소문자화하고 끝낸다.
