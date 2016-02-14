# R로 크롤링하기

## 1. 라이브러리 설치, 적용

`httr`, `rvest`, `dplyr`, `stringr`, `stringi`

```sh
install.packages(c('httr', 'rvest','stringr', 'dplyr'))
library(httr)
library(rvest)
library(dplyr)
library(stringi)
library(stringr)
```

## 2. 웹 페이지의 html 텍스트 다운 받기

GET 함수로 특정 페이지의 html 텍스트 데이터를 긁어온다. 받아온 html RESPONSE 객체를 `read_html` 함수를 통해 xml_document 객체로 바꾼다. 바꿔야 css selector가 적용될 수 있다.

```sh
# GET으로 서버에 자료를 요청
res <- GET('http://movie.daum.net/moviedetail/moviedetailNetizenPoint.do?movieId=90378&t__nil_NetizenPoint=tabName')

# 크롬 개발자 도구에서 확인할 수 있는 내용들
summary(res)
str(res)

# content(res) #웹사이트에 자료를 요청하여 받아온 데이터를 보는 코드
# raw <- content(res, as = 'raw') # 원래 컴퓨터가 받아들일수 있는 상태
# stri_encode(raw, 'UTF8') # UTF8로 인코드하면 우리가 볼 수 있는 문자형태
# content(res, as = 'text')

tmp <- read_html(res) #html의 형태로 parsing
str(tmp)
```

## 3. CSS selector로 원하는 부분 고르기

두 가지 형태로 css selector를 사용할 수 있다.

```sh
# 다음 영화에서 댓글 불러오기
tmp %>% html_nodes('div#movieNetizenPointList.commentList span.comment.article')
tmp %>% html_nodes('div[id="movieNetizenPointList"] span[class="comment article"]')

# 엘리먼트의 텍스트 부분을 뽑는데 trim 함수로 양 끝 여백 삭제
tmp %>% html_nodes('div#movieNetizenPointList.commentList span.comment.article') %>% 
  html_text(trim = T)

# repair_encoding 함수로 인코딩을 복원
tmp %>% html_nodes('div#movieNetizenPointList.commentList span.comment.article') %>% 
  html_text(trim = T) %>% repair_encoding

comment <- tmp %>% html_nodes('div#movieNetizenPointList.commentList span.comment.article') %>% 
  html_text(trim = T) %>% repair_encoding

# 정규 표현식으로 두 개 이상의 공백(/r/n)을 한 개 공백으로 바꾸기.
comment
comment <- gsub('[[:space:]]+', ' ', comment)
```

## 4. 반복문으로 여러 페이지 긁어오기

```sh
result <- NULL
url <- 'http://movie.daum.net/moviedetail/moviedetailNetizenPoint.do?movieId=90378&searchType=all&type=after&page=1'
i <- 1
# modify_url(url, query = list(page = i)) #url의 주소를 보면 page에 i에 해당하는 숫자를 입력하므로써 page를 변경이 가능

for(i in 1:20) {
  tmp_url <- modify_url(url, query = list(page = i))
  html_text <- read_html(GET(tmp_url))
  
  id <- html_text %>% html_nodes('div#movieNetizenPointList ul li span.authorWrap span.fs11 a') %>%
    html_text(trim = T)
  
  comment <- html_text %>% html_nodes('div#movieNetizenPointList ul li span.comment.article a') %>%
    html_text(trim = T)
  comment <- gsub('[[:space:]]+', ' ', comment)
  
  point <- html_text %>% html_nodes('div#movieNetizenPointList ul li span.starWrap span span em') %>%
    html_text(trim = T) %>% as.numeric()
  
  # cbind.data.frame 이라는 함수에서 stringAsFactors 라는 매개변수가 존재한다. 이걸 False로 두면 벡터 중에서 문자열 타입의 벡터를 factor로 바꾸는 것을 방지한다. 이게 아니라 그냥 data.frame(v1, v2, v3) 이런식으로 하면 문자열 벡터가 죄다 factor로 바뀐다.
  temp <- cbind.data.frame(id, comment, point, stringsAsFactors = F)
  result <- rbind(result, temp)
}

View(result) # 데이터를 엑셀처럼 보기 쉽게 보여준다.
```
