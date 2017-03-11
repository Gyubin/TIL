# Deep learning fundamental

## 1. 역사

### 1.1 초기 시도

- 뉴런 동작 원리(매우 단순)
    + 어떤 데이터가 뉴런으로 들어오면 그 각각의 데이터는 `w*x + b`라고 할 수 있다.
    + 모든 데이터에 대해서 계산하고 합한 후에
    + 특정 임계점을 넘으면 다음 뉴런으로 넘어가는 것이 활성화되고, 아니면 활성화되지 않는다.
- 이 뉴런 동작 원리를 이용해서 만든 것이 **Activation Function**이다.
    + 신호가 들어오면(`x0`), `w0`과 곱해지고
    + 모두 합해져서, `f`(activation function)으로 들어가고 특정 값을 넘으면 다음 것으로 넘어가고 아니면 멈춘다.
    + ![Imgur](http://i.imgur.com/0DcB0BQ.jpg)
- 위의 연산, 즉 logistic regression을 여러 개 뭉치면 신경망이라 볼 수 있다.
    + ![Imgur](http://i.imgur.com/ikExeEr.jpg)
- 위의 신경망을 구현하기 위해 기본적인 판단을 하는 유닛을 만들어야했고 그것이 `AND`와 `OR`. 그리고 `XOR`이다.
    + AND, OR는 선형으로 쉽게 풀 수 있다.
    + 하지만 XOR은 선형으로 풀기가 매우 어렵다.
    + ![Imgur](http://i.imgur.com/qvtkFFA.png)
- 많은 사람들이 도전했지만 실패했고 MIT의 Marvin Minsky 교수는 Perceptrons(1969)이라는 책에서 XOR은 현재 불가능한 거라고 수학적으로 증명했다. MLP(Multilayer perceptron), 즉 Multilayer 신경망이 필요한데 각각의 weight, bias를 구해서 학습시키는 것이 불가능하다고 주장했다. 아래 이미지에서처럼 너무 복잡함
    + ![img](http://cs231n.github.io/assets/nn1/neural_net2.jpeg)

### 1.2 Backpropagation

![Imgur](http://i.imgur.com/pk5vBdj.png)

- Paul Werbos(1974, 1982)가 처음 주장했지만 주목받지 못했고 Hinton(1986)이 처음 주목받았다.
- Backpropagation: 쭉 진행해서 잘못된 결과가 나오면 온 길을 되돌아가서 w, b를 수정하는 알고리즘

### 1.3 CNN, Convolutional Neural Networks

- LeCun 교수의 고양이 뇌 관찰: 하나의 데이터를 판단하기 위해 모든 뉴런이 동원되는 것이 아니다. 각 데이터마다 연관된 뉴런들이 존재해서 해당되는 뉴런만 활성화된다.
- CNN: 데이터를 한 번에 학습시키는 것이 아니라 여러 부분으로 나눠서 다음 레이어로 보낸다. 마지막에 합쳐서 계산. 알파고도 CNN을 사용했다.

### 1.4 문제점

- BackPropagation: 적은 수의 레이어에선 잘 되지만 10개 이상의 레이어에선 학습이 안된다. 마지막 레이어 이후에서 발견된 에러를 학습하기위해 앞쪽 레이어로 옮기면 의미가 갈수록 약해져서 초기 레이어까지 가면 의미가 없다. 즉 초기 레이어에서 학습이 거의 불가능한 문제
- 그래서 SVM이나 RandomForest가 더 낫더라라고 CNN을 만든 LeCun 교수도 말함.

### 1.5 Deep Learning의 등장

- Hinton, Bengio 교수의 논문으로 다시 주목. Deep한 레이어도 초기값만 잘 주면 학습이 가능하다.
- 이미지 분류, 인식 대회에서 압도적으로 높은 성적을 냄

## 2. Neural Nets for XOR

### 2.1 예제

![Imgur](http://i.imgur.com/awpVUDH.png)

- logistic regression unit 하나로는 XOR을 풀 수 없고 최소 3개가 필요하다.
- 위 이미지에서처럼 w, b값이 각 유닛에 주어졌을 때 마지막 유닛의 결과가 XOR의 결과와 같이 나올 수 있다.
- 이미지의 한 객체는 unit, gate, perceptron 등으로 다양하게 불린다.

### 2.2 Forward propagation

![Imgur](http://i.imgur.com/WpI9COI.png)

위처럼 3개 이상의 유닛으로 데이터를 앞으로 넘겨가면서 최종 결과를 내는 것을 Forward propagation이라고 한다.

### 2.3 NN, Neural Network

![Imgur](http://i.imgur.com/DOI5Qlu.png)

- 기본적인 Forward propagation의 꼴은 x가 스칼라값이다. 더 많은 데이터를 쉽게 계산하기 위해 벡터 꼴로 바꾸면 Neural Network가 된다.
- 수식으로 정리하면 위 이미지에서처럼 최종 Y값은 `Y = H(X) = sigmoid(K(x)*W2 + b2)`가 된다.

## 3. Backpropagation

- 계산 순서
    + 학습 데이터에서 받아온 w, x, b 데이터를 가지고 forward 한다.
    + Label과 비교하고 backward 한다.
- 학습한다는 것은 W, b를 계속 변경한다는 뜻이다. 역시 Gradient descent 알고리즘을 쓰기 때문에 아래로 볼록한 그래프의 각 관측 지점에서 "기울기"를 구하고 변경해나가야 한다.
- 하지만 레이어가 여러개 이어져있기 때문에 각각의 W, b를 추정해서 기울기를 구하려면 연산이 매우 복잡해진다.(Minsky 교수가 이야기했듯.) 그래서 backpropagation을 사용한다.

![Imgur](http://i.imgur.com/BFJ5fnd.png)

> chain rule이란 `f(g(x))`같은 중첩된 함수에서 기울기를 구할 때 g에 대한 f의 편미분 값과, x에 대한 g의 편미분 값을 곱하면 되는 규칙이다.

- `f = wx + b`, `g = wx` => `f = g + b`: 우선 수식을 간단히 표현한다.
- 위 이미지에서 `w`, `x`, `b`가 f에 미치는 영향을 구해야하는데 그것이 미분값이다.
    + `w`에 대한 미분값은 5인데 1이 변할 때 5만큼 f값이 변한다는 것.
    + `x`에 대한 미분값은 -2. 즉 1 변하면 -2만큼 변한다.
    + `b`는 1이고 변한만큼 변한다는 의미.
    + `w*x + b` 공식 내에서 편미분을 했으니 당연한 결과다.

![Imgur](http://i.imgur.com/e0U1DD9.png)

- 더 많은 레이어의 경우도 마찬가지다.
- 가장 마지막(이미지에서 가장 우측) 레이어를 먼저 계산하고, 계속 연달아서 뒤로 가며 계산한다.
- 마지막 레이어까지 계속 계산했으므로 g에 대한 f의 편미분값을 알고 있다.
- 그리고 마지막 레이어에서 이 계산되어온 값을 활용해서 x 혹은 y에 대해 편미분한다.
- sigmoid 함수가 있더라도 편미분은 어렵지 않다.
    + `g(z)`를 편미분한다. z에 대한 g의 편미분값이다.
    + z가 sigmoid 함수일 때 잘게 쪼개면 된다.
    + 먼저 `1 + e^(-x)`를 하나의 덩어리로 두고 `1/x` 형태로 미분한다.
    + 그리고 `e^(-x)`를 한 덩어리로 두고 `1+x` 형태로 미분
    + 그리고 `e` 형태로 미분하고, `x*-1` 형태로 미분하면된다.
