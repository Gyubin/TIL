# 24 Pascal's Triangle

파스칼의 삼각형을 flat array로 리턴하는 문제다. 매개변수로 삼각형 어느 줄까지 뽑을 것인지 정한다. 1이면 [1], 2이면 [1, 1, 1], 3이면 [1, 1, 1, 1, 2, 1] 같은 식이다.

## 1. 내 코드

```js
function pascalsTriangle(n) {
  var result = [];
  for (var i = 0; i < n; i++) {
    result.push.apply(result, get_pascals(i+1));
  }
  return result;
}

function get_pascals(n) {
  if (n === 1) return [1];
  var result = [1];
  var upper = get_pascals(n-1);
  for (var i = 1; i < n-1; i++) {
    if (!upper[i]) result.push(upper[i-1]);
    else result.push(upper[i-1] + upper[i]);
  }
  result.push(1);
  return result;
}
```

- 역시 수학 관련되면 코드도 어렵다. 난 어렵게 풀었지만 역시 천재들은 간단하게 해결한다. 그래도 확실히 다른 코드들을 확인해보고 내것보다 좋을 때 다행이란 생각이 든다. 오늘도 조금 더 배웠구나 싶음.
- `get_pascals` : 특정 행의 파스칼 array를 구하는 함수를 따로 짰다. 재귀 형식이며 이전 열에서 두 원소를 합한 값을 array에 push하는 형태다.
- 문제의 함수는 `push`와 `apply`를 함께 써서 마치 Python의 extend와 같은 효과를 내도록 했다. apply와 call 함수는 다른 파일에 따로 정리하겠다.

## 2. 다른 해답

### A. 최고 득표

```js
function pascalsTriangle(n) {
  var pascal = [];  // 결과값이 저장될 array
  var idx = 0;
  
  for ( var i = 0; i < n; i++ ) {   // n번 반복을 돈다. i는 각 행의 길이 의미.
    idx = pascal.length - i;        // 바로 윗 행의 첫 번째 원소를 가리키는 인덱스
    for ( var j = 0; j < i+1; j++ ) // 행의 길이는 1씩 커진다. 한 번 더 반복.
      if ( j === 0 || j === i )     // 삼각형 행의 첫 번째거나 마지막일 때는
        pascal.push(1);             // 1을 push 한다.
      else                          // 윗 행의 원소 둘을 합쳐서 push.
        pascal.push( pascal[ idx+j ] + pascal[ idx+j-1 ] );
  }
  return pascal;
}
```

- 성능 좋은 코드다. 내 코드는 재귀라서 엄청 아래 부분의 삼각형 행이라면 계산이 오래 걸렸을 거다.
- 삼각형이 한 행 늘어날 수록 원소가 한 개씩 늘어남에 착안에서 원소를 정확하게 골라냈다. 똑똑하다.

### B. 재귀 활용

```js
function pascalsTriangle(n) {
  if (n === 1) {
    return [1];
  }
  var prev = pascalsTriangle(n - 1), len = prev.length;
  prev.push(1);
  for (var i = len - n + 1; i < len - 1; i ++) {
    prev.push(prev[i] + prev[i + 1]);
  }
  prev.push(1);
  return prev;
}
```

재귀 활용했다. A 답안과는 반복문을 중첩하느냐, 재귀를 쓰느냐의 차이다. 원리는 같다.
