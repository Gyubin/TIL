# #32 Scramblies

성능 이슈가 포함된 문제가 가장 어렵다. 넋놓고 짜면 안된다. 이번 문제는 문자열 2개를 매개변수로 받아서 s1을 재조합하여 s2를 만들어낼 수 있는지 검증하는 문제다.

## 1. 내 코드

###A. 첫 시도

처음엔 아래와 같이 짰다가 6초 제한에 걸렸다. 뭐가 시간을 많이 잡아먹는건가 싶어서 time 모듈을 활용해서 걸리는 시간을 체크해봤더니

- `s1 = list(s1)` : 이건 큰 차이가 없었다. 물론 차이가 있긴 했는데 s1이 20배로 길어져도 경과 시간은 3배만 늘어나는 정도였다.
- `for c in s2` : 문자열이 길어질수록 이 부분에서 시간이 많이 걸렸다. 다른 코드로 문제를 통과한 후 검증 문자열이 뭐였는지 봤더니 수십만? 수백만 글자까지 테스트하던 것 같았다. 여기 for 문에서 시간 초과가 일어났다.

```python
# fail to 6000ms limit
def scramble(s1,s2):
    s1 = list(s1)
    for c in s2:
        if c not in s1:
            return False
        s1.pop(s1.index(c))
    return True
```

### B. 두 번째 시도

문자열이 얼마나 길어질지 몰라서(이 땐 time 모듈로 확인해보지 않았다.) 문자열의 모든 문자를 하나하나 검증하려는 짓은 안하기로 했다. 그래서 s2를 문자와, 문자 개수로 이루어진 dict로 나타내었고, count를 통해서 s1, s2의 문자 개수를 비교했다. 같은 매개변수로 두 코드의 경과시간을 비교했더니 약 4-5배 정도 시간 차이가 났다. 통과했다.

```python
# 3725ms
def scramble(s1,s2):
    s2_dict = {}
    for c in s2:
        if c in s2_dict:
            s2_dict[c] += 1
        else:
            s2_dict[c] = 1
    for k, v in s2_dict.items():
        if s1.count(k) < v:
            return False
    return True
```

## 2. 다른 해답

### A. 최고 득표 해답

기가 막힌다. Counter라는 클래스가 있다는 것을 알고 있었지만 연습삼아 나는 직접 구현했다. 그런데 Counter 객체들 간에 뺄셈이 가능할 줄은 몰랐다. dict 끼리는 직접 뺄셈이 안되는데 Counter 객체끼리는 뺄셈이 가능하다. 아래 코드는 s2에서 s1을 빼서 0이 되는지를 검증했다. 0이 되어야 s2가 s1에 속한다는 것이므로. THUMBS UP!!!

```python
from collections import Counter
def scramble(s1,s2):
    return len(Counter(s2)- Counter(s1)) == 0
```

### B. count 문자열 각각에 활용

내 코드의 업그레이드판이다. s2를 dict로 굳이 만들지 말고 그냥 count 썼더라면 이와 똑같은 답이 됐을 것이다. 크 아쉽다!

```python
def scramble(s1,s2):
    for c in set(s2):
        if s1.count(c) < s2.count(c):
            return False
    return True
```

이 답변도 비슷했다. not any 말고 주석처럼 all 쓰고 부등호 반대로 하는게 더 괜찮았을듯.

```python
def scramble(s1, s2):
    return not any(s1.count(char) < s2.count(char) for char in set(s2))
#   return all(s1.count(char) >= s2.count(char) for char in set(s2))
```
