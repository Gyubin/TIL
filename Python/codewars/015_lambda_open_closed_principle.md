# #15 Lambdas as a mechanism for Open/Closed

>이 문제 풀고 6 kyu 등급으로 올라갔다. 은근히 기분 좋다.

open/closed principle이란 코드는 수정에 있어선 닫혀있어야 하지만, 추가(혹은 확장)에 대해서는 열려있어야 한다는 의미다. 즉 객체를 아예 바꾸지 않더라도 안에 기능(함수)를 추가할 수 있어야 한다. 이걸 할 수 있는 방법 중 하나가 람다를 쓰는 것이다. 아래 예제가 람다를 사용하는 형태 중 하나다.

```python
spoken    = lambda greeting: greeting.capitalize() + '.'
shouted   = lambda greeting: greeting.upper() + '!'
whispered = lambda greeting: greeting.lower() + '.'

greet = lambda style, msg: style(msg)
```

쉬운 문제라서 그런지 다른 사람들의 해답과 똑같았다. 재밌었던 것은

- 람다를 조합할 수 있는데 괄호를 붙여 매개변수임을 나타내는 방식이 통한다는 것. 설마 되나 하고 적어봤는데 되더라. 신기.
- 또 문자열에서 title()이라는 함수도 호출할 수 있다는 것. whitespace로 띄워진 모든 단어들의 첫글자를 대문자화 한다.
