# Web Crawling

파이썬으로 크롤링 하는 방법. 기본 함수 활용부터 scrapy, beautiful soup까지.

## 1. 가장 기초. request, response

참고 링크: [30분만에 따라하는 동시성 스크래퍼](http://www.slideshare.net/cornchz/pyconkr-2014-30)

기본적인 웹의 동작방식은 클라이언트가 서버에 Request를 보내고(브라우저에서 URL을 입력하는 행위), 서버가 그에 맞는 html 정보를 다시 클라이언트에 전달하는 것이다. 이와 똑같이 브라우저가 아닌 코드에서 request를 날리고 전달 받은 텍스트를 변수로 저장한다.

### A. requests 활용해서 html 텍스트 다운받기
한 페이지 html 텍스트를 죄다 다운로드하고 그 텍스트를 리턴하는 함수를 만들었다.

```python
import requests
def fetch_page(url):
    r = requests.get(url)
    html = r.text.encode('utf-8')
    return html
```

### B. html에서 원하는 부분만 뽑아내기
scrapy 라이브러리의 Selector를 사용한다. 예를 들어 techneedle 블로그에서 타이틀, 콘텐트, 링크, 저자를 뽑아오고싶을 때 다음처럼 작성한다.

```python
from scrapy.selector import Selector

def get_contents(text):
    sel = Selector(text = text)
    item = {}
    item['title'] = sel.xpath('//title/text()').extract()[0].encode('utf-8')
    item['content'] = sel.xpath('//div[@class="entry-content"]/p/text()').extract()[0].encode('utf-8')
    item['link'] = sel.xpath('/html/head/link[@rel="canonical"]/@href').extract()[0].encode('utf-8')
    item['author'] = sel.xpath('//div[@class="wp-about-author-text"]/h3/a/text()').extract()[0].encode('utf-8')
    return item

html_text = fetch_page("http://techneedle.com/archives/21768/")
item = get_contents(html_text)
print(item)
```

