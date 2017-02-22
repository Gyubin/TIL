# 모두의 딥러닝

## 1. 기본 개념

- 프로그래밍 방식
    + explicit programming: 프로그래머가 모든걸 다 하는 것. 모든걸 조절하고 통제한다. 하지만 rule이 너무 많은 경우엔 불가능한 방법이다. spam filter나 자율주행차는 너무 rule이 많아서 이 방법으로 하기는 불가능하다.
    + machine learning: Arthur Samuel(1959)이 처음 제창. 프로그램 자체가 학습하는 능력을 갖는 것
- 학습 종류
    + supervised learning : lable이 있는 데이터.
        * Regression: 이전 시험 성적과 공부 시간을 기반으로 성적 예측
        * Binary classification: 일반/스팸으로 구분되어있는 메일 데이터를 학습하고 프로그램이 분류
        * Multi-label classification: 태그가 있는 이미지를 학습해서 프로그램이 직접 이미지를 분류
    + unsupervised learning: unlabled data, 즉 분류돼있지 않은 데이터를 프로그램이 직접 비슷한것끼리 뭉친다. 지금은 서비스를 안하지만 Google news의 grouping 기능이 대표적이다. word clustering 방식 사용
- 예시
    + regression: x(hours), y(score) 데이터셋이 있다. 10시간 투자하니 90점, 9시간 투자하니 80점, 3-50, 2-30이다. 이 때 7시간 투자했을 때 나올 점수를 예측하는 것이 regression이다.
    + binary: 10시간, 9시간은 통과, 3시간, 2시간은 탈락이라는 데이터가 있을 때 점수를 가지고 통과, 탈락을 추정하는 것
    + multi-label: 9-10시간은 A, 5-8은 B, 3-4는 C, 0-2는 D라는 데이터셋이 있을 때 시간을 가지고 추정하는 것.

## 2. Regression

### 2.1 Linear Regression

| x | y |
|---|---|
| 1 | 1 |
| 2 | 2 |
| 3 | 3 |

- `H(x) = Wx + b`
- 위의 간단한 예처럼 선형으로 x, y 관계가 설명될 것이다라고 hypothesis를 세우고 예측하는 것.
- 선을 잘 찾는 것이 학습을 통해 이루어진다.
- Cost function(Loss function)
    + 어떤 선이, 즉 어떤 hypothesis가 가장 좋은 것일까. 선과 각 데이터의 점들 간의 거리의 합이 가장 작은 것이 좋은 가설이다. 이 거리를 계산하는 공식이 cost function이다.
    + `(H(x) - y)^2` 공식을 각 데이터(x)마다 계산해서 더하고, 데이터 개수로 나눈다.
    + `minimize cost(W, b)`: cost를 최소화하는 W와 b를 구하는 것이 목표다.
- Cost를 최소화하는 지점 찾기: Cost function에 대해서 각각의 W, b에 따른 값을 점으로 나타내어본다. 그리고 그 값이 가장 작은 지점을 찾으면 되는데 사람이 눈으로 그래프를 보면 가장 작은 지점이 바로 눈에 보일테지만 기계적으로 찾아야하는게 문제
- `Gradient descent algoritm`
    + minimizing 케이스에서 가장 자주 사용된다. 어느 임의의 점에서 시작해서 W와 b를 조금씩 바꿔서 변하는 값을 관찰하는 것. 이를 계속 반복한다.
    + 더이상 cost가 줄어들지 않는 지점까지 가는데 이 지점을 `local minimum`이라 한다. local이 붙는 이유는 이 minimum이 단 하나 존재하는 최소 지점이 아닐 수 있기 때문이다. 어디서 시작하느냐에 따라 다른 local minimum에 도달할 수 있다.
- - `Gradient descent algoritm` 원리
    + ![Imgur](http://i.imgur.com/SdupTWu.png)
    + ![Imgur](http://i.imgur.com/bqM1oIL.png)
    + cost function이 있는데 `1/m` 했던 것을 편의를 위해 `1/2m`으로 바꾼다. 최소값을 구하는 것이기 때문에 상관 없다.
    + `W := W - α*(cost function의 미분값)` : W를 조금씩 바꿀텐데 cost function을 미분한 값에 learning rate(α)를 곱한 값을 빼준다.
    + 즉 위 이미지의 파란색 그래프에서 왼쪽 점은 미분한 값, 즉 기울기가 음수이므로 W 값을 조금씩 + 한다는 것이고, 우측 점은 기울기가 양수이므로 W값을 점점 줄인다는 것을 의미한다.
    + 마지막 공식이 핵심이다.
- Convex function: 아래로 움푹한 것. 이 때는 minimum cost가 하나만 나온다. 그래서 linear regression을 적용하기 전에 Convex인지를 반드시 확인해야한다.
    + ![Imgur](http://i.imgur.com/LfQBx6l.png)
