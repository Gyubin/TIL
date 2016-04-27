# Java 기초 정리

참고 링크: [Wikidocs](https://wikidocs.net/191)

## 0. 설치

- JDK 설치: [다운로드 페이지](http://www.oracle.com/technetwork/java/javase/downloads/index.html)로 들어가서 `Java Platform (JDK)`를 설치하면 된다. 현재 기준으로 최신 버전은 '8u91 / 8u92'였다.
- IntelliJ IDEA 설치: JetBrains의 자바 IDE다. [다운로드](https://www.jetbrains.com/idea/)

### 0.1 개념 설명

- JVM: 자바 가상 머신(Java Virtual Machine)
    + `javac` 명령어로 생성되는 `.class` 파일을 실행할 수 있다.
    + 플랫폼 의존적(윈도우 JVM != 리눅스 JVM)이다.
    + `.class` 파일은 어떤 JVM에서도 동일하게 동작한다.
    + 바이너리 코드를 읽고, 검증하고, 실행하는 역할을 한다.
    + JRE(Java Runtime Environment)의 규격, 즉 필요한 라이브러리와 파일들의 규격을 제공.
- JRE: 자바 실행환경(Java Runtime Environment)
    + JVM이 자바로 된 앱을 동작시킬 때 필요한 라이브러리와 기타 파일들 보유.
    + JRE는 JVM의 실행환경, 규격을 구현한 것.
- JDK: 자바 개발도구(Java Development Kit). JRE에 javac(Java Compiler), java 등이 포함된 것.

![structure](http://wikidocs.net/images/page/257/jdk.jpg)

![java_compiler](http://wikidocs.net/images/page/256/compile.png)

- `javac`: `.java` 파일을 컴파일해서 `.class` 형태로 만든다.
- `java`: `.class` 파일을 JVM에서 실행하는 역할

### 0.2 IntelliJ IDEA 간단 시작하기

- 디렉토리 개념
    + 하나의 Project가 존재한다. 전체 workspace를 의미한다.
    + Project 안에 여러 Module이 있다.
    + Module 안에 여러 Package, class가 존재한다.
- [beyondj2ee 블로그](https://beyondj2ee.wordpress.com/2013/06/15/인텔리j-시작하기-part2-getting-start-intellij-자바-프로젝트편)를 참고하면 프로젝트 생성할 때 'Empty project'로 생성하고, 모듈을 하나하나 추가하는 것이 좋다고 한다.

## 1. 기본

- 변수명: 숫자와 특수기호(`_`, `$`는 가능)가 맨 앞에 올 수 없다. 자바의 키워드가 변수명이 될 수 없음도 당연.

    ```
    abstract  continue  for         new        switch
    assert    default   goto        package    synchronized
    boolean   do        if          private    this
    break     double    implements  protected  throw
    byte      else      import      public     throws
    case      enum      instanceof  return     transient
    catch     extends   int         short      try
    char      final     interface   static     void
    class     finally   long        strictfp   volatile
    const     float     native      super      while
    ```

- 자료형: 변수를 처음 선언할 때 꼭 자료형을 명시해줘야 한다.
    + 숫자(Number): `int`, `long`, `double`, `float`, (`byte`, `short`도 있지만 거의 사용하지 않는다.)
    + 참, 거짓: `boolean`
    + 문자: `char`
    + 문자열 관련: `String`, `StringBuffer`
    + 배열: ArrayList
    + 해시: HashMap
- `+`, `-`, `/`, `%`는 다른 언어와 같은 기능이다. `++`, `--` 연산자 존재하고 변수 앞뒤로 붙는 결과가 다르다.
- 주석: `//`, `/* */` 형태로 사용한다. 모든 코드에 주석을 다는 것은 코드를 지저분하게 만들 뿐이므로 복잡한 부분에만 달도록 한다.
- `public` : 메소드의 접근제어자, public은 누구나 이 메소드에 접근할 수 있다는 의미
- `static` : 메소드에 static 이 지정되어 있는 경우 이 메소드는 인스턴스 생성없이 실행 할 수 있음을 의미

## 2. 자료형

### 2.1 Number

#### 2.1.1 정수형

- `int`: 범위는 -2147483648 ~ 2147483647
- `long`
    + 범위: -9223372036854775808 ~ 9223372036854775807
    + `long hi = 2131241414412L;` 형태로 숫자 맨 뒤에 대문자 L을 붙여줘야 함.

#### 2.1.2 실수형

- `double`: 실수를 표현할 때 디폴트 값
- `float`: `float hi = 3.234234f;` 처럼 맨 뒤에 f를 붙여준다.
- 지수 표현

    ```java
    double a = 123.45;
    double b = 1.2345e2;
    ```

- 8진수: 앞에 0이 붙으면 된다. `int a = 023;`
- 16진수: 앞에 0x가 붙으면 된다. `int a = 0xC;`

### 2.2 boolean

`true`, `false`로 표현

### 2.3 char

문자는 홑따옴표로 감싸주면 된다. 잘 쓰진 않는다고 한다.

```java
char a = 'a';   // a
char aa = 97;   // a
char aaa = '\u0061';    // a
```

### 2.4 String

- 생성자 2가지. 첫 번째 리터럴을 활용한 생성 방식을 추천한다. 가독성과 최적화 측면에서 더 좋다.
    + `String a = "aaa";`
    + `String a = new String("aaa");`
- `int`, `long`, `double`, `float`, `boolean`, `char`를 primitive type이라고 하고 리터럴을 활용해 값 세팅이 가능하다. 대신 new를 통한 생성은 불가능. String은 primitive type은 아니지만 예외적으로 리터럴을 활용한 생성이 가능한 것.
- `myString.equals(yourString)` : 문자열이 같은지 확인할 땐 `equals` 함수를 쓴다. `==`를 쓰면 리터럴이 아니라 new로 생성한 경우 변수가 가리키는 메모리 값을 비교하게 돼서 같은 문자열이지만 false가 나올 수 있다.

    ```java
    String a = "hello";
    String b = new String("hello");
    System.out.println(a.equals(b));    // 문자열 비교
    System.out.println(a==b);   // 메모리 주소 비교
    ```

- `myString.indexOf(subString)`: 어떤 문자열 내에서 특정 문자열 부분이 시작되는 인덱스를 알아낼 수 있다.

    ```java
    String a = "Hello Java";
    System.out.println(a.indexOf("Java"));
    ```

- `myString.replaceAll(str, repl);` : myString에서 str을 repl로 바꾼다.
- `myString.substring(start, end);` : 문자열에서 시작, 끝 인덱스의 문자열을 뽑아낸다. 끝 인덱스는 포함하지 않는다.
- `myStr.toUpperCase()`, `myStr.toLowerCase()`: 대소문자로 변경

### 2.5 StringBuffer

문자열을 조작할 때 사용하는 자료형이다. 아래 코드는 StringBuffer 인스턴스를 append 함수를 통해 문자열을 계속 추가해나가는 코드다.

```java
StringBuffer sb = new StringBuffer();
sb.append("hello");
sb.append(" ");
sb.append("jump to java");
System.out.println(sb.toString());
```

단순히 String 자료형을 `+` 연산자로 이어도 같은 결과가 나온다. 다만 + 연산할 때마다 새로운 문자열이 메모리에  생기게 된다. 결과는 하나의 문자열이 바뀌는 것처럼 보이지만 String 자료형이 immutable이라서 새로운 문자열이 계속 만들어져야 한다. 하지만 StringBuffer는 mutable이라서 하나의 객체가 계속 변할 수 있다. 메모리에서 훨씬 우수한 부분이지만 String 보다는 더 무거운 객체이기 때문에 상황에 맞게 잘 써야 한다.

- `stringBuffer.insert(index, str)`: StringBuffer 객체의 index 위치에 str 추가.

    ```java
    StringBuffer sb = new StringBuffer();
    sb.append("jump to java");
    sb.insert(0, "hello ");
    ```

- `stringBuffer.substring(start, end)`: 시작, 끝 인덱스의 문자열을 뽑아낸다.

    ```java
    StringBuffer sb = new StringBuffer();
    sb.append("Hello jump to java");
    System.out.println(sb.substring(0, 4));
    ```

### 2.6 Array

같은 primitive type의 값들이 모인 자료형이다. 길이는 `.length` 형태로.

```java
int[] odds = {1, 3, 5, 7, 9};
String[] weeks = {"월", "화", "수", "목", "금", "토", "일"};
```

### 2.7 List

- 가장 대표적인 것이 `ArrayList`다.
- 생성: `ArrayList myVar = new ArrayList();`
- `add(value)`: 원소 추가
- `get(index)`: index의 원소를 리턴
- `size()`: 길이 리턴
- `contains(value)`: value가 있는지 boolean으로 리턴
- 원소 삭제 2가지
    + `remove(index)`: 인덱스를 지정해서 삭제하고, 삭제한 원소를 리턴. 원소가 모두 정수형이라도 매개변수에 정수형태를 넣으면 아래 객체를 넣는 방식처럼 작동하지 않는다.
    + `remove(object)`: 특정 원소를 지정해서 삭제하고, 성공했는지 boolean 리턴




















