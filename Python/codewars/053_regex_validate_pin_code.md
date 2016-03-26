# #53 Regex validate PIN code

입력받은 문자열이 숫자로 이루어진 4자리 혹은 6자리 PIN 코드인지 확인해서 True, False를 리턴하는 문제다.

## 1. 내 코드

```py
import re
def validate_pin(pin):
    if len(pin) == 4 and re.match(r'\d{4}', pin): return True
    if len(pin) == 6 and re.match(r'\d{6}', pin): return True
    return False
```

- 만약 길이가 4이고, 정규표현식으로 숫자 4개가 match 된다면 True를 리턴한다. 6개인 경우도 동일하게 if문을 더 써줬다.
- 두 개의 if문에 해당이 되지 않으면 마지막에 False를 리턴한다.

## 2. 다른 코드

### 2.1 최고 득표

```py
def validate_pin(pin):
    return len(pin) in (4, 6) and pin.isdigit()
```

- 정규표현식을 안 쓰고 문제를 풀었다. pin의 길이가 4 또는 6일 경우를 튜플에 속하는지로 표현했고, `isdigit()` 함수를 통해 숫자인지 판별했다.
- 머리 좋다.

### 2.2 정규표현식 간결화

```py
import re
def validate_pin(pin):
    return bool(re.match(r'^(\d{4}|\d{6})$',pin))
```

- 내가 처음 원했던 정규표현식만을 활용한 코드다. 난 정규표현식의 앞 뒤에 `^ &`를 붙일 생각을 못했다. 그래서 len 함수를 안 쓰면 '1234aa'같은 것도 match돼서 문제였다.
- 마지막에 `bool`로 형변환해서 리턴.
