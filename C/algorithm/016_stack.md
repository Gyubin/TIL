# 스택

- 문제 링크: https://www.acmicpc.net/problem/10828
- 스택에서 push, pop, size, empty, top 기능 구현하기

## 1. 내 코드

```c
int     main(void)
{
    int     command_num;
    int     stack[10000];
    char    command[6];
    int     top, value;

    scanf("%d", &command_num);
    top = 0;
    while (command_num--)
    {
        scanf("%s", command);
        if (command[0] == 'p')
        {
            if (command[1] == 'u')
            {
                scanf("%d", &value);
                stack[top] = value;
                top++;
            }
            else if (command[1] == 'o')
            {
                if (top != 0)
                {
                    top--;
                    printf("%d\n", stack[top]);
                    stack[top] = 0;
                }
                else
                {
                    printf("%d\n", -1);
                }
            }
        }
        else if (command[0] == 's')
        {
            printf("%d\n", top);
        }
        else if (command[0] == 'e')
        {
            printf("%d\n", top == 0 ? 1 : 0);
        }
        else if (command[0] == 't')
        {
            printf("%d\n", top != 0 ? stack[top - 1] : -1);
        }
    }
    return (0);
}
```
