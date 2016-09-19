# 분수 찾기

- 문제 링크: https://www.acmicpc.net/problem/1193
- 링크에 접속하면 분수 표가 있다. 숫자를 입력받아 그 숫자 번째의 분수를 출력하는 문제

## 1. 내 코드

```c
#include <stdio.h>

int     main(void)
{
    int num;
    int line;
    int tmp;

    scanf("%d", &num);
    line = 1;
    while (1)
    {
        tmp = line * (line + 1) / 2;
        if (tmp >= num)
            break ;
        line++;
    }
    if (line % 2 == 0)
        printf("%d/%d\n", line - tmp + num, tmp - num + 1);
    else
        printf("%d/%d\n", tmp - num + 1, line - tmp + num);
    return (0);
}
```

- 대각선으로 묶으면 분자와 분모의 합이 같다.
- 대각선을 하나씩 넘어갈수록 분자 분모의 합이 1씩 커지고, 분수의 개수도 1개씩 늘어난다.
- 대각선을 `line`이라 두고, `n(n+1)/2` 공식을 활용해 어느 라인에 찾고자 하는 분수가 위치하는지 찾아낸다.
- 홀수, 짝수 line이 각각 순서가 반대로 되어있으므로 마지막에 반대로 출력해준다.
