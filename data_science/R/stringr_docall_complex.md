# 문자열 처리, 복소수 함수, do.call 함수 사용법 정리

KoNLP, tm 패키지를 쓰려니 자연스럽게 다른 기본 함수들을 많이 쓰게 되었다. 기초 다지는 겸 자주 쓰는 함수들을 정리해본다.

## 1. 문자열 처리 stringr 패키지

### A. str_detect, str_match, str_extract

```
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
```

### B. paste, paste0

```
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
```

### C. strwrap

```
## 유용한 함수 strwrap. 매개변수는 width 정도만 기억하면 된다.
## 문자열을 입력받아서 width만큼 잘라서 벡터로 만든다.
## strsplit이 특정 문자 기준이라면 strwrap은 길이 기준으로 자른다.
titleText <- "Stopping distance of cars (ft) vs. speed (mph) from Ezekiel (1930)"
titleVector <- strwrap(titleText, width = 30)
title <- paste(titleVector, collapse = "\n")
plot(dist ~ speed, cars, main = title)
```

### D. sprintf

```
# sprintf. 문자열을 만들 때 동적으로 바꾸고싶다면 쓴다.
# %s 는 문자열이다. 이거 말고도 d, i, o, x, f, e, g 등이 있다.
person <- 'Gyubin'
action <- 'flying'
result <- sprintf("On %s I realized %s was...\n%s by the street", Sys.Date(), person, action)
message(result)
```

### E. strsplit

```
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

## strsplit 함수에서 분할된 마지막 결과가 빈 문자열이라면 아예 없어진다.
strsplit(paste(c("", "a", ""), collapse="#"), split="#")[[1]]
## 빈문자열이 구분되어 나오려면 정확한 매칭이 되어야 한다.
strsplit("", " ")[[1]]    # character(0)
strsplit(" ", " ")[[1]]   # [1] ""
```

### F. 문자열 뒤집는 함수 만들어보기

```
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

## 문자열 뒤집는 함수 사용 예
a <- readLines(file.path(R.home("doc"),"AUTHORS"))[-(1:8)] # 파일을 라인단위로 끊어서 읽어온다.
a <- a[(0:2)-length(a)] # 마지막 세 줄 제외
(a <- sub(" .*", "", a)) # " .*" 패턴을 찾아 ""로 바꿔버린다. 즉 없애버린다는 것.
# 정규표현식에서 .은 모든 것과 매칭되고, *는 바로앞에 오는 패턴이 0번 이상 반복될 수 있다는 의미
# 즉 " .*" 패턴의 의미는 일단 한 칸 띄워진다면 그 뒤에 무엇이 오든 끝까지 매칭시켜서 다 없애버린다는 것
# 실제로 결과를 보면 공백 이후 부분은 다 사라졌다.
strReverse(a) # 만들어진 함수를 호출해서 원소 하나하나의 문자열들을 다 바꿔버렸다.
```

## 2. do.call

```
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
```

## 3. complex

```
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
```
