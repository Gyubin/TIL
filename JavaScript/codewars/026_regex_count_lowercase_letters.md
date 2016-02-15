# #26 Regex count lowercase letters

정규 표현식으로 소문자가 몇 개인지 리턴하는 문제다.

## 1. 내 코드

```js
function lowercaseCount(str){
  var re = /[a-z]/g;
  var cnt = 0;
  while(re.exec(str)) {
    cnt += 1;
  }
  return cnt;
}
```

- 정규표현식 객체를 소문자 중 아무거나 하나로 지정하고 global 옵션을 넣는다. g 옵션은 ~all 같은 개념이다. searchAll, matchAll 이런식으로 문자열 전체에서 매칭되는 값을 찾는다. exec에서는 이미 찾은 것은 넘어가고 다음 것을 찾아 리턴한다.
- cnt 변수를 선언해두고 찾아질 때마다 1씩 플러스한다. while 반복문의 조건은 str에서 re와 매칭되는 문자열이 있다면 그것에 대한 정보를 배열로 리턴하는 것이다. global 옵션을 주었고 찾아지면 다음 걸로 넘어가니까 마지막까지 찾아지면 리턴값이 없어서 while 반복문을 빠져나오게 된다.

## 2. 다른 해답

### A. 최고 득표

g옵션으로 match를 실행시켰기 때문에 모든 매칭 문자열을 배열에 담아 리턴한다. 만약 매칭이 없다면 null을 리턴하는데 이 때 빈 배열을 `||` 연산하여 빈 배열이 리턴되게 한다. 마지막에 length를 리턴.

```js
function lowercaseCount(str){
    return (str.match(/[a-z]/g) || []).length
}
```

### B. 다음 득표

맨 앞에 `^`를 주어 소문자 알파벳이 '아닌' 것들을 g 옵션으로 모두 골랐다. 그리고 그 것을 빈 문자열로 바꾼다. 즉 없앴다. 그리고 문자열 자체의 length를 리턴했다.

```js
const lowercaseCount = str => str.replace(/[^a-z]/g, '').length;
```
