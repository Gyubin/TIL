#include <stdio.h>

int main(void) {
    // N개의 10진수를 주면, 등장하는 숫자들 중 홀수번만 나타나는 숫자들을, 모두 XOR한 결과를 구하라.
    1
    4
    2 5 3 3

    int num1 = 15;
    int num2 = 20;
    int num3 = 24;
    int result = 0;

    result = num1^num2^num3;
    printf("%d, %d, %d의 XOR 연산 결과: %d\n", num1, num2, num3, result);

    return 0;
}


<ul>
    <li>주식의 내용 (주)코리아코스팩 (사업자 등록번호: 131-86-11936)</li>
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
