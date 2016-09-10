#include <unistd.h>

void    ft_putchar(char c);
void    ft_putstr(char *str);

int     main(void)
{
    char    str[1001];
    int     ret;
    int     i;

    ft_putstr("string: ");
    ret = read(0, str, 1000);
    str[--ret] = '\0';
    i = 0;
    ret--;
    while (i < ret)
    {
        if (str[i] != str[ret])
        {
            ft_putstr("It's not.\n");
            return (0);
        }
        i++;
        ret--;
    }
    ft_putstr("It's palindrome\n");
    return (0);
}

void    ft_putchar(char c)
{
    write(1, &c, 1);
}

void    ft_putstr(char *str)
{
    while (*str)
        ft_putchar(*str++);
}
