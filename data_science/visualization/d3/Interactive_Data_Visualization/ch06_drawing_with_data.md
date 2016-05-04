# Chapter 6 Drawing with Data

챕터 6 내용 중 기억해야할 팁 몇 가지 정리

## 1. 메소드

- 클래스 추가, 제거
    + `attr("class", "myClass")`: 해당 셀렉션의 클래스 속성을 myClass로 바꾼다. 통으로 바꿔버린다. 오직 myClass 하나만 남는다. 두 개 이상 넣으려면 두 번째 매개변수의 문자열에서 '공백'으로 구분해서 여러개 넣으면 된다.
    + `classed("myClass", true)`: 두 번째 값이 true면 해당 셀렉션의 클래스 속성에 myClass를 추가한다. 있으면 그냥 둔다. 만약 false라면 딱 myClass만 없앤다. 없었다면 아무 작동 안한다.
- css style 속성 주기
    + `style("myAttr", "value")`: 두 번째 매개변수는 무조건 문자열로 들어가야 하고, 픽셀 값을 주려면 무조건 "10px"처럼 px를 붙여줘야한다. height, weight, margin 등에서 그냥 "10"만 주면 안되고 "10px"를 줘야함.
    + 자바스크립트 문법 상 숫자에 `+` 연산자로 문자열을 추가해주면 전체가 문자열로 바뀐다. 익명함수를 사용할 때 데이터가 숫자 형태라면 `d + "px"`를 리턴하면 유용하다.
- 한꺼번에 여러 속성 값 주기. comma로 구분된 두 값이 아니라 키 밸류 쌍이 여럿 담긴 Object 하나만 리턴하면 된다.

    ```js
    svg.select("circle")
        .attr( {cx: 0, cy: 0, fill: "red"} );
    ```

## 2. SVG와 D3

- SVG 태그 안에선 모든 것이 attributes다. style이 아니기 때문에 `attr` 메소드를 사용해야 한다.
- SVG는 많이 쓰이기 때문에 따로 변수를 만들고 SVG reference를 가리키도록 하면 좋다.
    + 매 번 SVG에 도형 추가할 때 select 함수를 사용하지 않아도 돼서 편하다.
    + 아래 코드에서 svg1, svg2는 select 함수의 역할까지 포함하는게 아니라 svg reference일 뿐이다.
    + width, height는 생성부터 적용해놓으면 편하다.
    + `style` 메소드와 달리 `attr`은 두 번째 매개변수 value 부분에 문자열이 아닌 값이 들어가도 된다. 물론 SVG에선 속성값도 모두 문자열로 적어줘야하지만 숫자를 넣어도 자동으로 문자열로 형변환돼서 들어간다.

    ```js
    var w = 500;
    var h = 50;
    var svg1 = d3.select("body").append("svg");
    var svg2 = d3.select("svg.mySVG2")
                 .attr("width", w)
                 .attr("height", h);
    ```

- `stroke`, `stroke-width` 속성은 자주 활용된다.
- bar-chart의 데이터들을 균일하게 배치하고 싶을 때
    + 가로 균등 배치 x 좌표값: `i * (w / dataset.length)`
    + width: `(w / dataset.length) - paddingValue`
- SVG는 기본적으로 좌상단에서 우하단으로 좌표가 배치된다. 그냥 rect로 bar chart를 그리면 위에서 아래로 길어지는 형태가 된다. 그래서 y 속성을 `전체 높이 - 데이터값`으로 주고 오히려 반대로 그래프에서 위부분부터 아래 방향으로 그려지는 편법을 쓴다.
- `fill` 속성에서 RGB 값을 지정해줄 수도 있다. 문자열 형태로 `"rgb(0, 0, 0)"` 숫자를 넣어주면 된다. 0-255 사이의 값으로 넣으면 되고, 익명함수에서 d를 활용해도 좋다.

## 3. Scatterplot

- x, y 좌표 셋을 데이터로 받는다.
- SVG 안에서 circle을 만들고 cx, cy 속성에 값을 대입하면 된다. r도 원하는 만큼 고정값을 입력해준다.

## 4. Labels

- SVG의 text 태그를 이용한다.
- bar chart에서 각 bar에 텍스트를 배치하고싶다면 그 x, y 좌표를 그대로 쓰면된다.
- `.attr("text-anchor", "middle")`: 텍스트를 정중앙에 위치하고 싶을 때. 텍스트의 x, y 좌표 기준을 텍스트의 중앙으로 둔다.
- `font-size`, `font-family`, `fill` 속성으로 텍스트 스타일 조정한다. 모두 `attr` 메소드로 지정.
