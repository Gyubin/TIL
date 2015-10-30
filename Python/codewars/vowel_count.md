# #7 Vowel Count
문자열을 입력 받아서 모음 철자 개수를 리턴하는 함수.

## 1. 내 코드

통과는 됐지만 대문자 'AEIOU'는 체크 안해줬다. 다른 분들 코드 보고 그 부분 고쳤음. 정규표현식을 써서 aeiou 알파벳들을 하나하나 리스트에 넣었고, 그 길이를 리턴했다.

```python
import re
def getCount(inputStr):
    return len(re.findall('[aeiou]', inputStr, re.IGNORECASE))
```

## 2. 다른 해답

python에서 'in' syntax는 정말 활용 방안이 많은 것 같다. 리스트 내포 for문을 활용해서 inputStr에서 문자를 하나하나 체크하면서 만약 "aeiouAEIOU"라는 문자열에 문자가 속해있다면 리스트에 1을 추가한다. 최종적으로 모든 수를 sum 해서 리턴.

```python
def getCount(inputStr):
    return sum(1 for let in inputStr if let in "aeiouAEIOU")
```
