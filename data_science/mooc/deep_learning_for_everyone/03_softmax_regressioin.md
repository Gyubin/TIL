# Softmax regression

Multinomial classification에서 가장 많이 사용되는 것이 Softmax다.

## 1. logistic 수식

![Imgur](http://i.imgur.com/k44d8tp.png)

- X를 W 계산식에 통과시킨다. 우리의 경우엔 `W*X`였다.
- 그러면 z라는 결과가 나온다.
- 사각형 테두리에 감싸진 S자: sigmoid 함수에 통과시킨다는 의미
- sigmoid 함수에 실수를 통과시키면 0과 1 사이의 값이 나오므로 Y hat으로 결과를 표현한다.
- real data는 그냥 `Y`로 표시하고, prediction은 표현의 차이를 두기 위해 `Y hat`으로 위 기호처럼 표현한다. `H(x)`와 같다.

## 2. 예제

아래 데이터로 classification을 해보자.

| x1(hours) | x2(attendance) | y(grade) |
|-----------|----------------|----------|
|        10 |              5 | A        |
|         9 |              5 | A        |
|         3 |              2 | B        |
|         2 |              4 | B        |
|        11 |              1 | C        |

- 세 가지 그래프를 그릴 수 있다. 각각은 binary classification을 활용해서 "A or no", "B or no", "C or no"이다.
    + 각 그래프에서 영역을 분할하는 선을 `hyperplane`이라고 한다. 우리가 그래프로 그려서 보기에는 2차원이지만 실제론 다차원이므로.

    ![Imgur](http://i.imgur.com/rfcPks4.png)

- 이 세 경우를 가각 `H(X) = W*X` 형태로 만들게 되면 총 세 번의 연산을 해야하고 복잡하다. 그래서 Matrix를 아래 이미지의 공식처럼 확장한다.

    ![Imgur](http://i.imgur.com/E7RitCD.png)
