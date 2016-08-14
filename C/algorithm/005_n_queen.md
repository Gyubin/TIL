# 005 N-Queen 알고리즘

## 1. 문제

n by n 체스 판에 퀸을 n개 배치하는데 서로가 한 번에 서로에게 갈 수 없어야 한다. 즉 서로 잡아먹을 수 있는 위치에 없어야 한다. 이 때 배치할 수 있는 가짓수를 구하라.

## 2. 코드

```c
#include <stdio.h>

int my_abs(int n);
int check(int cur);
void print_arr(int *g_arr);
void ft_find(int cur);
int ft_eight_queens_puzzle(void);

int g_cnt = 0;
int g_arr[8] = {0, 0, 0, 0, 0, 0, 0, 0};

int     main(void)
{
    printf("%d\n", ft_eight_queens_puzzle());
    return (0);
}

int     my_abs(int n)
{
    return (n >= 0 ? n : n * -1);
}

int     check(int cur)
{
    int i;

    i = 0;
    while (i < cur)
    {
        if (g_arr[i] == g_arr[cur] || cur - i == my_abs(g_arr[cur] - g_arr[i]))
            return (0);
        i++;
    }
    return (1);
}

void    print_arr(int *g_arr)
{
    int i;

    i = 0;
    while (i < 8)
    {
        printf("%d ", g_arr[i]);
        i++;
    }
    printf("\n");
}

void    ft_find(int cur)
{
    int i;

    if (cur == 8)
    {
        g_cnt++;
        return ;
    }
    i = 0;
    while (i < 8)
    {
        g_arr[cur] = i;
        if (check(cur))
            ft_find(cur + 1);
        i++;
    }
}

int     ft_eight_queens_puzzle(void)
{
    ft_find(0);
    return (g_cnt);
}
```

- 퀸의 위치를 나타내는 배열을 선언하는데 1차원 배열이다. 배열의 인덱스와 값 둘을 활용해서 인덱스는 row, 값은 col을 나타내는데 쓴다.
- `if (g_arr[i] == g_arr[cur] || cur - i == my_abs(g_arr[cur] - g_arr[i]))` 이 조건은 퀸이 한 번에 갈 수 있는 곳에 다른 말이 존재하는지 검사할 때 쓰는 조건이다.
    + 인덱스 값 즉 row 값은 당연히 다르므로 생략하고, 컬럼 값이 같은지 체크한다.
    + 대각선에 위치한 원소가 있는지 검색할 때는 인덱스끼리의 차와 값끼리의 차가 같은지 보면 된다. 판에서 대각선은 기울기 1, -1의 직선이다. 두 값의 차가 같으면 기울기가 1 또는 -1이므로 대각선 상에 위치하는게 된다.
- 재귀 함수를 이용해서 만약 끝까지 도달했을 때만 cnt를 1씩 증가시킨다. 끝이 아닐 때는 모두 확인해야하므로 while 반복문으로 8개 컬럼 값을 하나하나 체크하고, 체크가 오케이일 때만 다음 row로 넘어간다.
