# #25 Sum Strings as Numbers

0-9까지 숫자만 들어있는 문자열을 두 개 입력받아서 더하고, 결과를 문자열 타입으로 리턴한다. 매우 큰 수를 더하게 되면 일반 수치 연산에서 E 형태로 나타내게 된다. 그게 아니라 전체 수를 모두 일반 10진법 형태로 나타내어야 한다.

## 1. 내 코드

```js
function sumStrings(a,b) {
  var arr = length_equalize(a, b);
  arr[0] = arr[0].split('');
  arr[1] = arr[1].split('');
  result = [];
  for (var i = 0; i < arr[0].length; i++) {
    var temp = eval(arr[0][i] + '+' + arr[1][i]);
    if (temp >= 10) {
      if (result[i] === undefined) {
        result.push(temp%10, 1)
      } else {
        result[i] += temp%10;
        result.push(1);
      }
    } else {
      if (result[i] === undefined) {
        result.push(temp);
      } else {
        if (result[i] + temp >= 10) {
          result[i] = (result[i] + temp) % 10;
          result.push(1);
        } else {
          result[i] += temp;
        }
      }
    }
  }
  result.reverse();
  var i = 0;
  while(true) {
    if(result[i] != 0) return result.slice(i).join('');
    i++;
  }
}

function length_equalize(a, b) {
  if (a.length > b.length) {
    var len = a.length - b.length;
    b = b.split('').reverse();
    for (var i = 0; i < len; i++) {
      b.push('0');
    }
    b = b.join('');
    a = a.split('').reverse().join('');
  } else if (b.length > a.length) {
    var len = b.length - a.length;
    a = a.split('').reverse();
    for (var i = 0; i < len; i++) {
      a.push('0')
    }
    a = a.join('');
    b = b.split('').reverse().join('');
  } else {
    a = a.split('').reverse().join('');
    b = b.split('').reverse().join('');
  }
  return [a, b];
}
```

- 최악의 코드다. 정말 길게 짰다. 중복도 많다. `unshift`라는 함수를 쓰면 array의 맨 앞에 원소를 추가할 수 있는데 코드워에선 없는 함수라고 나온다.

## 2. 다른 해답

```js
String.prototype.reverse = function() {
  return this.split('').reverse().join('');
}

function sumStrings(a,b) {
  a = a.reverse(); b = b.reverse();
  var carry = 0;
  var index = 0;
  var sumDigits = [];
  while (index < a.length || index < b.length || carry != 0) {
    var aDigit = index < a.length ? parseInt(a[index]) : 0;
    var bDigit = index < b.length ? parseInt(b[index]) : 0;
    var digitSum = aDigit + bDigit + carry;
    sumDigits.push((digitSum % 10).toString());
    carry = Math.floor(digitSum / 10);
    index++;
  }
  sumDigits.reverse();
  while (sumDigits[0] == '0') sumDigits.shift();
  return sumDigits.join('');
}
```

```js
function sumStrings(a, b) {
  var res = '', c = 0;
  a = a.split('');
  b = b.split('');
  while (a.length || b.length || c) {
    c += ~~a.pop() + ~~b.pop();
    res = c % 10 + res;
    c = c > 9;
  }
  return res.replace(/^0+/, '');
}
```

```js
function sumStrings(a, b)
{
    var A = a.split(""), B = b.split(""), C = 0, R = "";

    while (A.length || B.length || C)
    {
        C = C + (~~A.pop() + ~~B.pop());
        R = (C % 10) + R;
        C = C > 9;
    }

    return R.replace(/^0+/, "");
}
```

```js
function sum(n1, n2) {
  return (parseInt(n1) || 0) + (parseInt(n2) || 0);
}

function sumStrings(a,b) { 
  a = a.split("").reverse();
  b = b.split("").reverse();
  total = [];
  var length = (a.length > b.length) ? a.length : b.length;
  
  //make the sum digit by digit
  for (var i = 0; i < length; i++) {
    s = sum(a[i], b[i]);
    total[i] = sum(total[i], s);
    if (total[i]>9) {
      total[i] -= 10;
      total[i+1] = 1;
    }
  }
  
  //remove fruitless zero
  if (total[total.length-1] == 0) 
    total[total.length-1] = "";
    
  //reverse the array and return the string
  return total.reverse().join("");
}
```

```js
function sumStrings(a,b) { 
   var A = a.replace(/^0*/, "").split("").reverse();
   var B = b.replace(/^0*/, "").split("").reverse();
   var res = "";
   var tenths = 0;
   while (A.length>0 || B.length>0) {
     var a0 = A.length==0 ? 0 : +A[0];
     var b0 = B.length==0 ? 0 : +B[0];
     var d = a0 + b0 + tenths;
     tenths = d>9 ? 1 : 0;
     res = (d%10) + res;
     A = A.slice(1);
     B = B.slice(1);
   }
   if (tenths) res = "1"+res
   return res;
}
```
