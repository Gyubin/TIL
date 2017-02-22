# Visualize Cost

hypothesis 식에서 "W 값에 따른 Cost 값의 변화"를 그래프로 나타내본다.

```py
import tensorflow as tf
from matplotlib import pyplot as plt

X = [1., 2., 3.]
Y = [1., 2., 3.]
m = n_samples = len(X)

W = tf.placeholder(tf.float32)

hypothesis = tf.multiply(X, W)

cost = tf.reduce_sum(tf.pow(hypothesis - Y, 2)) / m

init = tf.global_variables_initializer()

W_val = []
cost_val = []

sess = tf.Session()
sess.run(init)

for i in range(-30, 50):
    print(i * 0.1, sess.run(cost, feed_dict={W : i * 0.1}))
    W_val.append(i * 0.1)
    cost_val.append(sess.run(cost, feed_dict={W : i * 0.1}))
    
plt.plot(W_val, cost_val, 'ro')
plt.ylabel('Cost')
plt.xlabel('W')
plt.show()
```

- hypothesis는 선형식이고 상수항이 없는 `W * X`다. 이 때 W는 계속 값을 바꿔보기 위해 placeholder를 사용한다.
- cost는 hypothesis 식에 실제 값인 Y를 빼서 제곱해서 모두 더한 값이다. 전체 샘플 수로 나눠준다.
- -3에서 -5까지 0.1 간격으로 W 값을 집어넣어서 cost를 구한다.
- W, cost 값들을 x, y 축으로 넣고 그래프를 그린다.
    + `pyplot.plot` 함수는 매개변수로 2개를 넣으면 x, y 값이고, 하나만 넣으면 y다.
    + 값들을 하나를 넣든, 두 개를 넣든 뒤에 문자열로 'bo', 'r+' 등을 넣어주면 표시되는 점의 형태를 정할 수 있다. 앞 이니셜이 색, 뒤가 기호모양이다.
