# #58 Multiplication Tables

row, col 값을 매개변수로 받아서 r*c 어레이를 만든다. 첫 행은 1부터 row까지의 값이고 두, 세번째 행들은 2, 3을 곱한 값이면 된다.

## 1. 내 코드

```py
def multiplication_table(row,col):
  result = []
  for r in range(row):
    result.append([(r+1)*(c+1) for c in range(col)])
  return result
```

## 2. 다른 해답

```py
def multiplication_table(row,col):
    return [[(i+1)*(j+1) for j in range(col)] for i in range(row)]
```

for 문을 중첩해서 써서 바로 리턴했다.
