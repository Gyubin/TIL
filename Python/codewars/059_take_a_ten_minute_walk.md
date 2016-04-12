# #59 Take a Ten Minute Walk

동서남북 방향을 가리키는 원소들이 들어있는 배열을 입력받는다. 한 번 이동할 때 1분이 걸리고 현재 10분의 여유 시간이 있는 상태다. 정확히 10분동안 걸어서 다시 원래 지점으로 돌아와야한다. 입력받은 배열대로 움직였을 때 위와 같다면 True, 아니라면 False 리턴한다.

## 1. 내 코드

```py
def isValidWalk(walk):
  if len(walk) != 10: return False
  n, s, e, w = 0, 0, 0, 0
  for c in walk:
    if c == 'n': n += 1
    if c == 's': s += 1
    if c == 'e': e += 1
    if c == 'w': w += 1
  if n == s and e == w: return True
  return False
```

- 처음에 배열의 길이가 10이 아니라면 바로 False 리턴하다.
- n, s, e, w 변수를 만들고, walk 리스트 반복을 돌려서 해당 문자일 때 변수를 +1 한다.
- n과 s가 같고, e와 w가 같으면 본래로 돌아오는 것이므로 True를 리턴한다.

## 2. 다른 해답

```py
def isValidWalk(walk):
    return len(walk) == 10 and walk.count('n') == walk.count('s') and walk.count('e') == walk.count('w')
```

리스트에 붙어있는 count 함수를 활용했다.
