# HTML 기초

html에 대해서 공부하면서 새로운 것들, 외워둘 것들 등등에 대해서 정리해 나가는 파일

## 0. 태그 모음

- 헤딩: `<h1>`, `<h2>`, `<h3>`, `<h4>`, `<h5>`, `<h6>`
- 리스트: `<ol>`, `<ul>` 태그가 `<li>`를 여럿 포함. li에 새로운 ol, ul 태그를 할당해서 중첩 리스트 가능.
    + `<ol reverseed="reversed">` : 속성 지정하면 ol에서 번호가 역순이 된다.
    + `<ol start="10">` : 10부터 번호가 지정된다.
- 개념, 정의 구조
    + `<dl>` 태그로 전체를 감싼다.
    + `<dt>`: 개념, 단어 등을 의미하는 inline 속성
    + `<dd>`: 정의, 설명을 적는 block 속성
    + dt, dd가 꼭 1:1일 필요는 없다. 1:다, 다:1, 다:다 가능.
- `<a>`
    + `href`: 링크 지정. 속성 없이 사용하면 일반 텍스트처럼 보인다.
    + `title`: 링크의 설명이다. 접근성에 유용.
    + `target`: 현재 창에서 열지, 새 창에서 열지 등을 결정하는데 사용자의 선택이므로 아예 사용하지 않는걸 추천.
    + `href` 속성에 js 코드를 넣는 것은 지양한다. 꼭 주소를 지정하는 것이 좋고 js 코드를 사용해야 한다면 아래 코드처럼.

    ```html
    <a href="http://webberstudy.com" onclick="해당 스크립트">팝업 열기</a>
    ```

- `<img>`: `src` 속성으로 이미지 위치를 지정하고, `alt` 속성으로 이미지에 대한 설명을 적는다. 둘 모두 꼭 적어주는 거로. 부가적으로 `longdesc` 속성이 있는데 이미지에 대한 긴 설명이 필요할 경우 해당 텍스트 파일의 경로를 지정해준다.
- 강조: `<strong>` 태그는 텍스트 **볼드** 처리, `<em>` 태그는 _italicize_ 하는 것. 같은 효과로 i, b 태그가 있는데 사용을 추천하지 않음.
- 영역
    + `<section>`
    + `<article>`
    + `<div>`
    + `<p>` : 문단. 한 주제의 글 뭉치들을 넣으면 된다.
    + `<pre>` : 시 같은 특정한 형태가 있는 텍스트를 넣을 때. 공백이 다 적용된다.
- Escape characters
    + `&nbsp;` `&#160;`: 한 칸 띄우기
    + `&amp;` `&#38;`: &
    + `&lt;` `&#60;`: <
    + `&#61;` : = 등호
    + `&gt;` `&#62;` : >
    + `&copy;` `&#169;`: 저작권 표시 C
- 인용
    + `blockquote`: block 속성.
    + `q`: inline 속성이다. 기본적으로 `" "` 쌍 따옴표로 표현되기 때문에 추가로 적지 않도록 한다.
    + `cite`: 속성으로 활용하면 웹에 표현되지 않고 검색엔진이 활용한다. 인용이 아니라 그냥 작품명을 언급하고 싶을 때 따로 쓰는데 자원을 나타내는 태그이기 때문에 작품명을 적어야지 사람 이름을 적으면 안된다. 

    ```html
    <p>다음 한 마디는 <cite>손규빈 어록</cite> 중 하나다.</p>
    <blockquote cite="https://www.facebook.com/gyubin.son">
      <p>'으아!!!'</p>
      <p>사실 어록이 없다.</p>
    </blockquote>

    <p><q cite="http://html5.clearboth.org/text-level-semantics.html#the-q-element">인용이 아닌 내용에 따옴표를 나타내기 위해 q 요소를 사용해서는 안됩니다.</q></p>
    ```

