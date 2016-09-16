# #13 한수

- 문제 링크: https://www.acmicpc.net/problem/1065
- 어떤 양의 정수 X의 자리수가 등차수열을 이룬다면, 그 수를 한수라고 한다. 등차수열은 연속된 두 개의 수의 차이가 일정한 수열을 말한다. N이 주어졌을 때, 1보다 크거나 같고, N보다 작거나 같은 한수의 개수를 출력하는 프로그램을 작성하시오.

## 1. 내 코드

```c
#include <stdio.h>

int     check_han_num(int num);

int     main(void)
{
    int i, cnt, num;

    scanf("%d", &num);
    if (num < 100)
    {
        cnt = num;
    }
    else
    {
        cnt = 99;
        for (i = 100; i <= num; i++)
        {
            if (check_han_num(i))
                cnt++;
        }
    }
    printf("%d\n", cnt);
    return (0);
}

int     check_han_num(int num)
{
    int i, digit;
    int arr[4];

    digit = 0;
    while (num > 0)
    {
        arr[digit] = num % 10;
        digit++;
        num /= 10;
    }
    for (i = 0; i < digit - 2; i++)
    {
        if (arr[i] - arr[i + 1] != arr[i + 1] - arr[i + 2])
            return (0);
    }
    return (1);
}
```

- 최대 수가 1000이므로 최대 자리 수는 4다. 크기 4인 정수형 배열을 만들고 각 자리수를 대입해준다. 동시에 자리수도 계산해둔다.
- 첫 번쨰 수와 두 번쨰 수의 차, 두 번째 수와 세 번쨰 수의 차이를 매 번 비교해서 다르다면 바로 0을 리턴한다. 반복은 자리수에서 2를 뺀 수까지 한다.
