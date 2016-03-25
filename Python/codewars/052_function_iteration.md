# #52 Function iteration

함수와 n(횟수)을 매개변수에 넣으면 그 함수를 n번 실행한 결과를 내놓는 새로운 함수를 리턴하게 하는 문제다.

## 1. 내 코드

```py
def create_iterator(func, n):
  def nth_iterator(num):
    for i in range(n):
      num = func(num)
    return num
  return nth_iterator
```

- 클로저 개념으로 처음 입력받은 n 값을 사용했고, for 문으로 함수를 여러번 호출했다. 마지막에 함수 리턴.

## 2. 다른 해답

```py
def create_iterator(func, n):
  if n == 1: return func
  return lambda x : func(create_iterator(func, n-1)(x))
```

- for문 대신 재귀 용법을 썼다.
- n이 1이면 바로 리턴하면 되고, 아니라면 create_iterator 함수를 func의 매개변수에 넣어서 재 호출했다.
- 즉 func(func(func(func(x)))) 이런식으로 중첩 호출되는 방식이다.
