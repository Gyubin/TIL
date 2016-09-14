# #10 OX quiz

- 문제 링크: https://www.acmicpc.net/problem/8958
- OX 퀴즈에서 맞고 틀린 것을 다음처럼 표현한다.
    + `OOXXOXXOOO`
- 맞추면 1점인데 연속으로 맞추면 점수를 1점씩 더 받는다. 위 경우엔 점수가
    + `1+2+0+0+1+0+0+1+2+3` 이렇게 된다.
- 점수를 구하는 프로그램 만들기.

## 1. 내 코드

```c
#include <stdio.h>

int     main(void)
{
    int     case_num;
    char    str[81];
    int     score;
    int     add;
    int     i;

    scanf("%d", &case_num);
    while(case_num)
    {
        score = 0;
        add = 1;
        i = 0;
        scanf("%s", str);
        while (str[i])
        {
            if (str[i] == 'O')
            {
                score += add;
                add++;
            }
            else
            {
                add = 1;
            }
            i++;
        }
        printf("%d\n", score);
        case_num--;
    }
    return (0);
}
```
