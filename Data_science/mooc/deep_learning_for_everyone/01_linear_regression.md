# Linear regression

## 1. 개념

| x | y |
|---|---|
| 1 | 1 |
| 2 | 2 |
| 3 | 3 |

- `H(x) = Wx + b` : W는 Weight, b는 bias의 첫 글자
- 위의 간단한 예처럼 선형으로 x, y 관계가 설명될 것이다라고 hypothesis를 세우고 예측하는 것.
- 선을 잘 찾는 것이 학습을 통해 이루어진다.
- Cost function(Loss function)
    + 어떤 선이, 즉 어떤 hypothesis가 가장 좋은 것일까. 선과 각 데이터의 점들 간의 거리의 합이 가장 작은 것이 좋은 가설이다. 이 거리를 계산하는 공식이 cost function이다.
    + `(H(x) - y)^2` 공식을 각 데이터(x)마다 계산해서 더하고, 데이터 개수로 나눈다.
    + `minimize cost(W, b)`: cost를 최소화하는 W와 b를 구하는 것이 목표다.
- Cost를 최소화하는 지점 찾기: Cost function에 대해서 각각의 W, b에 따른 값을 점으로 나타내어본다. 그리고 그 값이 가장 작은 지점을 찾으면 되는데 사람이 눈으로 그래프를 보면 가장 작은 지점이 바로 눈에 보일테지만 기계적으로 찾아야하는게 문제

## 2. Gradient descent algoritm

- cost function의 최소값을 찾는 알고리즘
- minimizing 케이스에서 가장 자주 사용된다. 어느 임의의 점에서 시작해서 W와 b를 조금씩 바꿔서 변하는 값을 관찰하는 것. W와 b가 거의 변화가 없을 때(converge)까지 반복한다.
- global minimum, local minimum
    + 최소값을 찾는 대상이 convex 함수가 아닐 경우 기울기가 0이 되는 지점이 여럿 존재할 수 있다. 시작하는 지점에 따라 어떤 기울기 0 지점에 알고리즘이 멈출지 알 수 없다.
    + 가장 작은 지점을 global minimum이라 하고 다른 움푹한 지점을 local minimum이라 한다.
- 원리
    + ![Imgur](http://i.imgur.com/SdupTWu.png)
    + ![Imgur](http://i.imgur.com/bqM1oIL.png)
    + cost function이 있는데 `1/m` 했던 것을 편의를 위해 `1/2m`으로 바꾼다. 최소값을 구하는 것이기 때문에 상관 없다.
    + `W := W - α*(cost function의 미분값)` : W를 조금씩 바꿀텐데 cost function을 미분한 값에 learning rate(α)를 곱한 값을 빼준다.
    + 즉 위 이미지의 파란색 그래프에서 왼쪽 점은 미분한 값, 즉 기울기가 음수이므로 W 값을 조금씩 + 한다는 것이고, 우측 점은 기울기가 양수이므로 W값을 점점 줄인다는 것을 의미한다.
    + 마지막 공식이 핵심이다.
- Convex function: 아래로 움푹한 것. 이 때는 minimum cost가 하나만 나온다. 그래서 linear regression을 적용하기 전에 Convex인지를 반드시 확인해야한다.
    + ![Imgur](http://i.imgur.com/LfQBx6l.png)

## 3. Single, Multi variable, Polynomial regression

| x1(hours) | x2(attendance) | score |
|-----------|----------------|-------|
|        10 |              5 |    90 |
|         9 |              5 |    80 |
|         3 |              2 |    50 |
|         2 |              4 |    60 |
|        11 |              1 |    40 |

- hypothesis가
    + `Wx + b` 형태로 x가 하나이면 single
    + `W1X1 + W2X2 + b` 등의 형태로 x의 종류(feature)가 늘어나게 되면 multi variable regression
    + `W1X^2 + W2X + b` 형태로 같은 feature인데 차수가 다양하게 존재하는 경우를 polynomial regression이라고 한다.
- variable은 feature라고도 하고, 실제 분석에선 수만개의 feature가 쓰이기 때문에 좋은 feature를 선택하는 것이 중요하다.
- hypothesis는 w, x만 개수에 맞게 추가하면 되므로 거의 똑같고 cost function은 그대로 쓰면 된다. 다만 샘플의 수(n)가 너무 커지게 되면 작성에 어려움이 있으므로 Matrix를 사용한다.
- 수식 고도화 과정
    + `H(X) = WX + b`를 풀어쓰면 `[w1 w2 w3] * [x1 x2 x3] = [w1*x1 + w2*x2 + w3*x3]`이 된다. 글 쓸 때 표현이 어려워서 위처럼 썼지만 w는 1 by n이고 x는 n by 1이다.
    + `H(X) = WX` 형태로 b까지 없앨 수 있다. 맨 앞에 상수 b와 1을 각각 추가해주면 계산식은 똑같게 된다. `[b w1 w2 w3] x [1 x1 x2 x3] = [b*1 + w1*x1 + w2*x2 + w3*x3]`
    + 마지막으로 W와 X가 서로 차원이 다르기 떄문에 표현의 편리를 위해 둘다 n by 1로 맞춰준다. 그래서 계산식은 행렬의 곱셈의 조건을 맞춰주기 위해 W를 transpose하는 것으로 바꿔준다. `H(X) = WT X` 즉 W를 transpose해서 쓰는 것임.
