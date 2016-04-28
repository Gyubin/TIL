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
- and(`&&`), or(`||`), not(`!`)
- 값이 없는 것은 `null`
- 접근 제어자. 접근 범위 좁은 순이다.
    + `private`: 해당 클래스에서만 접근 가능
    + `default`: 해당 패키지 내에서만 접근 가능
    + `protected`: 해당 패키지 + 해당 클래스를 상속받은 외부 패키지의 클래스
    + `public`: 어디서든 접근 가능
    + 추가: 클래스 내의 클래스인 inner class에서도 접근 제어자 범위 적용된다.

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

### 2.8 Generics

ArrayList에 들어갈 타입을 고정한다. 만약 제네릭스가 없다면 ArrayList에 추가되는 자료형은 `Object`로 인식된다. 그렇기 때문에 원소를 빼서 변수로 저장할 때는 타입 변환이 필요하다. 하지만 제네릭스를 사용한다면 그럴 필요 없다.

```java
// generics 사용 안했을 경우
ArrayList a = new ArrayList();
a.add("hello");
String hello = (String) aList.get(0);

// generics 사용.
ArrayList<String> b = new ArrayList<String>();
b.add("hello");
String hello = aList.get(0);
```

### 2.9 Map

키, 밸류 쌍을 갖는 자료형이다. `HashMap`을 주로 쓴다. 아래 예제는 제네릭을 활용해 key, value의 타입을 모두 String으로 정한 것이다. `put` 함수로 자료들을 추가했다.

```java
HashMap<String, String> map = new HashMap<String, String>();
map.put("people", "사람");
map.put("baseball", "야구");
```

- `myMap.get(key)`: key에 해당하는 value 리턴
- `myMap.containsKey(key)`: key가 있으면 true, 없으면 false
- `myMap.remove(key)`: key에 해당하는 쌍을 지우고, value를 리턴한다.
- `myMap.size()`: map 자료들의 개수를 리턴

## 3. 제어문

- if, case

    ```java
    if (condition) {
        // code
    } else if (condition) {
        // code
    } else {
        // code
    }

    switch (variable) {
        case var1:
            // code
            break;
        case var2:
            // code
            break;
        default:
            //code
            break;
    }
    ```

- while, for 반복문: 공통으로 `break`, `continue` 적용된다.

    ```java
    while (condition) {
        // code
    }
    
    for (int i = 0; i < 10; i++) {
        // code
    }
    ```

- for each: iterable에서 원소 하나씩 뽑아서 쓰는 구조

    ```java
    String[] numbers = {"one", "two", "three"};
    for (String number: numbers) {
        System.out.println(number);
    }
    ```

## 4. Class

### 4.1 기본

```java
public class Animal {
    String name;

    public void setName(String name) {
        this.name = name;
    }

    public static void main(String[] args) {
        Animal cat = new Animal();
        cat.setName("boby");
        System.out.println(cat.name);
    }
}
```

- Class를 이용해 object(객체)를 만든다. instance란 용어는 관계를 나타낼 때 주로 쓰이는데 위 예에서는 'cat이 Animal의 instance' 라고 말하면 좋다. 'cat은 객체'라고 해도 정확한 표현이다.
- instance variable: 위 코드의 `name`이다. 객체에서 `.`을 통해 접근 가능.
- method: 클래스 내의 함수를 method라고 지칭한다. 리턴 값이 없는 메소드는 타입을 `void`로 지정하면 된다. 그런데 Java에서는 모든 함수가 클래스 내에 존재하기 때문에 그냥 method라고 호칭하면 된다. 뭐든.
- `this`: 클래스의 instance를 지칭한다.

### 4.2 Method

```java
public class Test {
    public int sum(int a, int b) {
        return a+b;
    }

    public static void main(String[] args) {
        int a = 3;
        int b = 4;

        Test myTest = new Test();
        int c = myTest.sum(a, b);

        System.out.println(c);
    }
}
```

- class 안에서 메소드가 구현되고, main 메소드 내에서 사용한다고 보면 됨
- 스코프 역시 함수 안과 밖이 구분된다. 변수 효력 범위에 대한 것. 함수 내에서 만들어지고 사용되는 변수를 local variable(지역 변수)이라고 한다.
- 메소드의 매개변수로 primitve type을 넘기면 call by vlaue지만 클래스의 인스턴스, 즉 객체를 넘기게 되면 call by reference가 된다. 바뀐 값을 다시 대입하지 않더라도 내부 속성 값을 메소드 호출만으로 변경할 수 있다.

### 4.3 상속

```java
public class Dog extends Animal {
    // Animal의 instance variable, method를 그대로 사용 가능
}
```

- `extends` 키워드를 통해 다른 클래스를 상속.
- 부모 클래스의 instance variable, method를 그대로 쓸 수도 있지만 override 할 수도 있다. 똑같은 형태로 적어서 원하는대로 안의 내용을 수정하면 됨.
- 다중 상속은 지원하지 않는다. 부모 클래스는 하나만 존재.

