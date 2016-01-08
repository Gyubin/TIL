# #10 Decode the Morse code

Morse code 3부작 중 [1편](http://www.codewars.com/kata/decode-the-morse-code) ( [2편](http://www.codewars.com/kata/decode-the-morse-code-advanced), [3편](http://www.codewars.com/kata/decode-the-morse-code-for-real) ) 이다. 1편은 가장 쉬운 문제로 해독하는 함수를 작성하는 것이다. 글자는 빈 칸 한 개로 구분되고, 단어는 빈 칸 3개로 구분된다. `MORSE_CODE`라는 object를 통해 코드를 글자로 변환할 수 있다.

## 1. 내 코드

```js
String.prototype.replaceAll = function(org, dest) {
  return this.split(org).join(dest);
}

var decodeMorse = function(morseCode){
  morseCode = morseCode.trim().replaceAll('   ', ' space ').split(' ');
  var result = []
  for (var i = 0; i < morseCode.length; i++) {
    if (morseCode[i] === 'space')
      result.push(' ');
    else
      result.push(MORSE_CODE[morseCode[i]]);
  }
  return result.join('')
}
```

- `trim` : 문자열 앞 뒤의 빈칸을 제거했다.
- `replaceAll` : `replace` 밖에 없어서 문자열의 prototype에다가 추가해줬다. trim의 결과물에다가 빈 칸 세 개를 ' space '로 바꿔줬다. space 부분에서 단어를 구분하라는 의미다.
- split 결과물인 리스트에서 반복을 돌았다. 만약 space라면 한 칸을 띄우고, 아니라면 해독해서 집어넣었다.

## 2. 다른 해답

```js
decodeMorse = function(morseCode){
  function decodeMorseLetter(letter) {
    return MORSE_CODE[letter];
  }
  function decodeMorseWord(word) {
    return word.split(' ').map(decodeMorseLetter).join('');
  }
  return morseCode.trim().split('   ').map(decodeMorseWord).join(' ');
}
```

- 글자를 해독하는 함수, 단어를 해독하는 함수를 따로 만들었다.
- 매개변수로 받은 문자열을 '   '로 구분해서 단어 별로 떼어놓았고, 그것을 다시 각각 ' '으로 구분해서 함수를 적용했다.
- 훨씬 가독성이 좋다.
