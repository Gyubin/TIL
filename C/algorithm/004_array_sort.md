# 004 Array sort

## 1. 문제

정렬하는 예제 2가지다. 둘 모두에 버블 소트를 사용했다. 최대한 포인터를 많이 활용하는 방향으로 하는 중인데 굉장히 재미있다.

- 문제 1: 정수형 배열을 가리키는 정수형 포인터와 배열 크기를 입력받아서 정렬한다.
- 문제 2: 쉘 커맨더를 통해 매개변수를 입력받아서 문자열들을 비교해 역순으로 정렬한다.

## 2. 코드

### 2.1 정수형 배열 정렬

```c
void    ft_sort_integer_table(int *tab, int size)
{
    int i;
    int flag;
    int tmp;

    flag = 1;
    while (flag)
    {
        flag = 0;
        i = 0;
        while (i < size - 1)
        {
            if (*(tab + i) > *(tab + i + 1))
            {
                tmp = *(tab + i);
                *(tab + i) = *(tab + i + 1);
                *(tab + i + 1) = tmp;
                flag = 1;
            }
            i++;
        }
    }
}
```

### 2.2 문자열 배열 정렬

```c
#include <unistd.h>

void    ft_putchar(char c);
void    ft_print_params(int argc, char **argv);
int     ft_strcmp(char *s1, char *s2);
void    ft_bubble_sort(int argc, char ***ptr);

int     main(int argc, char **argv)
{
    ft_bubble_sort(argc, &argv);
    ft_print_params(argc, argv);
    return (0);
}

void    ft_bubble_sort(int argc, char ***ptr)
{
    int     i;
    int     flag;
    char    *tmp_ptr;

    flag = 1;
    while (flag)
    {
        flag = 0;
        i = 1;
        while (i < argc - 1)
        {
            if (ft_strcmp((*ptr)[i], (*ptr)[i + 1]) > 0)
            {
                tmp_ptr = (*ptr)[i];
                (*ptr)[i] = (*ptr)[i + 1];
                (*ptr)[i + 1] = tmp_ptr;
                flag = 1;
            }
            i++;
        }
    }
}

int     ft_strcmp(char *s1, char *s2)
{
    while (*s1 == *s2 && *s1)
    {
        s1++;
        s2++;
    }
    return (*s1 - *s2);
}

void    ft_print_params(int argc, char **argv)
{
    int i;

    i = 1;
    while (i < argc)
    {
        while (*argv[i])
        {
            ft_putchar(*argv[i]);
            argv[i]++;
        }
        ft_putchar('\n');
        i++;
    }
}
```
