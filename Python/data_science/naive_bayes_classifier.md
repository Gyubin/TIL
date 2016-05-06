# Naive Bayes Classifier

베이즈 정리를 활용한 분류 기법

## 1. 조건부 확률

### 1.1 개념

![conditional_probability](http://sites.nicholas.duke.edu/statsreview/files/2013/06/jointmargcond.jpg)

![conditional_probability2](http://i.imgur.com/YbmJvZI.jpg)

- `A`: 암에 걸리는 사건. 전체 인구 중 1%가 암환자라면 => `P(A) = 0.01`
- `B`: 검사자가 65세인 사건. 전체 인구 중 0.2%가 65세라면 => `P(B) = 0.002`
- `P(B|A)`: 전체 암환자 중 65세의 비율. => `P(B|A) = 0.005`
- `P(A|B)`: 주로 위 세 조건이 주어진 다음 구한다. 65세가 암에 걸릴 확률이다. `P(A|B) = 0.025`

### 1.2 예제 코드

'65세 일반인이 암을 가지고 있을 확률'에 대한 파이썬 코드다.

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

- `P(A=1|B=1)`: 검사의 민감성(sensitivity). 유방암을 가지고 있을 때 검사 결과가 양성일 확률. 예를 들어 0.8이라면 유방암을 가지고 있을때 80%의 확률로 검사 결과가 양성이 나온단 의미다.
- `P(B)`: 총 인구를 기준으로 유방암을 가지고 있을 사전확률(prior probability).
- `P(A)` : 양성으로 진단될 확률
- `P(A=1|B=0)`: 실제로 병을 가지고 있지 않은데도 유방암이라고 진단될 확률. False alarm이라고 부른다.
