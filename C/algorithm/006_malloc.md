# 006 Malloc 예제들

## 1. 쉘 커맨드의 매개변수 잇기

```c
#include <stdlib.h>

int     ft_strlen(char *str)
{
    int size;

    size = 0;
    while (str[size])
        size++;
    return (size);
}

int     ft_strlen_all(int argc, char **argv)
{
    int len;
    int i;

    len = 0;
    i = 1;
    while (i < argc)
    {
        len += ft_strlen(argv[i]);
        i++;
    }
    return (len);
}

char    *ft_concat_params(int argc, char **argv)
{
    int     i;
    int     j;
    int     k;
    int     len;
    char    *str;

    if (argc == 1)
        return (NULL);
    len = ft_strlen_all(argc, argv);
    str = (char *)malloc(sizeof(*str) * (len + argc - 1));
    k = 0;
    i = 1;
    while (i < argc)
    {
        j = 0;
        while (argv[i][j])
            str[k++] = argv[i][j++];
        str[k++] = '\n';
        i++;
    }
    str[k - 1] = '\0';
    free(str);
    return (str);
}
```

## 2. 숫자의 베이스 달리 표현하기

```c
#include <stdlib.h>

int     ft_strlen(char *str)
{
    int len;

    len = 0;
    while (*str++)
        len++;
    return (len);
}

int     ft_decimalize(char *nbr, char *base)
{
    int     result;
    int     digit;
    int     i;
    int     j;

    digit = ft_strlen(base);
    result = 0;
    i = 0;
    while (nbr[i])
    {
        j = 0;
        while (base[j])
        {
            if (nbr[i] == base[j])
            {
                result = (digit * result) + j;
                break ;
            }
            j++;
        }
        i++;
    }
    return (result);
}

char    *ft_basify(int num, char *base_str)
{
    int     base_num;
    int     digit;
    char    *result;
    int     i;
    int     target;

    base_num = ft_strlen(base_str);
    target = num;
    digit = 0;
    while (target > 0)
    {
        digit++;
        target /= base_num;
    }
    result = (char *)malloc(sizeof(*result) * (digit + 1));
    i = digit - 1;
    while (i >= 0)
    {
        result[i] = base_str[num % base_num];
        num /= base_num;
        i--;
    }
    result[i] = '\0';
    free(result);
    return (result);
}

int     check_base(char *base)
{
    int i;
    int base_num;

    base_num = 0;
    while (base[base_num])
    {
        if (base[base_num] == '+' || base[base_num] == '-')
            return (0);
        i = 0;
        while (i < base_num)
        {
            if (base[base_num] == base[i])
                return (0);
            i++;
        }
        base_num++;
    }
    if (base_num < 2)
        return (0);
    return (base_num);
}

char    *ft_convert_base(char *nbr, char *base_from, char *base_to)
{
    int     middleware;

    if (!*nbr || !check_base(base_from) || !check_base(base_to))
        return (NULL);
    middleware = ft_decimalize(nbr, base_from);
    return (ft_basify(middleware, base_to));
}
```
