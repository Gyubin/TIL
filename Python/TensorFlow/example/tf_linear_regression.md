# Linear regression with TensofFlow

모두의 딥러닝 lab 따라하기

## 1. Single variable regression

### 1.1 기본 형태

```py
import tensorflow as tf

x_train = [1, 2, 3]
y_train = [1, 2, 3]

W = tf.Variable(tf.random_normal([1]), name='weight')
b = tf.Variable(tf.random_normal([1]), name='bias')

hypothesis = W * x_train + b
cost = tf.reduce_mean(tf.square(hypothesis - y_train))

optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.01)
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
- `tf.random_normal(shape, mean=0.0, stddev=1.0, dtype=tf.float32, seed=None, name=None)`
    + 정규분포에서 랜덤값 뽑는 것. `mean`, `stddev`를 정할 수 있고 기본은 0, 1이다.
- `tf.reduce_mean(value)` : 평균 구하기
- `tf.train.GradientDescentOptimizer(learning_rate, use_locking=False, name='GradientDescent')`
    + 클래스다. 클래스를 만들어서 메소드를 호출해서 사용한다.
    + `learning_rate` : Tensor나 float 값을 넣어준다.
- `minimize(loss)` : 위 GradientDescentOptimizer 클래스의 메소드 중 하나
    + `loss`: 최소화할 Tensor
- `init = tf.global_variables_initializer()`, `session.run(init)` : 이건 세션으로 다른 오퍼레이션을 실행하기 전에 먼저 실행해줘야한다.
- 마지막 반복문: 2000번 최적화를 한다. minimize 할 때마다 cost, W, b의 변화값을 살펴보는 것.

### 1.2 Placeholder 사용

```py
import tensorflow as tf

W = tf.Variable(tf.random_normal([1]), name='weight')
b = tf.Variable(tf.random_normal([1]), name='bias')

X = tf.placeholder(tf.float32, shape=[None])
Y = tf.placeholder(tf.float32, shape=[None])

hypothesis = W * X + b
cost = tf.reduce_mean(tf.square(hypothesis - Y))

optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.01)
train = optimizer.minimize(cost)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

for step in range(2001):
    cost_val, W_val, b_val, _ = sess.run([cost, W, b, train], feed_dict={X:[1, 2, 3], Y:[1.1, 2.1, 3.1]})
    if step % 20 == 0:
        print(step, cost_val, W_val, b_val)

print(sess.run(hypothesis, feed_dict={X: [5]}))
print(sess.run(hypothesis, feed_dict={X: [2.5]}))
print(sess.run(hypothesis, feed_dict={X: [1.5, 3.5]}))
```

- 1의 예제와 거의 대부분 같다.
- placeholder를 선언할 때 `shape=[None]` 부분은 어떤 shape이든 올 수 있다는 의미다. 1차원, 2차원 등등
- 다만 처음 hypothesis와 cost 오퍼레이션을 쓸 때 placeholer를 사용하고, 세션에서 run할 때 `feed_dict`로 필요한 데이터를 넣어주면 된다.

### 1.3 Gradient Descent 직접 구현

```py
import tensorflow as tf

x_data = [1., 2., 3.]
y_data = [1., 2., 3.]

W = tf.Variable(tf.random_normal([1]), name='weight')

X = tf.placeholder(tf.float32)
Y = tf.placeholder(tf.float32)

hypothesis = W * X
cost = tf.reduce_sum(tf.square(hypothesis - Y))

learning_rate = 0.1
gradient = tf.reduce_mean((W * X - Y) * X)
descent = W - learning_rate * gradient
update = W.assign(descent)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

for step in range(50):
    sess.run(update, feed_dict = {X:x_data, Y:y_data})
    print(step, sess.run(cost, feed_dict={X:x_data, Y:y_data}), sess.run(W))
```

- `1.1`, `1.2`에서 tensorflow의 함수를 썼던 것을 직접 구현해봄
- descent 부분이 실제 공식을 구현한 것이다.
- 새로 구해진 W, 즉 기울기를 계속 갱신해가면서 여러번 실행하면 원하는 값이 나온다.

### 1.4 라이브러리의 gradient 값 커스텀하기

```py
import tensorflow as tf
tf.set_random_seed(777)  # 랜덤 함수에 seed 넣기

X = [1, 2, 3]
Y = [1, 2, 3]

W = tf.Variable(5.)

hypothesis = X * W
gradient = tf.reduce_mean((W * X - Y) * X) * 2

cost = tf.reduce_mean(tf.square(hypothesis - Y))

optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.01)
train = optimizer.minimize(cost)

gvs = optimizer.compute_gradients(cost)
# gvs = [(tf.clip_by_value(grad, -1., 1.), var) for grad, var in gvs]
apply_gradients = optimizer.apply_gradients(gvs)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

for step in range(100):
    print(step, sess.run([gradient, W, gvs]))
    sess.run(apply_gradients)
```

- 1.2의 코드는 알고리즘을 적용한 것을 바로 사용했다. 라이브러리를 통해 계산된 값을 우리가 임의로 수정해서 사용할 수 있다.
- `gvs = optimizer.compute_gradients(cost)` 이렇게 optimizer로부터 gvs를 계산하고, 우리 입맛에 맞게 수정하면 된다.
- `apply_gradients = optimizer.apply_gradients(gvs)` 수정된 값을 적용한다.

## 2. Multi variable regression

### 2.1 Matrix 사용

```py
import tensorflow as tf

