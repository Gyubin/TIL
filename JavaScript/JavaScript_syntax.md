# JavaScript 문법

몰랐던 것만 가볍게 정리한다. int, string 같은 기본적인 것들 제외하고 몰랐던 것들, 다른 언어와 다른 점들(주로 Python과 다른 점)을 헷갈리지 않기 위하여 정리한다.

참고 자료: [Eloquent JavaScript](http://eloquentjavascript.net/), [코드카데미](https://www.codecademy.com/learn/javascript)

## 1. 기본

- 문자열 길이: `'string'.length;`
- 한 줄 끝에 `;` 붙이기. 안 붙여도 되는 경우도 있지만 속 편하게 다 붙이기.
- 주석 : `//`
- 참 거짓은 소문자로: `true`, `false`
- 출력: `console.log(context)`
- 블록: `{ }`로 표현. if ( 조건 ) { } 형태
- 문자열 슬라이싱: `'string'.substring(i, j)`
- 변수명: 첫 글자는 소문자, 이후로 CamelCase. 예를 들어 `myAge` 같은 식. 이게 JavaScript에서 컨벤션인 듯 하다.

## 2. 브라우저 확인 창 관련

- `confirm('string');` : 확인, 취소 버튼과 함께 문자열을 띄워준다. 확인 버튼을 누르면 `true`, 취소 버튼을 누르면 `false`를 리턴한다.
- `prompt('string');` : 매개변수로 들어간 문자열을 보여주면서 입력 상자가 띄워진다. 유저가 어떤 텍스트를 입력하면 그것을 리턴한다.
- 
