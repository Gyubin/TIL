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

## 2. Binding Data

- 데이터가 들어가면 -> 시각화 결과물이 나온다.
- 데이터를 binding한다는 말은 element에 'attach'한다는 의미.
- `d3-selection.data()` 형태로 사용한다.

### 2.1 데이터 로드

```js
var dataset; // Global variable
d3.csv("file_name.csv", function(data) {
  dateset = data;
});
// d3.tsv("file_name.tsv", function) 형태도 존재. tab separated value.

// error 잡는 방법
d3.json("file_name.json", function(error, data) {
  if (erorr) {
    console.log(error);
  } else {
    dataset = data;
  }
})
```

- csv, json 파일을 불러오는 예제다.
- 파일명과 callback function을 매개변수로 받는다.
- csv는 모든 값이 문자열 형태로 되어있다. 필요하다면 사용할 때 형변환해줘야함.
- 데이터를 불러올 때 함수 내의 지역변수로 불러와지므로 미리 전역변수를 선언해두고 대입하는 형태가 좋다. 아니라면 안에서 모든 시각화처리를 다 하든지.
- 만약 데이터를 불러오는 상황에서 서버 에러나 인터넷 연결 에러가 발생한다면 원하는 결과가 나오지 않는다. 이를 방지하기 위해 위 코드블록의 두 번째 예제처럼 하면 된다. callback funcion에서 첫 번째 매개변수를 error로 두고 쓴다. 매개변수를 한 개만 넣으면 'data'와 매칭되고, 두 개를 넣으면 'error', 'data'로 매칭된다. 순서가 묘한데 callback function에서 매개변수가 몇 개냐에 따라 다르게 적용하는 내부구조가 있는 것 같다.

### 2.2 코드 분석

```js
// 만약 기존 p tag가 2개 있고, 데이터가 5개인 경우
d3.select("body")
  .selectAll("p")
  .data(dataset)
  .text(function(d) {   // 기존 2개 p에 적용
    return d.Food + ": " + d.Deliciousness;
  })
  .enter()
  .append("p")
  .text(function(d) {   // 새로 만들어질 3개에 적용
    return d.Food + ": " + d.Deliciousness;
  });
```

- 위 코드는 1.1 코드에서 `selectAll`, `data`, `enter` 메소드만 추가됐다.
- 원래는 body를 고르고, p를 붙인 다음, text를 추가한 것.
- 코드 분석
    + `d3.select("body").selectAll("p")`: body를 선택하고, body의 자식 element인 p를 모두 선택했다. 기존에 존재하는 p 태그만 골라서 selection 객체를 리턴한다. 2개면 2개, 없었다면 빈 객체를.
    + `data(dataset)`: 데이터가 들어있는 객체인 dataset을 data 메소드에 매개변수로 넣어준다. 데이터를 `select` 메소드로 선택된 element에 바인딩 시키는 역할이고, 이 다음부터 호출되는 함수는 데이터가 바인딩된 element의 개수만큼 반복되서 호출한다. 리턴 타입은 데이터와 결합된 selection 객체다. 기존에 2개가 존재했다면 2개, 없었다면 빈 객체다.
    + `enter()`: 데이터가 기존 element보다 많았다면, `placeholder element`를 만들어 결합되지 않은 나머지 데이터와 결합시킨다. `data` 메소드처럼 이 이후엔 새롭게 만들어진 placeholdef element의 개수만큼 이후에 호출되는 메소드가 반복 호출된다. 리턴값은 가장 최근에 호출된 `select` 류의 메소드가 가리키는 element의 부모 element다. 위 코드에선 가장 최근에 p 태그를 모두 골랐으므로 그 부모 element인 body가 된다. 그래서 이 이후에 `append(p)` 함수가 호출되면 body에 p가 여러개 붙는 것이다.
    + 위에서 `text` 메소드가 2번 호출됐는데 지금까지의 설명에서처럼 `enter` 메소드 이전과 이후에 선택된 객체들이 다르다. 이전은 기존 존재하던 것을 select한 결과이고, 이후는 남는 데이터와 바인딩된 placeholder를 선택한 결과다. 저렇게 두 element 그룹에 어떤 효과를 적용하려면 위 아래로 각각 관련 메소드를 호출해줘야한다.
    + `data` 메소드를 호출한 이후부터 익명 함수를 사용해서 데이터를 이용할 수 있다. 관습적으로 익명함수의 첫 번째 매개변수인 데이터는 `d`로 한다.

### 2.3 다른 메소드

- `.style(attribute, value)` : HTML에서 사용되는 속성과 값을 정해줄 수 있다.
- attribute엔 일반적인 HTML의 속성이 들어간다. width, height, class, id, name, font-weight 등등
