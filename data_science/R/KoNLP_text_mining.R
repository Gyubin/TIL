install.packages(c('wordcloud', 'tm','rJava', 'KoNLP'))

# options("java.home"="/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre")
dyn.load('/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/server/libjvm.dylib')

library(KoNLP)
library(tm)
library(wordcloud)
library(stringr)
library(dplyr)

rm(list = ls())
gc(reset = T)   # garbage collector. 사용 안하는 메모리 사용 해제하기.
options(java.parameters = "-Xmx1024m")   # 최대 사용 메모리 지정
options(mc.cores = 1)  # 코어를 몇 개 쓸지. 성능 최대로 쓸지.
memory.size(max = F)  # 윈도우 전용. 지금 메모리 얼마나 쓰고 있는지 확인



########################
## 1. 형태소 분석하기
########################
comment1 <- '검사외전은 강동원 때문에 정말 재미있다.'
KoNLP::extractNoun(comment1)  # 문자열을 입력받아서 명사만 뽑아낸다. 문자열 벡터 리턴.
tmp1 <- c("R은 free 소프트웨어이고, [완전하게 무보증]입니다.", "일정한 조건에 따르면, 자유롭게 이것을 재배포할수가 있습니다.")
sapply(tmp1, KoNLP::extractNoun) # sapply 함수를 통해 각 원소별로 빠르게 함수 적용 가능

tmp <- KoNLP::SimplePos09(comment1)
# 문자열을 입력받아 형태소로 나누는 함수다. 리턴 타입은 리스트다.
# 리스트 각 원소의 name은 문자열을 ' ' 공백으로 나눈 값이다. 매칭되는 값은 분석된 문자열이다.
# 즉 위의 경우 'tmp$검사외전은'처럼 호출이 가능하다.
# ' ' 공백으로 구분된 문자열들이 어떤 형태소들의 조합인지 분석한다.
# /S 기호, /F 외국어, /N 체언, /P 용언, /M 수식언, /I 독립언, /J 관계언, /E 어미, /X 접사
# 이걸 정규표현식으로 잘 발라내면(?) 된다.
str(tmp) # SimplePos09의 결과가 리스트임을 알 수 있다.
str(tmp$검사외전은) # 리스트의 각 원소는 문자열 스칼라임.

tmp <- paste0(tmp)
# 문자열들이 담긴 리스트를 벡터로 바꾼다.
# 원래는 문자열끼리 연결하는 함수지만 위와 같이 작동할 수도 있다.
tmp <- stringr::str_match(tmp, '[가-힣]+/[NP]') # 문장에서 체언과 용언 추출. 리턴 타입은 매트릭스
tmp <- tmp[!is.na(tmp)] # is.na는 NA인지 검사해서 T, F로 리턴하는 함수다. 앞에 ! 붙여서 na 아닌 것만 필터링
res <- stringr::str_extract(tmp, '[가-힣]+') # 한글만 뽑아내서 벡터로 리턴



################################################
## 2. 형태소 분석 결과에서 활용될 문자열 관련 함수 설명
################################################
fruit_v <- c("appleap", "banana", "pear", "pinapple", "123", "hi123")
fruit_mat <- matrix(fruit_v, c(2:3))
stringr::str_detect(fruit_mat, '[0-9b-d]')
stringr::str_detect(fruit_v, 'b')
# 첫 번째는 자료, 두 번째는 패턴이 매개변수로 들어간다.
# 문자열에 패턴이 포함돼있는지 체크해서 T, F 리턴한다. 벡터나 매트릭스를 넣으면 모든 원소에 적용.
stringr::str_match(fruit_mat, 'ap')
# 찾아진 패턴을 뽑아내서 character mode의 matrix로 리턴한다.
# 왜 하필 매트릭스로 리턴하는지는 모르겠음. 그러려니 해야하나.
# 처음 찾은 패턴만 리턴한다. 'appleap'에서 ap를 찾으면 첫 ap만 찾는다.
stringr::str_match_all(fruit_v, "a")[[3]]
# 이름 그대로 문자열 처음부터 끝까지 패턴을 모두 찾는다. 찾는 모든 패턴을 리턴한다.
# 리턴 타입은 리스트고, 각 원소들은 문자열 타입의 매트릭스
stringr::str_extract(fruit_v, 'ap')
# str_match와 완벽하게 일치하지만 리턴 타입이 벡터다.
stringr::str_extract_all(fruit_v, 'a', simplify = FALSE)
# str_match_all과 같다. 리턴 타입은 리스트인데 내부 원소들은 벡터다.
# 만약 2개 이상의 패턴이 찾아지면 벡터의 원소가 늘어나는 형태.
# simplify 매개변수를 TRUE로 하면 리턴 타입이 리스트가 아니라 매트릭스가 됨.