- `ins`, `del`: 추가 삭제된 부분 표시. GitHub에서 수정 부분 보여줄 때와 비슷한 모양이다. block, inline 속성을 모두 가지고 있어서 block 속성 태그 안에서 쓰이면 inline이 되고, 안에 다른 태그를 포함하는 형태로 쓰면 block 속성이 된다.

    ```html
    <!-- 인라인 형태 -->
    <p>매일 팔굽혀 펴기는 <del>50회</del> <ins>2회</ins> 실시한다.</p>
     
    <!-- 블럭 형태--> 
    <del>
      <p>매일 아침 새벽에 일어나 30분 조깅을 한다.</p>
      <p>식사는 고단백, 저열량으로 먹는다</p>
    </del>
    <ins>
      <p>아침에는 충분한 숙면을 취하도록 한다.</p>
      <p>먹을 것에 스트레스 받지 않도록 한다.</p>
    </ins>
    ```

## 1. 기본

- `<!-- comment -->`: 주석
- class, id 규칙
    + 첫 글자는 알파벳으로. 두 번째 이후부터 `-`, `_` 사용 가능
    + 대소문자 구분
    + 단어 사이에 `-`를 넣어서 구분하고 모두 소문자로 쓰는 것을 추천.

## 2. 페이지 내부 스크롤 이동

```html
<a href="#history">1. 역사</a><br />
<a href="#markup">2. 마크업</a><br />

<h2><a id="history" href="history">역사</a></h2>
<h2 id="markup">마크업</h2>
```

- a의 href 속성에 `#`으로 시작하는 형태로 적어주면 된다. 원하는 곳의 id 값을 적어주면 된다.
- 해당 부분은 id 속성을 지정해주면 된다. 주로 헤딩을 이용.

## 3. 비추천 element

### 3.1 절대 네버

- `<font>`: css에서 적용해야 함.
- `<center>` : 문단 정렬은 `text-align: center;` 을 사용한다.
- `<blink>`, `<marquee>` : 깜빡이고 흐르는 효과를 가진다. 매우 산만함.

### 3.2 사용 지양

- `<iframe>` : 특별한 경우가 아니라면 사용하지 말자. 웹접근성, 검색엔진 접근에서 불리하다.
- `<big>`, `<small>` : 크게 작게 보여주는 요소. css로 하자.
- `<i>`, `<b>`, `<s>` : 이탤릭, 굵게, 취소선. `em`, `strong`, `del`을 쓰자.

## 4. 문구 요소

- `<abbr>` : 축약어(abbreviation)을 나타낸다. 마우스 커서를 갖다대면 툴팁이 뜬다.

    ```html
    <abbr title="World Wide Web">WWW</abbr>는 언터넷에 연결된...
    ```

- `<address>` : 해당 사이트를 만든 사람의 연락처를 나타낸다. 주소 외에도 이메일, 전화번호 등 다양한 정보 담을 수 있음. 저작권 표기는 안에 담지 않는다.

    ```html
    <address>
      <p><a href="mailto:geubin0414@gmail.com">손규빈</a></p>
      <p>서울 특별시 서대문구</p>
      <p>010-1234-5678</p>
    </address>
    ```

- `<dfn>` : 정의. definition을 뜻한다. 이 element를 쓰려면 dfn이 속한 블록에서 설명이 포함되어야 한다. dfn 요소에 title 속성으로 설명을 넣든지, 안에 abbr 요소에서 title 속성을 넣든지 하면 된다.

    ```html
    <p><dfn>언감생심</dfn>은 감히 바랄 수도 없다는 뜻의 사자성어입니다.</p>

    <p><dfn><abbr title="Hyper Text Markup Language">HTML</abbr></dfn>은 웹 페이지 작성을 위한 마크 업 언어입니다.</p>
    ```

## 5. 테이블

- `<table>` 태그로 전체를 감싼다.
    + `summary` 속성: 표에 대한 설명을 적어준다.
