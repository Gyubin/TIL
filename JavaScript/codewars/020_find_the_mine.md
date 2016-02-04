# #20 Find the Mine

array가 들어있는 array, 즉 2차원 배열을 입력받아서 1의 위치를 row, col 값으로 리턴하는 문제다.

## 1. 내 코드

```js
function mineLocation(field){
  for (var i = 0; i < field.length; i++) {
    for (var j = 0; j < field[0].length; j++) {
      if (field[i][j] === 1) return [i, j];
    }
  }
}
```

for 중첩해서 i, j를 바로 리턴했다. 다른 해답들과 같은 코드.
