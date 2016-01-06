# #6 Return a sorted list of objects

002_sort_with_arrow ~~ 문제와 같은 형태다. object가 원소로 되어있는 리스트를 정렬하는 것. 그런데 여기선 매개변수로 정렬 기준이 될 것을 추가로 넣어줬다. 이 때는 dot notation으로 접근하면 안된다. `[ ]`를 통해야 한다. 다른 해답과 같다.

## 1. 내 코드

```js
function sortList (sortBy, list) {
  return list.sort(function(i, j){return j[sortBy] - i[sortBy]});
}
```
