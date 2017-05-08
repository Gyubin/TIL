# XOR with Neural Network

## 0. 데이터

```
#XOR
# X1 X2 Y
0 0 0
0 1 1
1 0 1
1 1 0
```

## 1. 선형으로 풀기(불가능)

```py
import tensorflow as tf
import numpy as np

xy = np.loadtxt('xor_dataset.txt')
x_data = xy[0:, 0:2]
y_data = xy[0:, 2:]

X = tf.placeholder(tf.float32)
Y = tf.placeholder(tf.float32)

################################################################
### 이 부분만 바뀐다.
################################################################
W = tf.Variable(tf.random_uniform([1, len(x_data)], -1.0, 1.0))

h = tf.matmul(W, X)
hypothesis = tf.div(1., 1 + tf.exp(-h))
################################################################

cost = -tf.reduce_mean(Y*tf.log(hypothesis) + (1-Y)*tf.log(1-hypothesis))

a = tf.Variable(0.01)
optimizer = tf.train.GradientDescentOptimizer(a)
train = optimizer.minimize(cost)

init = tf.global_variables_initializer()

with tf.Session() as sess:
    sess.run(init)
    
    for step in range(1001):
        sess.run(train, feed_dict={X:x_data, Y:y_data})
        if step % 200 == 0:
            print(step, sess.run(cost, feed_dict={X:x_data, Y:y_data}), sess.run(W))
    
    correct_prediction = tf.equal(tf.floor(hypothesis + 0.5), Y)
    
    accuracy = tf.reduce_mean(tf.cast(correct_prediction, "float"))
    print(sess.run([hypothesis, tf.floor(hypothesis+0.5), correct_prediction, accuracy], feed_dict={X:x_data, Y:y_data}))
    print("Accuracy:", accuracy.eval({X:x_data, Y:y_data}))
```

- 단순한 선형으로 풀기는 불가능하다.
- 역시 기본적인 것들은 이전의 regression과 비슷하다.
    + X, Y placeholder를 사용해서 데이터를 동적으로 입력받을 수 있다.
    + cost는 cross-entropy를 활용한다.
    + learning rate를 정해서 tensorflow의 Gradient descent 알고리즘으로 학습한다.
    + 1000번 학습을 하고 cost와 W 값을 찍어본다.
    + 결국 0 또는 1이므로 hypothesis 값에 0.5를 더해서 "버림"하면 1 또는 0이 나올 것이다. 이걸로 맞는지 틀린지 accuracy 값을 계산한다.
- 학습을 아무리 해도 값이 accuracy는 0.5가 나올 수 밖에 없다.

## 2. NN으로 풀기

```py
# 바뀌는 부분 "1.선형" 코드 참조

W1 = tf.Variable(tf.random_uniform([2, 2], -1.0, 1.0))
W2 = tf.Variable(tf.random_uniform([2, 1], -1.0, 1.0))

b1 = tf.Variable(tf.zeros([2]), name="Bias1")
b2 = tf.Variable(tf.zeros([1]), name="Bias2")

L2 = tf.sigmoid(tf.matmul(X, W1) + b1)
hypothesis = tf.sigmoid(tf.matmul(L2, W2) + b2)
```

- 레이어를 하나 더 추가해서 2개로 XOR을 풀어본다.
- 코드 바뀌는건 어렵지 않다. 기존에 W 하나만 쓰던 것을 W1, W2로 나누고, bias도 두 개 쓴다.
- 그래서 L2를 따로 만들어서 레이어를 구분해준다. hypothesis에서 L2를 사용하는 방식으로 둘을 연결한다.
- 여기서 W1, W2의 shape은 서로 matrix multiply가 적용될 수 있어야한다. 위 예제에는 `[2, 2]`, `[2, 1]` 형태인데 2로 같다.
- Wide NN: 단순히 2개가 아니라 다량의 원소를 사용한다.
    + `[2, 10]`, `[10, 1]`: W1, W2의 연결되는 값들은 똑같이 맞춰주되 숫자를 늘인다.
    + bias의 값도 바꿔준다. 위 경우엔 b1은 10, b2는 1이 된다.

## 3. Deep NN for XOR

```py
# 바뀌는 부분 "1.선형" 코드 참조

W1 = tf.Variable(tf.random_uniform([2, 5], -1.0, 1.0))
W2 = tf.Variable(tf.random_uniform([5, 4], -1.0, 1.0))
W3 = tf.Variable(tf.random_uniform([4, 1], -1.0, 1.0))

b1 = tf.Variable(tf.zeros([5]), name="Bias1")
b2 = tf.Variable(tf.zeros([4]), name="Bias2")
b3 = tf.Variable(tf.zeros([1]), name="Bias3")

L2 = tf.sigmoid(tf.matmul(X, W1) + b1)
L3 = tf.sigmoid(tf.matmul(L2, W2) + b2)
hypothesis = tf.sigmoid(tf.matmul(L3, W3) + b3)
```

- 위 2.의 NN에서는 레이어가 2개였다. 레이어를 더 추가하게 되면 Deep NN이 된다.
- Deep and Wide할수록 성능이 좋아진다.
