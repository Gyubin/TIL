# #2 Square Every Digit

각 자리 숫자를 제곱한 수로 연결된 숫자. 9119 -> 811181

## 내 코드

```python
def square_digits(num):
    str_num = str(num)
    result = ""
    for ch in str_num:
        ch_num = pow(int(ch), 2)
        result += str(ch_num)
    return int(result)
```

## 다른 해답

```python
def square_digits(num):
    return int(''.join(str(int(d)**2) for d in str(num)))
```

리스트 내포 '표현식 for 항목 in iterable if 조건문'를 활용했다.

- 표현식: 'str(int(d)**2)'
- 항목: d
- iterable: str(num)

리턴되는 값을 빈 문자열 ''에다가 계속 join한 후 마지막에 정수로 바꿔서 리턴한다.
