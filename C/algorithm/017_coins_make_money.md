# #17 동전 세기 문제

백준 온라인저지 9084 문제: https://www.acmicpc.net/problem/9084

## 1. 문제 설명

- 동전의 종류와 만들어야할 금액을 입력받는다.
- 가지고 있는 동전으로 금액을 만들 수 있는 가짓수를 출력한다.
- 첫째줄에 전체 케이스, 둘째줄에 동전 종류 수, 셋째줄에 동전 종류, 넷째줄에 만들어야 할 금액을 입력받는다.

## 2. 내가 짠 재귀 코드

### 2.1 파이썬 코드

속도가 느려서 통과하지 못한 코드다.

```py
def calculate_kinds(coin_types, money):
    cnt = 0
    if (money % coin_types[0] == 0):
        cnt = 1
    if (len(coin_types) != 1):
        for i in range(money // coin_types[0]):
            cnt += calculate_kinds(coin_types[1:], money - coin_types[0] * i)
    return cnt

def main():
    case = int(input())
    while (case):
        kinds = int(input())
        coin_types = list(map(int, input().split(' ')))
        money = int(input())
        print(calculate_kinds(coin_types, money))
        case -= 1

if __name__ == '__main__':
    main()
```

- 원리: a, b, c 동전이 있을 때 a가 0개 사용되는 것부터 a만 모두 사용하게 되는 것까지 경우의 수를 구한다. 각각의 경우의 하위에서 다시 b가 0개 사용되는 것부터 b만 사용되는 것까지 구한다. 이렇게 타고 내려가면서 가짓수를 구하는 것이고 그래서 재귀함수를 사용했다.
- 재귀 함수에서 한 단계 내려갈 때마다 첫 번째 동전은 제하고, 첫 번째 동전이 쓰이는만큼 금액에서 빼서 매개변수로 넣어줬다.
- 맨 처음 금액을 첫 동전으로 나눈 나머지를 구하는 조건문은 첫 번째 동전만 모두 사용하는 조건이 포함되어야하기 때문이다. 기저 사례이기도 하고, 그 아래 for문을 돌 때 포함되지 않기도 하다.

### 2.2 C 코드

똑같은 원리로 C 코드로 변환했지만 역시 시간초과가 나온다.

```c
#include <stdio.h>

int cal(int *arr, int len, int money)
{
    int cnt, i;

    cnt = 0;
    if (money % arr[0] == 0)
        cnt = 1;
    if (len != 1)
        for (i = 0; i < money / arr[0]; i++)
            cnt += cal(&arr[1], len - 1, money - arr[0] * i);
    return (cnt);
}

int main(void)
{
    int cases, kinds, money, i;
    int arr[20];

    scanf("%d", &cases);
    while (cases--)
    {
        scanf("%d", &kinds);
        i = 0;
        while (i < kinds)
            scanf("%d", &arr[i++]);
        scanf("%d", &money);
        printf("%d\n", cal(arr, kinds, money));
    }
    return (0);
}
```
