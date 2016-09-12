# Quick Sort

## 0. 개념

- 기준(pivot)을 선택한다.
- 기준보다 작은 수는 왼쪽, 큰 수는 오른쪽에 배치
- 왼쪽 수들과 오른쪽 수들 각각에 재귀적으로 같은 함수를 호출한다.

## 1. pseudo code

```
quicksort (list)
{
    if (length(list) < 2)
        return list
    x = pickPivot(list)
    list1 = {y in list where y < x}
    list2 = {x}
    list3 = {y in list where y > x}
    quicksort(list1)
    quicksort(list3)
    return (concatenate(list1, list2, list3))
}
```

## 2. C 코드

- quick_sort 함수
    + 매개변수로 정수형 배열 포인터, 왼쪽 끝 원소 인덱스, 오른쪽 끝 원소 인덱스를 받는다.
    + 왼쪽 인덱스가 오른쪽 인덱스보다 작을 때까지 재귀 함수를 호출한다.
    + partition 함수로 pivot을 고르고 양쪽으로 재귀 호출.

    ```c
    void    quick_sort(int a[], int l, int r)
    {
        int j;

        if( l < r ) 
        {
            j = partition(a, l, r);
            quick_sort(a, l, j - 1);
            quick_sort(a, j + 1, r);
        }
    }
    ```

- partition 함수
    + 가장 왼쪽의 원소를 pivot으로 두고 시작한다. 오른쪽의 원소 중 가장 가까운 pivot보다 큰 원소를 찾는다.
    + 가장 오른쪽부터 왼쪽 방향으로 pivot보다 작은 원소를 찾는다.
    + 위 두 행동에서 찾은 두 원소를 swap한다.
    + 두 원소가 서로 교차되지 않을 때까지 반복한다.

    ```c
    int     partition(int a[], int l, int r)
    {
        int pivot;
        int i;
        int j;
        int t;

        pivot = a[l];
        i = l;
        j = r + 1;
        while (1)
        {
            do
            {
                ++i;
            } while (a[i] <= pivot && i <= r);
            do
            {
                --j;
            } while (a[j] > pivot);
            if(i >= j)
                break ;
            t = a[i];
            a[i] = a[j];
            a[j] = t;
        }
        t = a[l];
        a[l] = a[j];
        a[j] = t;
        return j;
    }
    ```

## 3. main 파일

```c
#include <unistd.h>

int     partition(int a[], int l, int r);
void    quick_sort(int a[], int l, int r);
void    ft_putchar(char c);
void    ft_putstr(char *str);
void    ft_putnbr(int n);

int     main(void)
{
    int     i;
    int     arr[] = {5, 100, 30, 25, 4, -5, -10, 66};

    ft_putstr("from:");
    for (i = 0; i < 8; i++)
    {
        ft_putchar(' ');
        ft_putnbr(arr[i]);
    }
    ft_putchar('\n');
    quick_sort(arr, 0, 8);
    ft_putstr("to  :");
    for (i = 0; i < 8; i++)
    {
        ft_putchar(' ');
        ft_putnbr(arr[i]);
    }
    ft_putchar('\n');
    return (0);
}

void    ft_putchar(char c)
{
    write(1, &c, 1);
}

void    ft_putstr(char *str)
{
    while (*str)
        ft_putchar(*str++);
}

void    ft_putnbr(int n)
{
    if (n < 0)
    {
        ft_putchar('-');
        n = -n;
    }
    if (n >= 10)
    {
        ft_putnbr(n / 10);
        ft_putnbr(n % 10);
    }
    else
    {
        ft_putchar(n + '0');
    }
}
```
