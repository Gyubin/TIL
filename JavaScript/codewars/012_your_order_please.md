# #12 Your order, please

문장을 매개변수로 받는데 각 단어에 단어의 순서를 의미하는 숫자가 끼어있다. 이 순서에 맞게 단어를 다시 재배열한다.

## 1. 내 코드

```js
function order(words){
  var result = [];
  words = words.split(' ');
  for (var i = 1; i < 10; i++) {
    for (var j in words) {
      if (words[j].indexOf(i) > -1) {
        result.push(words[j]);
        continue;
      }
    }
  }
  return result.join(' ');
}
```

- 단어를 뽑아내고, 단어의 글자에 숫자가 포함되어있는지 검사한다.
- 1이 있는지 단어 전체를 검사하고, 있으면 결과 array에 추가하는 방식이다.
- 마지막에 합쳐서 리턴한다.

## 2. 다른 해답

```js
function order(words){
  return words.split(' ').sort(function(a, b){
      return a.match(/\d/) - b.match(/\d/);
  }).join(' ');
}    
```

- 멋지다. 내가 for 반복을 중첩해서 사용한 것을 sort와 정규표현식을 통해 해결했다. 기가 막힌다.
- split으로 단어를 구분해서 array로 만들었고 이것을 sort한다. sort의 기준은 정규표현식으로 단어에서 숫자를 매칭해서 뽑아냈고 그것을 뺄셈해서 순서를 오름차순으로 정했다.
- 마지막으로 붙여서 리턴했다.
- 다시 한 번 말하지만 정규표현식은 최고고, 위 답은 멋지다.
