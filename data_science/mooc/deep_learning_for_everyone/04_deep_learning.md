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
