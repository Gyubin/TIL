# #12 단어의 개수

- 문제 링크: https://www.acmicpc.net/problem/1152
- 영어 대소문자와 띄어쓰기만으로 이루어진 문장이 주어질 때 단어의 개수를 구하라. 단어는 띄어쓰기 하나로 구분된다.

## 1. 내 코드

```c
#include <stdio.h>

int     is_sep(char c);

int     main(void)
{
    int     i, cnt;
    char    str[1000001];

    scanf("%[^\n]s", str);
    cnt = 0;
    i = 0;
    while (str[i])
    {
        if (!is_sep(str[i]) && is_sep(str[i + 1]))
            cnt++;
        i++;
    }
    printf("%d\n", cnt);
    return (0);
}

int     is_sep(char c)
{
    if (c == ' ' || c == '\0')
        return (1);
    return (0);
}
```

- 현재 문자가 알파벳이고, 그 다음 문자가 공백일 때만 단어 개수를 1씩 늘렸다.
- scanf에서 입력 조건을 커스텀 설정했다. 개행 문자를 만날 때까지 받아들인다.