- `<caption>` : table element 안에서 맨 첫번째로 나와야 함. 접근성의 관점에서 필수로 넣어야 한다. 표의 제목 역할.
- `<colgroup>`: caption 다음에 와서 열을 한 번에 모아서 속성을 지정하는데 사용한다. 여러개 만들어서 사용할 수 있다.
    + `span` 속성은 한 번에 컬럼을 몇 개 선택할 것이냐다. 아래 예제에서는 1, 2번째 컬럼을 선택해서 10% 너비 지정하고, 배경색을 red로 했다.
    + 자동으로 다음 두 개는 3번째, 4번째다.

    ```html
    <table>
      <colgroup>
        <col span="2" width="10%" style="background-color:red">
        <col width="40%;" style="background-color:yellow">
        <col width="40%;">
      </colgroup>
      <tr>
        <th rowspan="2">출품물</th>
        <th rowspan="2">작품규격</th>
        <td rowspan="2">A4 패널 매수(
          <input type="text" style="width:60px;" align="right" />)매
        </td>
        <td>
          <input type="radio" value="A4 패널 가로 (29.7 x 21.0 cm)" />
          A4 패널 세로 (21.0 x 29.7 cm)
          </td>
      </tr>
      <tr>
        <td>
          <input type="radio" value="A4 패널 세로 (21.0 x 29.7 cm)" />
          A4 패널 가로 (29.7 x 21.0 cm)
        </td>
      </tr>
    </table>
    ```

- `<thead>`, `<tbody>`, `<tfoot>`: 행을 그룹화하는 요소. table element의 자식으로 caption, colgroup 다음에 오게 된다.
    + `<thead>`: 열의 제목으로 구성된 행의 집합. table element 내에서 한 번만 쓸 수 있음. tbody나 tfoot보다 먼저 선언되어야 한다.
    + `<tbody>`: 여러번 선언해서 그룹화할 수 있다. 아래 코드에선 남, 여를 tbody로 구분해서 그룹핑했다.
    + `<tfoot>`: 한 번만 쓸 수 있고, tbody보다 위에 선언해도 맨 마지막에 위치한다.

    ```html
    <table>
      <thead>
        <tr>
          <th>이름</th>
          <th>나이</th>
          <th>성별</th>
          <th>100M 달리기</th>
          <th>윗몸 일으키기</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>홍길동</td>
          <td>22세</td>
          <td>남</td>
          <td>15.25</td>
          <td>29</td>
        </tr>
      </tbody>
      <tbody>
        <tr>
          <td>황진이</td>
          <td>20세</td>
          <td>여</td>
          <td>16.12</td>
          <td>41</td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="3">참가자 평균</td>
          <td>15.7</td>
          <td>35</td>
        </tr>
      </tfoot>
    </table>
    ```

- 위 예제처럼 행을 뜻하는 `<tr>` 태그를 상위 태그 아래에 두고, `<td>` 태그를 그 하위에 여러개 사용해서 값을 넣어준다.
- `scope` 속성: `th` element에서 사용 가능한 속성이다. 해당 th 요소가 어느 영역의 제목을 뜻하는 지를 정의
    + `row`: 행에 있는 셀들에 적용
    + `col`: 같은 열에 있는 셀들에 적용
    + `rowgroup`: 동일한 행 집합에 있는 다른 모든 셀에 적용. 요소가 행 집합을 가리킬 때에만 사용
    + `colgroup`: 동일한 열 집합이 있는 다른 모든 셀에 적용. 요소가 열 집합을 가리킬 때에만 사용

    ```html
    <table style="width:100%; font-size:12px;">
      <caption>참가자 별 점수 표</caption>
      <colgroup style="background:#fff;border-right:2px solid #333;">
        <col>
      </colgroup>
      <colgroup style="background:#eee;border-right:3px double #333;">
        <col>
        <col>
      </colgroup>
      <colgroup>
        <col>
        <col>
      </colgroup>
      <thead>
        <tr>
          <th rowspan="2" scope="rowgroup">thead</th>
          <th colspan="2" scope="colgroup">참가자 (colgroup)</th>
          <th colspan="2" scope="colgroup">항목 (colgroup)</th>
        </tr>
        <tr>
          <th scope="col">이름 <br>(col)</th>
          <th scope="col">나이 <br>(col)</th>
          <th scope="col">100M 달리기 <br>(col)</th>
          <th scope="col">윗몸 일으키기 <br>(col)</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th rowspan="3" scope="rowgroup">tbody</th>
          <th colspan="4" scope="rowgroup">남성 (rowgroup)</th>
        </tr>
        <tr>
          <th scope="row">홍길동 (row)</th>
          <td>24</td>
          <td>15.44</td>
          <td>31</td>
        </tr>
        <tr>
          <th scope="row">임꺽정 (row)</th>
          <td>31</td>
          <td>16.3</td>
          <td>28</td>
        </tr>
      </tbody>
      <tbody>
        <tr>
          <th rowspan="3" scope="rowgroup">tbody</th>
          <th colspan="4" scope="rowgroup">여성 (rowgroup)</th>
        </tr>
        <tr>
          <th scope="row">장옥빈 (row)</th>
          <td>29</td>
          <td>18.12</td>
          <td>20</td>
        </tr>
        <tr>
          <th scope="row">심청이 (row)</th>
          <td>21</td>
          <td>17.1</td>
          <td>33</td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <th scope="rowgroup">tfoot</th>
          <th colspan="2" scope="row">평균 (row)</th>
          <td>16.74</td>
          <td>28</td>
        </tr>
      </tfoot>
    </table>
    ```

