# KMOOC 인공지능과 기계학습 : W3-2 Model Selection

## 1. 사례

![overfitting](http://i.imgur.com/iWK0OHy.png)

- 위 이미지에서 단순히 error term의 값이 가장 작은 것을 선택하면 안된다. noise까지 fitting해버리고 있는 것을 볼 수 있다.
- 판단 기준은 데이터가 없는 부분, 즉 0에 가까워지는 부분과, 데이터의 최대값보다 더 큰 부분에서 직관적으로 있을 수 없는 결과가 나오는 것을 보면 알 수 있다.


## 2. 오차 추정(Measuring Errors)

- 학습된 데이터에서 오차를 추정하는 것이 아님.
- 보지 않았던 데이터에서 얼마나 잘 예측하고 있는지 알아내야함.

### 2.1 K-fold Cross Validation(CV)

![5-fold](http://i.imgur.com/xx3x1OL.png)

- 데이터를 k 개로 쪼갬. 위 이미지는 5개로 쪼갰으므로 '5-fold cv'다.
- 주어진 데이터에서 4개의 fold는 학습하는데 쓰이고, 학습된 결과를 바탕으로 나머지 1개 fold의 오차를 측정한다. 전자를 training dataset, validation dataset이라고 한다.

![Imgur](http://i.imgur.com/tX22v7L.png)

- x축은 차수, y축은 오차 값이다.
- 위의 주황색 그래프가 k-fold, 아래 파이 그래프가 그냥 전체를 대상으로 error 값을 구한 것.
- 아래 그래프는 차수가 높아질 수록 점점 데이터에 대한 추정이 강화되므로 오차값이 줄어든다.
- 하지만 위 k-fold는 과적합(overfitting) 문제 때문에 validation dataset에 대한 오차값이 차수가 늘어나면서 점점 커지게 된다.
- 최종적으로 k-fold의 오차값이 가장 적은 2차 함수를 쓰는 회귀모델이 가장 좋은 것으로 결론.
- `LOOCV`(Leave One Out Cross Validation): k-fold에서 k를 데이터의 개수로 맞춰주는 것. 즉 N-1개를 트레이닝 데이터셋으로 삼고, 총 N번 테스트를 하는 것이다. 학습하고자하는 모델에 비해 데이터가 너무 없을 경우에 주로 사용된다.

### 2.2 Curse of Dimensionality

- 함수의 차수가 커질 수록(linear -> quadratic -> cubic -> polynomial) 표현력은 좋아진다. 하지만 학습해야 할 parameter 개수가 늘어나기 때문에 적정한 타협점을 찾아야 한다.
- 차수가 늘어날수록 계산량은 늘어난다. 이를 Big-O notaion, 즉 시간복잡도로 표현한다. `O(d^n)`에서 d는 파라미터 개수, n은 차수다.
- input vector의 차원이 엄청 크다면 데이터들이 잘 분간이 안된다.
    + 아래 슬라이드에서 원이 두 개 겹쳐있고, 안쪽 원을 제외한 테두리 부분의 데이터들을 나타내는 함수를 찾는다고 해보자.
    + 차원이 커질수록 parameter가 엄청나게 많아지는데 아래 식처럼 수학 계산을 통해 굉장히 단순화시킬 수 있다. 이런 작업들이 필요한 경우가 많다.

![Imgur](http://i.imgur.com/Vb9avP0.png)

## 3. Feature Mapping

![feature_mapping](http://i.imgur.com/GVaDwQA.png)

input data를 그대로 쓰는게 아니라 feture mapping function을 통해 적절히 변환시켜서 쓰는 것. 다항식 회귀모델 푸는 것과 비슷하다.