# extract 관련 예제들
shopping_list <- c("apples x4", "bag of flour", "bag of sugar", "milk x2")
str_extract(shopping_list, "\\d")
str_extract(shopping_list, "[a-z]+")
str_extract(shopping_list, "[a-z]{1,4}")
str_extract(shopping_list, "\\b[a-z]{1,4}\\b")

str_extract_all(shopping_list, "[a-z]+")
str_extract_all(shopping_list, "\\b[a-z]+\\b")
str_extract_all(shopping_list, "\\d")

# Simplify results into character matrix
str_extract_all(shopping_list, "\\b[a-z]+\\b", simplify = TRUE)
str_extract_all(shopping_list, "\\d", simplify = TRUE)

# paste, paste0
# 함수 형태 paste(..., sep = ' ', collapse = NULL)
# 함수 형태 paste(..., collapse = NULL)
# 앞에 ...은 몇 개라도 들어올 수 있다는 의미
# sep은 합칠 때 구분을 뭘로 할 것이냐. paste0은 기본이 sep=''인거다.
# paste0은 구분에 관한 연산이 없어서 좀 더 빠르다.
# collapse는 벡터 원소들을 합쳐서 문자열 하나로 만들 때 뭘로 이어붙이냐다.
# 결국 sep, collapse는 뭘로 구분할 것이냐는 똑같은것.

## 그냥 벡터 하나를 넣으면 벡터가 리턴된다. 기본 리턴 타입이 벡터다.
paste0(1:12)
paste(1:12)        # same
as.character(1:12) # same

## 만약 벡터를 여러개 넣으면 각 벡터의 동일 위치가 연결된다. 벡터 연산이다.
(nth <- paste0(1:12, c("st", "nd", "rd", rep("th", 9))))

## 역시 짧은 벡터는 긴 벡터의 길이만큼 반복된다. 유용하다.
paste(month.abb, "is the", nth, "month of the year.")
paste(month.abb, letters)

## sep 매개변수를 통해 구분값 지정해줄 수 있다.
paste(month.abb, "is the", nth, "month of the year.", sep = "_*_")

## 문자열 스칼라값으로 만들고 싶을 때 collapse를 쓴다.
paste0(nth, collapse = ", ")

## 즉 sep은 ...에 들어가는 변수들의 동일 위치간 붙일 때 쓰이고
## collapse는 결과 벡터의 원소 간 연결할 때 쓰인다.
paste("1st", "2nd", "3rd", collapse = ", ") # 잘못된 활용
paste("1st", "2nd", "3rd", sep = ", ") # O

## 같이 쓰는 예.
paste(month.abb, nth, sep = ": ", collapse = "; ")

## 유용한 함수 strwrap. 매개변수는 width 정도만 기억하면 된다.
## 문자열을 입력받아서 width만큼 잘라서 벡터로 만든다.
## strsplit이 특정 문자 기준이라면 strwrap은 길이 기준으로 자른다.
titleText <- "Stopping distance of cars (ft) vs. speed (mph) from Ezekiel (1930)"
titleVector <- strwrap(titleText, width = 30)
title <- paste(titleVector, collapse = "\n")
plot(dist ~ speed, cars, main = title)

# sprintf. 문자열을 만들 때 동적으로 바꾸고싶다면 쓴다.
# %s 는 문자열이다. 이거 말고도 d, i, o, x, f, e, g 등이 있다.
person <- 'Gyubin'
action <- 'flying'
result <- sprintf("On %s I realized %s was...\n%s by the street", Sys.Date(), person, action)
message(result)



################################################
## 3. 실전
################################################

## comment가 여러개 있을 경우 사용자 정의함수를 생성하자
comment1 <- '검사외전은 강동원 때문에 정말 재미있다.'
comment2 <- '강동원은 정말 너무 잘생겼다.'
example <- data.frame(comment = c(comment1, comment2),stringsAsFactors = F)
# comment를 컬럼명으로 해서 comment1, comment2를 행의 값으로 넣어준 것

