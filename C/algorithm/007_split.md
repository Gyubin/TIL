# 006 Split

공백 문자들(`\t`, `\n`, ` `) 기준으로 자르기

```c
#include <stdlib.h>

int     is_sep_or_null(char c)
{
    if (c == ' ' || c == '\n' || c == '\t' || c == '\0')
        return (1);
    return (0);
}

int     ft_get_words_cnt(char *str)
{
    int cnt;

    cnt = 0;
    while (*str)
    {
        if (!is_sep_or_null(*str) && is_sep_or_null(*(str + 1)))
            cnt++;
        str++;
    }
    return (cnt);
}

void    record_word_len(int **ptr, char *str)
{
    int cnt;
    int i;

    i = 0;
    cnt = 0;
    while (*str)
    {
        if (is_sep_or_null(*str))
        {
            if (cnt)
            {
                (*ptr)[i] = cnt;
                i++;
            }
            cnt = 0;
        }
        else
        {
            cnt++;
        }
        str++;
    }
    if (cnt)
        (*ptr)[i] = cnt;
}

void    record_string(char **str_arr, char *str, int n, int word_len)
{
    int cnt;
    int i;
    int mem;

    cnt = 0;
    i = 0;
    while (str[i])
    {
        if (!is_sep_or_null(str[i]))
        {
            if (is_sep_or_null(str[i - 1]))
                mem = i;
            if (is_sep_or_null(str[i + 1]))
                cnt++;
            if (cnt == n)
                break ;
        }
        i++;
    }
    i = 0;
    while (i < word_len)
        (*str_arr)[i++] = str[mem++];
    (*str_arr)[i] = '\0';
}

char    **ft_split_whitespaces(char *str)
{
    int     len;
    int     *word_len_arr;
    char    **str_arr;
    int     i;

    if (!*str)
        return (NULL);
    len = ft_get_words_cnt(str);
    str_arr = (char **)malloc(sizeof(*str_arr) * (len + 1));
    word_len_arr = (int *)malloc(sizeof(*word_len_arr) * len);
    record_word_len(&word_len_arr, str);
    i = 0;
    while (i < len)
    {
        str_arr[i] = (char *)malloc(sizeof(**str_arr) * (word_len_arr[i] + 1));
        record_string(&str_arr[i], str, i + 1, word_len_arr[i]);
        i++;
    }
    str_arr[len] = 0;
    free(word_len_arr);
    i = 0;
    while (i < len)
        free(str_arr[i++]);
    free(str_arr);
    return (str_arr);
}
```
