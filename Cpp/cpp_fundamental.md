# C++ 문법 정리

## 1. 기본

```cpp
#include <iostream>
using namespace std;
int main ()
{
    cout << "Hello World!";
    return 0;
} 
```

- 확장자는 `.cpp`
- 맥에서 파일을 만들고 `clang++ <filename.cpp> -o hey`로 컴파일하고, `./hey` 로 실행하면 된다. `g++`도 되는데 `clang++`을 이용하는 것 추천
- 한 줄 주석은 `//`, 멀티라인은 `/* */`
- 문장의 끝에 세미콜론 `;` 붙여줘야함.
- `#include` : preprocessor. iostream이란 파일을 가져와서 쓰겠다는 의미
- `using namespace std;` : cpp의 standard library는 std라는 이름의 namespace 영역에서 선언된다. 그걸 사용하겠다.
- 선언할 때 타입 앞에 `const` 붙이면 상수가 되고 변경 불가.
- C++11로 컴파일: `clang++ -std=c++11 -stdlib=libc++ -Weverything main.cpp`
    + `libc++` 라이브러리를 사용해야한다.(현재 디폴트는 `libstdc++`)
    + `-Weverything` 옵션은 모든 diagnostics를 다 띄우라는 의미. warning 다 띄운다.
    + 만약 c++98 호환성 경고를 무시하고 싶다면 뒤에 다음 옵션을 추가해준다. `-Wno-c++98-compat`

## 2. 타입

### 2.1 기본 타입들

자세한 도표: [msdn data type](https://msdn.microsoft.com/en-us/library/s3f49ktz.aspx)

|      type      |     value      | size |                          range                          |
|----------------|----------------|------|---------------------------------------------------------|
| `bool`         | true or false  |    1 |                                                         |
| `char`         | ASCII용 문자   |    1 | –128 to 127                                             |
| `wchar_t`      | UNICODE용 문자 |    1 | 0 to 65,535                                             |
| `short`        | 작은 정수      |    2 | -32,768 to 32,767                                       |
| `int`          | 정수           |    4 | –2,147,483,648 to 2,147,483,647                         |
| `unsigned int` | 자연수, `999u` |    4 | 0 to 4,294,967,295                                      |
| `float`        | 실수           |    4 | 3.4E +/- 38 (7 digits)                                  |
| `double`       | 실수           |    8 | 1.7E +/- 308 (15 digits)                                |
| `long long`    | 정수           |    8 | −9,223,372,036,854,775,808 to 9,223,372,036,854,775,808 |

- 숫자 관련
    + `float f = 335e-2;` : 3.35
    + `10.0 / 0.0` : infninity
    + `-10.0 / 0.0` : -infinity
    + `infinity / -infinity` : NaN
- 암묵적 형변환
    + `x = y` 일 때 y 값의 타입이 알아서 x 타입으로 변환되어서 들어간다.
    + widening conversion: 정수 값이 실수 변수로 들어가면서 실수 값이 되는것
    + narrowing conversion: 만약 실수 2.9가 int 타입의 변수로 들어가게 된다면 뒷자리는 자동 "버림" 된다.
- 명시적 형변환, casting: `(int)3.3` -> 3, `(float)1` -> 1.0

### 2.1 auto

- C++ 11에서 새로 생긴 데이터 타입이다.
- 타입 설정을 컴파일러가 하도록 넘긴다. 컴파일될 때 데이터타입을 확인하고 auto 타입을 대체해서 알아낸 데이터 타입이 설정된다.

### 2.2 decltype

- `auto`를 통해 정해진 타입을 가져온다.
- 선언되고 대입되어 initialized 된 변수에만 쓸 수 있다. 그게 아니라면 에러 남.
- 특히 iterator를 쓸 때 타입을 일일이 적어줄 필요 없이 쉽게 쓸 수 있다.

```cpp
auto myVar = 3;
decltype(myVar) myVar2;     // int
decltype(myVar < 1) myVar3; // bool
```

## 3. 입출력

### 3.1 출력 `cout`

- console output이란 의미. `<<`는 insertion operator라고 한다.
- iostream의 std 네임스페이스에 있는 표준 출력 함수.
- `using` 구문을 썼기 때문에 그냥 `cout`을 사용하는 것이고, 만약 쓰지 않았다면 `std::cout` 형태로 네임스페이스를 지정해줘야한다.
- 마지막에 `<< std::endl;`을 추가해주면 line break된다.
- 호출 가능 함수
    + `cout.width(int)` : 출력 폭을 정한다.
    + `cout.fill(char)` : 빈칸을 뭘로 채울건지 정한다.
    + `std::cout << std::left << "hello";` : 출력할 문자열이 어디에 위치할건지. default가 right다.

    ```cpp
    cout << "Norwich"<< endl;
    cout.width(15);
    cout << "University" << endl;
    cout.fill('*');
    cout.width(20);
    cout << left << "Corps of Cadets" << endl;
    ```

### 3.2 입력 `cin`

- `cin >> x;` : x라는 변수가 미리 선언되어있고, 입력을 받아 x에 저장하는 경우
- `cin.fail()`
    + 위 경우에서 `x`가 정수 타입인데 문자가 들어갔을 때 에러가 난다.
    + 이 때 분기를 해주는 함수
    
    ```cpp
    #include <iostream>
    using namespace std;
    int main ()
    {
        int x = 0;
        cin >> x;
        if (cin.fail())
            cout << "This is not a valid data type." << endl;
        return 0;
    }
    ```
