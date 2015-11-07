# #10 Narcissistic Number check
각 자리의 숫자들을 원래 수의 자리수로 제곱한다. 즉 세 자리 수면 각 자리 수를 3제곱하고, 4자리 수면 4제곱한다. 이 제곱된 수의 합이 원래 수와 같으면 narcissistic number이다. 이걸 체크하는 함수.

## 1. 내 코드

```python
def narcissistic( value ):
    narcissistic_number = sum(int(i)**len(str(value)) for i in str(value))
    if value == narcissistic_number:
        return True
    else:
        return False
```

## 2. 다른 해답

다 비슷하게 했다. 다만 리턴할 때 나처럼 if 문을 활용한게 아니라 'return value==narcissistic_number' 이라고만 했다. 더 간결하고 좋은 것 같다. 앞으로는 이렇게.
