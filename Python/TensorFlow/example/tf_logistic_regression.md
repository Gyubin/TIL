# TensorFLow: Logistic Regressioin 

## 1. 데이터

- diabetes.csv 파일에서 데이터를 읽어온다. 파일 구조는 다음과 같다.
- 당뇨병 데이터이고 마지막 열의 값이 양성이냐 음성이냐를 나타내는 0, 1 값이다.

```
-0.294118,0.487437,0.180328,-0.292929,0,0.00149028,-0.53117,-0.0333333,0
-0.882353,-0.145729,0.0819672,-0.414141,0,-0.207153,-0.766866,-0.666667,1
-0.0588235,0.839196,0.0491803,0,0,-0.305514,-0.492741,-0.633333,0
-0.882353,-0.105528,0.0819672,-0.535354,-0.777778,-0.162444,-0.923997,0,1
...
```

## 2. 코드

```py
import tensorflow as tf
import numpy as np

xy = np.loadtxt('diabetes.csv', delimiter=',', dtype=np.float32)
x_data = xy[:, 0:-1]
y_data = xy[:, [-1]];

X = tf.placeholder(tf.float32, shape=[None, 8])
Y = tf.placeholder(tf.float32, shape=[None, 1])

W = tf.Variable(tf.random_normal([8, 1], name='weight'))
b = tf.Variable(tf.random_normal([1], name='bias'))

hypothesis = tf.sigmoid(tf.matmul(X, W) + b)

cost = -tf.reduce_mean(Y*tf.log(hypothesis) + (1-Y)*tf.log(1-hypothesis))

a = tf.Variable(0.1)
optimizer = tf.train.GradientDescentOptimizer(a)
train = optimizer.minimize(cost)

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    for step in range(10001):
        cost_val, _ = sess.run([cost, train], feed_dict={X: x_data, Y: y_data})
        if step % 200 == 0:
            print(step, cost_val)

    h, c, a = sess.run([hypothesis, predicted, accuracy],
                       feed_dict={X: x_data, Y: y_data})
    print("\nHypothesis: ", h, "\nCorrect (Y): ", c, "\nAccuracy: ", a)
```

- `W`는 `x_data`의 행 개수만큼 만들어준다 그래야 행렬 간 곱셈이 가능한 꼴이 된다.
- `hypothesis`는 `H(X) = 1 / 1 + e^(-WT*X+b)` 식을 tensorflow의 함수인 `tf.sigmoid`를 이용한다.
- `cost`는 cost function을 각 케이스별로 계산해서 평균을 구한 값이다. cost function은 `C(z, y) = -y*log(z) - (1-y)*log(1-z)` 식을 구현한 것이고 cost는 여기다 reduce_mean 함수를 추가로 사용했다.
- 이후론 linear regression과 동일
