# Make

빌드 도구. 여러 파일들과 사용하는 라이브러리, shell 명령어들을 정의해놓고 한 번에 빌드할 수 있게 해준다. `Makefile`이 있는 디렉토리에서 `make` 명령어로 실행할 수 있다.

[멍멍멍 블로그](http://bowbowbow.tistory.com/12)에서 정말 친절하고 쉽게 설명해놓았는데 약간 혼동될 수 있는 개념들이 있어서 42 동영상 강의를 바탕으로 좀 더 간추리고 다듬었다.

## 0. 기본 구성

정말 간단하다. 딱 2가지 종류만 있다. **rule**과 **variable**이다.

- rule
    + make 커맨드가 실행하는 여러가지 실행의 종류들이다.
    + `make rule1`, `make rule2` 처럼 터미널에서 실행하면 해당되는 행동들이 실행된다.
    + rule들은 실행될 특정 목적을 위한 쉘 스크립트들을 순서대로 잘 뭉쳐놓은 덩어리라고 볼 수 있겠다. 그 덩어리들을 상황에 맞춰 쓰면 되는 것이다.
    + 콜론을 뒤에 붙이면 자동으로 룰로 인식한다.
- variable
    + 반복되어 사용되는 단어들을 변수화해서 편하게 사용할 수 있게 한다.
    + 모두 대문자로 적는 것이 관습이다.
    + 혹은 스위치를 온 오프하듯이 쉽게 특정 부분을 바꿀 수 있도록 하는 목적도 있다. 예를 들어 컴파일러 이름같은.
    + 지정한 이름은 `$()`를 통해서 어디서나 불러쓸 수 있다.
    + 뒤에 `=`을 붙이면 자동으로 변수로 인식한다.
    + 변수의 내용이 길어지면 `\` 백슬래시로 한 줄 띄운다.

```sh
TEXT = "NICE TO MEET YOU."

my_first_rule:
    echo "HELLO THERE!"
    echo $(TEXT)
```

## 1. 사용

```sh
my_first_rule:
    @echo "HELLO THERE!"

my_second_rule: my_first_rule
    @echo "Nice to meet you. :-)"
```

- colon을 찍으면 rule을 작성할 수 있도록 신택스가 활성화된다.
- 다음 줄부터 룰의 상세내용, 즉 쉘 스크립트를 작성할 수 있는데 무조건 탭으로 인덴트를 줘야 한다.
- 터미널에서 `make my_rule` 형태로 명령할 수 있다. 해당 룰의 커맨드들이 실행된다.
- 그냥 `make`라고만 커맨드를 입력하면, 즉 룰을 언급하지 않으면 가장 위에 선언된 룰이 실행된다.
- 디폴트로 해당 룰의 명령어들이 디스플레이되고, 실행된다. 만약 명령어가 디스플레이되는 것이 싫다면 룰의 상세 쉘 스크립트 맨 앞에 @를 붙여주면 된다.
- 만약 위처럼 룰 옆에 다른 룰을 적어준다면 dependency를 의미한다. 위 코드는 second를 실행하기 전에 first를 실행한다는 의미.
- 디펜던시는 한 칸을 띄워서 여러개 입력할 수 있는데 순서대로 실행된다.
    
## 2. 대표적 구성

```sh
NAME = awesomeprog

SRC = source.c

all: $(NAME)

$(NAME):
    gcc -o $(NAME) $(SRC)

clean:
    /bin/rm -f *.o

fclean: clean
    /bin/rm -f $(NAME)

re: fclean all
```

- 정답은 없다. 다만 이게 보일러플레이트 같은 느낌의 파일이다.
- 만들고, o 파일 지우고, 바이너리파일까지 모두 지우고, 다시 실행하는.
- 특히 re 룰이 정말 편하다.

## 3. target 예제

- 기본 구조
    + CC는 컴파일러
    + target은 만들어질 파일. colon으로 구분해서 만드는데 이용할 파일들을 나열

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

## 4. 변수 사용해보기

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

- 내부적으로 이미 선언되어있는 내부 변수도 있다. 
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

## 5. 내가 서브라임에서 쓰는 방식.

```sh
TARGET = test.o
SOURCE = test.m
FW_FOUN = -framework Foundation

$(TARGET) : $(SOURCE)
    gcc $(FW_FOUN) $(SOURCE) -o $(TARGET)
    ./$(TARGET)
    rm $(TARGET)
```

Obj-C 컴파일 때문에 Make 사용 방법을 찾아봤었다. 위처럼 타겟, 소스 파일과 `Foundation` 프레임워크 사용을 지정해놓고, **컴파일 -> 실행 -> 기존 파일 삭제**가 다 돌아가도록 해놨다. 타겟 파일이 만들어지면 이미 되어있다고 컴파일이 안되서 지우는 것까지 만들어놨다.
