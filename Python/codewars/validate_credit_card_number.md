# #11 Validate Credit Card Number
신용카드 계좌 검증 알고리즘이다.

- 뒤에서 2번째 자리부터 2개 간격으로 2배를 한다. 즉 1234->2264, 342->382
- 만약 2배를 했을 때 10 이상이라면 각 자리수를 더하든지, 9를 뺸다.
- 새롭게 만들어진 수의 각 자리수를 모두 합했을 때 0이면 True.

## 1. 내 코드
다른 코드들과 꽤 비슷하게 했다. 다른 사람들 코드를 보니 xrange가 아니라 그냥 range도 start, stop, step을 지정할 수 있다는걸 알았다. 그래도 xrange가 큰 리스트를 다룰 때 메모리 사용은 더 좋다고 한다.

- 리스트에서 가장 마지막 원소의 인덱스는 -1이기도 하다. xrange로 2부터 2칸씩 뛰어가며 반복을 했고, 인덱스로 활용할 땐 -1을 곱해줬다.(다른 해답 보면서 -2씩 스텝을 음수로 지정할 수도 있구나 알게됨)
- 2배를 한 숫자만 10 이상일 가능성이 있으므로(나머지 자리수는 체크 안해도 됨) 반복문 내에서 바로 조건문으로 분기해서 9를 빼줬다.
- sum 함수로 숫자리스트의 합을 구하고, 0인지 아닌지에 대해 연산자 활용해서 바로 리턴했다.

```python
def validate(n):
    num_list = [int(i) for i in str(n)]
    for i in xrange(2, len(num_list)+1, 2):
        num_list[i*-1] *= 2
        if num_list[i*-1] >= 10:
            num_list[i*-1] -= 9
    result = sum(num_list)
    return result % 10 == 0
```

## 2. 다른 해답

### A. 최고 득표 해답. map.
문자열이 리스트라는 점과 map을 써서 코드를 크게 줄였다. xrange에서 전체 길이에서 -2를 뺀 값으로 뒤에서 두 번째 원소를 구했고, -2씩 다음 수로 넘어갔다. 해당 자리수를 2배한 후 문자열로 바꿔서 원소마다 정수로 다시 명시적 변환했다. 이 리스트의 합을 다시 sum으로 구해서 해당 원소값에 넣었다. if 문으로 10 이상인지 확인하는게 더 나을지, 10 이상이든 아니든 이 해답처럼 모두 같은 처리를 해주는게 더 나을지는 잘 모르겠다.

```python
def validate(n):
    digits = [int(x) for x in str(n)]
    for x in xrange(len(digits)-2, -1, -2):
        digits[x] = sum(map(int, str(digits[x] * 2)))
    return sum(digits) % 10 == 0
```

### B. enumerate, extended slices, reversed
대부분 위 세 함수를 사용했다. 그리고 해답 중 너무 과하게 한 줄로 줄이려고 하는 코드는 가독성이 안좋아서 제외했다.

- enumerate: for index, element in enumerate(iterable_thing) 이런식으로 괄호 안에 iterable 객체를 넣어주고 for문을 사용하면 객체의 인덱스와 값을 한 번에 뽑아낼 수 있다. 두 개 변수로 안 받고 한 개로 받으면 두 개 값이 들어간 튜플이 리턴된다.
- extended slices: iterable 바로뒤에 [n:n:n] 이런식으로 숫자를 넣어주면 된다. 시작과 끝이 들어가는 기본 슬라이싱에 세 번째로 step이 더 들어간 것이다. [1:10:3]이면 1부터 10(미포함)까지 3칸씩 점프해서 리턴해라는 의미다. 만약에 0부터 20까지 리스트였다면 [1, 4, 7]이 리턴될 것. [::-2] 이렇게 적으면 맨 뒤에서부터 2칸씩 뒤로 간다. '[1, 2, 3, 4, 5, 6][::-2]'라면 [6, 4, 2]다.
- reversed(iterable) 형태로 사용하면 순서가 바뀐다. reverse가 아니라 reversed라는 것 기억해둬야겠다.

```python
def validate(n):
    list = []
    for index, number in enumerate(reversed(str(n))):
        list.append(int(number) * 2 if index % 2 != 0 else int(number))        
    return sum([digit - 9 if digit > 9 else digit for digit in list]) % 10 == 0
```
