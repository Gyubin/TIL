# 003 atoi - alphabet(?) to integer

## 1. 문제

atoi의 a가 알파벳을 의미하는게 맞는지 모르겠다. 문자열 타입으로 정수를 입력받아서 정수로 타입을 바꿔서 리턴하는 문제다. 음수 체크해야하고 만약 `123a324` 형태라면 a 직전까지 계산하면 된다. 즉 123.

## 2. 코드

```c
int my_pow(int base, int exp)
{
    int result;

    result = 1;
    while (exp > 0)
    {
        result *= base;
        exp--;
    }
    return (result);
}

int ft_atoi(char *str)
{
    int result;
    int digit;
    int is_negative;

    is_negative = 0;
    if (*str == '-')
    {
        is_negative = 1;
        str++;
    }
    digit = 0;
    while (*str <= '9' && *str >= '0')
    {
        digit++;
        str++;
    }
    str -= digit;
    result = 0;
    while (*str <= '9' && *str >= '0')
    {
        result += (*str - '0') * my_pow(10, digit - 1);
        digit--;
        str++;
    }
    return (is_negative ? result * -1 : result);
}
```

- 먼저 첫 글자를 확인해서 `-`라면 미ㅣㄹ 체크를 해둔다. 최종 결과에 -1을 곱하기 위해.
- 문자가 숫자 이외의 것이라면 그 직전까지만 반복을 돈다.
- 먼저 자리수를 구하고 각 자리마다 자리수를 이용해서 10의 제곱을 곱한다음 결과값에 더한다.
