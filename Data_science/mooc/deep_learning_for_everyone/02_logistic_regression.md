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

### 2.1 기존 cost function 활용 불가

![Imgur](http://i.imgur.com/1aZS9Wa.png)

- 새로 도출한 Logistic hypothesis를 가지고 그대로 기존 cost function(차를 제곱해서 평균을 내는 것)에 대입하는 것은 불가능하다.
- 이유는 hypothesis가 sigmoid function이기 때문에 위 이미지의 우측 그래프처럼 구불구불한 모양으로 나타내어지기 때문이다.
- 저런 그래프에서는 local minimum이 자주 나타나기 떄문에 global minimum에 도달하지 못할 확률이 높다. 그래서 Gradient descent 알고리즘 사용이 불가능하다.

### 2.2 cost function 변형

```
cost(W) = 1/m* Σc(H(x), y)
c(H(x), y) = { -log(H(x))    :   y=1
               -log(1 - H(x)):   y=0
}
```

- log를 사용한다. 그래프가 구불구불해지는 것은 자연상수 `e` 때문인데 log를 활용해서 그래프를 쭉 펼칠 수 있다.
- 첫째 식: cost function의 결과치를 평균 내는 것이다. `m`은 샘플 개수다.
- 둘째 식: (binary classification 가정) cost function의 계산 식은 두개다.
    + y=0 : `-log(H(x))`, 즉 `-log(z)`의 값을 리턴
    + y=1 : `-log(1 - H(x))`, 즉 `-log(1-z)`의 값을 리턴

- 직접 그래프로 그려보면 다음 이미지와 같다.

![Imgur](http://i.imgur.com/yCttUDo.png)

> 왼쪽 그래프가 y가 1일 때, 오른쪽이 y가 0일때다.

- 문제부터 해결까지 순서대로 유도해보면 다음과 같다.
    + 1) hypothesis를 sigmoid function을 쓰는 것으로 변형했다.
    + 2) sigmoid는 자연 상수 e를 쓰기 때문에 그래프가 구불구불해진다.
    + 3) 그래프가 구불구불하면 local minimum이 많이 생기기 때문에 Gradient descent 알고리즘을 사용하지 못한다.
    + 4) 이 문제를 해결하기 위해선 그래프를 쭉 펴야한다.
    + 5) 자연상수 e 때문에 구불구불해졌으므로 log를 활용해 e를 없애면 된다. 다만 log를 사용하더라도 결과 값에 이상이 없어야 한다.
    + 6) 결과 값에 이상이 없다는 말은 cost function의 원칙에 충실파면 된다는 이야기다. 즉 예측이 맞을 때 cost를 작게 하고, 틀렸을 때 cost를 크게 해주면 된다.
    + 7) binary case에서 y 값을 기준으로 나눠보면(이미지의 좌, 우 그래프 참조)
        * y가 1일 때: H(x)가 1과 가까울수록 코스트가 낮아져야하고, 0에 가까울수록 높아져야한다.
        * y가 0일 때: H(x)가 1과 가까울수록 코스트가 높아져야하고, 0에 가까울수록 낮아져야한다.
    + 8) 7에서와 같이 cost의 원칙을 따르면서 더불어 log를 활용하는 식이 각각 `-log(z)`와 `-log(1-z)`다.
    + 9) 이 두 그래프를 붙이면 convex 형태가 되어 Gradient descent 알고리즘을 적용할 수 있는 형태가 된다.
- 하지만 이 식을 코드로 짜기엔 힘드므로 두 경우로 구분하는 것이 아니라 하나로 합쳐야 한다. 마침 binary 케이스고 y값이 0과 1이므로 각 식에 곱해주기만 하면 된다.

    ```sh
    C(H(x), y) = -y*log(H(x)) - (1-y)*log(1-H(x))
    C(z, y) = -y*log(z) - (1-y)*log(1-z) # H(x)를 z로 치환. 같은 식.
    ```

## 3. Minimize cost - Gradient descent algorithm

```
cost(W) = -1/m * Σy*log(z) + (1-y)*log(1-z)
W := W - α*(cost function의 미분값)
```

- cost의 값은 케이스 별 cost function의 평균이다.
- 예측 알고리즘을 적용하기 위해 W 값을 계속 바꾸는 것은 linear regression 경우와 일치한다.
- `α`는 learning rate를 뜻함
