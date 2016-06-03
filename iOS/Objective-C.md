# Objective-C 기초

iOS 앱을 만들기 위해 문법을 정리한다. [Do it 아이폰 앱 프로그래밍](http://www.easyspub.co.kr/20_Menu/BookView/A001/96), [tutorials point](http://www.tutorialspoint.com/objective_c/), [codeschool](http://tryobjectivec.codeschool.com/) 참고.

## 0. 기본

- ANSI C의 상위호환. C 문법을 그대로 쓸 수 있다.
- id 데이터형: 어떤 데이터가 들어올지 알 수 없을 때 자유로이 형변환이 가능하다.
- 함수 호출: 함수를 쓰겠다고 메시지를 보내는 형태. 함수가 없다면 nil을 리턴하기 때문에 에러 때문에 프로그램이 멈추지 않는다.
- `Object`가 정확하게 지칭하는 바는 `variable` 안에 들어있는 것이다. 둘 구분할 것.
- 주석은 `//`
- `!`는 not 을 의미한다. `BOOL` 자료형 앞에 쓰일 수 있음.

## 1. 자료형

C 위에 얹혀진 문법이라서 더 쉽게 쓰기 위해 새로운 자료형을 만들었다. C 언어의 operator들은 C의 기본 자료형에 대해서 쓰여지기 때문에 새로운 방식들이 등장한다.

### 1.1 NSString

- `NSLog(@"Hello, Mr. Higgie.");` : 출력 함수.
- 문자열: `NSString *firstName = @"Gyubin";`
    + `" "` 앞에 `@`를 붙이면 문자열을 의미한다.
    + 문자열 타입은 `NSString`이고, **포인터**다.
    + 물론 사용할 때는 `firstName` 변수명만 사용한다. `*` 빼고.
- 출력: `NSLog(@"Hello there, %@.", firstName);`
    + `%@`로 placeholder를 만들 수 있다. 쉬운 출력.
    + 여러개 placeholder 사용 가능.
    + 만약 placeholder를 안쓰고 바로 firstName을 출력하려하면 warning 뜬다.
- 문자열 잇기1: `stringByAppendingString`
    + message를 nest하는 것 가능하다.
    + 단순히 + 연산으로 안된다.

    ```objective-c
    NSString *firstName = @"Gyubin";
    NSString *lastName = @"Son";
    NSString *fullName = [[firstName stringByAppendingString:@" "] stringByAppendingString:lastName];
    NSLog(@"My name is %@.", fullName);
    ```

- 문자열 잇기2: `stringWithFormat`
    + format string을 활용한다. placeholder를 이요한 방법.

    ```objective-c
    NSString *fullname = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    ```

- NSString Class 사용하기.
    + string 메시지로 빈 문자열 생성: `NSString *s = [NSString string];`
    + 문자열 복사: `NSString *s = [NSString stringWithString:anotherString];`
- `isEqualToString` 문자열 같은지 비교: `[@"Gyubin" isEqualToString:@"GGGGGG"]`

### 1.2 NSNumber

- `NSNumber *age = @28;` : `NSNumber` 타입에, 역시 `*`를 붙여서 선언하고, Object 앞에는 `@`를 붙인다.
- 출력: 문자열에서와 똑같이 `%@` placeholder를 쓰면 된다.
- `NSLog(@234);` 이런식으로 못 쓴다. 무조건 placeholder 써야 한다. 숫자를 출력하려면.
- 곱셈하기
    + 단순 곱셈이 안된다. Obj-C는 C 위에 얹혀진거라서 `*` operation은 양 쪽에 C의 Integer형을 받아야한다. 그래서 NSNumber를 못쓴다.
    + `unsignedIntegerValue` 메소드를 사용해서 `NSUInteger` Object로 바꾼 다음에 더해줘야한다.

    ```objective-c
    NSNumber *higgiesAge = @6;
    NSNumber *phoneLives = @3;

    NSUInteger higgiesAgeInt = [higgiesAge unsignedIntegerValue];
    NSUInteger phoneLivesInt = [phoneLives unsignedIntegerValue];

    NSUInteger higgiesRealAge = higgiesAgeInt * phoneLivesInt;
    ```

### 1.3 NSArray

- `NSArray *apps = @[@"AngryFowl", @"Lettertouch", @"Tweetrobot"];`
    + 타입은 `NSArray`. 역시 변수 선언할 때 `*` 붙인다.
    + 배열을 의미하는 `[ ]` 앞에 `@` 붙여야 한다.
    + 원소 접근은 다른 언어와 비슷하게 `apps[0]` 처럼 인덱스로 한다.
- NSArray는 immutable Object다. 만약 원소를 추가하고 뺀다면 원래 것에서 빼는게 아니라 변경된 NSArray를 새로 만든다. 문자열도 immutable이며 모든 것은 mutable한 counterparts가 존재한다. `NSMutableArray`, `NSMutableString`이 있다.
- `NSArray *emptyArray = [NSArray array];` : 빈 배열 생성.
- 원소 추가: 

### 1.4 NSDictionary

- key, value 쌍으로 이루어진 자료형. 중괄호로 감싸고, key-value는 콜론으로 구분하고, 쌍 끼리는 comma로 구분한다. 파이썬이랑 똑같다.
- `NSDictionary *person = @{@"firstName": @"Gyubin"};`
- `person[@"firstName"]` 접근은 이렇게 대괄호에 키를 넣어서.
- `NSDictionary *emptyDict = [NSDictionary dictionary];`

### 1.5 NSInteger, NSUInteger

- C-layer의 자료형이다. 사칙연산 등의 operator 사용 가능하다.
- 예로 문자열을 `length` 메소드를 통해 길이를 재었을 때 리턴되는 타입이 NSUInteger다.
- `*` asterisk를 쓰지 않는다. NSLog에서 placeholder를 `%@`가 아니라 NSUInter의 경우 `%lu`로 받는다.

```objective-c
NSString *firstName = @"Gyubin";
NSUInteger firstNameLength = [firstName length];
NSLog(@"firstName length is %lu", firstNameLength);
```

### 1.6 BOOL

- `YES`, `NO`로 표현된다.
- `BOOL flag = YES;` 형태로 사용한다. `*` 쓰지 않는다.

### 1.7 ENUM

```objective-c
typedef NS_ENUM(NSInteger, DayOfWeek) {
    DayOfWeekMonday = 1,
    DayOfWeekTuesday = 2,
    DayOfWeekWednesday = 3,
    DayOfWeekThursday = 4,
    DayOfWeekFriday = 5,
    DayOfWeekSaturday = 6,
    DayOfWeekSunday = 7
};
DayOfWeek day = 5;
```

- DayOfWeek이란 타입을 만든 것. 이 타입으로 변수 선언해서 사용.
- 위 코드에선 NSInteger를 실제 값으로 쓰는 것. 다른 타입 가능하다.
- 값을 지정할 수 있는데 위에선 1에서 7까지 지정한 것. 만약 지정 안했으면 0부터 6까지 인덱스로 접근할 수 있다.

## 2. Message

- `[objectName messageName];`
- Obj-C에선 메소드를 바로 사용하는 것이 아니라 사용하겠다고 메시지를 보내는 형태다. 대괄호에 타겟 object와 관련된 메소드의 이름을 적으면 된다.
    + 아래 예제에서처럼 사용하면 된다.
    + `description`은 object를 문자열 형태로 바꿔서 리턴한다. Array는 속한 원소들을 보기 쉽게 나열해주고, 문자열을 넣으면 그냥 문자열이다.
    + description을 공식 문서를 보면 `(NSString *)description` 으로 표현되어있다. 리턴 타입이 NSString이란 의미다.

    ```objective-c
    NSArray *foods = @[@"tacos", @"burgers"];
    NSString *myString = [foods description];
    NSLog(@"%@", [foods description]);
    ```

- message를 여러개 nest할 수 있다.
- 매개변수를 여러개 가질 수 있다. 가독성을 위해 띄워쓴다.

    ```objective-c
    NSString *s = [@"aa bb" stringByReplacingOccurrencesOfString:@"aa"
                                                      withString:@"AA"];
    ```

- 타입 별 초기화하기
    + 모든 클래스는 `alloc` 메시지에 반응한다. 메모리에 Object가 들어갈 공간을 만드는 역할이다.
    + `alloc`의 리턴 객체는 `init`을 다시 해줘야 사용가능해진다.
    + `init`보다는 `initWithString`같은 메시지를 더 많이 사용한다.

    ```objective-c
    NSString *emptyString = [[NSString alloc] init];
    NSString *emptyString = [[NSString alloc] initWithString:otherString];

    NSArray *emptyArray = [[NSArray alloc] init];
    NSDictionary *emptyDictionary = [[NSDictionary alloc] init];
    ```

## 3. 조건, 제어문

### 3.1 if

```objective-c
NSNumber *scale = @5;

if ([scale intValue] < 4) {
    NSLog(@"HELLO WORLD!");
} else if ([scale intValue] < 7) {
    NSLog(@"WOW!!");
} else {
    NSLog(@"HO!!");
}
```

- if 구문은 C 언어와 동일하다.
- 만약 NSNumber 타입의 object를 크기로 분기하려면 inValue 메시지를 통해 먼저 NSUInteger 타입으로 바꿔주고 operator로 비교한다.

### 3.2 switch, enum

```objective-c
typedef NS_ENUM(NSInteger, DayOfWeek) {
    DayOfWeekMonday = 1,
    DayOfWeekTuesday = 2,
    DayOfWeekWednesday = 3,
    DayOfWeekThursday = 4,
    DayOfWeekFriday = 5,
    DayOfWeekSaturday = 6,
    DayOfWeekSunday = 7
};

DayOfWeek day = 3;

switch (day) {
    case DayOfWeekMonday:
    case DayOfWeekTuesday:
    case DayOfWeekWednesday:
    case DayOfWeekThursday: {
        NSLog(@"%@", @1234);
        break;
    }
    case DayOfWeekFriday: {
        NSLog(@"%@", @5);
        break;
    }
    case DayOfWeekSaturday:
    case DayOfWeekSunday: {
        NSLog(@"%@", @67);
        break;
    }
}
```

- switch
    + C의 switch에선 각 case를 curly-braces로 묶지 않았지만 여기선 묶는다. 그 외엔 break이나 default같은 것들은 같다.
    + case에 사용할 object는 C-layer에 있는 타입이어야 한다. 그래서 위에 보면 NSNumber가 아니라 NSInteger다.
- enum: switch문과 같이 잘 쓰인다.

### 3.3 for

```objective-c
// Enumerating an NSArray
NSArray *newHats = @[@"Cowboy", @"Conductor", @"Baseball"];
for (NSString *hat in newHats) {
  NSLog(@"Trying on new %@ hat", hat);
}

// Enumerating an NSDictionary
NSDictionary *funnyWords = @{
  @"Schadenfreude": @"pleasure derived by someone from another person's misfortune.",
  @"Portmanteau": @"consisting of or combining two or more separable aspects or qualities",
  @"Penultimate": @"second to the last"
};
for (NSString *word in funnyWords) {
  NSLog(@"%@ is defined as %@", word, funnyWords[word]);
}
```

- NSArray를 `for in` 구문으로 하나씩 뽑아 쓸 수 있다.
- NSDictionary에서 for in 구문을 쓰면 key가 하나씩 뽑혀 나온다.

## 4. Block

### 4.1 인수 없는

```objective-c
void (^logMessage)(void) = ^{
    NSLog(@"Hello from inside the block");
};
logMessage();
```

- block과 method의 다른 점은 무엇일까.
- block을 변수로 할당해서 재사용할 수 있다. 할당된 값을 method의 매개변수와 리턴값으로 쓸 수 있고, Array나 Dictionary의 원소로 쓸 수도 있다.
- 변수명과 `{ }` 앞에 `^` 붙여야 한다. 변수명은 `^` 포함해서 괄호로 감싼다.
- `{ }`이 끝날 때 `;` semi-colon 꼭 붙여준다.
- 변수명의 앞엔 리턴값의 타입을 나타내고, 뒤에는 괄호로 감싸서 매개변수를 적어준다. 만약 매개변수가 없다면 `void`
- 변수명 뒤에 `();`를 붙여서 block을 실행한다.

### 4.2 인수 있는

```objective-c
// 정수 2개 받아서 합을 나타내는.
void (^mySum)(NSUInteger, NSUInteger) = ^(NSUInteger n1, NSUInteger n2){
    NSLog(@"The sum of the numbers is %lu", n1 + n2);
};
mySum(10, 20);

// NSArray를 받아서 원소 개수를 리턴하는.
void (^logCount)(NSArray *) = ^(NSArray *array){
    NSLog(@"There are %lu objects in this array", [array count]);
};
logCount(@[@"Mr.", @"Higgie"]);
logCount(@[@"Mr.", @"Jony", @"Ive", @"Higgie"]);
```

- 선언 부분에선 타입만 적어주고, block 부분에선 할당할 변수도 적어준다.
- NSArray같은 경우 `*`를 선언 부분에도 꼭 적어줘야함.

### 4.3 메시지에 블락 넘겨보기

```objective-c
NSArray *funnyWords = @[@"Schadenfreude", @"Portmanteau", @"Penultimate"];
[funnyWords enumerateObjectsUsingBlock:
  ^(NSString *word, NSUInteger index, BOOL *stop){
    NSLog(@"%@ is a funny word", word);  
  }
];
```

- NSArray에 `enumerateObjectsUsingBlock`라는 메시지가 있다. 각 원소에 대해 넘겨준 block을 사용하는 것.
- 변수에 할당 없이 block 부분만 적어주면 된다.
- 저 메시지에 block을 넘겨주려면 3가지 매개변수가 꼭 있어야한다. 하나라도 없으면 에러가 난다.
    + `NSString *word` : Array의 원소 하나 하나.
    + `NSUInteger index` : 해당 원소의 인덱스.
    + `BOOL *stop` : 반복을 멈추고싶을 때 `*stop = YES` 형태로 값을 넣어주고, 바로 return하면 된다.(for문에서 `break`와 같은 동작.) 원래 BOOL 타입은 `*`를 쓰지 않는데 로컬 변수가 아니라 포인터 형태로 사용하는 것 같다. 그냥 return은 해당 반복을 종료하는 것일 뿐 전체 반복을 종료하는 것은 아니다.(`continue`와 같다.)
- 변수로 선언해서 변수만 넘겨도 되고, block 부분만 적어서 익명 함수처럼 넘겨도 된다. 상황에 맞게 활용.

## 5. Class

클래스 구조는 `선언.h`과 `구현.m`으로 나뉜다.

### 5.1 헤더 파일

#### 5.1.1 기본

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

#### 5.1.2 변수 memberDeclarations

- 헤더 파일(.h)에 선언하는 것을 원칙으로 하되 구현 파일(.m)에서도 선언 가능하다.
- `{ }` 중괄호 사이에 데이터 타입과 변수명을 선언해주면 된다.
- 인스턴스 변수라고도 하며 클래스가 생성될 때마다 각 객체별로 구분되는 변수다.

#### 5.1.3 method

- `- (int) SampleMethod : (int) value returnValue:(int) value;`
    + `-` or `+` : +는 static method를 의미한다. 객체 생성하지 않더라도 호출할 수 있으며 내부에선 class method와 class 변수만 사용할 수 있다. -는 인스턴스 메서드를 의미.
    + `(int)` : 반환 타입
    + `SampleMethod1:` : 메소드 이름. 인수가 있을 땐 colon을 꼭 써줘야 하고, 인수가 없다면 콜론 적지 않고 semi-colon으로 끝낸다.
    + `(int) value` : 인수 데이터 타입, 인수 이름
    + `returnValue: (int) value;` : 리턴값에 대한 선언.
- 선언하는 이유는 method들이 서로를 사용할 수 있게 하기 위해서다. 선언하지 않더라도 아래에 있는 method는 그 위 줄에서 구현된 method를 사용할 수 있지만 다른 클래스 메소드를 import해서 사용하려면 선언해줘야 한다.

#### 5.1.4 @property

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

### 5.2 구현 파일
