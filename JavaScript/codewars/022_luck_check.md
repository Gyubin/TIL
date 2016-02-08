# #22 Luck check

문자열 타입의 숫자를 입력받아 중간을 자른다. 앞 숫자들의 합과 뒷 숫자들의 합이 같으면 true, 틀리면 false 리턴한다. 짝수자리라면 정확하게 반으로 나누고 홀수 자리라면 정 중앙 숫자의 왼쪽, 오른쪽을 계산한다.

## 1. 내 코드

```js
function luckCheck(ticket){
  var left_index = parseInt(ticket.length / 2);
  var right_index = left_index;
  if (ticket.length % 2 == 1) right_index += 1;
  
  var left = ticket.slice(0, left_index).split('').reduce(function(p, c){
    return p + parseInt(c);
  }, 0);
  var right = ticket.slice(right_index).split('').reduce(function(p, c){
    return p + parseInt(c);
  }, 0);
  return left === right ? true : false;
}
```

- 앞 뒤를 나누는 인덱스를 각각 선언하고, 만약 홀수 자리인 경우 뒤 인덱스에 1을 더해줬다.
- 문자열을 정해준 인덱스까지 자르고, reduce 함수를 통해 값을 모든 숫자를 더해줬다.

# 2. 다른 해답

```js
function luckCheck(ticket){
  var long = ticket.length; 
  var left = ticket.split('').splice(0, long/2);
  var right = ticket.split('').splice((long % 2 == 0? long/2: long/2 + 1), long);
  return left.reduce((a, b) => +a + +b) == right.reduce((a, b) => +a + +b);
}
```

- 앞과 뒷 부분을 구분하는 인덱스를 구하는 방식은 같다. 그런데 slice의 매개변수로 float형이 들어갈 수 있는지는 몰랐다. 굳이 parseInt 함수를 쓰지 않아도 자연스럽게 slice 가능하다.
- true, false를 리턴하기 위해 reduce 결과를 비교하는 구문을 리턴했다. 그리고 parseInt와 초기값을 지정하지 않고 변수 앞에 `+`를 붙여서 쉽게 숫자형으로 타입 변환했다.
