# TensorFLow: Logistic Regressioin 

Logistic regression의 예제 코드

```py
import tensorflow as tf
import numpy as np

xy = np.loadtxt('train.txt', unpack=True, dtype='float32')
x_data = xy[0:-1]
y_data = xy[-1];

X = tf.placeholder(tf.float32)
Y = tf.placeholder(tf.float32)

W = tf.Variable(tf.random_uniform([1, len(x_data)], -1.0, 1.0))

h = tf.matmul(W, X)
hypothesis = tf.div(1., 1.+tf.exp(-h))

cost = -tf.reduce_mean(Y*tf.log(hypothesis) + (1-Y)*tf.log(1-hypothesis))

a = tf.Variable(0.1)
optimizer = tf.train.GradientDescentOptimizer(a)
train = optimizer.minimize(cost)

init = tf.global_variables_initializer()

sess = tf.Session()
sess.run(init)

for step in range(4001):
    sess.run(train, feed_dict={X:x_data, Y:y_data})
    if step % 100 == 0:
        print(step, sess.run(cost, feed_dict={X:x_data, Y:y_data}), sess.run(W))
```

- train.txt 파일에서 행렬 데이터를 읽어온다. 파일 구조는 다음과 같다.
    + `#`으로 돼있는 부분은 읽어오지 않는다.
    + x0은 bias이고 x1, x2가 feature다.
    + 마지막 컬럼이 y값

    ```
    #x0 x1 x2 y
     1  2  1  0
     1  3  2  0
     1  3  4  0
     1  5  5  1
     1  7  5  1
     1  2  5  1
    ```

- `W`는 `x_data`의 행 개수만큼 만들어준다 그래야 행렬 간 곱셈이 가능한 꼴이 된다.
- `hypothesis`는 `H(X) = 1 / 1 + e^(-WT*X)` 식을 tensorflow의 함수를 이용해서 작성한다.
- `cost`는 cost function을 각 케이스별로 계싼해서 평균을 구한 값이다. cost function은 `C(z, y) = -y*log(z) - (1-y)*log(1-z)` 식을 구현한 것이고 cost는 여기다 reduce_mean 함수를 추가로 사용했다.
- 이후론 linear regression과 동일
