# SVG 기초

참고링크: [MDN tutorial](https://developer.mozilla.org/ko/docs/Web/SVG/Tutorial), [W3Schools tutorial](http://www.w3schools.com/svg/)

Scalable Vector Graphics의 약자. 브라우저에서 그래픽을 마크업으로 표현하기 위한 것. 자세한 명세는 MDN의 [SVG element reference](https://developer.mozilla.org/ko/docs/Web/SVG/Element), [SVG element interface](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model#SVG_interfaces)에서 찾아볼 수 있다.

시작하기 전에 유의사항 2가지

- XML이 대소문자를 구분하는 언어이므로 SVG 요소와 속성은 반드시 예제에 보여지는 대로 입력해야한다.
- SVG에서 속성 값은 숫자라고 할 지라도 반드시 따옴표로 둘러싸야한다.

## 1. 샘플 코드

```html
<svg version="1.1"
     baseProfile="full"
     width="300" height="200"
     xmlns="http://www.w3.org/2000/svg">
  <rect width="100%" height="100%" fill="red" />
  <circle cx="150" cy="100" r="80" fill="green" />
  <text x="150" y="125" font-size="60" text-anchor="middle" fill="white">SVG</text>
</svg>
```

위 코드를 `.svg` 확장자로 저장해서 브라우저에 열어볼 수 있다. 렌더링 과정은 다음과 같다.

- root element로 SVG를 만든다.
    + HTML의 doctype 선언은 쓰지않는다. DTD 기반의 SVG 검증은 득보다 실이 많다.
        * a doctype declaration as known from (X)HTML should be left off because DTD based SVG validation leads to more problems than it solves
    + DTD 말고 다른 validation에서 SVG의 버전을 알아내려면 version, baseProfile 속성을 꼭 적어줘야한다.
    + XML 구문 내에서는 SVG를 xmlns 속성으로 namespace를 명시해줘야한다.
- 이미지 영역 전체를 차지하는 rectangle을 그리면서 배경색이 빨강으로 지정된다.
- 초록색 원이 80px 반지름으로 빨간 사각형 중앙에 그려진다. offset은 30+120px inward, 50+50px upward다.
- 텍스트 SVG가 그려진다. 글자는 하얀색으로 채워지고, text-anchor를 middle로 설정했으므로 중앙에 그려진다. 녹색 원의 정 중앙이다.

## 2. 그리드

![grid](https://developer.mozilla.org/@api/deki/files/78/=Canvas_default_grid.png)

For all elements, SVG uses a coordinate system or grid system similar to the one used by canvas (and by a whole lot of other computer drawing routines). That is, the top left corner of the document is considered to be the point (0,0). Positions are then measured in pixels from the top left corner, with the positive x direction being to the right, and the positive y direction being to the bottom. Note that this is the opposite of the way you're taught to graph as a kid. However, this is the same way elements in HTML are positioned.

## 9. 자료

- [구글 코드](https://code.google.com/archive/p/svgweb/)
- [html5rocks](http://www.html5rocks.com/ko/features/graphics)
- [hakim.se](http://hakim.se/)
- [강좌 모음](http://modangs.tistory.com/548)
- [MSDN 기본](https://msdn.microsoft.com/ko-kr/library/gg193979)
- [MDN](https://developer.mozilla.org/ko/docs/Web/SVG/Attribute/pointer-events), [W3](https://www.w3.org/TR/SVG/interact.html#PointerEventsProperty) pointer-events property: SVG 이벤트 체계에서 굉장히 강력한 역할을 한다. 원래 SVG에서 사용하려고 만든거지만 다른 HTMLElement에도 사용 가능. `none`, `all`이 주로 사용되고, z-order를 무시하고 이벤트를 걸 수 있다.
- [W3 SVG arcTo](https://www.w3.org/TR/SVG/paths.html#PathDataEllipticalArcCommands)
- [회전행렬 증명](http://egloos.zum.com/saruchi/v/2079220)
- [코드스쿨 ES6 강의](http://campus.codeschool.com/courses/es2015-the-shape-of-javascript-to-come/)
- [ES6 Katas](http://es6katas.org/)
- [You Dont Know JS](https://github.com/getify/You-Dont-Know-JS/tree/master/es6%20%26%20beyond)
- [ES6 In Depth](http://hacks.mozilla.or.kr/category/es6-in-depth/)






