### 4.4 생성자

- 클래스 이름과 동일한 이름을 가지고, 리턴 값이 없는 메소드가 생성자다. 매개변수를 원하는대로 지정해주면 된다.
- 생성자가 없다면 자바 컴파일러가 default 생성자를 자동으로 만들어준다. 아무 매개변수가 없는 생성자가 default 생성자다. 그래서 생성자 없어도 클래스의 인스턴스 생성이 가능한 것이고, 하나라도 다른 생성자를 만들었다면 디폴트 생성자를 만들지 않은 이상 매개변수 없는 생성은 불가능해진다.
- 매개변수를 다르게 받는 생성자를 여러개 만들 수 있다. 이를 오버로딩(overloading)이라고 한다. 다만 매개변수 타입의 순서와 개수가 동일한 생성자는 만들 수 없다.

### 4.5 인터페이스

```java
public class ZooKeeper {    
    public void feed(Predator predator) {
        System.out.println("feed "+predator.getName());
    }
    public static void main(String[] args) {
        Tiger tiger = new Tiger("tiger");
        Lion lion = new Lion("lion");
        ZooKeeper zooKeeper = new ZooKeeper();
        zooKeeper.feed(tiger);
        zooKeeper.feed(lion);
    }
}
```

- 클래스와 비슷한 형태지만 실질적인 값이 없다. 변수와 함수 모두 타입과 이름, 매개변수까지만 지정해준다. 인터페이스를 `implements` 한 클래스에서 구현하라는 의미다. 인터페이스를 구현한다고 해놓고 메소드나 변수를 하나라도 구현하지 않으면 에러가 난다.
- 인터페이스는 상속과 달리 다중 구현이 가능하다. 콤마로 구분해서 적어주면 된다.
- 인터페이스에서 변수나 함수가 public일 경우 굳이 public을 써주지 않아도 된다. 어차피 인터페이스가 public인 것은 모두가 알고있기 때문에 불필요하다.
- 인터페이스는 위 코드 예제에서처럼 하위의 것들을 공통으로 묶어줄 수 있는 '규격' 개념이다. 아래 물리적 세계 부분을 보면 더 쉽게 이해 가능.

|           물리적 세계           |       예제 코드       |
|---------------------------------|-----------------------|
| 컴퓨터                          | ZooKeeper             |
| USB 포트                        | Predator              |
| 하드 디스크, 디지털 카메라, ... | Tiger, Lion, Dog, ... |

### 4.6 다형성(Polymorphism)

- 부모 클래스 `Animal`, 인터페이스 `Predator`, 인터페이스 `Barkable`, 자식 클래스 `Tiger` 이렇게 4가지가 있을 때 Tiger 클래스의 객체는 위 모든 4가지 모양으로 표현될 수 있다. 이렇게 같은 객체지만 다른 자료형으로 표현되면 그 자료형에 속한 변수나 메소드만 활용할 수 있다. 예를 들어 barkable은 bark 메소드만 호출 가능하고, predator는 getName 메소드만 호출할 수 있다.

    ```java
    Tiger tiger = new Tiger();
    Animal animal = new Tiger();
    Predator predator = new Tiger();
    Barkable barkable = new Tiger();
    ```

- 만약 위 같은 상황에서 `bark`, `getName` 메소드 모두 사용하고 싶다면
    + 둘 모두가 구현된 `Tiger` 클래스의 인스턴스를 사용하거나
    + 둘 모두를 포함하는 인터페이스를 사용하면 된다.
        * 새로운 인터페이스를 만들어서 두 메소드 모두 써주는 방법
        * 새로운 인터페이스를 만들어서 Predator, Barkable 인터페이스를 상속하는 방법. 아래 코드와 같다. 인터페이스 끼리는 `extends` 사용할 수 있다.

    ```java
    public interface BarkablePredator extends Predator, Barkable {
    }
    ```

### 4.7 Abstract Class(추상 클래스)

```java
public abstract class Predator extends Animal {
    public abstract String getName();
}
```

- 위와 같은 식이다. class 앞에 abstract를 붙이면 되고 다른 클래스를 상속받을 수 있다. 하지만 interface와 구분이 모호하고 복잡해지기 때문에 쓰는 것을 추천하진 않는다고 한다.
- 내부에 abstract method도 선언할 수 있고, 실제 메소드를 넣을 수도 있다. 실제 메소드는 당연하게 따로 구현 안해도 된다.

## 5. 입출력

### 5.1 콘솔 입출력

#### 5.1.1 입력

