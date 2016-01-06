# #8 Multi-tap Keypad Text Entry on an Old Mobile Phone

매개변수로 받는 문자열을 옛날 키패드로 타이핑하려면 몇 번 눌러야하는지 리턴하는 문제다.

## 1. 내 코드

```js
Array.prototype.contains = function(obj) {
    var i = this.length;
    while (i--)
        if (this[i] === obj)
            return true;
    return false;
}

function presses(phrase) {
  phrase = phrase.toUpperCase();
  var cnt = 0;
  var one = ['1', 'A', 'D', 'G', 'J', 'M', 'P', 'T', 'W', '*', ' ', '#'];
  var two = ['B', 'E', 'H', 'K', 'N', 'Q', 'U', 'X', '0'];
  var three = ['C', 'F', 'I', 'L', 'O', 'R', 'V', 'Y'];
  var four = ['2', '3', '4', '5', '6', 'S', '8', 'Z'];
  var five = ['7', '9'];
  for (var i = 0; i < phrase.length; i++) {
    if (one.contains(phrase[i]))
      cnt += 1;
    else if (two.contains(phrase[i]))
      cnt += 2;
    else if (three.contains(phrase[i]))
      cnt += 3;
    else if (four.contains(phrase[i]))
      cnt += 4;
    else if (five.contains(phrase[i]))
      cnt += 5;
  }
  return cnt;
}
```

- Array에 contains 라는 함수를 만들었다. 매개변수로 들어가는 객체가 Array에 있으면 true를 리턴하는 함수다.
- 눌러야하는 패드 수로 각각 리스트를 만들고 phrase를 for 반복 돌렸다. 어떤 array에 속하는지에 따라 cnt에 더하는 숫자가 달라진다.

## 2. 다른 해답

### A. forEach, filter, indexOf

```js
function presses(phrase) {
  var chunks = ['1', 'ABC2', 'DEF3', 'GHI4', 'JKL5', 'MNO6', 'PQRS7', 'TUV8', 'WXYZ9', ' 0'],
      phrase = phrase.toUpperCase().split(''),
      total = 0;
  
  phrase.forEach(function(l) {
    var key = chunks.filter(function(c) {
      return c.indexOf(l) > -1;
    })[0];
    total += key.indexOf(l) + 1;
  });
  return total;     
}
```

- `forEach` : 파이썬에서 `for i in list` 의 구문과 같은 효과를 가진다. 이런게 어디 없나 찾았었는데 여기 있었구나. forEach의 매개변수로 함수가 들어가며 Array의 원소 하나하나당 작업을 할 수 있다.
- `filter` : Array에서 호출되며 원소마다 매개변수의 함수가 실행된다. 함수에서 true가 리턴되는 원소만 Array에 담아 리턴한다. 위 경우 `indexOf`가 -1보다 큰, 즉 존재한다면 리스트에 담는데 거기서 첫 번째 원소를 리턴했다. 문자가 포함된 문자열을 받는다.
- 문자열에서 문자의 인덱스를 뽑아내고 +1을 하면 키패드를 누르는 횟수가 된다.
