# 004 Integer array sort

## 1. 문제

정수형 배열을 가리키는 정수형 포인터와 배열 크기를 입력받아서 정렬한다.

## 2. 코드

### 2.1 버블 소트

```c
void    ft_sort_integer_table(int *tab, int size)
{
    int i;
    int flag;
    int tmp;

    flag = 1;
    while (flag)
    {
        flag = 0;
        i = 0;
        while (i < size - 1)
        {
            if (*(tab + i) > *(tab + i + 1))
            {
                tmp = *(tab + i);
                *(tab + i) = *(tab + i + 1);
                *(tab + i + 1) = tmp;
                flag = 1;
            }
            i++;
        }
    }
}
```
