# #26 Counting duplicates

매개변수로 받은 문자열에서 중복되는 알파벳이 몇 개인지 리턴하는 문제다. 대소문자 구별하지 않는다.

## 1. 내 코드

최고 득표 해답과 살짝 다르다. 뭐 똑같네 하고 다시 보다가 반복 회수가 나보다 적더라. 내 코드 아래에 붙여넣었다. 대소문자를 구별하지 않으므로 upper를 활용했고, 하나씩 뽑아서 count 함수를 활용해 1보다 크면 리스트에 넣었다. 그리고 그것을 set으로 만들어서 길이를 리턴했다. 최고득표 해답은 애초에 반복문 돌릴 때 set을 활용하더라. 반복이 얼마나 많이 있느냐에 따라서 반복회수가 내 답보다 적어진다. 머리 좋다!

```python
# 내꺼
def duplicate_count(text):
    return len(set([c for c in text.upper() if text.upper().count(c) > 1]))

# 최고 득표
def duplicate_count(text):
    return len([c for c in set(text.lower()) if text.lower().count(c) > 1])
```

## 2. 다른 해답

Counter 클래스를 활용했다. lower를 적용한 텍스트로 Counter 객체를 만들고 내장함수인 iteritems 메소드로 문자와 문자 개수 딕셔너리 객체를 하나하나 리턴했다. 그래서 개수가 1보다 크면 1을 리스트에 넣고 최종 sum을 한 코드다.

근데 이건 python2에서만 작동한다. python3에선 iteritems 대신 items()를 활용하면 된다. 주석 참조

```python
from collections import Counter

def duplicate_count(text):
    return sum(1 for c, n in Counter(text.lower()).iteritems() if n > 1)
    # return sum(1 for c, n in Counter(text.lower()).items() if n > 1)
```
