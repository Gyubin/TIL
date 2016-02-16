# #27 Rotate for a Max

매개변수로 숫자를 받는다. 처음엔 첫 번째 숫자를 맨 뒤로 옮긴다. 두 번째엔 만들어진 숫자에서 두 번째 수를, 세 번째엔 두 번째에서 만들어진 수의 세 번째 수를 맨 뒤로 옮긴다. 이를 마지막 수에 도달할 때까지 반복한다. 기본 숫자 포함, 각 단계에서 만들어진 모든 수 중에서 가장 큰 수를 리턴하면 된다. 다음 예에선 68957이 리턴되면 된다. `56789 -> 67895 -> 68957 -> 68579 -> 68597`

## 1. 내 코드

- 단계가 지날 때마다 맨 앞의 숫자들은 변하지 않았다. 첫 단계가 지나면 맨 앞자리 수는 다음 수에서도 변하지 않았고, 두 번째 단계가 지나면 두 번째 수가 뒤에서도 똑같이 유지됐다. 그래서 단계가 지날때마다 뒷 부분의 수에 다시 함수를 재귀로 호출하면 어떨까 생각했다. 그런데 만약 숫자가 `6640`처럼 같은 숫자가 반복되고 그 다음에 작은 숫자가 오는 경우 이전 단계로 되돌아가는 것이 너무 어려웠다.
- 그래서 모든 단계의 숫자들을 다 배열에 집어넣고 마지막에 그 배열에서 가장 큰 수를 리턴하는 것으로 단순하게 짰다.

```js
function maxRot(n) {
  var result = [n];
  n = (n+'').split('');
  var len = n.length;
  for (var i = 0; i < len; i++){
    var temp = n[i];
    n = n.slice(0, i).concat(n.slice(i+1));
    n.push(temp);
    result.push(n.join('') * 1);
  }
  return Math.max.apply(null, result);
}
```

## 2. 다른 해답

- 나와 원리는 같은데 더 간결하게 짰다. 나는 배열로 만들어 slice 함수를 적용했는데 여기선 문자열에서 바로 slice를 사용했다. 배열에서 concat 함수를 써서 연결하는 것보다 + 를 통해 문자열 연결하는게 훨씬 쉽다. 
- Math의 max 함수는 숫자 형태인 문자열도 마치 숫자처럼 알아서 형변환하여 결과값을 리턴한다. 여기서 처음 알았다.

```js
function maxRot(n) {
  var str = n.toString();
  var arr = [str];
  for (var i=0;i<=str.length-1 ;i++){
    str = str.slice(0,i)+str.slice(i+1)+str[i];
    arr.push(str.split().join());
  }
  return Math.max.apply(null, arr);
}
```
