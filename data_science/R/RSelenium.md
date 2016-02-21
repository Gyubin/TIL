# RSelenium

R에서 셀레니움 활용방식을 간단하게 정리한다. 셀레니움은 웹 테스팅 툴이다. 웹 사이트에서 버그가 없는지 테스트할 때 모든 버튼을 눌러보거나 해야하는데 이를 자동화한다. 이게 가능한 이유는 브라우저의 웹 드라이버 API를 구현(?)하고 있기 때문이다. 즉 브라우저의 모든 동작, 예를 들면 클릭이나 더블 클릭, 우클릭 등을 자동으로 실행할 수 있다. 

그런데 웹 크롤링에서도 많이 쓰인다. 만약 내가 필요한 데이터가 JavaScript로 불러올 수 있는 것이라면, 즉 url request를 날리는 것만으론 해결이 불가능하다. 댓글이 매우 길어서 more 링크(스크립트를 실행하는)가 달려있는 경우엔 more를 누르지 않고선 전체 텍스트를 긁어올 수 없다. 또 pagination이 링크가 아니라 스크립트로 되어있는 경우 다음 페이지로 넘어가면서 여러 페이지를 한 번에 긁을 수 없다. 이 때 셀레니움을 이용한다.

## 0. 설치

- 우선 jre(java runtime environment)가 필요하다. 셀레늄에서 remote server를 돌릴 때 자바를 이용하기 때문이다. oracle.com에 들어가서 jre를 받는게 가장 간편하지만, 개인적으로 터미널을 즐겨 이용하기 때문에 jdk를 받는 것이 좋겠다.
- 다음은 R 패키지 설치다. 설치랑 부착은 쉽다. 인터넷에 보면 가끔 library 대신 require를 쓰는 경우가 있는데 그냥 library 쓰는게 좋다고 한다. require(package)는 library(package)를 try하는 함수다. 그래서 될 수도 있고, 안 될 수도 있는데 에러가 안난다. 그래서 만약 된 줄 알고 넘어가면 나중에 에러가 다시 날 수도 있기 때문에 그냥 안되면 바로 에러 터지는 library를 쓰라고 한다. 근데 왠지 require를 써야하는 특수 상황이 있을 것 같다.

    ```sh
    install.packages('RSelenium')   # install
    library(RSelenium)  # attach
    ```

## 1. 웹 드라이버 - PhantomJS

- phantomjs를 주로 사용한다고 그래서 homebrew를 이용해 설치했다. 크롬이나 파이어폭스를 쓰면 실제로 설치된 브라우저가 작동되는 것을 볼 수 있는데 더 직관적일 순 있겠다. 터미널 명령어다.

    ```sh
    brew install phantomjs
    ```

- R script에서 순서대로 실행한다.
    + `checkForServer`는 셀레늄 바이너리 서버가 있는지 확인하고 없으면 설치하라는 명령어다. 처음 한 번만 해주면 된다.
    + `startServer`는 서버를 시작하라는 의미고 실제로 자바 서버가 돌아간다. 터미널에서 `jps -lv` 명령어를 입력하면 서버 프로세스가 보일 것이다. 만약 뭐 자꾸 에러나면 프로세스 아이디 확인하고 `kill 프로세스id` 해주면 된다. 하나는 기본으로 있는 것이니 지울 필요 없다.
    + 세 번째는 remoteDriver 생성이고, 네 번째는 실제로 인스턴스를 만드는 코드다.
    + 마지막 navigate 함수는 웹드라이버로 원하는 url을 띄우는 것이다.

    ```sh
    RSelenium::checkForServer() # 셀레늄 서버가 있는지 확인, 없으면 설치
    RSelenium::startServer()
    myDriver <- RSelenium::remoteDriver(browserName = "phantomjs")
    myDriver$open()
    myDriver$navigate("http://www.naver.com")
    ```

- 속성 고르기. 아래 css selector는 TripAdvisor의 리뷰에서 more 버튼을 가리키는 것이다. 리뷰가 길면 잘리기 때문에 셀레니움으로 눌러줘야한다. findElement로 찾아서 변수에 할당해두고, 여러 함수를 호출해서 쓸 수 있다.

```sh
more <- myDriver$findElement('css selector', 'span.moreLink')
more$getElementAttribute('onclick')
more$getElementText()
more$clickElement()
```

## 2. 웹드라이버 - 크롬, 파이어폭스

추가 예정
