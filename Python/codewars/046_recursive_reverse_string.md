# #46 Recursive reverse string

재귀 연습하기. 재귀 용법으로 문자열 뒤집기.

## 1. 내 코드

```py
def reverse(str):
  if len(str) == 1: return str
  return reverse(str[1:]) + str[0]
```

- 길이가 1이면 그냥 재귀 없이 그냥 문자열을 리턴하는 조건을 걸기
- 첫 번째 글자를 맨 뒤로 보내기
- 문자열을 인덱스 1부터 잘라서 함수의 매개변수로 넣는다. 재귀.

다른 코드도 역시 동일한 패턴이다.
