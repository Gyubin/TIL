# 괄호 관련 문제

스택을 활용한 문제다. 괄호들이 열고 닫히는 관계가 성립하기 때문에 스택을 활용하면 매우 쉽게 풀린다.

## 1. 괄호 계산 순서 구하기

```py
def find_order(p) :
    order = [0] * len(p)
    cnt = 1
    stack = []
    for i, c in enumerate(p):
        if c == '(':
            stack.append(i)
        else:
            order[stack.pop()] = cnt
            order[i] = cnt
            cnt += 1
    return order

def main():
    p = input()
    print(*find_order(p))

if __name__ == "__main__":
    main()
```

- 주어지는 괄호 문자열은 정상적인 것으로 간주
- 순서가 입력될 배열을 미리 선언한다. 길이는 괄호의 숫자만큼이다.
- 여는 괄호라면 스택에 추가한다. 닫힐 때 그 괄호가 계산되는 것이므로 아직은 계산 순서가 올라가지 않는다. 해당 인덱스 값만 필요하므로 스택에 인덱스만 넣는다.
- 만약 닫는 괄호라면 스택의 top에 있는 괄호와 매칭되는 것일 수 밖에 없다. 두 인덱스에 해당하는 순서 배열의 값을 cnt 값으로 변경한다. cnt는 순서이므로 추가될 때마다 1씩 올린다.

## 2. 올바른 괄호 구성인지 검증

```py
def check_parenthesis(p):
    stack = []
    for c in p:
        if c == '(' or c == '{' or c == '[':
            stack.append(c)
        else:
            if len(stack) == 0:
                return False
            open_p = stack.pop()
            if open_p == '(' and c != ')':
                return False
            if open_p == '{' and c != '}':
                return False
            if open_p == '[' and c != ']':
                return False
    return True if not len(stack) else False

def main():
    p = input()
    print("result:", check_parenthesis(p))

if __name__ == "__main__":
    main()
```

- 괄호는 `(){}[]` 형태가 들어오고 다른 문자는 들어오지 않는다고 가정
- 여는 괄호가 들어오면 스택에 쌓는다.
- 닫는 괄호를 만나면
    + 이전에 여는 괄호가 있었는지 확인한다. 스택이 비었으면 바로 False 리턴
    + 스택의 top에 있는 여는 괄호가 닫는 괄호와 매칭되는지 확인하고 아니라면 False를 리턴한다.
- 모든 괄호를 다 검사했을 때 여전히 stack에 여는괄호가 남아있다면 제대로 안 닫힌 것이므로 False를 리턴하고 비었다면 모두 정상적으로 닫힌 것이므로 True 리턴한다.
