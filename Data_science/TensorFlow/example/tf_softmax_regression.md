# Softmax regression

## 1. 데이터

```
# x0 x1 x2 y[A  B  C]
  1  2  1    0  0  1
  1  3  2    0  0  1
  1  3  4    0  0  1
  1  5  5    0  1  0
  1  7  5    0  1  0
  1  2  5    0  1  0
  1  6  6    1  0  0
  1  7  7    1  0  0
```

- 위 데이터 파일을 `np.loadtxt` 함수를 통해 읽어올 것이다.
- `x0`은 bias term이고 모두 1이다.
- `x1`, `x2`가 공부한 시간과 출석일수를 의미하는 feature다.

## 2. 코드

```py
import numpy as np
import tensorflow as tf

xy = np.loadtxt('train2.txt', unpack=True, dtype='float32')
x_data = np.transpose(xy[0:3])
y_data = np.transpose(xy[3:])

X = tf.placeholder("float", [None, 3])
Y = tf.placeholder("float", [None, 3])

W = tf.Variable(tf.zeros([3, 3]))

# matrix shape X=[8, 3], W=[3, 3]
hypothesis = tf.nn.softmax(tf.matmul(X, W))

learning_rate = 0.001

cost = tf.reduce_mean(-tf.reduce_sum(Y * tf.log(hypothesis), reduction_indices=1))
optimizer = tf.train.GradientDescentOptimizer(learning_rate).minimize(cost)

init = tf.global_variables_initializer()

with tf.Session() as sess:
    sess.run(init)

    for step in range(2001):
        sess.run(optimizer, feed_dict={X: x_data, Y: y_data})
        if step % 200 == 0:
            print(step, sess.run(cost, feed_dict={X: x_data, Y: y_data}), sess.run(W))
```

- placeholder에서 데이터 shape을 `[None, 3]`으로 준 것은 3개의 w 값(w0, w1, w2)이 들어오는 것은 알지만 데이터가 총 몇 개 들어올지는 모르기 때문이다. 유동적으로 사용 가능
- `W = tf.Variable(tf.zeros([3, 3]))` : 첫 번째 3은 x가 3개라는 것, 두 번째 3을 클래스가 3개라는 것(A, B, C)을 의미한다.
- `hypothesis = tf.nn.softmax(tf.matmul(X, W))` : 이론에서는 `wT*X`였는데 순서가 바뀌었다. 데이터가 몇 개가 들어오는지 모르는 상황이라서 그냥 편하게 반대로 곱해준거다. `X*W`를 하면 데이터 개수 by 3 shape의 matrix가 나온다. 이게 H(X)이며 y hat이다. 이것을 cost function에 넣어서 계산하면 된다.
- cost function을 통해 계산된 각 데이터의 cost를 평균내면 우리가 원하는 최종 cost가 된다.
- 나머지 알고리즘은 다른 linear regression과 같다. `tf.reduce_mean` 함수의 reduction_indices 매개변수는 몇 차원으로 줄일 것인지를 뜻한다.


## 3. 테스트 해보기

```py
a = sess.run(hypothesis, feed_dict={X: [[1, 11, 7]]})
print(a, sess.run(tf.argmax(a, 1)))

b = sess.run(hypothesis, feed_dict={X: [[1, 3, 4]]})
print(b, sess.run(tf.argmax(b, 1)))

c = sess.run(hypothesis, feed_dict={X: [[1, 1, 0]]})
print(c, sess.run(tf.argmax(c, 1)))

all = sess.run(hypothesis, feed_dict={X: [[1, 11, 7], [1, 3, 4], [1, 1, 0]]})
print(all, sess.run(tf.argmax(all, 1)))
```

특정 데이터를 hypothesis에 넣고 결과를 `tf.argmax` 함수를 통해 도출하는 예다. 함수에 배열을 넣고 몇 차원으로 줄일지 정해주면 가장 높은 값을 리턴한다.
