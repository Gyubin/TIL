# #4 Insert dashes

홀수 사이엔 대시를 넣어서 문자열을 리턴하는 문제다.

## 1. 내 코드

- 이전 숫자가 홀수인지를 판별하는 `isPrevOdd` 변수를 두고, 숫자를 문자열화해서 for 반복을 돌았다.
- 현재 숫자가 홀수라면 `isPrevOdd`에 따라 대시를 삽입할 것인지 하지 않을 것인지 정한다. 그리고 공통적으로 `isPrevOdd`를 true로 바꿔준다.
- 현재 숫자가 짝수라면 대시를 삽입하지 않고, `isPrevOdd`를 false로 바꿔준다.

```js
function insertDash(num) {
    num = num + '';
    var result = '';
    var isPrevOdd = false;
    for (var i = 0; i < num.length; i++) {
        if (num[i] % 2) {
            if (isPrevOdd) result = result + '-' + num[i];
            else result += num[i];
            isPrevOdd = true;
        } else {
            result += num[i];
            isPrevOdd = false;
        }
    }
    return result;
}
```

## 2. 다른 해답

자바스크립트 정규표현식을 다시 훑어봐야겠다. 파이썬이랑 뭐가 다른지 확인하자. 정규표현식은 정말 강력한 도구다.

```js
function insertDash(num) {
   return num.toString().replace(/[13579](?=[13579])/g, "$&-");
}
```

- Number를 String으로 바꾸는 또 다른 방법: `toString()`
- `$`는 뒤에 쓰이면 텍스트의 마지막을 의미하기도 하지만, 앞에서 쓰이면 그룹을 `$1`, `$2`와 같이 특정해서 활용할 수 있다. 위의 `$&`는 매칭되는 전체를 의미한다.
- `(?=[13579])`는 전방 탐색으로 포함되지 않으면서 홀수 뒤에 홀수가 온다는 것을 의미한다.
