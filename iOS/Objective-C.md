# Objective-C 기초

iOS 앱을 만들기 위해 문법을 정리한다. [Do it 아이폰 앱 프로그래밍](http://www.easyspub.co.kr/20_Menu/BookView/A001/96), [tutorials point](http://www.tutorialspoint.com/objective_c/) 참고.

## 0. 기본

- ANSI C의 상위호환. C 문법을 그대로 쓸 수 있다.
- id 데이터형: 어떤 데이터가 들어올지 알 수 없을 때 자유로이 형변환이 가능하다.
- 함수 호출: 함수를 쓰겠다고 메시지를 보내는 형태. 함수가 없다면 nil을 리턴하기 때문에 에러 때문에 프로그램이 멈추지 않는다.

## 1. Class

클래스 구조는 `선언.h`과 `구현.m`으로 나뉜다.

### 1.1 헤더 파일

#### 1.1.1 기본

- `@interface`, `@end` 사이에 클래스 구성을 적어서 컴파일러에게 알려줘야한다. 클래스 상속 구조와 어떤 변수와 메소드를 다룰 것인지 적으면 됨.
- 클래스명: 대문자로 시작하고 CamelCase로.
- 상속
    + 콜론(`:`)으로 구분해서 클래스명 뒤에 부모 클래스(Super Class) 적어준다.
    + 가장 밑바탕이 되는 RootClass는 `NSObject`
    + 다중 상속은 지원하지 않는다. Java의 Interface와 비슷한 역할을 하는 `Protocol`을 사용해서 공통 이벤트 발생시키고, 클래스끼리 정보 주고 받는다.
    
    ```objective-c
    @interface ClassName: ParentClassName
        {
            memberDeclarations;
        }
        methodDeclarations;
        propertyDeclarations;
    @end
    ```

#### 1.1.2 변수 memberDeclarations

- 헤더 파일(.h)에 선언하는 것을 원칙으로 하되 구현 파일(.m)에서도 선언 가능하다.
- `{ }` 중괄호 사이에 데이터 타입과 변수명을 선언해주면 된다.
- 인스턴스 변수라고도 하며 클래스가 생성될 때마다 각 객체별로 구분되는 변수다.

#### 1.1.3 method

- `- (int) SampleMethod : (int) value returnValue:(int) value;`
    + `-` or `+` : +는 static method를 의미한다. 객체 생성하지 않더라도 호출할 수 있으며 내부에선 class method와 class 변수만 사용할 수 있다. -는 인스턴스 메서드를 의미.
    + `(int)` : 반환 타입
    + `SampleMethod1:` : 메소드 이름. 인수가 있을 땐 colon을 꼭 써줘야 하고, 인수가 없다면 콜론 적지 않고 semi-colon으로 끝낸다.
    + `(int) value` : 인수 데이터 타입, 인수 이름
    + `returnValue: (int) value;` : 리턴값에 대한 선언.
- 선언하는 이유는 method들이 서로를 사용할 수 있게 하기 위해서다. 선언하지 않더라도 아래에 있는 method는 그 위 줄에서 구현된 method를 사용할 수 있지만 다른 클래스 메소드를 import해서 사용하려면 선언해줘야 한다.

#### 1.1.4 @property

- 다른 클래스에서 현재 클래스의 변수를 활용하도록 getter, setter 접근자를 만들게하는 부분이다. 구현 파일에도 `@synthesize` 또는 `@dynamic`을 사용해줘야함.
- 만약 미리 숫자형 myNumber라는 변수가 있었다면 `@property int myNuber;` 라고 적어주면 된다. 아래 표는 property의 종류에 대해서.

|        속성       | 역할 |
|-------------------|------|
| getter=gettername |      |
| setter=settername |      |
| readwrite(기본값) |      |
| readonly          |      |
| assign(기본값)    |      |
| retain            |      |
| copy              |      |
| atomic            |      |
| nonatomic         |      |

### 1.2 구현 파일
