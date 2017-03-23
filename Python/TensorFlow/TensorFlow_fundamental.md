# TensorFlow 기초

## 0. 설치

참고 사이트: [공식문서](https://www.tensorflow.org/install/install_mac), [Mistobaan's gist](https://gist.github.com/Mistobaan/dd32287eeb6859c6668d), [srikanthpagadala blog](https://srikanthpagadala.github.io/notes/2016/11/07/enable-gpu-support-for-tensorflow-on-macos)

### 0.1 요구 조건

- TensorFlow GPU 버전으로 설치할 것이다. 다행히 맥북 GPU의 CUDA Compute Capability가 최저 기준인 3.0이었다.

    ```
    MacBook Pro (Retina, 15-inch, Early 2013)
    OS: macOS Sierra 10.12.3
    CPU: 2.4 GHz Intel Core i7
    메모리: 8GB 1600 MHz DDR3
    그래픽: NVIDIA GeForce GT 650M 1024 MB
            Intel HD Graphics 4000 1536 MB
    ```

- GPU 버전으로 이용하려면 TensorFlow 라이브러리 외에 다음을 갖춰야한다.
    + CUDA Toolkit 8.0
    + The NVIDIA drivers associated with CUDA Toolkit 8.0
    + cuDNN library v5.1
    + CUDA Compute Capability가 3.0 이상

### 0.2 CUDA 설치

```sh
# 설치 명령어
brew update && brew upgrade
brew install coreutils swig
brew cask install cuda
```

위 명령어로 cuda를 설치한 후 `brew cask info cuda` 명령어로 버전을 확인해본다. 나는 다음 결과를 얻었다.

```sh
cuda: 8.0.55
https://developer.nvidia.com/cuda-zone
/usr/local/Caskroom/cuda/8.0.55 (23 files, 1.3G)
From: https://github.com/caskroom/homebrew-cask/blob/master/Casks/cuda.rb
==> Name
Nvidia CUDA
==> Artifacts
```

### 0.3 NVIDIA cuDNN

- 먼저 [공식 홈페이지](https://developer.nvidia.com/cudnn)로 들어가서 **Register**한다. 여러가지 설문 조사를 해야할 것이 많다.
- 로그인 후 다시 공홈으로 가서 **Download** 버튼을 누르면 해당 라이브러리를 다운받을 수 있다.
- 아래 명령어로 압축을 풀고, cuda 디렉토리로 라이브러리 파일들을 옮긴다.

```sh
tar xzvf ~/Downloads/cudnn-7.5-osx-x64-v5.0-rc.tgz
sudo mv -v cuda/lib/libcudnn* /usr/local/cuda/lib
sudo mv -v cuda/include/cudnn.h /usr/local/cuda/include
```

### 0.4 dynamic loading

- 파이썬 스크립트로 라이브러리를 로딩하기 위해서 alias가 필요하다.

    ```sh
    export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:$DYLD_LIBRARY_PATH
    ```

- 이건 옵션이다. 내 경우는 TensorFlow가 위 디렉토리에서 `libcuda.dylib` 파일을 찾아야하는데 `libcuda.1.dylib` 파일을 찾기 때문에 segmentation fault가 계속 발생했다. 아래처럼 링크를 걸어준다.

    ```sh
    sudo ln -s /usr/local/cuda/lib/libcuda.dylib /usr/local/cuda/lib/libcuda.1.dylib
    ```

### 0.5 TensorFlow 설치

- TensorFlow 공홈에서 virtualenv를 활용하는 것을 권장했다.
- 가상환경을 만들고 버전은 Python3으로 한다.
- `pip3 install --upgrade tensorflow-gpu` 명령어로 설치한다.
- 다음 코드로 `test.py` 파일을 만들고 실행한다.

    ```py
    import tensorflow as tf
    hello = tf.constant('Hello, TensorFlow!') # Create a Constant operator
    sess = tf.Session()
    print sess.run(hello)
    ```

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
