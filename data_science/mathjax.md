# MathJax

웹, 특히 블로그에서 수식을 쉽게 입력해줄 수 있도록 도와주는 라이브러리

참고: [stackexchange](http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference)

## 0. 설치

- CDN 사용
    + head, body 어디든 괜찮다.

    ```html
    <script type="text/javascript" async
      src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
    </script>
    ```

- 직접 호스팅
    + [The latest distribution](https://github.com/mathjax/MathJax/)에서 다운받으면 된다.
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
