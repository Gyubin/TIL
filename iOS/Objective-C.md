# Objective-C 기초

iOS 앱을 만들기 위해 문법을 정리한다. [Do it 아이폰 앱 프로그래밍](http://www.easyspub.co.kr/20_Menu/BookView/A001/96), [tutorials point](http://www.tutorialspoint.com/objective_c/) 참고.

## 0. 기본

- ANSI C의 상위호환. C 문법을 그대로 쓸 수 있다.
- id 데이터형: 어떤 데이터가 들어올지 알 수 없을 때 자유로이 형변환이 가능하다.
- 함수 호출: 함수를 쓰겠다고 메시지를 보내는 형태. 함수가 없다면 nil을 리턴하기 때문에 에러 때문에 프로그램이 멈추지 않는다.

## 1. 클래스

클래스 구조는 `선언.h`과 `구현.m`으로 나뉜다.

### 1.1 헤더 파일

- `@interface`, `@end` 사이에 클래스 구성을 적어서 컴파일러에게 알려줘야한다. 클래스 상속 구조와 어떤 변수와 메소드를 다룰 것인지 적으면 됨.
- 클래스명: 대문자로 시작하고 CamelCase로.
- 상속
    + 콜론(`:`)으로 구분해서 클래스명 뒤에 부모 클래스(Super Class) 적어준다.
    + 가장 밑바탕이 되는 RootClass는 `NSObject`
    + 다중 상속은 지원하지 않는다.
    
    ```objective-c
    @interface ClassName: ParentClassName
        {
            memberDeclarations;
        }
        methodDeclarations;
        propertyDeclarations;
    @end
    ```


### 1.2 구현 파일