- System.in
    + `System.in`(키보드 입력) -> `InputStream`(byte) -> `InputStreamReader`(character) -> `BufferedReader`(String, line 단위)
    + `BufferedReader`는 말 그대로 일정 사이즈를 버퍼에 보관하고 한 번에 읽어오는 방식이다. `readLine` 함수를 통해 줄 단위 읽기 가능.

    ```java
    InputStreamReader r = new InputStreamReader(System.in);
    BufferedReader b = new BufferedReader(r);
    String userInput = b.readLine();
    System.out.println("user input :"+userInput);
    ```

- Scanner
    + 콘솔 입력을 매개변수로 넣어서 Scanner 객체를 만든다.
    + 주요 함수
        * `next()` : 단어
        * `nextLine()` : 라인
        * `nextInt` : 정수

    ```java
    Scanner sc = new Scanner(System.in);
    System.out.println(sc.next());
    ```

#### 5.1.2 출력

`System.out.println(myStr);`

### 5.2 파일 입출력

#### 5.2.1 내용 쓰기

- `FileOutputStream` 사용
    + 생성할 때 매개변수로 파일명 지정
    + 바이트 형태로 읽어들이기 때문에 문자열을 byte화하는게 필요. 문자열에서 `getBytes()` 호출해서 써야함.
    + FileOutputStream 객체에서 `write(value)` 함수 호출
 
    ```java
    FileOutputStream output = new FileOutputStream("c:/out.txt");
    for(int i=1; i<11; i++) {
        String data = i+" 번째 줄입니다.\n";
        output.write(data.getBytes());
    }
    output.close();
    ```

- `FileWriter` 사용
    + 역시 생성할 때 매개변수로 파일명 지정
    + 이번엔 byte화 할 필요 없음.
    + 역시 `write` 함수를 통해 내용 파일에 씀.

    ```java
    FileWriter fw = new FileWriter("c:/out.txt");
    for(int i=1; i<11; i++) {
        String data = i+" 번째 줄입니다.\n";
        fw.write(data);
    }
    fw.close();
    ```

- `PrintWriter` 사용
    + 생성할 때 파일명을 가지고 씀.
    + byte화 필요없고, 개행문자도 필요없음.
    + `println` 함수를 활용해서 씀.

    ```java
    PrintWriter pw = new PrintWriter("c:/out.txt");
    for(int i=1; i<11; i++) {
        String data = i+" 번째 줄입니다.";
        pw.println(data);
    }
    pw.close();
    ```

#### 5.2.2 내용 추가

- `FileWriter` 사용: 두 번째 매개변수를 true로 주면 이어서 쓰게 된다.

    ```java
    FileWriter fw2 = new FileWriter("c:/out.txt", true);
    for(int i=11; i<21; i++) {
        String data = i+" 번째 줄입니다.\n";
        fw2.write(data);
    }
    fw2.close();
    ```

- `PrintWriter` 사용: 매개변수로 추가모드인 FileWriter 객체를 전달하면 된다.

    ```java
    PrintWriter pw2 = new PrintWriter(new FileWriter("c:/out.txt", true));
    for(int i=11; i<21; i++) {
        String data = i+" 번째 줄입니다.";
        pw2.println(data);
    }
    pw2.close();
    ```

#### 5.2.3 파일 읽기

- `FileInputStream` 사용
    + 한 번에 모두를 읽어들이다.
    + byte 단위로 읽는데 얼마를 읽어들일지 모른다면 낭비가 되거나 에러가 난다.
 
    ```java
    byte[] b = new byte[1024];
    FileInputStream input = new FileInputStream("c:/out.txt");
    input.read(b);
    System.out.println(new String(b));
    input.close();
    ```

- `FileReader`, `BufferedReader` 사용
    + FileReader로 character 단위로 파일을 읽어들인다.
    + BufferedReader의 매개변수로 FileReader 객체를 전달한다.
    + 몇 가지 메소드를 통해 다양한 방식으로 내용을 읽어들일 수 있다. 아래 예제의 `readLine`은 줄 단위로 읽으들이는 함수. 읽어들일게 없으면 `null`을 리턴한다.

    ```java
    BufferedReader br = new BufferedReader(new FileReader("c:/out.txt"));
    while(true) {
        String line = br.readLine();
        if (line==null) break;
        System.out.println(line);
    }   
    br.close();
    ```

## 6. 기타

- 패키지
    + 클래스를 묶어놓은 개념. 비슷한 것 끼리 분류 용이
    + 패키지가 다르면 클래스 이름이 겹쳐도 상관없다.
    + `.java` 파일 맨 위에 `package io.qbinson;` 이라고 패키지를 명시해준다.
    + 다른 패키지의 클래스를 사용하려면 아래처럼 한다.

    ```java
    import io.qbinson.MyClass; // io.qbinson 패키지의 MyClass를 import
    import io.qbinson.*;    // io.qbinson 패키지의 모든 클래스 import

    package io.qbinson.blog; // 이런식으로 '.'을 통해 sub 패키지 표현 가능.
    ```
