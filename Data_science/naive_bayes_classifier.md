# Naive Bayes Classifier

베이즈 정리를 활용한 분류 기법. [elice.io](https://www.elice.io/) 참고

## 1. 조건부 확률

### 1.1 개념

![conditional_probability](http://sites.nicholas.duke.edu/statsreview/files/2013/06/jointmargcond.jpg)

![conditional_probability2](http://i.imgur.com/YbmJvZI.jpg)

- '65세 일반인이 암을 가지고 있을 확률'에 대한 간단한 예제
- `A`: 암에 걸리는 사건. 전체 인구 중 1%가 암환자라면 => `P(A) = 0.01`
- `B`: 검사자가 65세인 사건. 전체 인구 중 0.2%가 65세라면 => `P(B) = 0.002`
- `P(B|A)`: 전체 암환자 중 65세의 비율. => `P(B|A) = 0.005`
- `P(A|B)`: 주로 위 세 조건이 주어진 다음 구한다. 65세가 암에 걸릴 확률이다. `P(A|B) = 0.025`

### 1.2 예제 코드

유방암으로 진단될 확률(A)과 유방암일 확률(B)에 대한 파이썬 예제 코드.

```py
def main():
    sensitivity = float(input())
    prior_prob = float(input())
    false_alarm = float(input())

    print("%.2lf%%" % (100 * mammogram_test(sensitivity, prior_prob, false_alarm)))

def mammogram_test(sensitivity, prior_prob, false_alarm):
    p_a1_b1 = sensitivity # p(A = 1 | B = 1)
    p_b1 = prior_prob # p(B = 1)
    p_b0 = 1.0 - p_b1 # p(B = 0)
    p_a1_b0 = false_alarm # p(A = 1|B = 0)
    p_a1 = false_alarm*p_b0 + sensitivity*p_b1 # p(A = 1)
    p_y1_x1 = sensitivity*prior_prob/p_a1 # p(B = 1|A = 1)
    return p_y1_x1

if __name__ == "__main__":
    main()
```

- `P(A)` : 양성으로 진단될 확률
- `P(B)`: 총 인구를 기준으로 유방암을 가지고 있을 사전확률(prior probability).
- `P(A=1|B=1)`: 검사의 민감성(sensitivity). 유방암을 가지고 있을 때 검사 결과가 양성일 확률. 예를 들어 0.8이라면 유방암을 가지고 있을때 80%의 확률로 검사 결과가 양성이 나온단 의미다.
- `P(A=1|B=0)`: 실제로 병을 가지고 있지 않은데도 유방암이라고 진단될 확률. False alarm이라고 부른다.

## 2. Bag of Words

### 2.1 기본 개념

기계학습을 이용한 자연어 처리 모델 중 하나다. 문장을 단어로 쪼개고 어떤 단어가 있고, 그 단어가 몇 개씩 있는지 표현한다.

```py
'''
John likes to watch movies. Mary likes movies too.
John also likes to watch football games.
'''

bow_dict = { "John": 0, "likes": 1, "to": 2, "watch": 3,
            "movies": 4, "also": 5, "football": 6,
            "games": 7, "Mary": 8, "too": 9
            }

# Index: 0  1  2  3  4  5  6  7  8  9
bow1 =  [1, 2, 1, 1, 2, 0, 0, 0, 1, 1]
bow2 =  [1, 1, 1, 1, 0, 1, 1, 1, 0, 0]
```

- `bow_dict`: Bag of Words 모델에서 dict 자료형으로 표현. unique한 단어들만 뽑아서 각각에 index를 기록.
- `bow1`, `bow2`: 각 문장에 포함된 단어를 bow_dict와 비교해서 개수를 기록해놓은 벡터다. 단어 종류가 10개라서 10차원 벡터.

### 2.2 예제 코드

```py
import re

def main():
    sentence = input()
    BOW_dict, BOW = create_BOW(sentence)

    print(BOW_dict)
    print(BOW)

def create_BOW(sentence):
    bow_dict = {}
    bow = []
    
    sentence = replace_non_alphabetic_chars_to_space(sentence.lower())
    for word in sentence.split():
        if word in bow_dict:
            bow[bow_dict[word]] += 1
        else:
            bow_dict[word] = len(bow)
            bow.append(1)

    return bow_dict, bow

def replace_non_alphabetic_chars_to_space(sentence):
    return re.sub(r'[^a-z]+', ' ', sentence)

if __name__ == "__main__":
    main()
```

- 전처리: 소문자화하고, 알파벳이 아닌것은 공백으로 치환
- bow_dict: 단어가 최소 1글자 이상이고, 새로운 단어일 경우에만 추가해나간다. cnt로 개수 세어나가면서 value로 넣어줌.
- bow_dict의 key가 단어이므로 개수를 세어서 bow에 넣어준다.

## 3. Naive Bayes 기초

### 3.1 Likelihood

가능도 혹은 우도. 확률 분포의 parameter(모수)가 관찰된 sample(표집값)과 일치하는 정도를 나타내는 parameter에 대한 함수. 동전 던지기의 예에서 앞면이 나올 확률이 0.6이고, 10번 던져서 10번 다 앞이 나왔다고 할 때 likelihood는 0.6을 10 제곱한 값이 된다.

동전을 10번 던져서 앞면이 8번 뒷면이 2번 나온 실험을 진행했다고 하자. 여기서 동전이 2개 있는데 동전A는 앞면이 나올 확률이 0.7이고, 동전B는 0.4다. 이 때 likelihood를 구해보면 A는 0.005188이고 B는 0.000236이다. 확률적으로 동전 A가 B보다 실험을 더 잘 설명한다고 말할 수 있다.

### 3.2 Laplace smoothing

additive smoothing이라고도 불린다. 이 기법은 일어나지 않은 사건의 확률이 0이 안되게 하는 것. 0은 너무 강력하기 때문에 확률을 부드럽게 만들어준다. 예를 들어 어떤 사건이 이번에만 한 번도 일어나지 않을 수 있다. 100번 중 1번 정도 확률로 일어날 수 있는데 어쩌다 한 번도 사건이 일어나지 않았다고 확률을 0으로 줘버리면 너무 오차가 커진다. 그래서 0이 아니라 0.1, 0.01 등의 확률을 준다.

![laplace](https://upload.wikimedia.org/math/8/b/6/8b60634f0b70678e411441e64a95109e.png)

빨강, 파랑, 초록 공을 임의로 반환하는 기계가 있다고 할 때

- `theta i`: i일 경우의 확률. i는 red, blue, green 중 하나가 된다.
- `xi`: i(색깔)인 공의 개수
- `N`: 관측한 총 공의 개수
- `d`: i(색깔) 종류 수
- `alpha`: laplace smoothing 값. 값이 작을수록 0이었던 사건의 확률을 작게 친다.

만약 10개를 뽑으며 빨강이 6개, 파랑이 4개일 때 Laplace smoothing을 적용하지 않았다면 확률은 `0.6`, `0.4`, `0`이겠지만 적용한다면 위 공식에 따라 `0.5922`, `0.3981`, `0.0097`이 된다.

### 3.3 예제 코드

- `calculate_doc_prob` 함수만 보면 된다.
- 로그를 썼을 뿐 laplace smoothing 공식을 그대로 적용한 예제다.
- 트레이닝 문장으로 테스트 문장을 만드는 likelihood를 구한 것.

```py
import re
import math

def main():
    training_sentence = input()
    training_model = create_BOW(training_sentence)

    testing_sentence = input()
    testing_model = create_BOW(testing_sentence)

    alpha = float(input())

    print(calculate_doc_prob(training_model, testing_model, alpha))

def calculate_doc_prob(training_model, testing_model, alpha):
    train_dict = training_model[0]
    train_bow = training_model[1]
    test_dict = testing_model[0]
    test_bow = testing_model[1]
    
    N = sum(train_bow)
    d = len(train_dict)
    
    logprob = 0
    for word in test_dict:
        train_x_num = train_bow[train_dict[word]] if word in train_dict else 0
        test_x_num = test_bow[test_dict[word]]
        logprob += test_x_num * math.log((train_x_num + alpha) / (N + alpha*d))

    return logprob

def create_BOW(sentence):
    bow_dict = {}
    bow = []
    
    sentence = replace_non_alphabetic_chars_to_space(sentence.lower())
    for word in sentence.split():
        if len(word) < 1: continue
        if word in bow_dict:
            bow[bow_dict[word]] += 1
        else:
            bow_dict[word] = len(bow)
            bow.append(1)

    return bow_dict, bow

def replace_non_alphabetic_chars_to_space(sentence):
    return re.sub(r'[^a-z]+', ' ', sentence)

if __name__ == "__main__":
    main()
```

## 4. Naive Bayes Classifier

3과 다른건 없다. 트레이닝 문장을 2개 넣었고 테스트 문장이 어디에 속할지 확률을 정규화해서 계산하는 코드

```py
import re
import math

def main():
    training1_sentence = input()
    training2_sentence = input()
    testing_sentence = input()

    alpha = float(input())
    prob1 = float(input())
    prob2 = float(input())

    print(naive_bayes(training1_sentence, training2_sentence, testing_sentence, alpha, prob1, prob2))


def naive_bayes(tr1, tr2, test, alpha, p1, p2):
    classify1 = math.log(p1) + calculate_doc_prob(create_BOW(tr1), create_BOW(test), alpha)
    classify2 = math.log(p2) + calculate_doc_prob(create_BOW(tr2), create_BOW(test), alpha)
    
    return normalize_log_prob(classify1, classify2)


def normalize_log_prob(prob1, prob2):
    maxprob = max(prob1, prob2)

    prob1 -= maxprob
    prob2 -= maxprob
    prob1 = math.exp(prob1)
    prob2 = math.exp(prob2)

    normalize_constant = 1.0 / float(prob1 + prob2)
    prob1 *= normalize_constant
    prob2 *= normalize_constant

    return (prob1, prob2)

def calculate_doc_prob(training_model, testing_model, alpha):
    train_dict = training_model[0]
    train_bow = training_model[1]
    test_dict = testing_model[0]
    test_bow = testing_model[1]
    
    N = sum(train_bow)
    d = len(train_dict)
    
    logprob = 0
    for word in test_dict:
        train_x_num = train_bow[train_dict[word]] if word in train_dict else 0
        test_x_num = test_bow[test_dict[word]]
        logprob += test_x_num * math.log((train_x_num + alpha) / (N + alpha*d))

    return logprob

def create_BOW(sentence):
    bow_dict = {}
    bow = []
    
    sentence = replace_non_alphabetic_chars_to_space(sentence.lower())
    for word in sentence.split():
        if len(word) < 1: continue
        if word in bow_dict:
            bow[bow_dict[word]] += 1
        else:
            bow_dict[word] = len(bow)
            bow.append(1)

    return bow_dict, bow

def replace_non_alphabetic_chars_to_space(sentence):
    return re.sub(r'[^a-z]+', ' ', sentence)

if __name__ == "__main__":
    main()
```

## 5. Sentiment Classification using Naive Bayes

긍정, 부정 정서를 분류하는 것을 Sentiment Classification이라고 한다. 다양한 감정(분노, 기쁨, 두려움 등) 분류는 emotion analysis라고 함.

아래 예제 코드에서 긍정, 부정 트레이닝 데이터는 다음 [논문](http://www.cs.cornell.edu/home/llee/papers/sentiment.home.html)의 것을 사용한다. IMDB의 영화 리뷰 중 긍정적 리뷰 1000개와 부정적 리뷰 1000개를 모은 것이다. 테스트 데이터는 트립어드바이저의 리뷰로 했고 아래 코드에선 인사동의 리뷰들을 분석했다. 결과는 리뷰가 원래 그렇듯 매우 긍정(likelihood 90% 이상)과 매우 부정(5% 이하)이 대부분이었다.

```py
import re
import os
import math
import csv
import json

def main():
    tr1sen = read_text_data('./txt_sentoken/pos/')
    tr2sen = read_text_data('./txt_sentoken/neg/')

    a, p1, p2 = 0.1, 0.5, 0.5

    prob_list = []
    with open('./review/total_insadong.csv') as csvfile:
        spamreader = csv.reader(csvfile)
        for row in spamreader:
            if row[0] == '': continue
            print(row[0])
            prob_list.append({'id':int(row[0]), 'pos_prob':naive_bayes(tr1sen, tr2sen, row[2], a, p1, p2)[0]})

    with open('./pos_insadong.json', 'w', encoding='utf-8') as f:
        f.write(json.dumps(prob_list, ensure_ascii=False))

def naive_bayes(tr1sen, tr2sen, testsen, a, p1, p2):

    [test_dict, test_bow] = create_BOW(testsen)

    classify1 = math.log(p1) + calculate_doc_prob(create_BOW(tr1sen), create_BOW(testsen), a)
    classify2 = math.log(p2) + calculate_doc_prob(create_BOW(tr2sen), create_BOW(testsen), a)

    return normalize_log_prob(classify1, classify2)

def read_text_data(directory):
    files = os.listdir(directory)
    files = [f for f in files if f.endswith('.txt')]

    all_text = ''
    for f in files:
        all_text += ' '.join(open(directory + f).readlines()) + ' '

    return all_text

def normalize_log_prob(prob1, prob2):
    maxprob = max(prob1, prob2)

    prob1 -= maxprob
    prob2 -= maxprob
    prob1 = math.exp(prob1)
    prob2 = math.exp(prob2)

    normalize_constant = 1.0 / float(prob1 + prob2)
    prob1 *= normalize_constant
    prob2 *= normalize_constant

    return (prob1, prob2)

def calculate_doc_prob(training_model, testing_model, alpha):
    train_dict = training_model[0]
    train_bow = training_model[1]
    test_dict = testing_model[0]
    test_bow = testing_model[1]
    
    N = sum(train_bow)
    d = len(train_dict)
    
    logprob = 0
    for word in test_dict:
        train_x_num = train_bow[train_dict[word]] if word in train_dict else 0
        test_x_num = test_bow[test_dict[word]]
        logprob += test_x_num * math.log((train_x_num + alpha) / (N + alpha*d))

    return logprob

def create_BOW(sentence):
    bow_dict = {}
    bow = []
    
    sentence = replace_non_alphabetic_chars_to_space(sentence.lower())
    for word in sentence.split():
        if len(word) < 1: continue
        if word in bow_dict:
            bow[bow_dict[word]] += 1
        else:
            bow_dict[word] = len(bow)
            bow.append(1)

    return bow_dict, bow

def replace_non_alphabetic_chars_to_space(sentence):
    return re.sub(r'[^a-z]+', ' ', sentence)

if __name__ == "__main__":
    main()
```
