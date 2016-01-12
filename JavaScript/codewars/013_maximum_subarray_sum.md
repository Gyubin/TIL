# #13 Maximum subarray sum

배열을 매개변수로 받아서 인접한 원소들의 합 중 최대치를 구하는 함수다.

# 1. 내 코드

```js
var maxSequence = function(arr){
  var sums = [];
  for (var i = 0; i < arr.length; i++) {
    for (var j = 0; j < arr.length-i; j++) {
      sums.push(arr.slice(j, j+i+1).reduce(function(p, c) {
        return p + c;
      }, 0));
    }
  }
  return sums.reduce(function(p, c) {
    return p >= c ? p : c;
  }, 0);
}
```

- 뽑히는 원소의 개수를 i, 뽑혀지는 원소들의 시작 인덱스를 j로 두었다. 즉 가능한 모든 subarray들을 뽑아보려는 의도다. (성능 무시)
- sums에 각 subarray들의 총 합을 reduce 함수로 계산해서 집어넣었다.
- 마지막에 원소들 중에 최대값을 리턴했다.
- 사용된 두 번의 reduce 함수에서 둘 모두 0을 initial value로 넣어줘야 빈 배열이나 음수 원소의 경우를 대비할 수 있다.

## 2. 다른 해답

### A. 최고 득표

![gorgeous!!](http://i.imgur.com/HnEEx0Q.png)

```js
var maxSequence = function(arr){
  var min = 0, ans = 0, sum = 0;
  for (var i = 0; i < arr.length; i++) {
    sum += arr[i];
    min = Math.min(sum, min);
    ans = Math.max(ans, sum - min);
  }
  return ans;
}
```

- 개인적으로 문제를 푸는데 새로운 사고방식을 얻을 수 있었다. itsPG 라는 유저가 직접 그림까지 링크하면서 푸는 방식을 설명해줬다. 설명이 없었다면 이해하기 어려웠을 것이다.
- 이미지의 가로 축은 index를 의미하고, 세로 축은 index까지의 원소들의 누적 합을 의미한다. 원소들 중 음수도 있기 때문에 합이 내려갈 수도 있는 것이다. 즉 위 이미지를 문제에 대입해보면 가장 낮은 valley를 찾고, 가장 높은 peak를 찾아서 둘 사이의 차를 구하면 된다. 그 차가 최대치의 subarray다. 다만 peak이 valley보다 뒤에 있어야 한다. 앞에 있으면 반대가 되므로.
- sum 변수를 통해 그 순간의 합을 계속 기록하고, 최소값인 min과 우리가 구하려는 값인 ans를 계속 구한다. 주목할 점은 ans를 구하는 식에서 `sum-min`이다. 이렇게 뺄셈을 해줬기 때문에 peak이 valley보다 뒤에 있어야 한다는 조건을 자연스럽게 충족한다. 내려가는 그래프에서 min이 새로운 최소치를 계속 갱신할 때는 sum과 min이 항상 일치한다. 그렇기 때문에 새로운 min이 생성되어서 valley가 peak보다 뒤에 있더라도 `sum-ans`가 항상 0이라서 새로운 max ans 값을 갱신하지 못하는 것이다.
- 멋지다. 이렇게 시각적으로 상상해서 문제를 푸는 방식은 한 번도 시도해보지 않았다. 멋진 코드와 설명에 감사를 표한다.

### B. 같은 원리, 약간 다른 방식

```js
var maxSequence = function(arr){
    var currentSum = 0;
    return arr.reduce(function(maxSum, number){
        currentSum = Math.max(currentSum+number, 0);
        return Math.max(currentSum, maxSum);
    }, 0);
}
```

- 이 코드 해석하는데 좀 오래 걸렸다. 역시 A와 원리는 같다.
- 큰 줄기는 currentSum에다가 계속 원소 하나 하나를 더해서 얼마만큼 커질 수 있는지, 즉 어디까지 최고점을 찍을 수 있는지 구하는 방식이다.
- 0과 비교해서 더 큰 값을 계속 찍어나가는 것이 핵심이다. 0보다 크다면 아직 새로운 최저점이 안나왔다는 소리라서 기존 최저점을 유지하며 계속 최대값을 찍어나갈 수 있다. 하지만 만약 0보다 작은 수라면 새로 최저점이 찍혔으므로 0을 currentSum에 넣어서 기준점 잡은 후에 또 계속 + 하면서 올라가면 되는 것이다.
- 즉 currentSum은 0부터 시작해서 어디까지 최대로 올라갈 수 있는지 측정하는 변수인 것이다.
