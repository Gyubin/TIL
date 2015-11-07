# #20 Convert string to camel case
'-', '_'를 기준으로 camel case 형태로 문자열을 바꿔서 리턴하는 문제다. 맨 앞 글자는 굳이 대문자로 바꾸지 않고 원래 형태를 따른다.

## 1. 내 코드
'-'를 '_'로 모두 바꾼 후 언더바를 기준으로 split했다. 그리고 첫 단어는 건드릴 필요 없으니 바로 넣고, 나머지 단어들을 capitalize 해서 join 후 첫 단어와 + 연산했다.

```python
def to_camel_case(text):
    text = text.replace('-', '_').split('_')
    return text[0] + ''.join(word.capitalize() for word in text[1:])
```

## 2. 다른 해답

### A. 최고 득표. 내가 처음 원했던 흐름
이렇게 하고자 했지만, 구현을 못했다. 좋은 걸 배웠다.

- 정규표현식을 사용했다. 정규표현식에 split이 있었다. 그냥 split에 어떻게 정규표현식을 적용하지 고민했었는데 여기에 답이 있었다. re.split(pattern, text) 형태로 넣어주면 된다.
- reduce 역시 사용하고자 했는데 앞에 함수 부분에 join이나 capitalize를 어떻게 넣어야할지 고민했다. 람다를 사용하면 됐다.
    + reduce는 function, iterable, initializer 세 가지 매개변수를 받는다. 이 중에서 function과 iterable만 매개변수로 들어왔다.
    + iterable의 첫, 두번째 원소가 p, n으로 적용된다. p는 그냥 두고, n만 capitalize 해준다. 그리고 이 두 문자열을 + 연산한 값이 다음 p로 들어가고, iterable의 그 다음 원소가 n으로 되서 끝까지 반복한다.

```python
import re
def to_camel_case(text):
    return reduce(lambda p,n: p + n[0].upper() + n[1:], re.split('[-_]', text))
    # 패턴을 이렇게 해도 된다. re.split('_|-', text)
```
