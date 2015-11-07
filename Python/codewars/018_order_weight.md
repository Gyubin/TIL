# #18 Weight for weight
공백으로 구분되는 몸무게들이 적혀있는 문자열을 입력 받는다. 몸무게 각 자리 수의 합을 기준으로 오름차순으로 몸무게 원래 값들을 정렬한다. 만약 각 자리 수의 합이 같다면 원래 몸무게를 문자열이라고 했을 때 오름차순으로 정렬되면 된다.

## 1. 내 코드

- 문자열을 공백 기준으로 split 후 리턴값인 리스트를 for문으로 반복했다.
- 각 자리 수의 합을 key로, 원래 숫자가 담긴 리스트를 value로 하는 딕셔너리를 만들었다. 각 자리 수의 합이 같을 경우를 대비해서 리스트를 value로 했으며, 같은 경우엔 리스트에 append시켰다. 정렬은 그 때 그 때 sort를 활용했다.
- 딕셔너리에서 키값을 뽑아내어 리스트로 만든 후 정렬했다.
- 정렬된 키 리스트에서 하나씩 뽑아내어 딕셔너리의 값을 뽑아낸 후 join해서 리턴했다. 딕셔너리의 value 자체가 리스트여서 두 번 join했다.

```python
def order_weight(strng):
    match = {}
    for str_num in strng.split():
        key = sum(int(i) for i in str_num)        
        if key in match:
            match[key].append(str_num)
            match[key].sort()
        else:
            match[key] = [str_num]
    ordered_list = list(match.keys())
    ordered_list.sort()
    return " ".join(" ".join(match[key]) for key in ordered_list)
```

## 2. 다른 해답: sorted 함수 사용
sort 함수에(혹은 sorted) 정렬 기준을 지정할 수 있다는게 중요. 기억하자.

- ```sorted(iterable[, key][, reverse])``` 형태로 사용된다.
- iterable을 매개변수로받아서 정렬한 후 리턴한다.(디폴트는 오름차순)
- key와 reverse 매개변수가 있으며, 이를 사용하려면 명칭까지 적어줘야 한다. key=무엇, reverse=무엇 이런식으로.
- key: 함수가 들어간다. lambda가 들어갈 수도 있다. iterable의 원소 하나가 이 함수에 매개변수로 들어가며, 리턴된 값이 비교값으로 사용된다. key의 기본값은 None이라서 아무것도 안 적으면 원소 값 자체가 비교된다.
- reverse: True, False 값이 들어간다. 기본값은 False이며 True가 적용되면 key의 비교가 반대로 적용된다.
- 풀이 방식: 우선 문자열을 split으로 쪼개자마자 정렬했다. 자리수합이 같을 경우의 정렬 이슈를 해결했다. 그 후에 다시 정렬을 하는데 그 기준은 각자리수의 합으로 지정했다. 정렬된 리스트를 공백 한 칸씩 띄워붙여 리턴했다.(쩐다)

```python
def order_weight(_str):
    return ' '.join(sorted(sorted(_str.split(' ')), key=lambda x: sum(int(c) for c in x)))
```
