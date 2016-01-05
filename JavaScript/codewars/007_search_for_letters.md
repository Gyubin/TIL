# #7 Search for letters

매개변수로 받은 문자열에 알파벳이 몇 가지나 존재하는지 1과 0으로 나타낸다. 순서대로 a부터 z까지며 있으면 1, 없으면 0으로 나타내서 리턴한다. 리턴 예는 '1110000000000000000000000'이고 a, b, c만 존재한다는 의미다.

## 1. 내 코드

- 모든 원소가 0으로 되고 원소 개수가 26개인 Array 만든다.
- 문자열을 우선 대문자화해서 변수를 줄인다.
- 문자열의 길이만큼 반복을 돌아서 아스키코드값이 A, Z 사이에 있으면 해당하는 array의 원소를 1로 바꾼다.

```js
function change(string){
  var result = [];
  while (result.length < 26)
    result.push(0);
  
  string = string.toUpperCase();
  for (var i = 0; i < string.length; i++) {
    var ascii_num = string[i].charCodeAt(0);
    if (ascii_num >= 65 && ascii_num <= 90)
      result[ascii_num - 65] = 1
  }
  return result.join('');
}
```

## 2. 다른 해답

```js
function change(string) {
  string = string.toLowerCase()
  return 'abcdefghijklmnopqrstuvwxyz'.split('').map(function (c) { 
    return string.indexOf(c) !== -1 ? 1 : 0;
  }).join('');
}
```

- 역시 변수를 줄이기 위해 모두 소문자로 바꾼다.
- 소문자 알파벳이 모두 들어있는 리스트를 만들고 `map` 함수를 호출한다. map은 호출한 배열의 원소 하나하나에 매개변수로 받는 function을 적용하는 것이다.
- 매개변수의 함수는 문자열에서 해당 알파벳이 있으면 1을, 없으면 0을 리턴하는 함수다. `indexOf`는 알파벳이 존재하면 첫 알파벳의 인덱스를 리턴하고, 아예 없으면 -1을 리턴한다. -1이 아닌 경우라는 조건을 활용했다.
- 머리가 매우 좋은 것 같다.
