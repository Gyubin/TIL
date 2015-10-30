# #13 Digital Root
자연수를 입력받아서 각 자리수를 더한 값을 리턴하는 함수다. 만약 각 자리수의 합이 10 이상이면 또 같은 작업을 반복한다.

## 1. 내 코드
매개변수로 받은 자연수를 문자열화 해서 각 자리수에 int를 적용하는 map 함수를 사용했다. 10보다 크면 다시 호출하는 형태로 재귀를 활용했다.

```python
def digital_root(n):
    result = sum(map(int, str(n)))
    return result if result < 10 else digital_root(result)
```

## 2. 다른 해답

### A. 최고 득표
내 해답도 꽤 줄인 코드가 아닌가 싶었지만 허를 찔렸다. 특히 처음부터 n이 10보다 작은지 검사를 한다는 측면에서 나보다 훨씬 나은 코드다. 뒤에 map과 sum을 쓴 부분은 나와 똑같다. 멋지다.

```python
def digital_root(n):
    return n if n < 10 else digital_root(sum(map(int,str(n))))
```

### B. 두 번째 득표 but..
이걸 좋은 코드라고 해야할지 모르겠다. 이 코드를 봤을 때 어떻게 동일한 결과가 나오는지 이해할 수가 없었다. 하지만 같은 문제를 더 빠르게 연산해서 해결한다는 점에선 좋은 알고리즘이라고 할 수 있지 않을까. 성능 면에선 더 나을 것이다. sum, map, int, str, if, 재귀 등등을 조합한 것보단. 그래도 난 A 답변이 더 좋다.

```python
def digital_root(n):
    return n%9 or n and 9 
```