- `th`의 너비 설정할 때
    + `<th width="10"></th>` : 왼쪽 코드처럼 width를 attribute로 준다.
    + 그냥 숫자만 적어주면 픽셀, %를 적어주면 비율로 동작한다.
    + 다만 주의할 것은 모든 th를 픽셀 값으로 지정할 때 원치 않는 형태로 나타날 수 있다. 부모 엘리먼트의 width와 th들의 width의 합이 다를 경우 flexbox의 flex-grow, flex-shrink, flex-basis 특성처럼 동작한다. th의 픽셀 값으로 채우고 남은 width 혹은 넘치는 width는 각 th가 동일한 비율로 늘어나고 줄어든다.
    + 내가 원하는데로 세팅하고 싶으면 전체 너비를 th width의 총합보다 넓게 하고 적어도 하나의 th는 width를 주지 않으면 된다.(안 준 th가 나머지를 차지)
- 마지막으로 테이블로 레이아웃 잡지는 말자.

## 6. meta

문서의 특성을 적어준다. 인코딩 방식이나 검색용 키워드

- 화면 크기: `<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />`
    + 모바일 디바이스처럼 화면이 작은 경우에 화면이 축소되어 딱 맞게 보여진다.
    + `width=device-width` : 페이지 너비가 기기의 너비가 된다. `initial-scale=1.0`과 동일한 효과
    + `minimum-scale=1.0` : 줌 아웃을 할 때 가장 줄어들 수 있는 비율. 0.8이라면 실제 페이지의 80%까지 더 축소 가능. 1이면 축소 불가
    + `maximum-scale=1.0` : 줌 인 할 때 가장 커질 수 있는 비율. 2라면 두 배까지 확대 가능, 1이라면 확대 불가
    + `user-scalable=no` : 줌 인,  줌 아웃 불가능. `minimum-scale=1.0, maximum-scale=1.0` 둘 다 선언한 것과 같은 효과
- `<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />`: 올바른 문자셋을 넣어줘야 안 깨진다. `UTF-8`이나 `EUC-KR`을 주로 사용하는데 UTF 쓰는게 제일 낫다.
- `<meta name="Description" content="소개 내용" />` : 검색엔진에서 사이트 제목 아래쪽에 나오는 설명 부분. 페이스북에 공유했을 때 텍스트가 뜬다.
- `<meta name="Keywords" content="키워드들의 나열, abc, 123" />` : 페이지의 주요 내용을 키워드로 적어둔다. 검색엔진에게 유용. 무작위로 엄청 많이 넣으면 스팸으로 걸러질 수도 있는데 이것 때문에 요즘엔 아예 수집하지 않을 수도 있다고 함.
- `<meta name="author" content="Gyubin Son" />`: 페이지 제작자 이름을 쓴다.
- `<meta name="robots" content="noindex, nofollow" />` : 검색엔진이 이걸 보면 색인하지 않는다. 사적인 페이지로 사용할 때.
- `<meta http-equiv="refresh" content="10;url=http://google.com/" />`: 10초 후에 해당 url로 이동시킨다. 하지만 이 방식은 좋지 않음. 뒤로 가기 기록에도 남지 않아서 [301 리디렉션](https://support.google.com/webmasters/answer/93633?hl=ko)을 이용하는게 좋다고 한다.
- `<meta http-equiv="X-UA-Compatible" content="IE=edge" />` : 해당 IE 모드로 렌더링. edge 모드로 해서 최신 모드로 렌더링되게 하는게 좋다. 하위버전은 버그가 많아지고 있어서 비추천
