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

## 3. DP(Dynamic Programming) 코드

출처: http://blog.naver.com/occidere/220793012348

```c
#include <stdio.h>

int main() {
    int i, j, t, n, m;
    int a[21] = {0};

    scanf("%d", &t);
    while (t--)
    {
        scanf("%d", &n);
        for (i = 1; i <= n; i++)
            scanf("%d", &a[i]);    
        scanf("%d", &m);
        int d[10001] = {0};
        d[0] = 1;
        for (i = 1; i <= n; i++)
            for (j = a[i]; j <= m; j++)
                d[j] += d[j - a[i]];
        printf("%d\n", d[m]);
    }
    return (0);
}
```

- 변수 의미
    + `a[21]` : 주어질 동전 종류가 담길 배열이다.
    + `d[10001]` : 각 인덱스가 금액을 나타낸다. 인덱스 1은 1원을 나타내고 그 값은 우리가 가진 동전으로 1원을 만들 수 있는 가짓수다.
    + `t`: 테스트 케이스
    + `n`: 동전 가짓수
    + `m`: 금액
    + `i`, `j`: 인덱스로 사용될 정수 변수
- 원리: 어떤 숫자 A가 동전들을 가지고 만들어질 수 있는 금액이라면 -> 그 금액에 어떤 동전이든 하나를 더했을 때의 금액 역시 만들어질 수 있는 수다.
- 0원은 어떤 동전이든지 만들 수 있는 수다. 0원부터 시작해서 해당 동전을 하나씩 더해가면 결과로 나오는 금액들은 만들 수 있는 수가 된다.
    + 그래서 `d[0]`은 무조건 1로 두고 시작
    + 2원 가치의 동전일 때 0원부터 시작해서 2를 더해가면 그 거치는 모든 금액은 만들어질 수 있는 수다. 그래서 가짓수를 나타내는 배열의 값을 1 증가시킨다.
- 하지만 단순히 각 동전의 크기만큼 인덱스 널뛰기를 뛰어서 값을 증가시키면 결국 각 동전의 배수만 증가시키게 되고 그 조합은 계산이 안된다. 예를 들어 2, 3원짜리 동전을 하나씩 사용해서 5원을 만드는 것은 계산이 안되는 것.
- 그래서 `d[j] += d[j - a[i]];` 이 식을 사용했다. 즉 2원짜리 동전을 사용하는 케이스일 때 금액 2는 동전의 가치 2만큼을 뺀 0원을 만들 수 있는 가짓수에다 플러스 1을 한 값이라는 것이다. 즉 위에서 얘기한 원리를 기반으로 한다. 이렇게 되면 2원짜리를 모두 검사한 후 3원짜리로 5원을 검사할 땐 2원이 가능한지를 보기 때문에 계산이 가능하게 되는 것.
- 최종적으로 m원의 가짓수인 `d[m]` 값을 출력해주면 된다.
