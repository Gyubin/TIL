# 스택

- 문제 링크: https://www.acmicpc.net/problem/10828
- 스택에서 push, pop, size, empty, top 기능 구현하기

## 1. 내 코드

- 배열 사용, 함수화 하지 않음

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

- 수정: 구조체 사용, 함수화

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct  stack
{
    int *stack;
    int top;
}               stack;

int     my_strcmp(char *s1, char *s2);
stack   *stack_init(int len);
void    push(stack *s, int value);
int     pop(stack *s);
int     size(stack *s);
int     empty(stack *s);
int     top(stack *s);

int     main(void)
{
    int     command_num;
    stack   *s;
    char    command[6];
    int     top, value;

    scanf("%d", &command_num);
    s = stack_init(command_num);
    top = 0;
    while (command_num--)
    {
        scanf("%s", command);
        if (my_strcmp(command, "push") == 0)
        {
            scanf("%d", &value);
            s->top=
            s->stack[top] = value;
            top++;
        }
        else if (my_strcmp(command, "pop") == 0)
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
        else if (my_strcmp(command, "size") == 0)
        {
            printf("%d\n", top);
        }
        else if (my_strcmp(command, "empty") == 0)
        {
            printf("%d\n", top == 0 ? 1 : 0);
        }
        else if (my_strcmp(command, "top") == 0)
        {
            printf("%d\n", top != 0 ? stack[top - 1] : -1);
        }
    }
    return (0);
}

int     my_strcmp(char *s1, char *s2)
{
    while (*s1 == *s2 && *s1)
    {
        s1++;
        s2++;
    }
    return (*s1 - *s2);
}

stack   *stack_init(int len)
{
    stack *s;

    s->stack = (int *)malloc(sizeof(int) * len);
    s->top = -1;
    return (s);
}

void    push(stack *s, int value)
{

}
int     pop(stack *s);
int     size(stack *s);
int     empty(stack *s);
int     top(stack *s);
```
