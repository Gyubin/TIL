# Word2vec

자연어는 컴퓨터에게 유니코드의 조합 그 이상, 그 이하도 아니다. 이 의미를 컴퓨터가 이해하고 비교할 수 있게 하려면 어떤 방식이 좋을까. Word2vec은 단어들을 벡터화해서 실수 공간에 자리잡고 있다고 생각하고 유사도 등을 측정하는 방식이다.

단어의 벡터화 개념이 나오기 전에는 Naive bayes라고 해서 단순히 문장 속에 단어가 있는지 없는지 1과 0으로만 표현하는 one-hot encoding 방식을 많이 사용했다. 이 방식은 단어 간 유사도, 의미를 측정할 수 없다는 단점이 있다.

## 1. Previous theory

### 1.1 NNLM

![nnlm](http://img2016.itdadao.com/d/file/tech/2017/06/03/it327672031153191.png)

- NNLM : Feed-Forward Neural Net Language Model
- 비슷한 분포를 지니는 단어는 비슷한 의미를 지닌다. "비슷한 분포"라는 말은 단어들이 같은 문맥 내에서 자주 나타난다는 의미이다.
- Layer 구성
    + Input layer
    + Projection layer
    + Hidden layer
    + Output layer
- 방식
    + 현재 단어 이전의 단어들 N개를 one-hot encoding으로 벡터화
    + 단어별로 벡터화한 것의 크기를 V, Projection layer의 크기를 P라고 하면 Projection layer에서 다음 hidden layer로 넘어가는 값은 V by P 크기의 매트릭스이다.
    + 이 데이터가 hidden layer를 거쳐서 단어 별로 나올 확률을 계산한다. back-propagation을 통해 각 레이어별 weight를 최적화한다.
    + Output은 크기 P의 단어 벡터
- 단점
    + 몇 개의 단어를 볼 것인지 N값을 정해줘야
    + 이후의 단어들에 대해선 고려하지 않는다.
    + 매우 느리다. 대략 `N*P + N*P*H + H*V` 로 계산할 수 있고 예를 들어 N은 10, P는 500, H는 500, V는 모든 단어를 갖고 있어야 하므로 천만 정도 됨

### 1.2 RNNLM

![rnnlm](https://www.researchgate.net/profile/Michael_Johnson40/publication/257879210/figure/fig4/AS:293954571522048@1447095639053/Figure-2-Class-based-output-layer-for-RNNLM.png)

- NNLM을 RNN 방식으로 바꾼 것
- Projection layer 없이 input-hidden-output 꼴로 바꿔서 사용
- 단어를 순차적으로 input에 넣기만 하면 RNN의 특성 상 이전 단어를 보는 효과를 내기 때문에 N 값을 정해줄 필요가 없다.
- 계산 비용은 `H + H*H + H*V`이고 H*V 부분에서 V를 로그로 씌울 수 있는 테크닉이 존재해서 NNLM보다 더 빠르게 계산 가능

## 2. Word2vec

![cbow_and_skipgram](https://i.stack.imgur.com/O2YeO.png)

### 2.1 CBOW(Continuous Bag-of-Words)

- 컨텍스트로부터 찾고자 하는 목표 단어를 예측하는 모델
    + "날씨가 너무 더워서 OOO을 틀었다" -> 에어컨 예측
    + "The cat sits on the OOO." -> mat 예측
- 주어진 단어의 앞뒤로 `C/2`개의 단어를 골라서 총 C개의 단어를 input으로 활용. 대략 5-10개 정도를 쓴다고 한다.
- 방식
    + input-hidden-output 레이어로 구성 -> weight matrix는 2개
    + hidden layer는 사실상 projection layer이고 이를 output으로 보낼 때 소프트맥스를 활용해 확률을 계산한다.
    + 계산한 확률은 one-hot encoding된 벡터와 비교해서 에러를 계산하고 최적화한다.
- 계산 비용은 `C*N + N*V`인데 C는 작으니 무시하고, V는 로그화할 수 있으므로 사실상 `N*log(V)`이다.
- 작은 데이터셋에 적합

### 2.2 Skip-gram

- 현재 단어 하나를 가지고 이전, 이후의 단어들 몇 개를 추측하는 모델
    + "The cat sits on the mat." -> mat 단어를 가지고 앞 단어들을 예측
- 현재 단어 주위의 단어들을 샘플링하는데 가까이 있는 단어일수록 연관성이 높다고 가정하기 때문에 가까울수록 높은 확률로 뽑는다.
- 방식
    + input-hidden-output 레이어로 구성 -> weight matrix는 2개
    + 현재 단어를 projection
    + output layer로 보내서 확률 계산
    + C개의 단어에 대해서 각각 위 작업을 반복
- 계산비용은 `C(N + N*log(V))`
- 큰 데이터셋에 적합하다. 즉 요즘 많이 쓰임
