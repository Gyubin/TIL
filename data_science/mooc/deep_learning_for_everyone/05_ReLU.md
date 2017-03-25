# ReLU

- 레이어 종류
    + input layer: 데이터가 들어오는 첫 번 째 레이어(보임)
    + output layer: 결과가 나오는 마지막 레이어(보임)
    + hidden layer: 중간 레이어(보이지 않음)
- Vanishing gradieng(NN의 두 번째 겨울을 야기: 1986-2006)
    + Backpropagation에서 sigmoid를 활용하면 2, 3단은 학습 잘 되는데 9, 10단이 넘어가면 힘들다.
    + 값이 0 또는 0.01 등의 값으로 매우 작게 나와서 계속 곱해지면 뒤로 갈수록 0에 가까워진다. 거의 영향이 없음.