KO_NP <- function(sentence){
  tmp <- paste0(SimplePos09(sentence))   # SimplePos09로 만든 리스트를 벡터화
  tmp <- str_match(tmp, '[가-힣]+/[NP]') # 체언과 용언 뽑아내기. 매트릭스 리턴.
  tmp <- tmp[!is.na(tmp)]  # NA 제거하기. 역시 매트릭스 타입 유지된다.
  res <- str_extract(tmp, '[가-힣]+')  # 형태소 표시 제거한다. 리턴 타입은 벡터다.
  return(res)  # 결과 리턴.
}

tmp <- apply(example,1,KO_NP)
# example 데이터프레임에서 행 방향으로 원소에 KO_NP 함수를 적용한다.
# 행 방향이란 행 벡터를 함수의 매개변수로 넣는다는 의미다.
# 여기선 하나의 문자열만 존재하는 1 길이의 문자열 벡터, 즉 스칼라 문자열이다.
# 리턴 타입은 문자열 벡터가 담긴 리스트다.
res <- sapply(tmp, paste0, collapse = ' ')
# spally는 열방향으로 호출된 apply와 똑같다.
# tmp는 두 개 원소가 있는데 하나하나당 paste0을 collapse=' ' 옵션으로 호출한다.

# str_match(res,'강동원[가-힣]+')
res <- gsub('강동원[가-힣]+', '강동원', res) # 강동원 뒤에 조사 붙은거 떼어낸다.



##################################################################
## 실습 문제 1: 검사외전의 comment들을 용언과 체언만 추출해보기
##################################################################
par(family='AppleGothic') # 맥 사용자만 실행
setwd("/Users/gyubin/Downloads/R_dream/dream_data/20160221_꿈데디/")
# id, comment, point 컬럼의 데이터프레임
movie_data <- read.csv(file = 'comment.csv', header = T, stringsAsFactors = F, fileEncoding = "CP949")
tmp <- sapply(movie_data$comment[1:5], KO_NP)
# 너무 많아서 일단 5개만 뽑았다.
# 리스트가 리턴된다. 그 이유는 각 문자열마다 KO_NP의 결과인 문자열 벡터가 리턴되기 때문이다.
# movie_data$comment의 각 문자열이 key가 되고, KO_NP 결과값이 value가 된다.
tmp <- sapply(tmp, paste0, collapse = ' ')
# tmp의 문자열 벡터들 각각에 paste0 함수가 collapse = ' ' 옵션으로 적용된다.
# 문자열 벡터의 원소들이 ' ' 공백으로 띄워져서 하나의 문자열로 합쳐진다.
# 합쳐진 문자열들이 리스트의 value가 된다. key값은 변하지 않았다.
tmp <- gsub('강동원[가-힣]+', '강동원', tmp)
# 강동원 뒤에 붙은 조사를 다 없앤다. 매개변수 순서대로 패턴, 바꿀 문자열, 데이터다.
movie_data$comment <- tmp
# comment 컬럼을 바꿔준다. 지금 5개만 뽑은 상태라서 반복돼서 들어갔을 거다.
# 실제로 할 땐 위에 [1:5] 부분 없애고 해본다.


##################################################################
## 4. wordcloud 만들기
##################################################################

# do.call 함수가 wordcloud 만들 때 쓰인다. 이걸 먼저 이해하고 넘어가자.
# 함수 형태: do.call(what, args, quote=FALSE, envir = parent.frame())
# what엔 함수가 들어간다. 그냥 적어줘도, 문자열로 적어줘도 된다.
# args에는 무조건 list가 들어간다.

do.call(complex, list(l=10, r=1))
do.call(complex, list(imag=1:10))
do.call(complex, list(5, 1:5, 5:1))
# do.call은 결국 첫 매개변수인 함수에, 두번째 매개변수를 집어넣는 것이다. 리턴 타입은 벡터
# 그리고 '행 방향'이다! 리스트의 각 key의 value들의 동일 위치끼리 묶여서 함수에 매개변수로 들어간다.
# 두 번째 매개변수가 list 타입인 이유는 list의 각 원소의 name이 함수의 매개변수와 매칭되기 때문이다.
# complex 함수의 경우 length.out(복소수 개수), real(실수 부분), imaginary(허수 부분),
# modulus(절대값), argument(복소수 평면에서 각도) 매개변수가 있는데(맨 아래에 설명해뒀다)
# list에서 위 매개변수 이름으로 값들을 할당해놓는다면 자연스럽게 complex 함수에 적용된다.
# R 특성 상 매개변수 이름을 완벽하게 적을 필욘 없다. length.out은 l, le, leng, length 까지만 적어도 된다.
# 즉 그 매개변수를 특정지을 수 있을 때까지만 적어주면 된다. imaginary는 imag까지만 적어도 적용된다.
# 당연하게도 어떤 매개변수의 값이 다른 매개변수의 값보다 짧으면 반복되어 재사용된다.

