# Greedy Algorithm

참고링크: [나무위키](https://namu.wiki/w/그리디%20알고리즘), [janghw 티스토리](http://janghw.tistory.com/entry/알고리즘-Greedy-Algorithm-탐욕-알고리즘)

매 순간 최선의 선택을 하는 알고리즘이다. 특정 선택을 할 때마다 최선의 선택을 하면 결국엔 최종적으로 가장 최적의 답을 찾는 원리. 하지만 전술의 승리가 항상 전략의 승리로 가는 것은 아닌 것처럼 예외가 존재한다.

## 1. 거스름돈 예제

- 문제 내용: 1원, 7원, 10원짜리 동전이 있고 14원을 거슬러줘야한다.
- greedy 알고리즘으로는 10원부터 시작해서 10원 1개, 1원 4개로 거슬러줄 것이다. 하지만 7원짜리를 사용하면 단 2개로 거슬러줄 수 있다.
- greedy, 즉 탐욕 알고리즘으로 불리는 이유는 다음처럼 현재만 바라보고 욕심을 부려서 최대한 특정 작업을 완수하려 하기 떄문이다.\
- 그래서 아래 거스름돈 예제같은 경우엔 각 동전이 서로 배수 관계를 가지는지 먼저 알아봐야한다. 즉 각 단계의 최적의 해를 모았을 때 전체의 최적 해가 되는지를 먼저 확인하고 탐욕 알고리즘을 써야 함.

```c
#include <stdio.h>

int main(void)
{
    int m, i = 0, f = 0;
    int coin[3] = {10, 7, 1};
    int count[3] = {0, 0, 0};

    scanf("%d", &m);
    while (i < 3)
    {
        if (coin[i] > m)
        {
            i++;
        }
        else if (coin[i] < m)
        {
            m -= coin[i];
            count[i]++;
        }
        else
        {
            f = 1;
            count[i]++;
            break;
        }
    }
    if (f)
        printf("%d, %d, %d\n", count[0], count[1], count[2]);
    else
        printf("Can't give change.\n");
    return 0;
}
```