x_data = [[1., 1., 1., 1., 1.],
          [1., 0., 3., 0., 5.],
          [0., 2., 0., 4., 0.]]
y_data = [1, 2, 3, 4, 5]

W = tf.Variable(tf.random_normal([1, 3], name="weight"))

hypothesis = W * x_data
cost = tf.reduce_mean(tf.square(hypothesis - y_data))

optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.1)
train = optimizer.minimize(cost)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

for step in range(701):
    sess.run(train)
    if step % 100 == 0:
        print(step, sess.run(cost), sess.run(W))
```

- `x_data`의 첫 번쨰 행, 즉 첫 번째 벡터는 모두 1의 값을 가진다. 즉 `b`를 의미한다. 그래서 `W`의 형태도 원소가 3개임을 알 수 있다. 첫 번째 b, 그리고 x1, x2 해서 세 개이다.
- 나머지는 single variable regression과 같다.

### 2.2 Matrix 사용예 2

```py
import tensorflow as tf

x_data = [[73., 80., 75.], [93., 88., 93.],
          [89., 91., 90.], [96., 98., 100.], [73., 66., 70.]]
y_data = [[152.], [185.], [180.], [196.], [142.]]

X = tf.placeholder(tf.float32, shape=[None, 3])
Y = tf.placeholder(tf.float32, shape=[None, 1])

W = tf.Variable(tf.random_normal([3, 1]), name='weight')
b = tf.Variable(tf.random_normal([1]), name='bias')

hypothesis = tf.matmul(X, W) + b
cost = tf.reduce_mean(tf.square(hypothesis - Y))

optimizer = tf.train.GradientDescentOptimizer(learning_rate=1e-5)
train = optimizer.minimize(cost)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

for step in range(2001):
    cost_val, hy_val, _ = sess.run(
        [cost, hypothesis, train], feed_dict={X: x_data, Y: y_data})
    if step % 10 == 0:
        print(step, "Cost: ", cost_val, "\nPrediction:\n", hy_val)
```

### 2.3 Queue runner

![queue-runner](https://www.tensorflow.org/images/AnimatedFileQueues.gif)

> 사진 출처: [TensorFlow 공식문서](https://www.tensorflow.org/programmers_guide/reading_data#creating_threads_to_prefetch_using_queuerunner_objects)

대용량의 파일을 처리할 때 메모리 부족으로 실행이 안되는 경우가 있다. 그래서 TensorFlow의 Queue runner는 파일을 큐에 쌓고, 작업한 다음, 결과물을 다시 큐에 담아서 쓰도록 해준다.

#### 2.3.1 데이터

```
73,80,75,152
93,88,93,185
89,91,90,180
96,98,100,196
73,66,70,142
53,46,55,101
69,74,77,149
47,56,60,115
87,79,90,175
79,70,88,164
69,70,73,141
70,65,74,141
93,95,91,184
79,80,73,152
70,73,78,148
93,89,96,192
78,75,68,147
81,90,93,183
88,92,86,177
78,83,77,159
82,86,90,177
86,82,89,175
78,83,85,175
76,83,71,149
96,93,95,192
```

#### 2.3.2 코드

```py
import tensorflow as tf

filename_queue = tf.train.string_input_producer(
    ['data-01-test-score.csv'], shuffle=False, name='filename_queue')

reader = tf.TextLineReader()
key, value = reader.read(filename_queue)

record_defaults = [[0.], [0.], [0.], [0.]]
xy = tf.decode_csv(value, record_defaults=record_defaults)

tr_x_batch, tr_y_batch = tf.train.batch([xy[0:-1], xy[-1:]], batch_size=10)

X = tf.placeholder(tf.float32, shape=[None, 3])
Y = tf.placeholder(tf.float32, shape=[None, 1])

W = tf.Variable(tf.random_normal([3, 1]), name='weight')
b = tf.Variable(tf.random_normal([1]), name='bias')

hypothesis = tf.matmul(X, W) + b
cost = tf.reduce_mean(tf.square(hypothesis - Y))

optimizer = tf.train.GradientDescentOptimizer(learning_rate=1e-5)
train = optimizer.minimize(cost)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

coord = tf.train.Coordinator()
threads = tf.train.start_queue_runners(sess=sess, coord=coord)

for step in range(2001):
    x_batch, y_batch = sess.run([tr_x_batch, tr_y_batch])
    cost_val, hy_val, _ = sess.run(
        [cost, hypothesis, train], feed_dict={X: x_batch, Y: y_batch})
    if step % 10 == 0:
        print(step, "Cost: ", cost_val, "\nPrediction:\n", hy_val)

coord.request_stop()
coord.join(threads)

print("Your score will be ",
      sess.run(hypothesis, feed_dict={X: [[100, 70, 101]]}))
print("Other scores will be ",
      sess.run(hypothesis, feed_dict={X: [[60, 70, 110], [90, 100, 80]]}))
```

- 다른 것은 다 비슷하고, 데이터를 읽어오는 부분과 사용하는 부분만 달라진다.
- `tr_x_batch, tr_y_batch = tf.train.batch([xy[0:-1], xy[-1:]], batch_size=10)` : 10 사이즈만큼 읽어오는 것
- `coord = tf.train.Coordinator()`, `threads = tf.train.start_queue_runners(sess=sess, coord=coord)` : coordinator, thread 사용
- `x_batch, y_batch = sess.run([tr_x_batch, tr_y_batch])` : batch를 run