tmp <- expand.grid(letters[1:2], 1:3, c("+", "-")) # data.frame을 만든다. 모든 경우의 수를 만든다.
do.call("paste", c(tmp, sep = "")) # 이렇게 쓰지말고 바래 아래 코드처럼 쓰는걸 추천한다고 함.
do.call("paste", c(tmp, sep = list(""))) # list를 combine하는 방식이다.
# 위처럼 c 함수는 벡터를 만들 때도 쓰이지만 list를 만들 때 혹은 리스트를 연결할 때도 쓰인다.
# paste 함수에 만들어진 리스트가 적용되는데 행 벡터(이렇게 말하면 안되지만 이해를 돕기 위해)가
# paste의 매개변수로 들어간다. tmp의 각 원소들의 동일 위치들이 모여 매개변수로 들어간다.
# 그래서 결과를 보면 알파벳, 숫자, 기호, 그리고 sep 매개변수값이 들어가서 합쳐진 값이 나온다.

a <- list(as.name("A"), as.name("B")) # symbol에 대해서 좀 더 알아봐야 할듯.
typeof(as.name('a'))
do.call(paste, list(as.name("A"), as.name("B")), quote = TRUE)
# 이 부분도 잘 모르겠다. quote 속성이 뭘 의미하는지 잘 모르겠다.

## do.call에는 스코프를 지정해주는 기능도 있다.
A <- 2
f <- function(x) print(x^2)   # 입력받으면 제곱해서 출력하는 함수
env <- new.env() # 새로운 스코프를 만든다.
assign("A", 10, envir = env) # 만들어진 스코프에 값이 10인 A 변수를 만든다.
assign("f", f, envir = env)  # 만들어진 스코프에 f 변수를 만들고 f 함수를 할당
f <- function(x) print(x)  # 글로벌 스코프에서 활용할 함수다. 값을 단순 출력


# 현재 글로벌에는 단순출력함수, A=2 이고, 만든 스코프에는 제곱출력함수, A=10이다.
# 스코프를 지정하고, 문자열로 함수를 지정하면 만들어진 스코프의 함수 지정할 수 있다.
# 함수의 들어갈 데이터를 만든 스코프 내의 것으로 지정하고 싶을 땐 quote을 쓴다.
# quote 말고 as.name을 써서 symbol화 하여 사용해도 만든 스코프의 변수를 지정할 수 있다.
f(A)                                      # 2  글로벌 스코프의 f, A
do.call("f", list(A))                     # 2  글로벌 스코프의 f, A
do.call("f", list(A), envir = env)        # 4  만든 스코프의 f, 글로벌의 A
do.call(f, list(A), envir = env)          # 2  글로벌의 f, A
do.call("f", list(quote(A)), envir = env) # 100  만든 스코프의 f, A
do.call(f, list(quote(A)), envir = env)   # 10   글로벌의 f, 만든 스코프의 A
do.call("f", list(as.name("A")), envir = env) # 100  만든 스코프의 f, A

# eval(call(function, data), envir = myEnv) 형태로 써도 do.call과 같은 의미다.
eval(call("f", A))                      # 2  글로벌의 f, A
eval(call("f", quote(A)))               # 2  글로벌의 f, A
eval(call("f", A), envir = env)         # 4  만든 스코프의 f, 글로벌의 A
eval(call("f", quote(A)), envir = env)  # 100  만든 스코프의 f, A

a <- list(5, 11:15, 1:5)
do.call(sum, a)
# 이 부분이 재밌는데 모든 원소가 sum에 싸그리 긁혀들어간다.
# 개인적인 추측으로 ... 가 매개변수로 있는 함수라면 이렇게 동작하지 않을까 싶다.


