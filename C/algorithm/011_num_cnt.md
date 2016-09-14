# #10 숫자의 개수

세 숫자를 입력받아 모두 곱한 후, 특정 숫자가 몇 번 결과값에 사용되었는지 나타낸다. 예를 들어 1123이라면 `0 2 1 1 0 0 0 0 0 0`를 한 줄씩 띄워서 출력하면 된다.

## 1. 내 코드

```c
#include <stdio.h>

int     main(void)
{
    int a, b, c, tmp, i;
    int arr[10] = {0};

    scanf("%d", &a);
    scanf("%d", &b);
    scanf("%d", &c);
    tmp = a * b * c;
    while (tmp > 0)
    {
        arr[tmp % 10]++;
        tmp /= 10;
    }
    for (i = 0; i < 10; i++)
        printf("%d\n", arr[i]);
    return (0);
}
```
