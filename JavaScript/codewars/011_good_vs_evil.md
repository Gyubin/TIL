# #11 Good vs Evil

천사팀 6 유닛, 악마팀 7 유닛이 있다. 각 유닛별로 점수가 다르다. 각 팀의 유닛 마리 수 정보를 매개변수로 받아서 누가 이겼는지 리턴하는 함수다.

## 1. 내 코드

```js
function goodVsEvil(good, evil){
  function calculate(race, worth) {
    var result = 0;
    race = race.split(' ');
    for (var i = 0; i < race.length; i++) {
      result += 1 * race[i] * worth[i]
    }
    return result;
  }
  var good_worth = [1, 2, 3, 3, 4, 10];
  var evil_worth = [1, 2, 2, 2, 3, 5, 10];
  
  var good_score = calculate(good, good_worth);
  var evil_score = calculate(evil, evil_worth);

  if (good_score > evil_score)
    return "Battle Result: Good triumphs over Evil"
  else if (good_score < evil_score)
    return "Battle Result: Evil eradicates all trace of Good"
  else
    return "Battle Result: No victor on this battle field"
}
```

- 팀과 유닛 점수 정보를 입력받아서 점수를 계산하는 함수를 내부에 만든다. for 반복을 돌아서 매칭되는 것을 곱해서 결과값에 더한 후 리턴한다.
- 만든 함수를 각각 적용하여 if로 분기해서 마무리한다.

## 2. 다른 해답

```js
function goodVsEvil(good, evil) {  
  var getWorth = function( side, worth ) {
    return side.split(' ').reduce( function(result, value, index) { 
      return result + (worth[index] * value);
    }, 0);
  }

  var result = getWorth( good, [1,2,3,3,4,10] ) - getWorth( evil, [1,2,2,2,3,5,10] );

  return result > 0 ? "Battle Result: Good triumphs over Evil" :
         result < 0 ? "Battle Result: Evil eradicates all trace of Good" :
                      "Battle Result: No victor on this battle field";
}
```

- reduce는 함수와 초기값을 매개변수로 받는다. 매개변수의 함수는 순서대로 이전값, 현재값, 현재인덱스, 배열을 매개변수로 받는다. 처음에 나도 reduce를 사용하려 했지만 현재인덱스를 이용할 생각을 못했다. 깔끔하다.
- 아래는 똑같다. 삼항 연산자를 연속으로 사용하는 걸로 if를 대신했다.
