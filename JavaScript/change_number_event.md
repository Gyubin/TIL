#Change html without reloading.
=========================
**요약: input field의 숫자가 바뀔 때마다 자동 계산되어 다른 label의 글이 바뀌는 스크립트**

지인이 워드프레스로 간단한 주식 관련 웹사이트를 만들고 있었다. 인수 주식 수를 사용자가 변경할 때마다 그 아래에 텍스트가 자동으로 바뀌었으면 좋겠다고 했다. php 기반인 워드프레스를 소스부터 다뤄본 적이 없어서 jQuery를 가져오기보다 html 내부에 스크립트로 삽입해보았다.

##코드 설명
- **인수 주식수 input field:** 워드프레스의 contact form 플러그인으로 input field를 만든거라서 내가 원하는 attribute을 임의로 추가할 순 없었다. 브라우저에서 띄워서 그 input field의 속성을 보니 name에 share-count가 되어있어서 이걸 사용했다. getElementByName으로 가져오면 리스트가 리턴되기 때문에 첫 번째 원소임을 나타냈다.
```js
document.getElementsByName("share-count")[0];
```
- 인수 주식수 input field가 변할 때마다 작업을 해줘야 하기 때문에 이벤트가 필요했다. 하지만 역시 위와 같은 이유로 직접 추가할 수 없어서 setAttribute를 활용했고 onclick, onfocusout 이벤트를 지정해줬다. 처음엔 keydown으로 엔터를 치면 변하게 했는데 contact form 플러그인이 엔터를 치면 '제출' 버튼을 눌러버려서 없앴다.
```js
stocks.setAttribute("onclick", "changeFunction()");
stocks.setAttribute("onfocusout",
```
- 세 가지 function을 활용했다. 숫자에 천 단위로 comma를 찍는 numberWithCommas, 문자열에서 특정 문자를 모두 바꾸는 replaceAll, 이벤트에 달아서 숫자를 바꾸는 changeFunction. 처음에 replaceAll을 안 만들고 replace만 썼다가 앞 쪽 comma만 바뀌어서 changeFunction 결과물이 계속 NaN이 나왔었다.
- (추가) 정규표현식 활용해서 replace를 replaceall처럼 쓰기 -> `mystr.replace(/,/gi, "");` 요렇게만 해주면 된다. 따옴표 대신 슬래시로 감싸고 뒤에 gi를 붙여주면 된다. 정규표현식에서 g는 발생할 모든 패턴에 대한 전역 검색, i는 대소문자 구분 안하는 것, m은 사용하진 않았지만 여러줄 검색을 의미한다. 훨씬 간단하다.
```js
function numberWithCommas(x) {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
String.prototype.replaceAll = function(org, dest) {
  return this.split(org).join(dest);
}
function changeFunction() {
  var value = Number(stocks.value) * Number(book_value.innerHTML.replaceAll(",", ""));
  total.innerHTML = numberWithCommas(value);
  return;
}
```
- 인수가액, 인수총액: li 태그 내에 label로 숫자 부분을 묶어서 값을 가져왔다.

##전체 코드

```html
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <ul>
            <li>인수 주식수 [number share-count min:1 max:10 placeholder "숫자만입력"]숫자만 입력해 주세요</li>
            <li>1주당 인수가액 <label id="book_value">1,400,000</label>원</li>
            <li>주식의 인수총액 <label id="total">0</label>원</li>
        </ul>
        <script>
            var book_value = document.getElementById("book_value");
            var total = document.getElementById("total");
            var stocks = document.getElementsByName("share-count")[0];
            stocks.setAttribute("onclick", "changeFunction()");
            stocks.setAttribute("onfocusout", "changeFunction()");
            function numberWithCommas(x) {
                return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }
            String.prototype.replaceAll = function(org, dest) {
                return this.split(org).join(dest);
            }
            function changeFunction() {
                var value = Number(stocks.value) * Number(book_value.innerHTML.replaceAll(",", ""));
                total.innerHTML = numberWithCommas(value);
                return;
            }
        </script>
    </body>
</html>
```
