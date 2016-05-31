# Make

빌드 도구. 여러 파일들과 사용하는 라이브러리, shell 명령어들을 정의해놓고 한 번에 빌드할 수 있게 해준다. `Makefile`이 있는 디렉토리에서 `make` 명령어로 실행할 수 있다.

[멍멍멍 블로그](http://bowbowbow.tistory.com/12)에서 정말 친절하고 쉽게 설명해놓았다.

## 0. 종류

-목적파일(Target) : 명령어가 수행되어 나온 결과를 저장할 파일 
-의존성(Dependency) : 목적파일을 만들기 위해 필요한 재료 
-명령어(Command) : 실행 되어야 할 명령어들 
-매크로(macro) : 코드를 단순화 시키기 위한 방법

## 1. target 예제

- 기본 구조
    + CC는 컴파일러
    + target은 만들어질 파일. colon으로 구분해서 만드는데 이용할 파일들을 나열
    + command는 **tab**으로 띄워서 해야함. 꼭.

    ```sh
    CC = gcc

    target1 : dependency1 dependency2
        command1
        command2

    target2 : dependency3 dependency4
        command3
        command4

    ```

- 예제
    + 헤더파일이 있어서 각 `.c` 파일의 메소드를 선언해두었다. `memo.c`, `calendar.c`에 메소드가 구현되어있고 `main.c`에서 메소드를 사용하는 형태다.
    + Makefile의 내용은 `.c` 파일로 `.o`를 만들고 -> `.o` 파일들을 모아 `diary_exe`를 만드는 것.
    + 순서는 딱히 상관없나보다. 알아서 make가 해주는듯. 위 아래 상관없이.
    + clean은 더미 타겟을 말함. `make clean` 명령어를 쓰면 실행된다.

    ```sh
    CC = gcc

    diary_exe : memo.o calendar.o main.o
        gcc -o diary_exe memo.o calendar.o main.o

    memo.o : memo.c
        gcc -c -o memo.o memo.c

    calendar.o : calendar.c
        gcc -c -o calendar.o calendar.c

    main.o main.c
        gcc -c -o main.o main.c

    clean :
        rm *.o diary_exe
    ```

## 2. Macro 추가

- 내가 만든 매크로 사용
    + C 언어에서 `#define`과 같은 역할을 한다. 아래처럼 사용한다. 선언하고, `$(TARGET)` 형태로 사용한다.
    + `-W` `-WALL`: 컴파일이 되지 않을 때 오류를 출력하는 옵션.

    ```sh
    CC = gcc
    TARGET = diary_exe
    CFLAGS = -W -WALL
    OBJECTS = memo.o calendar.o main.o

    $(TARGET) : $(OBJECTS)
        $(CC) $(CFLAGS) -o $(TARGET) $(OBJECTS)

    memo.o : memo.c
        $(CC) $(CFLAGS) -c -o memo.o memo.c

    calendar.o : calendar.c
        $(CC) $(CFLAGS) -c -o calendar.o calendar.c

    main.o main.c
        $(CC) $(CFLAGS) -c -o main.o main.c

    clean :
        rm *.o diary_exe
    ```

- 내부적으로 이미 선언되어있는 내부 매크로도 있다. 
    + `%@`: 현재 타겟
    + `%^`: dependency list

    ```sh
    CC = gcc
    TARGET = diary_exe
    CFLAGS = -W -WALL
    OBJECTS = memo.o calendar.o main.o

    all : $(TARGET)
    
    $(TARGET) : $(OBJECTS)
        $(CC) $(CFLAGS) -o %@ %^

    clean :
        rm *.o diary_exe
    ```
