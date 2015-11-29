# #34 Find The Parity Outlier

하나만 빼고 모두 짝수거나 홀수인 리스트를 매개변수로 받는다. 다른 수를 찾는 문제다.

## 1. 내 코드

리스트가 엄청 커질 수 있다고 했다. 하나하나 검사해야하므로 한 번은 무조건 리스트를 처음부터 반복해야 한다. 대신 여러번 반복 안시키도록 노력했다. 첫 세 원소를 검사해서 다수를 차지하는 것이 짝수인지 홀수인지 검사한다. 그리고 처음부터 반복해서 그 반대인 수가 나오면 리턴하는 방식을 취했다.

```python
def find_outlier(integers):
    check = [i % 2 for i in integers[:3]]
    num_mod = 0
    if check.count(0) == 1:
        return integers[check.index(0)]
    elif check.count(1) == 1:
        return integers[check.index(1)]
    else:
        num_mod = check[0]
    for num in integers:
        if num % 2 != num_mod:
            return num
```

## 2. 다른 해답

득표가 가장 많은 답은 따로 없었다. for반복을 한 번만 쓰면서 나보다 더 단순한 방법을 사용한 답을 골랐다.

### A. set의 뺄셈 활용

filter 함수를 사용해서 짝수만 따로 뽑았다. 만약 짝수 리스트의 원소가 1개라면 바로 그 원소를 리턴하고, 만약 아니라면 전체 리스트와, 짝수 리스트를 set으로 만들어서 둘을 뺐다. 그러면 결국 홀수 하나만 남을 것이므로 그것을 리턴하면 된다. set을 활용한 점이 인상깊었다.

```python
def find_outlier(integers):
    even = filter(lambda x: x % 2 == 0, integers)
    return even[0] if len(even) == 1 else list(set(integers) - set(even))[0]
```

### A. 내 방식을 세련되게 바꿈. sorted

sorted을 활용하다니 정말 기가막힌 방식이다. 첫 세 원소를 뽑아서 mod 2를 한 후 그것을 정렬했다. 그러면 어떤 상황에서든(000 111 011 001) 중간 원소는 메인 타입이 된다. 나는 하나하나 if 문을 활용했는데 훨씬 멋진 방식이다.

하지만 마지막 다른 원소를 찾는 과정에서 내 경우엔 중간에 찾아지면 바로 멈추는 방식이지만 이 경우는 무조건 전체 리스트를 모두 반복해야한다. 리스트가 엄청나게 길어질 경우 내 방식이 좀 더 효율적이라 할 수 있다.

```python
def find_outlier(integers):
    main_type = sorted([x%2 for x in integers[:3]])[1]
    return [x for x in integers if x%2!=main_type][0]
```
