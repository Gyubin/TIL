# Numpy 사용법

참고 링크 : [공식 튜토리얼](http://scipy.github.io/old-wiki/pages/Tentative_NumPy_Tutorial.html), [elice.io](https://www.elice.io/)

Numpy는 Python에서 사용되는 라이브러리다. 기본으로 지원되지 않는 배열과 행렬의 계산을 쉽게 할 수 있도록 다양한 함수들을 가지고 있다. Scipy 라이브러리에 포함되어있는데 Pandas같은 관련 라이브러리에 대해선 다른 곳에 기록하겠다.

## 1. 설치

### 1.1 Option 1

우선 `ml`이라는 이름으로(machine learning을 의미. 필수는 아니다.) Python 가상환경을 만들고 다음 명령어로 numpy를 설치한다.

```bash
pip install numpy
```

### 1.2 Option 2

Homebrew를 사용하고 있다면 다음처럼 설치도 가능하다.

```bash
brew install python3

# Get access to the scientific Python formulas
brew tap Homebrew/python

# Install Numpy and Matplotlib
brew install numpy --with-python3
brew install matplotlib --with-python3
```

## 2. 주요 함수

`import numpy`는 항상 필요하다.

### 2.1 기본

- numpy.ndarray 생성: `numpy.array(arr)` 매개변수로 리스트가 들어간다. 리스트 안에 또다시 리스트들이 있는데 각각 '행'을 의미한다. [[행], [행], [행], [행] ...] 이런 식이다. `numpy.array([[1, 2], [3, 4]])` 식으로 쓰이면 2 by 2 행렬이 생성된다.
- numpy.ndarray.shape: `my_ndarray.shape` 생성한 ndarray 객체의 모양을 튜플 형태로 리턴한다. 2 by 4 행렬이라면, 즉 2행 4열 행렬이면 (2, 4)를 리턴한다.
- numpy.ndarray.ndim: 차원을 리턴
- numpy.ndarray.size: 총 원소의 수를 리턴
- numpy.ndarray.dtype: 원소의 타입을 리턴.
    + 원소 100개가 있을 때 99개가 int인데 하나만 float형이면 전체 원소 타입이 float로 바뀐다. 더 general한 타입으로 모두 바꾼다. upcasting이라고도 한다.
    + array를 생성할 때 이 dtype을 특정지을 수도 있는데 `numpy.array( [ [1,2], [3,4] ], dtype=complex )` 혹은 `numpy.ones( (2,3,4), dtype='int16' )` 처럼 할 수 있다. int16 같은 경우 튜토리얼에선 그냥 변수처럼 적었는데 쉘에서 실행해보니 문자열로 넣지 않으면 에러가 뜨더라.
- `numpy.zeros((x, y))`, `numpy.ones((x,y))`, `empty((x,y))` : 0으로 채우기, 1로 채우기, random 값 행렬 만들기의 함수다. 기본 dtype은 float다.
- `numpy.arange(start, end, step)` : 쉽게 array를 만들어준다. start 부터 end 까지 step 간격으로 배열을 생성하는데 end는 불포함이고 1행짜리다. 원소 하나만 넣으면 start는 0, step은 1이 default로 들어간다. 즉 `numpy.arange(6)`의 결과는 `[0, 1, 2, 3, 4, 5]`이다. reshape을 통해서 2차 조작하면 될 것 같다.
- `numpy.linspace(start, end, number_of_elements)` : arange와 비슷하다. 다만 step이 아니라 원하는 원소 개수를 매개변수로 넣는다. `numpy.linspace(0, 2, 9)`를 하면 array([0., 0.25, 0.5, 0.75, 1., 1.25, 1.5, 1.75, 2.]) 결과를 얻는다. 여기선 end가 포함이다. `x = linspace( 0, 2*pi, 100 )` `f = sin(x)` 의 예시도 있다.
- numpy.ndarray.reshape: `my_ndarray.reshape(x, y)` 행렬 모양을 바꿀 수 있다. [[1, 2, 3], [4, 5, 6]] 의 행렬의 shape은 (2, 3)인데 reshape(3, 2)로 실행한다면 행렬 모양은 [[1, 2], [3, 4], [5, 6]]으로 바뀐다. 원소 수만 같으면 이렇게 순서대로 쭉 나열한 상태에서 그룹을 다시 지어줄 수 있다.
- 연산
    + 원소 개수와 shape이 일치하면 `+`, `-`, `*`, `/` 다 가능하고, 하나의 배열을 거듭제곱하는 것도 `**` 가능하다. 다만 `*`는 실제 원소끼리의 곱셈을 의미하고 행렬 연산에서 dot product는 `dot` 함수를 쓴다. `numpy.dot(A, B)`의 형태.
    + 비교 연산: a = numpy.arange(4)일 때 `a<3`의 결과는 `array([True, True, True, False])` 이다. 원소 하나하나에 적용된다.
- 파이썬 기본 라이브러리에서 `sum(iterable)`, `min(iterable)`, `max(iterable)`는 매개변수로 iterable을 받는 형태로 사용된다. 하지만 numpy에서 같은 이름의 함수를 따로 만들었는데 이 땐 `.` notation으로 접근할 수 있다. a.sum(), a.min(), a.max() 같은 식이다.
    + sum 함수에서 매개변수로 axis가 들어갈 수 있다. a.sum(axis=0) 처럼 0 값이 들어가면 각 컬럼들의 합을, 1일 때는 각 행들의 합을 ndarray 객체로 리턴한다. 하나의 행으로만 나타낸다.
    + min, max도 마찬가지로 axis가 0, 1일 때 각각 각 컬럼의 최소 최대값, 각 로우의 최소, 최대값을 ndarray 객체로 리턴한다.
    + `a.cumsum(axis=1)` 같은 경우엔 누적 분포를 보여주는데 기존 a의 모양 그대로에서 우측으로, 즉 행(row)을 따라 누적값을 보여준다. axis는 그냥 여러번 하면서 외우는게 제일 속 편하겠다.
- `numpy.exp(ndarray)`, `numpy.sqrt(ndarray)`, `numpy.add(A, B)` : 이런 함수들도 있다. exp, sqrt, add. 사실 이거 말고도 너무 많아서 그냥 있을 것은 다 있다고 보면 될 것 같다. 필요할 때 찾아서 쓰자.
- `numpy.mean(A)`, `numpy.median(A)`, `numpy.std(A)`, `numpy.var(A)` 순서대로 평균, 중간값, 표준 편차, 분산
- for 반복 등의 iterating 가능하다.
- `numpy.fromfunction(func, (row, col), dtype=type)` : 0부터 row, 0부터 col까지 정수를 func에 대입한다. func의 리턴값이 그 row, col의 값이 되는 것. fromfunction과 indexing 예시.

    ```py
    def f(x,y):
        return 10*x+y

    b = fromfunction(f,(5,4),dtype=int)
    # array([[ 0,  1,  2,  3],
    #       [10, 11, 12, 13],
    #       [20, 21, 22, 23],
    #       [30, 31, 32, 33],
    #       [40, 41, 42, 43]])

    b[2,3] # 23
    b[0:5, 1] # array([ 1, 11, 21, 31, 41])
    b[ : ,1] # array([ 1, 11, 21, 31, 41])
    b[1:3, : ]
    # array([[10, 11, 12, 13],
    #       [20, 21, 22, 23]])
    ```

- slicing: 파이썬에서 리스트 다루는 법과 거의 동일하다.
    + `A[:5:2] = 10` : 일반 리스트에선 에러나는데 여기선 시작부터 5번째 인덱스 이전까지 2칸씩 띄워가면서 원소에다가 10을 대입한다는 의미
    + `A[1:5, 3:5]` : A가 2차원 행렬일 때 1, 2, 3, 4 행에서 3, 4 열만 뽑아서 만든 행렬을 리턴한다. 원래가 10x10 2차원 행렬이었다면 이 slicing의 결과는 4x2 2차원 행렬이 되는 것.
- `...` : [ ] 안에서 인덱싱을 할 때 전체 행 선택, 전체 열 선택 이런 의미다. 5차원 배열에서 `x[1, 2, ...]`은 `x[1, 2, :, :, :]`의미와 같다. 또한 `x[..., 3]`은 `x[:,:,:,:,3]`와 같고 `x[4, ...,5,:]`은 `x[4,:,:,5,:]`와 같다.
- `for e in ndarray.flat: print(e)` : ndarray에서 `flat` 을 호출하면 모든 원소들을 하나씩 뽑아낼 수 있는 numpy.flatier object를 리턴한다. 하나씩 뽑아 내는 반복문 쓸 때 유용
- `numpy.random.random((3,4))` : 난수를 생성해서 3행 4열 생성한다. 매개변수엔 튜플이 들어가고 원소 수가 곧 차원 수다. `A = floor(10*numpy.random.random((3, 4)))` 형태로 사용한다.
- 원소 접근(만약 3 by 4 형태의 매트릭스 `a`가 있을 때)
    + 하나 가져오기: `a[1, 3]`과 `a[1][3]` 두 가지 방식으로 원소를 가져올 수 있다. 1번 인덱스의 행과 3번 인덱스의 열의 값을 가져오는 것
    + 여러개 가져오기: `a[0:4, 1:3]` 형태로 콜론을 쓴다. 0, 1, 2, 3 인덱스의 행과 1, 2 인덱스의 열을 가져와서 4 by 2 형태의 매트릭스를 리턴한다.
    + step 주기: 여러개의 행과 열을 가져올 때 `a[0:4:2, 1:3]` 이렇게 콜론과 수를 하나 더 적어주면 step을 의미한다. 2칸씩 띄워서 값을 가져옴
- `arr > 5` : 이렇게 부등호, 등호를 쓰면 똑같은 shape의 행렬에 5보다 큰가에 대한 boolean 값을 담아서 리턴한다.

### 2.2 모양 바꾸는 함수들

- `numpy.concatenate((ndarray, ndarray), axis=n)`
    + 배열을 합치는 함수다. 합칠 두 배열을 첫 번째 매개변수에 튜플 형태로 넣는다.
    + 두 번째 매개변수는 어느 방향으로 합치는지 정하는 것인데 axis의 값으로 0과 1이 들어갈 수 있다. 0은 첫 번째 배열 아래에 두 번째 배열을 접합시키는 것이고, 1은 첫 번째 배열 우측에 두 번째 배열을 붙이는 것이다. 아래 예제코드를 실행해본다.

    ```py
    A = numpy.array([[1, 2], [3, 4]])
    B = numpy.array([[5, 6], [7, 8]])
    C_Y = numpy.concatenate((A, B), axis = 0)
    print(C_Y)
    C_X = numpy.concatenate((A, B), axis = 1)
    print(C_X)
    ```

- 위 합치는 예제에서 더 직관적인 함수가 있다. vertical, horizontal의 의미에 쌓는다는 stack을 더한 이름의 함수다. `numpy.vstack((A, B))`는 수직으로 쌓는다는 의미로 axis = 0으로 concatenate 한 결과와 같다. `numpy.hstack((A,B))`는 수평으로 우측에 붙이는 것으로 axis=1로 concatenate한 결과와 같다.

- `numpy.split(ndarray, index, axis=n)`
    + 배열을 쪼갠다. 첫 번째 매개변수는 분리할 ndarray 객체를 넣는다.
    + 두 번째 매개변수는 ndarray가 분리될 위치를 정한다.
        * 첫 번째로 그냥 자연수 n을 입력할 경우 n등분한다. 만약 n으로 나눴을 때 나머지가 있으면 오류가 난다.
        * 두 번째로 분리할 위치를 지정할 수 있는데 `[ ]` 리스트 형태로 넣으면 된다. 만약 5개의 행이 있고 이를 axis=0으로 쪼갠다고 하자. 이 때 [1]이라면 0번째 행과, 1, 2, 3, 4번째 행으로 쪼개지고, [2]라면 0, 1번째 행과 2, 3, 4번째 행으로 쪼개진다. [1, 3]이라면 0번째 행과 1, 2번째 행, 3, 4번째 행으로 쪼개진다.
    + 세 번째 매개변수는 concatenate에서와 같이 방향을 지정하는데 0이면 위 아래로 쪼개고, 1이면 좌 우로 쪼갠다.

    ```py
    A = numpy.array([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13 ,14 ,15, 16]])
    print(A)
    slice_Y_equal_size = numpy.split(A, 2, axis = 0)
    print(slice_Y_equal_size[0])
    print(slice_Y_equal_size[1])
    slice_X_different_sizes = numpy.split(A, [2, 3], axis = 1)
    print(slice_X_different_sizes[0])
    print(slice_X_different_sizes[1])
    print(slice_X_different_sizes[2])
    ```

- `ndarray.ravel()` : 배열을 flat 하게 바꿔서 리턴한다. 타입은 ndarray
- `ndarray.transpose()` : 행 열을 바꾸는 것.
- `ndarray.resize((x, y))` : reshape은 모양을 바꾼 값을 리턴하지만 resize는 호출된 객체 자체를 바꿔버린다.
- `ndarray.reshape(x, -1)` : -1을 넣으면 다른 수에 맞춰서 자동으로 수를 조정해준다. 15개 원소인 ndarray에 reshape(5, -1)을 하면 자동으로 (5, 3) shape으로 모양을 바꿔준다.
- `numpy.linalg.inv(A)` : 역행렬 구하기.

### 2.3 사칙 연산

```py
A = numpy.array([[1, 2], [3, 4]])
print(A + 2)
print(A - 3)
print(A * 2)
print(A / 5)
```

ndarrary에 스칼라를 연산하면 모든 원소에 적용된다. 모든 원소 각각에 사칙연산이 적용된다.

## 3. Broadcasting

크기가 다른 행렬 간의 연산을 브로드캐스팅이라 한다. 아래 첫 번째 코드는 브로드캐스팅을 적용하지 않은 것, 두 번째가 적용한 예다.

```py
import numpy as np

x = np.array([[1,2,3], [4,5,6], [7,8,9], [10, 11, 12]])
v = np.array([1, 0, 1])
vv = np.tile(v, (4, 1))

y = x + vv
```

- x에 v를 더해서 y를 만들고자 한다.
- 이 때 x와 v의 차원이 다르기 때문에 v를 x에 맞게 바꿔줘야한다. `tile` 함수를 이용해서 세로로 층층이 4번 쌓았다.
- x와 쌓아서 새로 만든 행렬은 모양이 같으므로 더할 수 있다.

```py
import numpy as np

x = np.array([[1,2,3], [4,5,6], [7,8,9], [10, 11, 12]])
v = np.array([1, 0, 1])
y = x + v
```

- 하지만 broadcasting 특성을 통해 작은 행렬을 여러번 사용할 수 있다.
- 그냥 위 코드처럼 더해도 같은 결과가 나온다.
- 다만 약간의 규칙이 있다.
    + rank가 동일하지 않으면 같은 모양이 될 때까지 작은 행렬을 계속 붙인다(재사용한다)
    + 모든 차원에서 length가 같을 때 기본적으로 서로 호환. 매칭되는 차원에서 서로 길이가 다르다면 다른 한 쪽의 길이가 1이어야 함.

## 4. 자주 쓰이는 함수들

- `np.linalg.norm(matrix)` : 모든 원소들의 squared sum을 구하고 squared root 한다. Frobenius norm이라고도 불린다.
- `np.array_split(matrix, num)` : matrix를 원하는대로 쪼개준다.
- `np.concatenate(np.delete(X_train_folds, idx, axis))`
    + np.delete는 matrix에서 원하는 idx를 axis 방향으로 없앤 값을 리턴한다.
    + np.concatenate 함수에 matrix를 넣으면 쭉 펼쳐준다.
    + 위 코드는 CS231n의 코드로, X_train_folds가 np.array_split의 결과값인 list 타입이다. 저기서 delete로 원하는 인덱스는 제외하고, 나머지를 concatenate해줘야 정상적인 matrix 형태가 나온다.
