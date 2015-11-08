# #24 Nesting Structure Comparison

- 입력받은 2개의 리스트의 구조가 똑같은지를 검사하는 함수
- 원소가 1개인 리스트와, 일반 숫자나 문자열 값 하나는 같음으로 친다.
- 원소가 0개인 리스트는 정수 하나와 다르다고 나온다.

## 1. 내 코드

- 재귀를 썼다. 두 비교 대상이 모두 리스트라면 함수를 재귀로 다시 호출했고, flag boolean 값을 계속 리턴하고 받으면서 연결했다.
- 비교하는 두 대상의 길이를 구했다. 리스트라면 길이를, 아니라면 길이가 1이라고 정했다.
- 기본 flag 값은 True인데 길이가 다르다면 False라고 했다.

```python
def same_structure_as(original,other):
    flag = True
    len_original = len(original) if isinstance(original, list) else 1
    len_other = len(other) if isinstance(other, list) else 1
    if len_original == len_other:
        if isinstance(original, list) and isinstance(other, list):
            for org, oth in zip(original, other):
                flag = same_structure_as(org, oth)
    else:
        flag = False
    return flag
```

## 2. 다른 해답

나는 리스트가 아닌 원소와, 원소가 하나인 리스트를 비교하기 위해서 먼저 길이를 타나내는 변수 2개를 정의하고 시작했었다. 그렇기 때문에 조건 3개를 다음 답처럼 and로 연결시킬 수 없었다. 길이는 같지만 리스트가 아닌 타입이 있더라도 True일 수 있기 때문이다. 그래서 길이 비교와, 타입이 리스트인지를 조건문 2개로 분기했다. 하지만 아래 답은 3가지 조건을 뭉쳐놓는 대신 else에서 예외를 처리했다. 나머지는 같은 흐름이다.

```python
def same_structure_as(original,other):
    if isinstance(original, list) and isinstance(other, list) and len(original) == len(other):
        for o1, o2 in zip(original, other):
            if not same_structure_as(o1, o2): return False
        else: return True
    else: return not isinstance(original, list) and not isinstance(other, list)
```
