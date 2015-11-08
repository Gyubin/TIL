# #22 Did I finish my Sudoku?

이차원 배열 형태로 스도쿠 정보를 입력 받아서 올바른지 검증하는 것이다. 각각 9개인 region과 row, column들이 중복은 없는지, 1-9까지 모든 숫자가 있는지 확인하면 된다. 지금까지 풀었던 문제 중 최고로 나를 힘들게 했다. 하드코딩 안하려고 반복문 짜는게 너무 어려웠다.

## 1. 내 해답

- 1부터 9까지 다 들어있는지 확인
    + 비교하기 위해 완전한 세트를 만들었다.
    + row는 하나의 리스트로 바로 뽑아낼 수 있는데 column은 그렇게 안되서 board를 transpose 시켰다. `zip(*board)` 하면 transpose 되더라.
    + region을 반복문으로 구현하는게 가장 힘들었다. 차라리 하드코딩하는게 더 낫겠다 싶을 정도로. 겨우 어거지로 구현했다. 각 region의 원소들을 하나의 리스트로 담았다. row, col을 리스트로 뽑은 것처럼.
    + row, col, region 하나하나를 반복문 돌려서 완전한 세트와 비교해서 같은지 비교했다. 만약 다르면 틀리다고 리턴했다.
- 중복인지 확인
    + 0번 인덱스는 1에서 8번 인덱스까지 비교해야하지만, 6번 인덱스는 7번과 8번 인덱스만 비교하면 된다. 앞쪽 인덱스는 이미 비교했으므로. 그런식으로 반복문을 짰다. 만약 row, col, region에서 같은게 하나라도 있으면 다시하라고 리턴했다.
- 위 테스트를 모두 통과하면 마지막에 완료 문구를 출력했다.

```python
def done_or_not(board): #board[i][j]
    perfect_set = set([1, 2, 3, 4, 5, 6, 7, 8, 9])
    reverse = zip(*board)
    region = [[], [], [], [], [], [], [], [], []]
    for i in range(9):
        index = (i / 3) * 3
        for j in range(0, 9, 3):
            region[index].extend(board[i][j:j+3])
            index += 1
    
    for i in range(0, 9):
        if set(board[i]) != perfect_set or set(reverse[i]) != perfect_set or set(region[i]) != perfect_set:
            return 'Try again!'
        if i == 8: break
        for j in range(i+1, 9):
            if board[i] == board[j] or reverse[i] == reverse[j] or region[i] == region[j]:
                return 'Try again!'

    return 'Finished!'

# Finished가 출력되어야 한다.
print(done_or_not([[1, 3, 2, 5, 7, 9, 4, 6, 8]
                  ,[4, 9, 8, 2, 6, 1, 3, 7, 5]
                  ,[7, 5, 6, 3, 8, 4, 2, 1, 9]
                  ,[6, 4, 3, 1, 5, 8, 7, 9, 2]
                  ,[5, 2, 1, 7, 9, 3, 8, 4, 6]
                  ,[9, 8, 7, 4, 2, 6, 5, 3, 1]
                  ,[2, 1, 4, 9, 3, 5, 6, 8, 7]
                  ,[3, 6, 5, 8, 1, 7, 9, 2, 4]
                  ,[8, 7, 9, 6, 4, 2, 1, 5, 3]]))
```

## 2. 최고 득표 해답

- 이 사람도 내가 reverse를 만든 것처럼 board를 transpose 시켰다. 나처럼 zip을 쓴 대신 리스트 내포와 map 함수를 사용했다.
- 리스트 내포로 리전을 만들었다. 내가 좀 더 반복을 활용한듯.
- 세트로 만들어서 길이가 9인지 확인했다. 그런데 만약 1에서 8까지 있고 9가 아니라 10이 들어가있는 경우에도 길이는 9가 아닌가. 이 문제 때문에 나는 완전한 세트를 만들어서 비교했다.
- 중복도 체크하지 않았다. 스도쿠 자체 특성이 길이가 9인 것만 확인하면 중복과 다른 숫자 포함되는 문제는 자연스레 해결되는 종류의 게임일 수도 있다. 하지만 이런 가능성이 있는지 없는지 확인 안됐는데 이렇게만 체크했다면 잘못된 답이 아닐까.

```python
def done_or_not(board):
  rows = board
  cols = [map(lambda x: x[i], board) for i in range(9)]
  squares = [
    board[i][j:j + 3] + board[i + 1][j:j + 3] + board[i + 2][j:j + 3]
      for i in range(0, 9, 3)
      for j in range(0, 9, 3)]
    
  for clusters in (rows, cols, squares):
    for cluster in clusters:
      if len(set(cluster)) != 9:
        return 'Try again!'
  return 'Finished!'
```
