# #0 파이썬 라이브러리 초기 설치 과정

참고 링크: [fyears' gist](https://gist.github.com/fyears/7601881)

## 1. Homebrew, 가상환경

Homebrew 통해서 Python 3 설치하고, 작업할 가상환경을 만든 후 activate 한다.

## 2. 라이브러리 설치

```sh
pip install -U setuptools
pip install -U pip

pip install numpy
pip install scipy
pip install matplotlib

pip install ipython[all]
pip install patsy
pip install pandas
pip install sympy
pip install nose

pip install statsmodels
pip install zipline # 이건 설치가 잘 안된다.
pip install quandl
pip install scikit-learn
pip install pillow

ipython profile create
ipython qtconsole --matplotlib inline
```

이정도 깔면 웬만한 건 다 깔렸다. 
