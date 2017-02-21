# Linear regression with TensofFlow

모두의 딥러닝 lab 따라하기

## 1. 일반

```py
import tensorflow as tf

x_data = [1, 2, 3]
y_data = [1, 2, 3]

W = tf.Variable(tf.random_uniform([1], -1.0, 1.0))
b = tf.Variable(tf.random_uniform([1], -1.0, 1.0))

hypothesis = W * x_data + b
cost = tf.reduce_mean(tf.square(hypothesis - y_data))

a = tf.Variable(0.1)
optimizer = tf.train.GradientDescentOptimizer(a)
train = optimizer.minimize(cost)

init = tf.global_variables_initializer()

sess = tf.Session()
sess.run(init)

for step in range(2001):
    sess.run(train)
    if step % 20 == 0:
        print(step, sess.run(cost), sess.run(W), sess.run(b))
```

- `tf.random_uniform(shape, minval=0, maxval=None, dtype=tf.float32, seed=None, name=None)`
    + `shape`: 1차원 벡터로 몇 개의 랜덤값을 내보낼지 정한다. `[10]` 형태로 넣어주면 10개를 뽑아낸다.
    + `minVal`, `maxVal`: 최소값, 최대값으로 범위를 나타냄
    + `dtype`: 타입을 지정하는데 기본값은 float다.
    + `seed`: 파이썬 정수형태로 넣어주면 랜덤 수를 만들 때 seed로 사용한다.
- `tf.reduce_mean(value)` : 평균 구하기
- `tf.train.GradientDescentOptimizer(learning_rate, use_locking=False, name='GradientDescent')`
    + 클래스다. 클래스를 만들어서 메소드를 호출해서 사용한다.
    + `learning_rate` : Tensor나 float 값을 넣어준다.
- `minimize(loss)` : 위 GradientDescentOptimizer 클래스의 메소드 중 하나
    + `loss`: 최소화할 Tensor
- `init = tf.global_variables_initializer()`, `session.run(init)` : 이건 세션으로 다른 오퍼레이션을 실행하기 전에 먼저 실행해줘야한다.
- 마지막 반복문: 2000번 최적화를 한다. minimize 할 때마다 cost, W, b의 변화값을 살펴보는 것.

## 2. Placeholder 사용

```py
import tensorflow as tf

x_data = [1, 2, 3]
y_data = [1, 2, 3]

W = tf.Variable(tf.random_uniform([1], -1.0, 1.0))
b = tf.Variable(tf.random_uniform([1], -1.0, 1.0))

X = tf.placeholder(tf.float32)
Y = tf.placeholder(tf.float32)

hypothesis = W * X + b
cost = tf.reduce_mean(tf.square(hypothesis - Y))

a = tf.Variable(0.1)
optimizer = tf.train.GradientDescentOptimizer(a)
train = optimizer.minimize(cost)

init = tf.global_variables_initializer()

sess = tf.Session()
sess.run(init)

for step in range(2001):
    sess.run(train, feed_dict={X: x_data, Y: y_data})
    if step % 20 == 0:
        print(step, sess.run(cost, feed_dict={X: x_data, Y: y_data}), sess.run(W), sess.run(b))

print(sess.run(hypothesis, feed_dict={X: 5}))
print(sess.run(hypothesis, feed_dict={X: 2.5}))
```

- 1의 예제와 거의 대부분 같다.
- 다만 처음 hypothesis와 cost 오퍼레이션을 쓸 때 placeholer를 사용하고, 세션에서 run할 때 `feed_dict`로 필요한 데이터를 넣어주면 된다.
