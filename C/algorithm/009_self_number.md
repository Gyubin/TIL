# #9 Self Number

문제 링크: https://www.acmicpc.net/problem/4673

- 함수 정의: 양의 정수 n에 대해서 `d(n)`은 `n`과 `n의 각 자리수`를 더하는 함수
    + `d(75) = 75+7+5 = 87`
    + n을 d(n)의 생성자라고 한다.
- 셀프 넘버는 위 함수에서 생성자가 없는 수를 말한다.
- 문제는 10000 이하의 모든 셀프 넘버를 한 줄에 하나씩 출력하는 것이다.

## 1. 내 코드

```c
#include <unistd.h>

void    fill_arr(int *arr);
void    print_arr(int *arr);
int     gen(int num);
void    ft_putchar(char c);
void    put_num(int num);

int     main(void)
{
    int arr[10001] = {0};

    fill_arr(arr);
    print_arr(arr);
    return (0);
}

void    fill_arr(int *arr)
{
    int i;
    int j;

    i = 1;
    while (i <= 10001)
    {
        j = gen(i);
        if (j <= 10000)
            arr[j] = 1;
        i++;
    }
}

void    print_arr(int *arr)
{
    int i;

    i = 1;
    while (i <= 10001)
    {
        if (!arr[i])
        {
            put_num(i);
            ft_putchar('\n');
        }
        i++;
    }
}

int     gen(int num)
{
    int result;

    result = num;
    while (num > 0)
    {
        result += num % 10;
        num /= 10;
    }
    return (result);
}

void    ft_putchar(char c)
{
    write(1, &c, 1);
}

void    put_num(int num)
{
    if (num >= 10)
    {
        put_num(num / 10);
        put_num(num % 10);
    }
    else
    {
        ft_putchar('0' + num);
    }
}
```

# 2. 다른 사람 코드

https://www.acmicpc.net/source/4175266

```c
#include <stdio.h>

main(i,n,d){
 char a[10101]={0,};
 for(i=1;i<=10000;i++){
  d=n=i;
  while(n){
   d+=n%10;
   n/=10;
  }
  a[d]++;
 }
 for(i=1;i<=10000;i++){
  if(a[i]==0)
   printf("%d\n",i);
  }
}
```
