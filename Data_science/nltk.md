# NLTK

자연어 처리 라이브러리 사용 방법.

## 0. 설치

라이브러리를 설치하는 것 뿐만 아니라 텍스트 데이터도 같이 받아야 한다.

```sh
# 터미널에서
pip install nltk
```

```py
# 파이썬 REPL에서 실행. 다운로드 디렉토리는 HOME으로 했다.
import nltk
nltk.download()
```

## 1. Lemmatize, POS tagging

### 1.1 POS tagging

- 단어를 형용사인지, 명사인지 등으로 분류해서 해당 형태소 태그를 매기는 함수다. lemmatize 함수를 실행할 때 형태소를 지정해줘야 하기 때문에 사전 POS tagging이 필수다.
- `nltk.word_tokenize`: 문자열을 입력받아서 공백 기준으로 쪼개서 토큰으로 만든다.
- `nltk.pos_tag(tokenized_list)`: 리스트를 매개변수로 받아서 원소 하나 하나에 태그를 매긴다. 단어와 태그를 튜플로 해서 이들이 여럿 모인 리스트를 리턴한다. 주요 분류는 다음과 같다
    + 명사: ['NN', 'NNS', 'NNP', 'NNPS']
    + 동사: ['VB', 'VBD', 'VBG', 'VBN', 'VBP', 'VBZ']
    + 부사: ['RB', 'RBR', 'RBS']
    + 형용사: ['JJ', 'JJR', 'JJS']

```py
text = nltk.word_tokenize(my_string)
nltk.pos_tag(text)
```

### 1.2 Lemmatize

- lemmatize는 '분류, 정리하다'라는 의미이다. `[run, ran, running]`을 `run`으로 바꿔서 복잡성을 낮춘다. 대량으로 텍스트를 분석할 때 처리시간을 줄일 뿐만 아니라 정확도도 높일 수 있다.
- `from nltk.stem.wordnet import WordNetLemmatizer` : import할 것
- `wnl = WordNetLemmatizer()`: lemmatize를 실행할 변수다.
- `wnl.lemmatize(word, 'n')` : 함수를 실행할 때 첫 번째 매개변수로 문자열 단어가 들어가고, 두 번째로 형태소 태그가 들어간다. 형태소 태그를 넣지 않으면 기본값으로 'n'이 들어간다. 형태소 태그는 다음 네가지만 들어갈 수 있다.
    +  'n', wordnet.NOUN
    +  'r', wordnet.ADV
    +  'v', wordnet.VERB
    +  'a', wordnet.ADJ

### 1.3 예제 코드

```py
import csv
import nltk
from nltk.stem.wordnet import WordNetLemmatizer
from nltk.corpus import wordnet

def main():
    wnl = WordNetLemmatizer()
    with open('./lemmatized_text/lemmatized_bukchon.txt', 'w', encoding='utf-8') as f:
        with open('./reviews/total_bukchon.csv') as csvfile:
            spamreader = csv.reader(csvfile)
            for row in spamreader:
                if row[0] == '': continue
                tmp = ''
                text = nltk.word_tokenize(row[2])
                for tag in nltk.pos_tag(text):
                    lem = penn_to_wn(tag[1])
                    if lem:
                        tmp = tmp + ' ' + wnl.lemmatize(tag[0], lem)
                tmp += '\n'
                f.write(tmp.lower())

def is_noun(tag):
    return tag in ['NN', 'NNS', 'NNP', 'NNPS']

def is_verb(tag):
    return tag in ['VB', 'VBD', 'VBG', 'VBN', 'VBP', 'VBZ']

def is_adverb(tag):
    return tag in ['RB', 'RBR', 'RBS']

def is_adjective(tag):
    return tag in ['JJ', 'JJR', 'JJS']

def penn_to_wn(tag):
    if is_adjective(tag):
        return wordnet.ADJ
    elif is_noun(tag):
        return wordnet.NOUN
    elif is_adverb(tag):
        return wordnet.ADV
    elif is_verb(tag):
        return wordnet.VERB
    return None

if __name__ == "__main__":
    main()
```
