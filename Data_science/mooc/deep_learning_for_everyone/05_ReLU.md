# ReLU

## 1. Sigmoid의 문제점

- 레이어 종류
    + input layer: 데이터가 들어오는 첫 번 째 레이어(보임)
    + output layer: 결과가 나오는 마지막 레이어(보임)
    + hidden layer: 중간 레이어(보이지 않음)
- Vanishing gradient(NN의 두 번째 겨울을 야기: 1986-2006)
    + Backpropagation에서 sigmoid를 활용하면 2, 3단은 학습 잘 되는데 9, 10단이 넘어가면 힘들다.
    + sigmoid 게이트를 여러개 통과하게되면 매우 작은 값이 나올 확률이 크다. 왜냐면 sigmoid의 결과값은 무조건 1보다 작으므로.
    + 이것들이 레이어를 여러개 거치며 계속 곱해지면 갈수록 0에 가까워진다. 초기 레이어의 값들은 경사도가 매우 작아져서 거의 영향이 없게 된다.

## 2. ReLU(Reactified Linear Unit)

![relu](http://csci431.artifice.cc/images/relu.png)

> - 출처: [http://csci431.artifice.cc/notes/deep-learning.html](http://csci431.artifice.cc/notes/deep-learning.html)

- `max(0, x)`
- Sigmoid의 대안으로 나옴. 0보다 작으면 0이고, 크면 그 값을 리턴하는 함수
- activation function으로 Sigmoid 대신 Relu를 쓴다. 뉴럴 네트워크에선 sigmoid 말고 항상 ReLU를 쓴다.
- input layer부터 hidden layer까지는 모두 ReLU를 쓰면 되는데 마지막 output layer에서는 sigmoid를 쓴다. 0 또는 1의 바이너리로 출력을 하기 때문

## 3. 다른 시도들

각각의 방식을 사용한 결과를 비교해보면 Sigmoid는 수렴이 아예 안되서 값이 안나온다. ReLU 혹은 다른 것들을 쓰자.

- Leaky ReLU: 0 이하는 모두 0으로 해버리는 것이 과하다 생각. `max(0.1x, x)` 형태로 0 이하도 아주 완만하게 아래로 내려가는 그래프로 만든다.
- tanh: 탄젠트 사용. Sigmoid와 거의 비슷하다. 0을 중심으로 내린 것.
- ELU: 0보다 크면 그 값 리턴, 작으면 `a*(exp(x) - 1)`
- Maxout: `max(w1T*x + b1, w2T*x + b2)` hypothesis 중 큰 값 리턴
