#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
//다음 줄에 필요한 header file과 symbolic constant 들을 선언
//불변의 상수(예:지구의 둘레, 1분은 60초 등)는 symbolic constant로 선언할 것
//실행 결과는 첨부된 실행파일 참고
//제출 : 11월 4일 오후 3:00까지 와이섹에 소스코드 업로드

/*
1.  영문 문장을 입력받아 글자 수와 단어 수 및 평균 단어 길이를 구하는 프로그램
    글자수는 마침표,특수문자등을 포함(공백제외).

    힌트 : getchar() 사용
    http://www.cplusplus.com/reference/cstdio/getchar/ 혹은 p478 참고
    getchar()는 scanf()와 마찬가지로 키보드로 문자를 입력 받을 수 있음
    scanf는 지정한 형식(%d, %f 등)에 따라 입력한 문자열을 변수에 저장하는 반면,
    getchar()는 입력한 문자열의 문자가 한개 씩 차례대로 getchar()를 통하여 반환이 됨
    예를 들어 while(getchar() != '\n') {...}은 입력한 문자열의 문자 갯수 만큼(즉, 엔터를 만날 때 까지)
    while문을 반복함.

*/
#include <stdio.h>

int main(void) {
    int dates[20][6] = {0};
    int ch = 0;
    int i = 0;
    int j = 0;
    int temp = 0;
    int earliest_row = 0;

    printf("날짜 입력: ");
    while ((ch=getchar()) != '\n') {
        if (ch == '/' || ch == ',' || ch == ' ' || ch == ':') {
            continue;
        }
        dates[i][j] = ch;
        j++;
        if (j > 5) {
            i++;
            j = 0;
        }
    }

    for(j = 0; j < 6; j++) {
        for(i = 0; i < 20; i++) {
            if (i == 0) {
                temp = dates[i][j];
            }
            if (temp <= )
        }
    }

    return 0;
}


void Problem1(void)
{
}

/*
    2.  1개 이상의 년/월/일을 입력받아 가장 빠른 날짜를 출력
    년/월/일은 모두 2자리 형태로 입력.
    예) 15/01/01 : 2015년 1월 1일
    입력 종료는 0/0/0 입력
    윤년은 고려하지 않으며 달은 무조건 30일, 1년은 365일
    년도는 00~99까지만 입력(즉 사용자가 2000-2099까지만 입력함)
    time 관련 함수를 쓰지 않으며 조건문 및 반복문 만으로 구현
*/
void Problem2(void)
{

}

/*
    3.  0에서 8사이의 n을 입력받아 1/1!  1/2!  1/3!  ...  1/n! 를 계산하여 출력
    범위 밖의 입력에 대한 에러 처리는 생략가능
    factorial은 반복문으로 계산 할 것
*/
void Problem3(void)
{
}



/*
    4. 임의의 정수 n을 입력받아 자리수를 계산하여 출력
    자리수를 계산하는 find_digit() 함수를 recursive function으로 작성할 것
    단, 함수는 prototype을 먼저 선언 하고 함수 구현은 따로 할 것.
*/
void Problem4() {
    int n;
    printf("임의의 정수 n의 자리수를 계산하는 프로그램\n");
    printf("정수 입력: ");
    scanf("%d", &n);
    printf("%d는 %d자리 정수\n", n, find_digit(n));
}

/*
    5. n이 1부터 12까지 일 때 Stirling Approximation의 오차값을 구하여 출력
    factorial() 및 striling_approximation() 함수를 정의하여 사용하며 prototype을 먼저 선언 하고 함수 구현은 따로 할 것.

    참고 : Stirling Approximation (https://en.wikipedia.org/wiki/Stirling's_approximation)
    n!의 값을 근사값으로 구하는 잘 알려진 공식. 이 공식을 이용하면 반복이나 재귀를 통하지 않고 한번의 연산으로 n!의 값을 구할 수 있음
    정의는 위 링크에 있으며 (a more precise variant of the formula is therefore.. 다음에 있는 수식)
    n!과 Stirling 근사값의 비율을 그 아래 수식으로구할 수 있음

    힌트 : 수학 함수를 사용하세요.
*/
void Problem5() {
    int n;
    printf("n이 1부터 12까지 일 때 n!과 Stirling Approximation의 ratio를 구하는 프로그램\n");
    printf(" n\t Ratio\n");
    //반복문 작성
        printf("n: %2d\t %f\n", n, stirling_approximation(n));
}

int main(void) {
    printf("\n****************************** Problem 1 ******************************\n");
    Problem1();
    printf("\n****************************** Problem 2 ******************************\n");
    Problem2();
    printf("\n****************************** Problem 3 ******************************\n");
    Problem3();
    printf("\n****************************** Problem 4 ******************************\n");
    Problem4();
    printf("\n****************************** Problem 5 ******************************\n");
    Problem5();

    return 0;
}
