# R로 텍스트 분석하기 by KoNLP, tm

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

```
dyn.load('/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/server/libjvm.dylib')
```

dyn.load 함수는 DLL(dynamically loadable libraries)을 load, unload 하는 함수다. OSX에서는 DLL이 아니라 DSO(dynamic shared objects) 또는 shared objects라고 불린다. 즉 코드 레벨에서 직접 jvm을 로드하는 거다. KONLP 쓸 때마다 로드해야해서 불편하긴 하지만 이 방법 외에는 못찾았다. 로드한 다음에 패키지 부착하면 정상적으로 된다.

## 2. 기초

### A. 형태소 분류

| 상위 분류 | 하위 분류 | 하위 분류 | 태그 |
|-----------|-----------|-----------|------|
| S         |           |           |      |
| F         |           |           |      |
|           |           |           |      |
|           |           |           |      |

가장 상위 분류는 다음과 같다. `/S` 기호, `/F` 외국어, `/N` 체언, `/P` 용언, `/M` 수식언, `/I` 독립언, `/J` 관계언, `/E` 어미, `/X` 접사. 

- `KoNLP::extractNoun(character)` : character mode의 스칼라 값을 입력받아서 명사만 뽑아낸다. 리턴 타입은 문자열 벡터다. 만약 여러 문자열이 들어있는 벡터나 매트릭스에 적용하고 싶다면 apply 계열 함수를 써야 한다. 아래쪽에 sapply를 사용한 예제가 있다.

    ```
    comment <- '검사외전은 강동원 때문에 정말 재미있다.'
    result <- KoNLP::extractNoun(comment)

    sentences <- c("R은 free 소프트웨어이고, [완전하게 무보증]입니다.", "일정한 조건에 따르면, 자유롭게 이것을 재배포할수가 있습니다.")
    sapply(sentences, extractNoun)
    ```

- `KoNLP::SimplePos09(character)`
    + 문자열을 입력받아 형태소로 나누는 함수
    + 리턴 타입은 리스트다. 리스트 각 원소의 name은 매개변수의 문자열을 ' ' 공백으로 split한 값이다. name과 매칭되는 값은 분석된 문자열(스칼라)이다. 즉 'result$name'처럼 호출이 가능하다.
    + ' ' 공백으로 구분된 문자열들이 어떤 형태소들의 조합인지 분석하는데 쪼개진 형태소 뒤에 형태소 기호들이 붙는다. 이걸 정규표현식으로 잘 발라내면(?) 된다.

    ```
    comment <- '검사외전은 강동원 때문에 정말 재미있다.'
    result <- KoNLP::SimplePos09(comment)
    ```

## 기타

- 예쁜 워드 클라우드 갤러리: [tagxedo](http://www.tagxedo.com/gallery.html)
