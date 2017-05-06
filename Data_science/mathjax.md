# MathJax

웹, 특히 블로그에서 수식을 쉽게 입력해줄 수 있도록 도와주는 라이브러리

참고: [stackexchange](http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference), [wikibooks](https://en.wikibooks.org/wiki/LaTeX/Mathematics)

## 0. 설치

- CDN 사용
    + head, body 어디든 괜찮다.

    ```html
    <script type="text/javascript" async
      src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
    </script>
    ```

- 직접 호스팅
    + [The latest distribution](https://github.com/mathjax/MathJax/)에서 다운받는다.
    + root 디렉토리에 `MathJax` 폴더를 만들고 다운받은 파일을 모두 넣고, 아래 예제 html의 head 부분처럼 넣어주면 된다.
- 예제 html

    ```html
    <!DOCTYPE html>
    <html>
    <head>
      <title>MathJax TeX Test Page</title>
      <script type="text/x-mathjax-config">
        MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
      </script>
      <script type="text/javascript" async
        src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML">
      </script>
    </head>
    <body>
      When $a \ne 0$, there are two solutions to \(ax^2 + bx + c = 0\) and they are
      $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$
    </body>
    </html>
    ```

## 1. 사용법

```html
<!-- inline style -->
\( ... \)
$ ... $

<!-- display style -->
\[ ... \]
$$ ... $$
```

html에서 위와 같이 수식을 작성하면 바뀐다.

## 2. 수식

LaTeX, MathML 형식으로 입력하면 된다.

### 2.1 수식

```html
$$\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}$$
```

- `\sum_{i=0}^n i^2`: 시그마 i는 0부터 n까지, i의 제곱 값을 더하는 것
- `\frac{(n^2+n)(2n+1)}{6}`: `\frac{}{}`은 분수 표시를 나타내고 앞이 분자, 뒤가 분모다.

### 2.2 그리스 문자

- 소문자: `\alpha`, `\beta`, …, `\omega`(α,β,…,ω)
- 대문자: `\Gamma`, `\Delta`, …, `\Omega`(Γ,Δ,…,Ω)

### 2.3 삼각함수

- 코사인: `\cos`
- 세타 기호: `\theata`
- 예제: `\cos (2\theta) = \cos^2 \theta - \sin^2 \theta`

### 2.4 극한

- `\lim_{x \to \infty} \exp(-x) = 0`

### 2.5 지수, 밑수

- `k_{n+1} = n^2 + k_n^2 - k_{n-1}` : 밑수는 `_`로 구분하는데 한글자 이상이면 중괄호로 감싸줘야한다.
- `n^{22}` : 지수가 두자리수 이상이라면 중괄호로 감싸준다.
