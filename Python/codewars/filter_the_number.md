# Filter the number

입력받은 문자열에서 숫자만 뽑아내어 연결시킨 수를 리턴한다. 'a1b2c3'이면 123을 리턴하는 방식.

## 1. 내 코드

정규표현식을 활용했다. 숫자만을 뽑아내는 형태인 \d를 활용해서 매칭되는 모든 숫자 하나하나를 리스트로 받았다. 받은 리스트를 공백없이 join으로 붙이고 정수화해서 리턴했다.

```python
import re

def filter_string(string):
    p = re.compile("\d")
    num_list = p.findall(string)
    result = int("".join(num_list))
    return result
```

## 2. 다른 해답
filter 함수, re 모듈의 sub 함수, isdigit 함수를 활용한 해답들이 있었다.

### A. filter, isdigit

- 'filter(function, iterable)' 형태로 사용된다. iterable의 원소 중 function의 조건을 만족하는 원소만 뽑아내 리스트로 리턴한다.
- str.isdigit() isdigit() 함수는 문자열에서 호출할 수 있다. "10".isdigit()은 True를 리턴하고, "a1b2c3".isdigit()은 False를 리턴한다.
- re.sub(pattern, repl, string, count=0, flags=0) string에서 pattern에 해당하는 문자열을 repl로 바꾼다. count는 최대 바꾸는 회수를 말하고 flags는 확실히는 모르겠지만 re.IGNORECASE 같은 것이 들어가서 조건을 정하는 것 같다.

### B. 코드

```python
########################### isdigit을 조건으로 filter
def filter_string(string):
    return int(filter(str.isdigit, string))

########################### 문자가 아닌 것을 없애버린다.
import re
def filter_string(string):
    nb = re.sub(r'\D', '' ,string)
    return int(nb)
    
########################### isdigit 활용한 리스트 내포형
def filter_string(string):
    result = [el for el in string if el.isdigit()]
    return int(''.join(result))
```
