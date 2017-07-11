# Reverse string using recursion

A 문자열이 가 B 문자열에 포함되어있는지 검사하는 함수

```py
def strContain(A, B) :
    if len(A) > len(B):
        return "No"
    elif len(A) == 0:
        return "Yes"
    else:
        if A[0] in B:
            return strContain(A[1:], B)
        else:
            return "No"
```

- A 문자열이 더 짧으면 당연히 포함이 안되니 바로 X
- 재귀를 활용해서 A 문자열 앞 문자부터 줄여가면서 재 호출
- A 문자가 소진되면 종료해야해서 기저조건을 A의 길이로 설정
- 재귀 호출로 리턴되는 값 따로 변형 없이 바로 리턴
