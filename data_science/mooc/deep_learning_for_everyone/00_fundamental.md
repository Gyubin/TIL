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

## 2. 학습 오차 줄이기

### 2.1 Learning rate

- 너무 클 때: overshooting 문제 발생. learning rate이 너무 커서 최저점을 못 찾는 문제. 반복하다가 그래프의 범위를 넘어갈 수도 있음
- 너무 작을 때: 시간이 오래 걸리고 local minimum에서 멈춤. cost를 살펴보고 너무 작은 값으로 변화하면 learning rate을 올려보자.
- rate 설정에 답은 없다. 0.01부터 많이 시작하고 cost를 기반으로 계속해서 바꿔보는게 답

### 2.2 데이터 전처리

- x1, x2 데이터가 있을 때 크기 차이가 심한 경우가 있다. x1은 0~1 사이고, x2는 -5000~10000 사이의 값. 이럴 때 w1, w2, cost 그래프는 한 쪽으로 과하게 찌그러진 원이 된다.
- Gradient descent를 사용할 때 learning rate을 잘 설정해도 쉽게 그래프 밖으로 튀어나가는 문제가 발생
- 그래서 데이터 전처리가 필요하다.

![Imgur](http://i.imgur.com/oKfn7xu.png)

- zero-centered data: 0을 중심으로 재패치
- normalized data: 어떤 범위 안에 항상 들어가도록 아래 수식은 normalization 중에서도 가장 많이 사용되는 방식이다.
    + ![Imgur](http://i.imgur.com/hb7Q5pX.png)
    + 데이터에 평균을 빼고 분산으로 나오면 된다.
    + 파이썬 코드: `x_std[:, 0] = (x[:, 0] - x[:, 0].mean()) / x[:, 0].std()`

### 2.3 Overfitting

- 모델이 학습 데이터에 너무 딱 잘 맞아서 다른 테스트 데이터와는 안 맞는 문제 
- 피하는 방법
    + 데이터가 많으면 됨
    + feature의 개수를 줄이기(중복된거 없애는 등)
    + Regularization(일반화) 시키기

![Imgur](http://i.imgur.com/eJAPwWc.png)

- overfitting이란 것은 특정한 데이터에 맞게 그래프를 구부리는 것을 의미
- 구부리지 말고 펴는 것이 Regularization이고 weight의 값을 낮추면 된다.
- cost 함수 뒤에 `모든 w의 값의 합에 특정 상수를 곱한 값`을 추가해준다. 즉 전체적으로 w 값을 낮게 유지하겠다라는 의미한다.
- 뒤에 붙는 상수를 `λ`, regularization strength라고 하고 일반화를 얼마나 중요하게 여기느냐에 따라 수치를 변경한다.
- `l2reg = 0.001 * tf.reduce_sum(tf.square(W))`

### 2.4 Test, Training set

- test, train으로 분할: 학습을 할 때 전체 데이터로 학습을 하지 않는다. 데이터 셋에서 30% 정도를 Test dataset으로 만들고 나머지 70%를 Training dataset으로 학습을 한다. 학습에 test 데이터셋은 쓰지 않고, 학습이 잘 되었는지 확인할 때 사용한다.
- Training dataset을 train, validation으로 분할: training의 training 데이터셋은 완벽하게 학습할 때만 쓰고, training의 validation 셋은 learning rate이나 lambda(regularization strength)의 값을 정할 때 사용한다. 즉 train할 때 알파와 람다를 바꿔가면서 validation으로 테스트해보고 최종 결정한 다음 test data로 모델을 검증하는 것
- Online learning: 트레이닝 셋이 엄청 대용량일 때 한 번에 모든 데이터를 학습하는게 아니라 10개로 나눠서 순차적으로 학습하는 것. 이게 가능하려면 이전 부분의 데이터를 학습한 결과가 계속 모델에 남아있어야한다.
