# Chapter 5 Data

D3에서 data란 텍스트 기반 자료형을 뜻한다. 알파벳, 한글, 숫자 등이 텍스트 파일로 되어있다면(`.txt`, `.csv`, `.json`) D3에서 사용할 수 있다.

## 1. About Chaining Methods

- chain syntax: 함수들을 쭉 연결해서 쓸 수 있는 것을 말함.
- 간단한 코드 분석
    + `d3`: D3 object를 가리키는 reference. 이걸 통해서 D3의 methods를 사용 가능하다.
    + `.select("body")`: css selector 형태로 매개변수가 들어간다. 찾아지는 첫 DOM element를 가리키는 reference를 리턴한다. 여러개를 고르려면 `seletAll()` 메소드를 쓴다.
    + `.append("p")`: `select`로 고른 element에 매개변수로 특정한 element를 추가한다. 그리고 추가한 element를 리턴함.
    + `.text("New paragraph!")`: text 메소드를 호출한 reference element 안에 `<element>New paragraph!</element>` 이런 방식으로 매개변수의 문자열을 추가한다. 기존 텍스트가 존재했다면 덮어쓴다.

    ```js
    d3.select("body")
        .append("p")
        .text("New paragraph!");
    ```

- The Hand-off
    + 모두는 아니지만 대부분의 D3 method가 d3 selection 객체를 리턴한다. 그렇기 때문에 chain syntax를 쓸 수 있는 것.
    + 그래서 순서가 중요하다. 앞 method의 output이 뒤 method의 input 타입과 같아야 한다.
- Going Chainless: 다음처럼 분리해서 써도 된다. 만약 여러 번 반복되서 사용해야하는 객체인 경우 분리하면 더 좋다.

    ```js
    var body = d3.select("body");
    var p = body.append("p");
    p.text("New paragraph!");
    ```
