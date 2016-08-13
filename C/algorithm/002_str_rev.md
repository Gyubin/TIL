# 002 String reverse

## 1. 문제

문자 배열을 포인터로 입력받아서 따로 문자 배열 선언 없이 문자열을 reverse한 후 그 포인터를 리턴하는 문제다.

## 2. 내 코드

```c
char *ft_strrev(char *str)
{
    int i;
    int size;
    char tmp;

    size = 0;
    while (str[size])
        size++;
    size--;
    i = 0;
    while (i < size)
    {
        tmp = str[i];
        str[i] = str[size];
        str[size] = tmp;
        i++;
        size--;
    }
    return (str);
}
```

- 포인터를 한칸씩 이동하며 문자열의 크기를 구한다.
- 널 문자를 제외한 끝 문자와 첫문자를 하나씩 스왑한다.
