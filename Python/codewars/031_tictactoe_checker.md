# #31 Tic Tac Toe Checker

틱택토 게임은 3x3 보드에서 2명이 각각 O, X 기호를 가지고 빙고를 이루는 게임이다. 아직 마크하지 않은 부분은 0, X는 1, O는 2로 리스트에 표시한다. X가 이겼으면 1, O가 이겼으면 2, 비겼으면 0, 아직 덜 끝난 게임이라면 -1을 리턴한다.

## 1. 내 코드

- `zip(*board)`를 하면 transpose가 된다.
- 먼저 raw, col을 뽑아내어 set으로 만들고, 길이가 1이라면 모든 원소가 같다는 의미이므로 이 원소가 1인지, 2인지에 따라서 리턴값을 달리했다.
- 대각선을 각각 구해서 리스트로 만들고 역시 위와 같은 방법으로 리턴했다.
- raw, col, 대각선 모두에서 해당되는 빙고가 없으면 비겼거나, 진행이 덜 됐거나이다. 빙고가 나타나지 않은 상황에선 무조건 마지막 빈칸까지 채운다고 가정하고 0이 보드에 있다면 덜 끝난 것으로 코드를 짰다. -1 리턴.
- 위 상황들에 적용되는 것이 없다면 0을 리턴해서 비긴 것이라고 했다.

```python
def isSolved(board):
    for raw in board:
        if len(set(raw)) == 1:
            if raw[0] == 1: return 1
            if raw[0] == 2: return 2
    for col in zip(*board):
        if len(set(col)) == 1:
            if col[0] == 1: return 1
            if col[0] == 2: return 2
    if len(set([board[0][0], board[1][1], board[2][2]])) == 1:
        if board[0][0] == 1: return 1
        if board[0][0] == 2: return 2
    if len(set([board[0][2], board[1][1], board[2][0]])) == 1:
        if board[0][2] == 1: return 1
        if board[0][2] == 2: return 2
    for raw in board:
        if 0 in raw: return -1
    return 0
```

## 2. 다른 코드

### A. 최고 득표

- board에서 반복문을 돌리는 것이 아니라 range를 이용해서 반복했다. 그래서 raw, col을 한 개의 반복문 만을 활용해서 검사할 수 있었다. 나와 다른 부분. 이게 더 낫다.
- 조건 연산에서 `==`와 `!=`를 이용해서 네 개의 값을 연결시켰다. 이게 되는지 안되는지 긴가민가했었는데 되는구나. 기억해두자.
- 리턴값을 board의 원소값으로 했다. 나처럼 먼저 조건 연산을 할 필요가 없었다.
- 나머지 코드는 나와 똑같다.

```python
def isSolved(board):
  for i in range(0,3):
    if board[i][0] == board[i][1] == board[i][2] != 0:
      return board[i][0]
    elif board[0][i] == board[1][i] == board[2][i] != 0:
      return board[0][i]
      
  if board[0][0] == board[1][1] == board[2][2] != 0:
    return board[0][0]
  elif board[0][2] == board[1][1] == board[2][0] != 0:
    return board[0][0]

  elif 0 not in board[0] and 0 not in board[1] and 0 not in board[2]:
    return 0
  else:
    return -1
```

### B. 함수 적극 활용 답안

이렇게까지 함수를 사용해야하나 싶지만 뭔가 좋아보인다. 깔끔하다. 아직 많은 코드를 보지 못해서 좋다 나쁘다 판단을 못내리겠지만 왠지 이렇게 짜는게 맞는 것 같다. 주석으로 코드 해석을 달았다.

```python
# 매개변수: func(함수다), xs(board의 라인들을 담고 있는 리스트다.
# reduce 사용. xs에서 원소를 하나씩 빼서 이전 결과값과 연산한다. initializer가 False이므로 첫 번째 원소는 False와 연산한다. 연산은 '이전 결과값과 매개변수로 받은 함수에 원소를 넣은 값을 or 연산하는 것이다.
# 한 마디로 xs의 원소들을 func에 넣은 리턴값이 하나라도 True이면 True를 리턴하는 함수다.
def some(func, xs): 
    return reduce(lambda x,y: x or func(y), xs, False)

# some 함수와 대부분 같다. 연산에 and인 점과, 초기값이 True라는 점만 다르다.
# 한 마디로 xs의 원소들을 func에 넣은 리턴값이 모두 True여야 True를 리턴하는 함수다.
def every(func, xs): 
    return reduce(lambda x,y: x and func(y), xs, True)

# 매개변수: player(x인지 O인지 판별), line(라인들이 아니라 라인 하나를 의미)
# line도 숫자 세 개를 가지고 있는 리스트라서 every 함수를 내부에 호출해서 사용했다.
# 리스트의 모든 원소가 플레이어를 나타내는 숫자와 일치해야 한다.
def wins(player, line): 
    return every(lambda x: x == player, line)

def isSolved(board):
    rows = board          # 행 3개 뽑아내고
    cols = zip(*board)    # 열 3개 뽑아내고
    diag = [board[i][i] for i in range(3)]    # 좌측상단-우측하단 대각선
    anti = [board[i][2-i] for i in range(3)]  # 우측상단-좌측하단 대각선

    # 하나의 리스트에 행, 열, 대각선을 의미하는 리스트들을 담는다.
    lines = rows + cols + [diag, anti]

    # 1이냐 2냐는 플레이어를 의미하고 각각 x, o다.
    # 라인들이 담겨있는 lines에서 한 줄씩 뽑아내어 플레이어가 이길 조건인지를 wins를 통해 판별한다.
    # 이기는 경우가 하나라도 있으면 그 플레이어가 이긴 것이므로 some으로 묶는다.
    for i in (1,2):
        if some(lambda line: wins(i, line), lines):
            return i

    # 만약 누구도 이긴 경우가 없을 경우 아래 코드가 실행된다.
    # 하나라도 라인에 0이 있다면 True이므로 조건문으로 들어가서 -1을 리턴한다.
    # 만약 0이 없다면. 0을 리턴해서 비겼음을 알린다.
    if some(lambda line: some(lambda y: y == 0, line), lines):
        return -1
    else:
        return 0
```

### C. 가장 마음에 든 답안

- 기가 막힌다. 멋지다.
- [1, 1, 1], [2, 2, 2]를 만들고 전체에 이게 포함되어있는지 살폈다. 있으면 그 원소 값을 리턴하면 된다.
- itertools 모듈의 chain을 쓸 필요 없이 `sum(board, [])` 하니까 바로 같은 결과가 나온다. 여기서 0이 있는지 살피고 있으면 -1, 없으면 0을 리턴했다.

```python
def isSolved(board):
    for sign in [1, 2]:
        win = [sign] * 3
        if (win in board or
            win in zip(*board[::-1]) or
            win in [[board[x][0], board[1][1], board[2-x][2]] for x in [0, 2]]):
                return sign
    return -1 if 0 in sum(board, []) else 0
```
