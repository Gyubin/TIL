# KMOOC 인공지능과 기계학습 : W4-1 Classification

## 1. 의학 진단 문제와 베이즈

![Imgur](http://i.imgur.com/dnCWkmK.png)

- mammogram test(유방 X선 테스트)에서 양성 판정을 받았을 때 실제로 유방암일 확률은 얼마나 될 것인가.
- 개념
    + `X = mammogram result`, `Y = breast cancer`
    + `p(X = 1| Y = 1) = 0.8` : 실제 유방암이 걸렸을 때 양성 판정을 받을 확률이 80%
    + 하지만 그 반대로 양성 판정을 받았을 때 유방암이라고 진단할 수 있느냐? 이건 아니라는 것. 이 때 잘못된 판단을 내린다면 그것을 `base rate fallacy`라고 한다.
- Bayes rule 적용
    + `Posterior` : 양성 판정을 받았을 때 유방암일 확률. 우리가 구하고자 하는 값이다. 이것을 구하기 위해 아래 두 수치가 더 필요하다.
    + `Prior`: `p(Y = 1) = 0.004` 처럼 아무나 한 사람 잡았을 때 유방암일 확률
    + `False positive` or `False alarm` : 유방암 환자가 아닌데 양성 판정을 받을 경우. `p(X = 1|Y = 0) = 0.1`

## 2. Classifier

### 2.1 Bayes Classifiers

![Imgur](http://i.imgur.com/SDIHBll.png)

- 요소
    + `C` : 클래스, 즉 데이터가 속하게 될 큰 분류.
    + `x` : 비정형 데이터다.(주로) 음성 데이터 혹은 다양한 주제의 기사글이 될 것이고 이를 어떤 언어의 음성 데이터인지, 정치 기사글인지 과학 기사글인지 구분하게 된다.
    + `feature`: 데이터를 분별하기 위해 미리 feature를 정의해둔다. 그래서 임의의 데이터가 들어오게되면 feature function을 통해 벡터를 만들게된다. 스팸필터라면 성인 사이트로 유도를 하느냐(1) 아니냐(0), 주요 도메인 서비스 회사를 사용하느냐(1) 아니냐(0)로 벡터를 만든다. 즉 정형화하는 것.
- Bayes rule 적용
    + `Class posterior` : 어떤 데이터가 들어왔을 때 어떤 클래스(분류)에 들어갈 것이냐. 우리가 구해야하는 값. 아래 데이터가 필요하다.
    + `Class prior`: `p(C = c)` 아무런 정보가 없을 때 임의의 데이터가 특정 클래스 c에 속할 확률이 얼마냐.
    + `Class-conditional density` : 특정 클래스 c일 때 데이터는 어떤 모습을 띄겠느냐. 어떤 형태의 벡터이겠느냐를 나타내는 확률 분포. generative classifiers라고도 부른다.

### 2.2 Discriminant Functions

![Imgur](http://i.imgur.com/H33ezZX.png)

- `discriminative classifier` : prior, class-conditional density가 필요없이 바로 데이터를 클래스에 fit하는 방식이다. 로지스틱 회귀와 관련있고 기존 베이즈 classifier와는 반대되는 개념.
- 각 클래스마다 discriminant function을 내부적으로 정해놓고 있어서 임의의 데이터가 들어왔을 때 모든 클래스의 함수에 적용한 후 가장 높은 수치가 나오는 클래스로 분류하는 것이다.
- `αc` : K개의 클래스 중 하나를 리턴하는 알고리즘, 액션이다. 각 클래스마다 Action을 갖고 있다. 즉 K개 클래스가 있다면 K개의 Action이 있음.
- `λck` : 실제 클래스는 k인데 c라고 했을 때 발생하는 손실
- `R(αc|x)` : Expected loss(loss의 기대값), 즉 Risk.
    + 좌변: 임의의 데이터 x가 들어왔을 때 `αc`의 리스크
    + 우변: 모든 k에 대해서 `λck`와 **2.1**의 posterior 확률을 곱한 값들을 더한 것.
- binary loss(0/1 loss)
    + c와 k가 같으면 loss는 0, 다르면 1이다. 딱 이 경우 뿐.
    + Risk 수식에 적용하면 `1 - P(C = c|x)`로 단순화할 수 있다.
    + 즉 리스크를 최대로 줄이기 위해선 posterior 확률이 가장 큰 c를 선택하면 된다.
    + 이 때 베이즈룰을 적용하면 분모에 `P(x)`가 들어가는데 이 x는 고정되는 값이다. c만 바꿔가면서 값을 보기 때문. 그래서 결국 슬라이드의 마지막 수식으로 정의된다.

![Imgur](http://i.imgur.com/EG4EsrI.png)

- discriminant function은 클래스의 개수에 따라 input data를 K개의 region으로 구분할 수 있다.
- 만약 K가 2개인 binary classification이라면 그냥 데이터를 두 개의 discriminant function에 넣고 그 차에 따라서 클래스를 구분하면 된다.
