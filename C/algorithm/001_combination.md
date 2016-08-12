# 001 Combinations

## 1. 문제

- 숫자 하나를 입력받아서 숫자만큼의 콤비네이션을 모두 출력한다.
- 예를들어 2를 입력하면 `01, 02, 03, 04, 05, 06, 07, 08, 09, 12, 13, 14, 15, 16, 17, 18, 19, 23, 24 ... 78, 79, 89` 이런식으로 2개의 숫자의 콤비네이션을 콤마로 구분해서 모두 출력하는 것. 마지막엔 콤마 없어야 한다.

## 2. 코드

```c
#include <unistd.h>
#include <stdio.h>

void ft_putchar(char c);
void ft_putnbr(int nb, int digit);
int is_payload(int target, int digit);
void ft_recursive_combn(int cnt, int start, int payload, int digit);
void ft_print_combn(int n);

int main(void)
{
    int n;

    scanf("%d", &n);
    ft_print_combn(n);
    return (0);
}

void ft_putchar(char c)
{
    write(1, &c, 1);
}

void ft_putnbr(int nb, int digit)
{
    int arr[1000];
    int i;

    i = -1;
    while (nb)
    {
        i++;
        arr[i] = nb % 10;
        nb /= 10;
    }
    if (i < digit)
    {
        while (digit - i - 1)
        {
            ft_putchar('0');
            digit--;
        }
    }
    while (i >= 0)
    {
        ft_putchar(arr[i] + 48);
        i--;
    }
}

int is_payload(int target, int digit)
{
    if (digit == 1)
        return (target == 8 ? 1 : 0);
    else if (digit == 2)
        return (target == 78 ? 1 : 0);
    else if (digit == 3)
        return (target == 678 ? 1 : 0);
    else if (digit == 4)
        return (target == 5678 ? 1 : 0);
    else if (digit == 5)
        return (target == 45678 ? 1 : 0);
    else if (digit == 6)
        return (target == 345678 ? 1 : 0);
    else if (digit == 7)
        return (target == 2345678 ? 1 : 0);
    else
        return (target == 12345678 ? 1 : 0);
}

void ft_recursive_combn(int cnt, int start, int payload, int digit)
{
    if (cnt > 0)
    {
        while (start < 10 - cnt)
        {
            ft_recursive_combn(cnt - 1, start + 1, payload * 10 + start, digit);
            start++;
        }
    }
    else
    {
        while (start < 10 - cnt)
        {
            ft_putnbr(payload, digit);
            ft_putchar(start + 48);
            start++;
            if (payload == 0 && start == 10 && digit != 1)
                ;
            else if (!is_payload(payload, digit))
            {
                ft_putchar(',');
                ft_putchar(' ');
            }
        }
    }
}

void ft_print_combn(int n)
{
    ft_recursive_combn(n - 1, 0, 0, n - 1);
}
```