###########################
# strsplit에 대해서도 조금 살펴보고 워드클라우드 만들어보자.
###########################
noquote(strsplit("A text I want to display with spaces", NULL)[[1]])
# strsplit은 첫번째로 분할할 character vector, 두번째로 기준을 매개변수로 받는다. 리턴 타입은 list다.
# noquote은 따옴표 없이 보여주는 함수. 리턴타입은 character mode의 벡터이고 class는 noquote이다.

x <- c(as = "asfef", qu = "qwerty", "yuiop[", "b", "stuff.blah.yech") # 문자열 5개 들어있는 벡터
strsplit(x, "e") # 리스트가 리턴. x의 5개 문자열들이 'e'를 기준으로 분할되어 각각 벡터가 된다.
# 즉 분할된 벡터들 5개가 속한 리스트인 것.

unlist(strsplit("a.b.c", "."))
unlist(strsplit("a.b.c", "[.]"))
unlist(strsplit("a.b.c", ".", fixed = TRUE))
# 만약 첫 매개변수로 여러 문자열이 들어있는 벡터를 넣으면 그냥 구분자를 넣어도 되지만
# 길이가 1인 문자열 벡터를 분할할 땐 정규표현식으로 표현해줘야 한다. fixed 넣으면 안해줘도 된다.

## 문자열을 뒤바꾸는 함수를 직접 만들었다.
# 한 줄 밖에 없는 함수에서는 { } 생략할 수 있다.
# return이 없으면 마지막 문장을 알아서 리턴해준다. 명시적으로 return 써주는게 더 좋다.
# 매개변수로 받은 문자열 x를 글자 단위로 분해하면 리스트가 튀어나온다.
# 이것을 lapply 함수로 리스트의 각 원소별로 rev 함수를 적용한다. rev는 벡터의 원소 순서를 바꾼다.
# 순서가 뒤바뀐 결과(리스트)를 다시 sapply 함수로 각 원소별로 paste를 collapse = "" 옵션으로 적용
# 즉 리스트의 각 원소인 문자열 벡터들이 문자열 스칼라가 되어버린다. 그리고 최종적으로 벡터로 리턴.
strReverse <- function(x)
  sapply(lapply(strsplit(x, NULL), rev), paste, collapse = "")
strReverse(c("abc", "Statistics"))

## get the first names of the members of R-core
a <- readLines(file.path(R.home("doc"),"AUTHORS"))[-(1:8)] # 파일을 라인단위로 끊어서 읽어온다.
a <- a[(0:2)-length(a)] # 마지막 세 줄 제외
(a <- sub(" .*", "", a)) # " .*" 패턴을 찾아 ""로 바꿔버린다. 즉 없애버린다는 것.
# 정규표현식에서 .은 모든 것과 매칭되고, *는 바로앞에 오는 패턴이 0번 이상 반복될 수 있다는 의미
# 즉 " .*" 패턴의 의미는 일단 한 칸 띄워진다면 그 뒤에 무엇이 오든 끝까지 매칭시켜서 다 없애버린다는 것
# 실제로 결과를 보면 공백 이후 부분은 다 사라졌다.
strReverse(a) # 만들어진 함수를 호출해서 원소 하나하나의 문자열들을 다 바꿔버렸다.

## strsplit 함수에서 분할된 마지막 결과가 빈 문자열이라면 아예 없어진다.
strsplit(paste(c("", "a", ""), collapse="#"), split="#")[[1]]
## 빈문자열이 구분되어 나오려면 정확한 매칭이 되어야 한다.
strsplit("", " ")[[1]]    # character(0)
strsplit(" ", " ")[[1]]   # [1] ""



######################################
# 이제 워드클라우드 만드는 것을 다시 시작.
# 3. 실전 편에서의 res 객체를 이용한다. 문자열이 2개 들어있는 벡터다.
words <- do.call(c, strsplit(res, split = " ", fixed = F))
# res는 문자열이 2개 속한 벡터다. 각 문자열을 공백을 기준으로 나눈다. 리턴값은 리스트
# 리스트의 원소는 2개다. 이 2개의 벡터를 각각 c한 결과는 똑같은 벡터를 반환한다. 변함없다.
# 그런데 do.call이 마지막에 두 결과를 한 개 벡터로 합쳐서 리턴하기 때문에
# 자연스럽게 구분된 모든 단어들이 하나의 벡터로 들어간 값이 리턴되게 된다.
words_table <- table(words) # 중복되지 않는 유니크한 키들을 뽑아서 각 키가 몇 번 등장했는지

