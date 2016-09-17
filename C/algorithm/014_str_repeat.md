# #14 문자열 반복

- 문제 링크: https://www.acmicpc.net/problem/2675
- 문자열 S를 입력받은 후에, 각 문자를 R번 반복해 새 문자열 T를 만든 후 출력하는 프로그램을 작성하시오.
- S에는 QR Code "alphanumeric" 문자만 들어있다.
    + `0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ$%*+-./:`
- 입력
    + 첫째 줄: 테스트 케이스의 개수 T(1 <= T <= 1,000)
    + 각 테스트 케이스: 반복 횟수 R(1 <= R <= 8), 문자열 S가 공백으로 구분되어 주어진다.
    + S의 길이는 적어도 1이며, 20글자를 넘지 않는다.

## 1. 내 코드

```c
#include <stdio.h>

int     main(void)
{
    int     case_num = 0;
    int     repeat = 0;
    int     hold = 0;
    int     i = 0;
    char    str[21] = {0};

    scanf("%d", &case_num);
    while (case_num--)
    {
        scanf("%d", &repeat);
        scanf("%s", str);
        i = 0;
        while (str[i])
        {
            hold = repeat;
            while (hold--)
                printf("%c", str[i]);
            i++;
        }
        printf("\n");
    }
    return (0);
}
```

## 2. 다른 사람 코드

```c
#include <stdio.h>
 
int main()
{
    int t, r, i, j;
    char s[21];
     
    scanf("%d", &t);
 
    while(t--) {
        scanf("%d %s", &r, s);
        for(i=0; s[i]!=0; i++) 
            for(j=0; j<r; j++)
                printf("%c", s[i]);
        printf("\n");
    }
}
```
