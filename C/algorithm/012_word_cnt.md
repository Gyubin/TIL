# #12 단어의 개수

- 문제 링크: https://www.acmicpc.net/problem/1152
- 영어 대소문자와 띄어쓰기만으로 이루어진 문장이 주어질 때 단어의 개수를 구하라. 단어는 띄어쓰기 하나로 구분된다.

## 1. 내 코드

```c
#include <stdio.h>

int     main(void)
{
    char    ch;
    char    prev;
    int     cnt;

    cnt = 0;
    while ((ch = getchar()) == ' ')
        ;
    while ((ch = getchar()) != '\n')
    {
        if (ch == ' ')
            cnt++;
        prev = ch;
    }
    printf("%d\n", prev == ' ' ? cnt : cnt + 1);
    return (0);
}
```

- 맨 앞에 띄워쓰기가 여러개 될 수도 있어서 모두 스킵한다.
- 개행문자가 나오기 전까지 반복해서 띄워쓰기를 만날 때마다 cnt를 1씩 더해준다.
- 문장의 끝에서 마지막 단어를 포함했는지 안했는지 체크한다. 이전 문자를 기록해뒀다가 개행문자 전이 띄워쓰기라면 이미 체크가 되어있을거고, 문자라면 체크가 안되었을테니 1을 더해준다.
