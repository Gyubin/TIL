# TensorFlow 기초

## 1. 기본

- 텐서플로우는 Data Flow Graph라는 것으로 이루어져있다.
- Data Flow Graph는 node와 edge로 구성되어있다.
- Nodes
    + 수학의 **operator**를 뜻한다. 예를 들면 덧셈이나 뺄셈같은.
    + 노드들은 한 CPU에 모두 올라갈 필요가 없기 때문에 분산처리에 용이하다.
- Edges
    + 다차원의 data array를 의미하고 **tensor**라고도 불린다.
    + tensor가 돌아다닌다고 해서 TensorFlow라는 이름이 븥음
- 사용하기
    + `a`, `b`, `c`는 2나 3, 5를 의미하지 않는다. Tensor다.
    + 그래서 아래처럼 c를 바로 출력했을 때 원하는 5 값이 나오지 않는다.
    + 항상 세션에서 `run` 해줘야 원하는 값을 얻을 수 있다.
    + 즉 TensorFlow 사용은 크게 그래프를 Building하는 것과 Running하는 것으로 구분

    ```py
    import tensorflow as tf

    sess = tf.Session()

    a = tf.constant(2)
    b = tf.constant(3)
    c = a + b

    print(c)
    print(sess.run(c))
    ```

## 2. 문법

- Rank: TensorFlow의 차원 개념

| Rank |           Math entity           |                        Python example                        |
|------|---------------------------------|--------------------------------------------------------------|
| 0    | Scalar(magnitude only)          | s = 483                                                      |
| 1    | Vector(magnitude and direction) | v = [1.1, 2.2, 3.3]                                          |
| 2    | Matrix(table of numbers)        | m = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]                        |
| 3    | 3-Tensor(cube of numbers)       | t = [[[2], [4], [6]], [[8], [10], [12]], [[14], [16], [18]]] |
| n    | n-Tensor                        |                                                              |

- 행렬 계산
    + `hypothesis = W * x_data + b` 에서 `x_data`는 Python array
    + TensorFlow의 매트릭스인 W와 곱해지면 자동으로 행렬간 곱셈이 된다.
    + `b`를 더할 때도 일반 Python에서는 문법 오류지만 `b`가 `tf.Variable`이므로 역시 array 각 원소에 `b` 값이 더해진다.
- Placeholder
    + tensor를 만들 때 그 순간 값을 지정하는 것이 아니라 나중에 동적으로 지정해야할 경우가 있다. 이 때 placeholder를 쓴다.
    + `tf.placeholder(type)`: 형태로 선언한다.

    ```py
    a = tf.placeholder(tf.int16)
    b = tf.placeholder(tf.int16)

    add = tf.add(a, b)
    mul = tf.mul(a, b)

    with tf.Session() as sess:
        print("Addition: %i" % sess.run(add, feed_dict={a:2, b:3}))
        print("Multiplication: %i" % sess.run(mul, feed_dict={a:2, b:3}))
    ```

- `tf.Constant`: Constant는 말 그대로 상수값을 의미한다. 한 번 선언한 값은 다시 바뀌지 않는다.
- `tf.Variable`:
    + Variable은 계속 train 하면서 새로운 값을 저장할 때 사용한다.
    + 선언했을 때 초기화가 되지 않기 때문에 사용하기 전에 먼저 `sess.run(tf.global_variables_initializer())` 을 해줘야한다.
