# CSS 기초

css에 대해서 공부하면서 새로운 것들, 외워둘 것들 등등에 대해서 정리해 나가는 파일

## 1. 기본

- 브라우저 지원 : 앞에 붙인다. `-webkit-`, `-moz-`, `-o-`
- `#` -> `.` -> `나머지` : 스타일 겹칠 때 적용 우선순위
- `margin: 100px auto;` : 상하 마진 100px 주고, 좌우는 auto로 중앙 정렬시킨다.
- `text-transform: uppercase` : 대문자로 바꾸기
- `letter-spacing: 3px;` : 글자 간격 3px
- `box-sizing: border-box;` : 설정된 width, height 값을 무조건 지킨다. 이 속성이 없을 때 padding 값이 있으면 태그의 범위가 더 넓어진다. 즉 전체 가로가 width + padding left, right 값이 되는 것. 하지만 속성이 있으며녀 무조건 가로는 width다.
- `border: none;` : input box에서 테두리선 없애기. 자동으로 있게 마련이다.
- `outline: none;` : 입력 부분이 focus 되더라도 테두리선으로 강조표시 하지 않음.
- `transition: all 0.2s ease-in-out;` : [참고링크](https://css-tricks.com/almanac/properties/t/transition/) `transition: [transition-property] [transition-duration] [transition-timing-function] [transition-delay];` 형태로 사용한다. 

## 2. selector

- `grand parents child` : 태그를 순서대로 한 칸 씩 띄워서 쓰면 자식을 의미한다.
- `tag[attributes=value]` : tag 뒤에 대괄호를 쓰면 속성에 접근할 수 있다.
- `:focus` : colon을 한 번쓰면 다음에 이벤트가 올 수 있다.
- `::pseudo` : 태그는 없지만 존재하는 placeholder같은 것들을 붙잡을 때 쓴다.

