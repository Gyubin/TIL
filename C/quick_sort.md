# Quick Sort

- pseudo code

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

- C 코드

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

int     partition(int a[], int l, int r)
{
    int pivot, i, j, t;

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