display.brewer.all()
pal <- brewer.pal(12,"Paired")
pal <- pal[-1]

# 기본형
# wordcloud(words, freq, scale=c(4, .5), min.freq=3, max.words=Inf, random.order=TRUE,
#           random.color=FALSE, rot.per=.1, colors='black', ordered.colors=FALSE,
#           use.r.layout=FALSE, fixed.asp=TRUE, ...)
# 이름 보면 유추 가능한 매개변수는 넘어간다. scale은 단어의 최대, 최소 크기다.
# rot.per: 90도로 돌아간 글자의 퍼센티지 지정 가능
# ordered.colors: TRUE로 들어가면 많이 나온 글자 순으로 컬러가 다르게 지정된다.
# use.r.layout: FALSE라면 c++ 코드가 사용된다. 신경 안써도되는 변수.
# fixed.asp: TRUE라면 비율이 고정되고, rot.per가 0이어야 다양한 비율이 지원된다. 감이 잘 안옴
wordcloud(names(words_table), words_table, min.freq = 1, 
                random.color = F,
                colors = pal)


## 실습 2
rm(list=ls())
setwd("/Users/gyubin/Downloads/R_dream/dream_data/20160221_꿈데디/")
movie_data <- read.csv(file = 'comment.csv', header = T, stringsAsFactors = F, fileEncoding = "CP949")
tmp <- sapply(movie_data$comment, KO_NP)
tmp <- sapply(tmp, paste0, collapse = ' ')
tmp <- gsub('강동원[가-힣]+', '강동원', tmp)
movie_data$comment <- tmp
######################## 여기까지 데이터 준비

tmp <- strsplit(movie_data$comment, split = ' ', fixed = T)  # 공백 기준으로 단어를 분할. 리턴 타입은 리스트
tmp <- do.call(c, tmp) # 리스트의 모든 벡터가 하나로 합쳐진다.

words <- table(tmp) # 유니크한 단어들을 모으고 몇 번씩 등장했는지 알아낸다.
words <- sort(words, decreasing = T)[1:200] # 내림차순으로 정렬하고, 200개만 뽑는다.

pal <- brewer.pal(12,"Paired")
pal <- pal[-1]

wordcloud(names(words), words, min.freq = 1, 
          random.color = F, random.order = F,
          colors = pal)



################################
## 문서단어행렬 생성하기
################################
rm(list=ls())
comment1 <- '검사외전은 강동원 때문에 정말 재미있다.'
comment2 <- '강동원은 정말 너무 잘생겼다.'
example <- data.frame(comment = c(comment1, comment2),stringsAsFactors = F)
KO_NP <- function(sentence){
  tmp <- paste0(SimplePos09(sentence))   # SimplePos09로 만든 리스트를 벡터화
  tmp <- str_match(tmp, '[가-힣]+/[NP]') # 체언과 용언 뽑아내기. 매트릭스 리턴.
  tmp <- tmp[!is.na(tmp)]  # NA 제거하기. 역시 매트릭스 타입 유지된다.
  res <- str_extract(tmp, '[가-힣]+')  # 형태소 표시 제거한다. 리턴 타입은 벡터다.
  return(res)  # 결과 리턴.
}
tmp <- apply(example,1,KO_NP)
res <- sapply(tmp, paste0, collapse = ' ')
res <- gsub('강동원[가-힣]+', '강동원', res)

#### 여기까지 아래에서 사용할 res 객체 만드는 코드. 아래부터 시작.

# 전체 흐름은 다음과 같다. 타입의 변화다.
# character vector -> VectorSource -> Corpus -> DocumentTermMatrix -> matrix

res <- tm::VectorSource(res) # 문자열 벡터가 VectorSource로 바뀌고
res <- tm::Corpus(res) # VectorSource가 Corpus로 바뀐다.
inspect(res)
inspect(res)[[1]][1]
inspect(res)[[2]][1]

# doc <- res[[1]][1] %>% as.character
# strsplit(doc, split = ' ') %>% unlist

# Tokenize 함수를 만든다.
# Corpus의 content 부분을 문자열화해서 공백 기준으로 끊어서 벡터를 만드는 함수다.
ko.words <- function(doc){
  doc <- as.character(doc)
  doc <- strsplit(doc, split = ' ') %>% unlist
  return(doc)
}

