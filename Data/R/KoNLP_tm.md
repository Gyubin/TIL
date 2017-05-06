# R로 텍스트 분석하기 by KoNLP, tm

R의 syntax hilighting이 잘 안돼서 파이썬 신택스로 주석만 구분했다.

## 0. Java 설치부터

텍스트를 분석하는 KoNLP 패키지의 일부가 자바다. GitHub에 있는 소스코드를 보면 SimplePos 함수같은 경우 아예 자바로 짜여졌다. 그래서 JVM이 꼭 필요하다. jre를 깔아도 되지만 내가 이번에 겪은 버그는 JDK가 꼭 필요했다. 일단은 jre를 깔고 만약 나와 같은 에러가 발생한다면 JDK를 깔자. jre down -> [link](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html), jdk down -> [link](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

![difference](http://wikidocs.net/images/page/257/jdk.jpg)

## 1. 패키지 설치

```
install.packages(c('wordcloud', 'tm', KoNLP'))
library(wordcloud)
library(tm)
library(KoNLP)
```

위 코드처럼 설치하고 부착한다. 만약 여기서 에러 없이 모든게 잘 부착된다면 매우 다행이지만 아래처럼 rJava를 로드 못하는 에러가 생길 수 있다. 되는 사람과 안되는 사람의 차이는 Homebrew로 설치했느냐 하지 않았느냐에 차이인 것 같기도 하다. rJava는 KoNLP 패키지를 설치할 때 자동으로 깔리는 패키지다.

```
> library(KoNLP)
필요한 패키지를 로딩중입니다: rJava
Error : .onLoad가 loadNamespace()에서 'rJava'때문에 실패했습니다:
  호출: dyn.load(file, DLLpath = DLLpath, ...)
  에러: 공유된 객체 '/usr/local/lib/R/3.2/site-library/rJava/libs/rJava.so'를 로드 할 수 없습니다:
  dlopen(/usr/local/lib/R/3.2/site-library/rJava/libs/rJava.so, 6): Library not loaded: @rpath/libjvm.dylib
  Referenced from: /usr/local/lib/R/3.2/site-library/rJava/libs/rJava.so
  Reason: image not found
에러: 패키지 ‘rJava’는 로드되어질 수 없습니다
```

검색을 해보니 RStudio가 jvm 위치를 잘 못찾은 탓이라고 한다. RStudio를 터미널에서 alias로 jvm 위치를 지정하여 열어주는 방법이 많이 추천됐는데 내겐 안 먹혔다. 그래서 다음 방법을 이용했다.

```py
dyn.load('/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/server/libjvm.dylib')
```

dyn.load 함수는 DLL(dynamically loadable libraries)을 load, unload 하는 함수다. OSX에서는 DLL이 아니라 DSO(dynamic shared objects) 또는 shared objects라고 불린다. 즉 코드 레벨에서 직접 jvm을 로드하는 거다. KONLP 쓸 때마다 로드해야해서 불편하긴 하지만 이 방법 외에는 못찾았다. 로드한 다음에 패키지 부착하면 정상적으로 된다.

마지막으로 자바 런타임 6 SE 레거시가 필요하다는 메시지가 뜰 수 있다. 다음 [링크](https://support.apple.com/kb/DL1572?viewlocale=en_US&locale=en_US)에서 다운로드 받아서 설치한다.

## 2. 형태소 분류

| 상위 분류 |   하위 분류   |       하위 분류       |                                                                        태그                                                                       |
|-----------|---------------|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| 기호 S    |               |                       | sp(쉼표), sf(마침표), sl(여는 따옴표 및 묶음표), sr(닫는 따옴표 및 묶음표), sd(이음표), se(줄임표), su(단위 기호), sy(기타 기호)                  |
| 외국어 F  |               |                       | f(외국어)                                                                                                                                         |
| 체언 N    | 보통명사 NC   | 서술성명사 ncp        | ncpa(동작성 명사), ncps(상태성 명사)                                                                                                              |
|           |               | 비서술성명사 ncn      | ncn(비서술성 명사), ncr(비서술성--직위 명사)                                                                                                      |
|           | 고유명사 NQ   |                       | nqpa(성), nqpb(이름), nqpc(성+이름), nqq(기타-일반)                                                                                               |
|           | 의존명사 NB   |                       | nbu(단위성 의존명사), nbs(비단위성 의존명사 --하다 붙는 것), nbn(비단위성 의존명사)                                                               |
|           | 대명사 NP     |                       | npp(인칭대명사), npd(지시대명사)                                                                                                                  |
|           | 수사 NN       |                       | nnc(양수사), nno(서수사)                                                                                                                          |
| 용언 P    | 동사 PV       |                       | pvd(지시 동사), pvg(일반 동사)                                                                                                                    |
|           | 형용사 PA     |                       | pad(지시형용사), paa(성상형용사)                                                                                                                  |
|           | 보조용언 PX   |                       | px(보조용언)                                                                                                                                      |
| 수식언 M  | 관형사 MM     |                       | mmd(지시관형사), mma(성상관형사)                                                                                                                  |
|           | 부사 MA       |                       | mad(지시부사), maj(접속부사), mag(일반부사)                                                                                                       |
| 독립언 I  | 감탄사 II     |                       | ii(감탄사)                                                                                                                                        |
| 관계언 J  | 격조사 JC     |                       | jcs(주격조사), jcc(보격조사), jcv(호격조사), jcj(접속격조사), jcr(인용격조사), jco(목적격조사), jcm(관형격조사), jca(부사격조사), jct(공동격조사) |
|           | 보조사 JX     |                       | jxc(통용보조사), jxf(종결보조사)                                                                                                                  |
|           | 서술격조사 JP |                       | jp(서술격조사)                                                                                                                                    |
| 어미 E    | 선어말어미 EP |                       | ep(선어말어미)                                                                                                                                    |
|           | 연결어미 EC   |                       | ecc(대등적 연결어미), ecx(보조적 연결어미), ecs(종속적 연결어미),                                                                                 |
|           | 전성어미 ET   |                       | etn(명사형 전성어미), etm(관형사형 전성어미)                                                                                                      |
|           | 종결어미 EF   |                       | ef(종결어미)                                                                                                                                      |
| 접사 X    | 접두사 XP     |                       | xp(접두사)                                                                                                                                        |
|           | 접미사 XS     | 명사파생 접미사 xsn   | xsnu(단위뒤), xsnca(일반명사 뒤), xsncc(일반명사뒤), xsna(동작성뒤), xsns(상태성 뒤), xsnp(인명1,3뒤), xsnx(모든명사뒤)                           |
|           |               | 동사파생 접미사 xsv   | xsvv(동사뒤), xsva(동작명사뒤), xsvn(일반명사뒤)                                                                                                  |
|           |               | 형용사파생 접미사 xsm | xsms(상태명사뒤), xsmn(일반명사뒤)                                                                                                                |
|           |               | 부사파생 접미사 xsa   | xsam(형용사뒤), xsas(상태명사뒤)                                                                                                                  |

실제로 분석된 문자열엔 슬래쉬와 함께 태그가 붙는다. `검사외전/N` 같은 식이다.

## 3. 형태소 구분하기

### A. 명사만 추출하기

- `KoNLP::extractNoun(character)` : character mode의 스칼라 값을 입력받아서 명사만 뽑아낸다. 리턴 타입은 문자열 벡터다. 만약 여러 문자열이 들어있는 벡터나 매트릭스에 적용하고 싶다면 apply 계열 함수를 써야 한다. 아래쪽에 sapply를 사용한 예제가 있다.

    ```py
    comment <- '검사외전은 강동원 때문에 정말 재미있다.'
    result <- KoNLP::extractNoun(comment)

    sentences <- c("R은 free 소프트웨어이고, [완전하게 무보증]입니다.", "일정한 조건에 따르면, 자유롭게 이것을 재배포할수가 있습니다.")
    sapply(sentences, extractNoun)
    ```

### B. 형태소 별로 구분해보기

#### 1) 예제 1: 문자열 하나 분석하기

- `KoNLP::SimplePos09(character)`
    + 문자열을 입력받아 형태소로 나누는 함수
    + 리턴 타입은 리스트다. 리스트 각 원소의 name은 매개변수의 문자열을 ' ' 공백으로 split한 값이다. name과 매칭되는 값은 분석된 문자열(스칼라)이다. 즉 'result$name'처럼 호출이 가능하다.
    + ' ' 공백으로 구분된 문자열들이 어떤 형태소들의 조합인지 분석하는데 쪼개진 형태소 뒤에 형태소 기호들이 붙는다. 이걸 정규표현식으로 잘 발라내면(?) 된다.
    + 09는 가장 상위 구분만 하는거고, SimplePos22같은 더 자세한 구분이 가능한 함수도 있다.
- `paste0` : 문자열, 벡터 등을 연결하는 함수다. 리스트가 들어가면 모든 원소를 이어서 벡터로 만든다.
- `str_match`, `str_extract` : 일치하는 첫 패턴을 리턴
- 위 함수들을 통해 원하는 형태소를 찾고, 가공하면 된다. 아래 코드.

    ```py
    comment <- '검사외전은 강동원 때문에 정말 재미있다.'
    result <- KoNLP::SimplePos09(comment)
    
    result <- paste0(result)
    result <- stringr::str_match(result, '[가-힣]+/[NP]')
    result <- result[!is.na(result)]
    result <- stringr::str_extract(result, '[가-힣]+')
    ```

### 2) 예제 2: 문자열 여러개일 경우

```py
comment1 <- '검사외전은 강동원 때문에 정말 재미있다.'
comment2 <- '강동원은 정말 너무 잘생겼다.'
example <- data.frame(comment = c(comment1, comment2), stringsAsFactors = F)

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
```

## 4. wordcloud 만들기

### A. 기본: 문자열 2개가 있는 벡터 이용

```py
# 3-B-2의 최종 결과물인 res 이용
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
```

### B. 대량의 데이터 이용

```py
# 데이터 준비. id, comment 컬럼 2개만 있는 csv
movie_data <- read.csv(file = 'comment.csv', header = T, stringsAsFactors = F, fileEncoding = "CP949")
tmp <- sapply(movie_data$comment, KO_NP)
tmp <- sapply(tmp, paste0, collapse = ' ')
tmp <- gsub('강동원[가-힣]+', '강동원', tmp)
movie_data$comment <- tmp
########################

tmp <- strsplit(movie_data$comment, split = ' ', fixed = T)  # 공백 기준으로 단어를 분할. 리턴 타입은 리스트
tmp <- do.call(c, tmp) # 리스트의 모든 벡터가 하나로 합쳐진다.

words <- table(tmp) # 유니크한 단어들을 모으고 몇 번씩 등장했는지 알아낸다.
words <- sort(words, decreasing = T)[1:200] # 내림차순으로 정렬하고, 200개만 뽑는다.

pal <- brewer.pal(12,"Paired")
pal <- pal[-1]

par(family='AppleGothic') # 맥 사용자만 실행
wordcloud(names(words), words, min.freq = 1, 
          random.color = F, random.order = F,
          colors = pal)
```

## 5. DocumentTermMatrix 만들기

### A. 작은 단위 예제

- 우선 작은 크기 데이터부터 만든다.

    ```py
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
    ```

- 타입 변화의 흐름: `character vector -> VectorSource -> Corpus -> DocumentTermMatrix -> matrix`

    ```py
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
    ```

### B. 큰 단위 예제

- 데이터는 id, comment 컬럼으로 구성된 1800개 관측값이다. 약간의 가공을 거친다.

    ```py
    setwd("/Users/gyubin/Downloads/R_dream/dream_data/20160221_꿈데디/")
    movie_data <- read.csv(file = 'comment.csv', header = T, stringsAsFactors = F, fileEncoding = "CP949")
    tmp <- sapply(movie_data$comment, KO_NP)
    tmp <- sapply(tmp, paste0, collapse = ' ')
    tmp <- gsub('강동원[가-힣]+', '강동원', tmp)
    movie_data$comment <- tmp
    ```

- A 예제와 같이 함수를 차례차례 적용한다.

    ```py
    tmp <- tm::VectorSource(movie_data$comment) # 문자열 벡터를 VectorSource로 바꾸고
    tmp <- tm::Corpus(tmp) # VectorSource를 Corpus로 바꾸고
    result <- DocumentTermMatrix(tmp, control = list(tokenize = ko.words,  # DocumentTermMatrix로 바꾸고
                                                     weighting = weightTf,
                                                     removeNumbers=T,
                                                     wordLengths=c(2, 5)))
    result <- as.matrix(result) # matrix로 바꾼다.
    View(result)
    ```

## 기타

- `gc(reset = T)` : garbage collector. 사용 안하는 메모리 사용 해제하기.
- `options(java.parameters = "-Xmx1024m")`: 최대 사용 메모리 지정
- `options(mc.cores = 1)` : 코어 사용 개수 
- 예쁜 워드 클라우드 갤러리: [tagxedo](http://www.tagxedo.com/gallery.html)
