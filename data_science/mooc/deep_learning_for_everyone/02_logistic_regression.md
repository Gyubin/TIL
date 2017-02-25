# Logistic Regression

## 1. 기본 개념

### 1.1 Linear의 문제점

![Imgur](http://i.imgur.com/69A9Wcl.png)

- Logistic regression이 필요한 이유는 Linear regression으로 풀기 애매한 케이스들이 있기 때문이다. 아래 두 문제는 binary classification의 경우다.
- 문제로 가기 전에 binary case에선 0, 1로 구분하는데 판별해야할 중요한 사항을 1로 둔다: 스팸이냐? 1, 페이스북 피드에서 보여줄거냐? 1, 결제 내역에서 불법적인 결제냐? 1
- 첫 번째 문제: 위 그래프는 공부 시간에 따른 pass, fail 그래프이다.
    + 초기 데이터에는 0-5시간 공부하면 fail, 5-10시간 공부하면 pass인 데이터들만 있었다.
    + 이 때 pass, fail을 판단하는 기준은 `H(x)`의 값이 특정 값, 즉 0.5를 넘느냐 넘지 않느냐로 결과를 예측할 수 있다.
    + 하지만 50시간 공부하고 pass한 데이터가 생긴다면 이에 맞춰 그래프를 다시 그려야할 것이다. `H(x)`의 기울기는 좀 더 수평에 가깝게 작아질 것이고 아까 설정했던 0.5라는 기준은 더이상 맞지 않게 된다.
    + 매 번 데이터가 들어올 때마다 기준을 재설정해줘야 한다.
- 두 번째 문제
    + 비교할 값, 즉 진짜 결과치인 Y는 0 또는 1이다.
    + 하지만 `H(x) = W*x + b` 이 식에서 값은 Y의 값과는 매우 다른 값이 나올 수 있다. 0보다 훨씬 작거나 1보다 훨씬 클 수 있다.
    + 수치나, 그래프나 알아보기 쉬운 결과를 도출하기가 힘들다.

### 1.2 Logistic regression 방법

![Imgur](http://i.imgur.com/1teYL9K.png)

- 위에서 언급한 문제들로 인해 `H(x) = W*x + b`의 값을 0과 1 사이로 압축해서 표현하기로 했다.
- 기존 `W*x + b` 식을 `z`라고 두고 어떤 g 함수에 대입한 것을 새로운 Hypothesis라고 한다. `H(x) = g(z)`
- `g(x) = 1 / 1 + e^(-z)`: sigmoid function 또는 logistic function이라고 불리는 함수를 g 함수로 사용한다. S자 모양의 그래프가 나오고 x축은 z, y축은 g(z)가 된다.
- 결국 `H(X) = g(W*X)` 꼴이고 Logistic Hypothesis는 `H(X) = 1 / 1 + e^(-WT*X)` 형태가 된다.

## 2. Cost function

## 3. Gradient descent