# Corpus를 DocumentTermMatrix로 전환하는 함수.
# Corpus 객체를 넣고, 어떤 방식으로 변환할 것인지를 control 매개변수에 리스트로 넣는다.
# tokenize를 담당할 함수 지정하고, 가중치는 weightTf를 지정했다. Weight by Term Frequency의 의미.
# removeNumbers는 뜻 그대로이고, wordLengths는 단어 길이를 최소 최대 지정해주는 속성이다.
result <- tm::DocumentTermMatrix(res, control = list(tokenize = ko.words,
                                                     weighting = weightTf,
                                                     removeNumbers=T,
                                                     wordLengths=c(2, 5)
                                                    )
                                 )
result <- as.matrix(result) # matrix로 바꾼다. table 함수를 사용한 것과 같은 맥락이다.


## 실습
## 앞 실습에서 뽑아낸 자료를 DocumentTermmatrix 형태로 변환하기
rm(list=ls())
setwd("/Users/gyubin/Downloads/R_dream/dream_data/20160221_꿈데디/")
movie_data <- read.csv(file = 'comment.csv', header = T, stringsAsFactors = F, fileEncoding = "CP949")
tmp <- sapply(movie_data$comment, KO_NP)
tmp <- sapply(tmp, paste0, collapse = ' ')
tmp <- gsub('강동원[가-힣]+', '강동원', tmp)
movie_data$comment <- tmp
######################## 여기까지 데이터 준비

tmp <- tm::VectorSource(movie_data$comment) # 문자열 벡터를 VectorSource로 바꾸고
tmp <- tm::Corpus(tmp) # VectorSource를 Corpus로 바꾸고
result <- DocumentTermMatrix(tmp, control = list(tokenize = ko.words,  # DocumentTermMatrix로 바꾸고
                                                 weighting = weightTf,
                                                 removeNumbers=T,
                                                 wordLengths=c(2, 5)))
result <- as.matrix(result) # matrix로 바꾼다.
View(result)


################################################################
## complex 함수에 대해서 알아보자. 함수 형태는 아래와 같다.
# complex(length.out=0, real=numeric(), imaginary=numeric(), modulus=1, argument=0)
sample_complex <- complex(5, 1:5, 5:1)  # 5개 허수를 만드는데 실수 부분은 1:5, 허수 부분은 5:1
Re(sample_complex) # 실수 부분 벡터로 리턴
Im(sample_complex) # 허수 부분 벡터로 리턴
Mod(sample_complex) # 허수의 절대값이다. a+bi일 떄 sqrt(a^2+b^2) 값이다.
Arg(sample_complex) # 복소수 평면에서 각도, 즉 라디안 값을 의미. 2pi가 360도다.
Conj(sample_complex) # 켤레 복소수. conjugate complex numbers. 허수 부분만 부호 반대인 것 구함.

0i ^ (-3:3) # 이런 식으로 뒤에 연산되는 수가 벡터일 수 있다. 스칼라와 벡터의 연산이 역으로도 됨.
matrix(1i^ (-6:5), nrow = 4) # 0+1i를 -6부터 5까지 승수한 결과다
0 ^ 1i # 복소수를 지수로 사용할 순 없다.

## create a complex normal vector
z <- complex(real = stats::rnorm(100), imaginary = stats::rnorm(100)) # 정규분포에서 값 뽑아냄
## or also (less efficiently):
z2 <- 1:2 + 1i*(8:9)

## The Arg(.) is an angle:
zz <- (rep(1:4, len = 9) + 1i*(9:1))/10   # 복소수 벡터를 만든다.
zz.shift <- complex(modulus = Mod(zz), argument = Arg(zz) + pi)
# 똑같은 절대값에, zz의 각도에 pi를 더한, 즉 180도 돌린 값을 부여한다.

library(graphics)
plot(zz, xlim = c(-1,1), ylim = c(-1,1), col = "magenta", asp = 1,
     main = expression(paste("Rotation by "," ", pi == 180^o)))
# xlim, ylim은 최대 한계 값을 정해놓는 것, col은 점 색깔이다.(col은 주로 column 아닌가. 고려좀 하지)
# asp는 y/x 비율이다. 그래프의 비율. main은 제목이다. expression 함수 덕에
# 파이 기호나 180도가 표현된 것 같다.
abline(h = 0, v = 0, col = "blue", lty = 23) # 라인을 그린다. lty는 점선에서 대시의 길이?
points(zz.shift, col = "orange") # 그려진 plot에 점을 더 그린다.

