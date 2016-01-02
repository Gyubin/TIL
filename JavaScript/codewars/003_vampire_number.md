# #3 Vampire Number

두 수를 매개변수로 받아서 곱한다. 곱한 수가 매개변수의 두 수로 그대로 이루어져있으면 true를 리턴한다. 예를 들어 6과 21을 곱했으면 6, 2, 1이라는 숫자가 그대로 존재해야 한다. 곱의 결과가 126이므로 true다.

## 1. 내 코드

무지하게 길다. 파이썬에 익숙해서 짜던대로 짜면 다른 결과를 내놓는 경우가 다반사였다. 특히 Array로 타입을 바꾸는 것, 리스트와 String에서 `in`을 써서 원소가 있는지 알아보는 것 등이 파이썬과 달랐다. 그래서 아래처럼 무식하게 짰다.

```js
var vampire_test = function(a, b){
    var a_array = [];
    for (var i = 0; i < String(a).length; i++) {
        a_array.push(String(a)[i]);
    }
    var b_array = [];
    for (var i = 0; i < String(b).length; i++) {
        b_array.push(String(b)[i]);
    }
    var ab_array = [];
    for (var i = 0; i < String(a*b).length; i++) {
        ab_array.push(String(a*b)[i]);
    }

    pre = a_array.concat(b_array).sort();
    pos = ab_array.sort();
    if (pre.length !== pos.length)
        return false;
    for (var i = 0; i < pre.length; i++)
        if (pre[i] !== pos[i])
            return false;
    return true;
}
```

## 2. 다른 해답

아직 내가 모르는 함수들이 많다. 아래처럼 짜도록 차근차근 공부하자. 모든 답이 다음 코드처럼 `''+Number`, `split`, `sort`, `join`을 사용했다.

- `숫자형 + ''` : 빈 문자열을 숫자와 덧셈하면 `String(숫자형)`과 같은 효과다.
- `split(thing)` : thing을 기준으로 split한다.
- `sort` : Array 뒤에서 호출되어 정렬한다.
- `join(thing)` : Array의 원소들을 thing으로 연결한다. 마지막에 join을 쓰는 이유는 Array끼리 비교가 불가능하기 떄문이다. 같은 원소를 가지고 있더라도 Array끼리는 `===` 비교에서 무조건 false를 리턴한다. join을 통해 문자열로 만들어 비교해줘야 한다.
- 결국 내 방식과 같은 방식인데 함수를 활용해서 코드를 극도로 줄였다.

```js
function vampire_test(a, b){
  return sortStr(a + '' + b) == sortStr(a * b + '');
}
function sortStr(v){ return v.split('').sort().join('') }
```
