# Softmax regression

Multinomial classification에서 가장 많이 사용되는 것이 Softmax다.

## 1. logistic regression 복습

![Imgur](http://i.imgur.com/k44d8tp.png)

- X를 W 계산식에 통과시킨다. 우리의 경우엔 `W*X`였다.
- 그러면 z라는 결과가 나온다.
- 사각형 테두리에 감싸진 S: sigmoid 함수에 통과시킨다는 의미. 0과 1 사이의 값을 리턴한다.
- `Y hat`: real data는 그냥 `Y`로 표시하고, prediction은 표현의 차이를 두기 위해 `Y hat`으로 위 기호처럼 표현한다. `H(x)`와 같다.

## 2. Multinomial 케이스를 binary logistic으로 풀기

| x1(hours) | x2(attendance) | x3(somethiing) | y(grade) |
|-----------|----------------|----------------|----------|
|        10 |              5 |              2 | A        |
|         9 |              5 |              3 | A        |
|         3 |              2 |              4 | B        |
|         2 |              4 |              5 | B        |
|        11 |              1 |              6 | C        |

- 요약
    + 주제: `x1`시간 공부하고, `x2`번 출석하고 `x3`번 어떤 것이었을 때 어떤 `y` 성적이 나오느냐?
    + 목표: 적절한 모델을 만들고싶은 것. 즉 `x1`, `x2`, `x3`에 곱해질 weight `w1`, `w2`, `w3`를 구하고싶다.
    + cost: 위 데이터셋에는 총 5가지 데이터가 있다. cost function은 5가지 각각에 대해서 cost를 계산할 것이고, 최종적으로 Gradient algorithm을 돌릴 땐 5가지 cost의 평균을 활용한다.
- A, B, C 클래스 별로 세 가지 binary classification 그래프를 그릴 수 있다. "A or no", "B or no", "C or no"이다.
    + 각 그래프에서 영역을 분할하는 선을 `hyperplane`이라고 한다. 우리가 그래프로 그려서 보기에는 2차원이지만 실제론 다차원이므로.
    + ![Imgur](http://i.imgur.com/rfcPks4.png)
- 이 세 경우를 각각 `H(X) = W*X` 형태로(이 케이스에서 bias는 없다) Logistic regression을 한다. 각각의 코스트를 계산하고 최소값을 구한다.
- 하지만 여러 식을 사용하면 불편하므로 Matrix를 이용해서 하나의 식으로 만든다.
    + 3가지의 feature(x1, x2, x3)를 가지고 예측하기 때문에 X가 3 by 1 형태의 Matrix로 그려진다.
    + W는 3 by 3 매트릭스: 성적이 ABC 3가지이고, feature가 3개라서 weight도 3개다. 그래서 3 by 3이 된다.
    + feature가 3가지이므로 weight도 3가지다.
    + 최종적으로 나오는 3 by 1 매트릭스가 A, B, C 케이스 각각의 코스트이므로 합해서 최소가 나오는 지점을 찾는다.
    + ![Imgur](http://i.imgur.com/E7RitCD.png)

## 3. Softmax

![Imgur](http://i.imgur.com/MCVRUci.png)

- **2**까지는 아직 sigmoid function이 적용되지 않았다. 그래서 X의 값에 따라 각 클래스의 `W*X` 결과가 100이 될 수도 100,000이 될 수도 있다. sigmoid function을 통해 이 값을 0과 1 사이의 값으로 압축시켜야한다.
- 추가로 각 클래스의 cost function의 값들의 합이 1이 되게 만들면 확률의 성격을 띄게할 수 있다.
- 즉 0과 1 사이의 값으로 만들고, cost의 합이 1이 되게 만드는 것이 **Softmax**다. 다시 말해 임의의 데이터 x가 각 클래스에 속할 확률을 만들어주는 것이다.
- one-hot encoding: softmax를 통해 만들어진 확률 중에서 가장 큰 값을 1로 하고 나머지를 0으로 만드는 것을 말한다. 결국 클래스는 하나만 고를 것이기 때문

## 4. Cost function

![Imgur](http://i.imgur.com/EkuoObo.png)

- `S(Y)` : softmax를 적용한 prediction 값이고 y hat이다.
- `L` : 실제 값인 Label이다.
- `D(S,L) = -ΣLi*log(Si)`
    + Cross-entropy cost function
    + D는 distance의 이니셜
    + 의미는 Lable의 각 값에 매칭되는 S(Y) 원소를 곱해서 모두 더한 후 부호를 바꿔주는 것.

![Imgur](http://i.imgur.com/FuV5Dum.png)

- cost function을 풀이해보면 위 유도과정과 같다. `-`를 sigma 안으로 넣어서 `-log(Yi)`로 만들면 위 이미지의 우측 로그 그래프가 나온다. 1에 가까우면 값이 0이 되고, 0에 가까우면 값이 무한대로 간다.
- 즉 `Li`가 1일 때 `Yi`를 0으로 잘못 예측하면 cost가 무한대의 값이 되어버린다. 즉 cost function에서 강한 페널티를 주는 것.
- `C(H(x), y) = -y*log(H(x)) - (1 - y)*log(1 - H(x))`의 logistic의 cost에서 클래스만 늘어난 것이지 원리는 같다.
- 여기까지가 하나의 데이터를 활용해서 cost를 구한 것이다. 즉 "10시간 공부하고, 5일 출석하고, 2번 뭔가를 했을 때"의 cost를 구했다.
- 이러한 데이터가 총 5개가 있는 것이므로 모두 cost를 구한 후 평균을 내면 그것이 우리가 활용할 최종 cost가 되는 것이다.

## 5. Gradient descent

구한 최종 cost의 식은 아래로 볼록한 그래프다. 쉽게 Gradient descent 알고리즘을 활용하여 최저점을 구하면 된다.
