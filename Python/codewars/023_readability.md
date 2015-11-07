# #23 Readability is King

단일 문장 혹은 여러 문장의 텍스트를 입력받아서 'Flesch–Kincaid Grade Level'를 측정해서 리턴한다. 이 지표는 아래 식으로 구한다.

```
level = (0.39 * average number of words per sentence) + (11.8 * average number of syllables per word) - 15.59
```

- 문장 별 평균 단어 개수: "I am a student. Nice to meet you"인 경우 2문장에 8개 단어이므로 4다.
- 단어 별 평균 음절 수: 한 번에 발음되는 음절을 단어로 평균내라는 의미다. 영어같은 경우 이런 음절을 체크하기가 미묘한 것이 많으므로 모음 수를 계산하라고 한다. 하지만 meet처럼 모음이 연달아 연달아 붙어있는 경우는 하나로 친다고 한다.
- 소수점 2자리까지 표현한다.
- 다음은 무시한다: hyphens, dashes, apostrophes, parentheses, ellipses and abbreviations

## 1. 내 코드

포기하기 직전까지 갔다. 정말 어이없다. `?` 물음표는 문장을 나누지 않는다. 이 무슨 어이없는... 테스트를 계속 해보니 꼭 물음표만 나오면 incorrect가 떴다. 로컬에서 따로 돌려서 하나하나 문장 수, 단어 수, 음절 수 다 헤아려보면서 물음표 코드가 제대로 동작하는지 수십번을 확인해본 것 같다. 정말 화가 머리 끝까지 치밀어올라서 그럼 도대체 물음표는 어떻게 할건데 따지는 심정으로 `\?`를 패턴에서 지웠더니 정답이란다. 하...

findall은 자꾸 왜 없냐고 에러 떠서 re.findall로 메소드 넣어줬다. 누가 문제 만든건지 제대로 안 만들거면 만들지를 말든가. 정말 화난다. 중간에 포기하기도 싫고 이런거 잘못 걸리면 어이없이 시간만 낭비한다.

- 문장 개수는 '.'과 '!'을 기준으로 텍스트를 split해서 리스트로 만들고 길이를 구했다.
- 단어 개수는 단어가 아닌 것들을 기준으로 텍스트를 split했고, 반복문을 돌려서 빈 문자열이 원소로 들어가있으면 다 빼줬다.
- 음절 수 구하는 것은 단어 리스트에서 단어를 반복하고, 단어를 글자단위로 반복시켜서 모음인지 확인했다. 이전 글자를 temp로 저장해서 모음이 연속되는지 확인하면서 음절 수를 +1 시켰다.

```python
import re
findall = re.findall
def cal(wps, spw):
    return round(0.39 * wps + 11.8 * spw - 15.59, 2)

def flesch_kincaid(text):
    num_sen = len(re.split('[\.!] ', text)) # list of sentences
    words = []
    for word in re.split('\W+', text):
        if word != "": words.append(word)
    wps = len(words) / float(num_sen) # average number of words per sentence 
    
    num_syl = 0
    for word in words:
        temp = ''
        for c in word:
            if c in 'aeiouAEIOU' and not temp:
                num_syl += 1
                temp = c
            elif c in 'aeiouAEIOU':
                continue
            else:
                temp = ''
    spw = num_syl / float(len(words)) # average number of syllables per word
    return cal(wps, spw)
```

## 2. 다른 해답

이 사람도 역시 findall이랑 '?' 때문에 주석을 달아놨다.

- 단어를 ' ' 공백을 세서 +1 해줬다. 단어 세는 엄청나게 똑똑한 방법.
- `SYLLABLE = reCompile(r'(?i)[aeiou]+')` 이런 형태로 정규표현식 객체를 만들면 만약 'ii' 이렇게 붙어있으면 'ii' 통째로 찾아서 리스트에 원소로 넣는다. 멋진 방법이다.
- 정말 단순하게 잘 풀었다. 정규표현식의 강점을 또 다시 한 번 느끼는 순간.

```python
from re import findall # I don't need it, but there's a bug in the tests

from re import compile as reCompile

SENTENCE = reCompile(r'[.!]') # Should also include ?, but there's a bug in the tests
SYLLABLE = reCompile(r'(?i)[aeiou]+')

def count(string, pattern):
    return len(pattern.findall(string))

def flesch_kincaid(text):
    nWords = text.count(' ') + 1
    return round(0.39 * nWords / count(text, SENTENCE) + 11.8 * count(text, SYLLABLE) / nWords - 15.59, 2)
```
