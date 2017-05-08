# Beautiful Soup

파이썬 기반의 html parser다. 웹 페이지의 텍스트를 파이썬의 객체로 변환해준다. css selector나 xpath 같은 것을 몰라도 파이썬을 통해 데이터를 정리할 수 있다.

참고링크: [공식 문서](http://www.crummy.com/software/BeautifulSoup/bs4/doc), [안수찬님 블로그](https://dobest.io/article-result-parser-using-beautifulsoup/)

## 0. 웹 페이지 받아오기

requests 모듈을 활용해서 받아온다. 터미널에서 `pip install requests` 명령어 입력한다. 그리고 `import requests` 해서 사용한다. requests의 get 함수를 활용해서 블로터에 request를 보낸다. 리턴 값이 response 객체다.

```py
import requests
res = requests.get("http://www.bloter.net/archives/249998")
```

## 1. BeautifulSoup 객체 만들기

```py
import requests
from bs4 import BeautifulSoup

res = requests.get("http://www.bloter.net/archives/249998")
data = BeautifulSoup(res.text, "html.parser")
print(data.prettify())
```

response의 text를 활용해서 BeautifulSoup 객체를 만든다. 이제 data에서 변수, 함수를 호출해서 쓰면 된다!

## 2. 함수

### A. element 뽑기

변수처럼 호출하면 된다. div, a, title 등의 태그들은 모두 BeautifulSoup 객체의 변수처럼 존재한다. 예를 들면 다음과 같다.

- 변수만 호출하면 태그 포함 모든 텍스트가 리턴된다.
- 태그에 name을 chain해서 쓰면 태그 이름이 나온다.
- string을 추가해서 쓰면 텍스트가 나온다. text를 써도 같은 결과다.
- parent를 통해 부모 태그를 호출할 수도 있다.
- 아래의 주석들은 공식 문서의 예제 자료다.

```py
data.title # <title>The Dormouse's story</title>
data.title.name # u'title'
data.title.string # u'The Dormouse's story'
data.title.parent.name # u'head'
data.p  # <p class="title"><b>The Dormouse's story</b></p>
data.a  # <a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>
```

### B. 속성으로 뽑기

```py
data.p['class'] # u'title'

data.find_all('a')
# [<a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>,
#  <a class="sister" href="http://example.com/lacie" id="link2">Lacie</a>,
#  <a class="sister" href="http://example.com/tillie" id="link3">Tillie</a>]

data.find(id="link3")
```
