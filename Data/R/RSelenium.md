# RSelenium

R에서 셀레니움 활용방식을 간단하게 정리한다. 셀레니움은 웹 테스팅 툴이다. 웹 사이트에서 버그가 없는지 테스트할 때 모든 버튼을 눌러보거나 해야하는데 이를 자동화한다. 이게 가능한 이유는 브라우저의 웹 드라이버 API를 구현(?)하고 있기 때문이다. 즉 브라우저의 모든 동작, 예를 들면 클릭이나 더블 클릭, 우클릭 등을 자동으로 실행할 수 있다. 

그런데 웹 크롤링에서도 많이 쓰인다. 만약 내가 필요한 데이터가 JavaScript로 불러올 수 있는 것이라면, 즉 url request를 날리는 것만으론 해결이 불가능하다. 댓글이 매우 길어서 more 링크(스크립트를 실행하는)가 달려있는 경우엔 more를 누르지 않고선 전체 텍스트를 긁어올 수 없다. 또 pagination이 링크가 아니라 스크립트로 되어있는 경우 다음 페이지로 넘어가면서 여러 페이지를 한 번에 긁을 수 없다. 이 때 셀레니움을 이용한다.

## 0. 설치

- 우선 jre(java runtime environment)가 필요하다. 셀레늄에서 remote server를 돌릴 때 자바를 이용하기 때문이다. oracle.com에 들어가서 jre를 받는게 가장 간편하지만, 개인적으로 터미널을 즐겨 이용하기 때문에 jdk를 받는 것이 좋겠다.
- 다음은 R 패키지 설치다. 설치랑 부착은 쉽다. 인터넷에 보면 가끔 library 대신 require를 쓰는 경우가 있는데 그냥 library 쓰는게 좋다고 한다. require(package)는 library(package)를 try하는 함수다. 그래서 될 수도 있고, 안 될 수도 있는데 에러가 안난다. 그래서 만약 된 줄 알고 넘어가면 나중에 에러가 다시 날 수도 있기 때문에 그냥 안되면 바로 에러 터지는 library를 쓰라고 한다. 근데 왠지 require를 써야하는 특수 상황이 있을 것 같다.

    ```py
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

    ```py
    RSelenium::checkForServer() # 셀레늄 서버가 있는지 확인, 없으면 설치
    RSelenium::startServer()
    myDriver <- RSelenium::remoteDriver(browserName = "phantomjs")
    myDriver$open()
    myDriver$navigate("http://www.naver.com")
    ```

- 속성 고르기. 아래 css selector는 TripAdvisor의 리뷰에서 more 버튼을 가리키는 것이다. 리뷰가 길면 잘리기 때문에 셀레니움으로 눌러줘야한다. findElement로 찾아서 변수에 할당해두고, 여러 함수를 호출해서 쓸 수 있다.

    ```py
    more <- myDriver$findElement('css selector', 'span.moreLink')
    more$getElementAttribute('onclick')
    more$getElementText()
    more$clickElement()
    ```

## 2. 크롬, 파이어폭스로 띄우기

phantomjs는 실제로 GUI가 나타나거나 하지 않는다. 그래서 그냥 편하게 shell만 보면서 작업하면된다. 근데 가끔 이상하게 버그가 안잡히는 경우가 있다. 그럴 땐 직접 브라우저에서 동작하는걸 보면서 하는게 최고다. 예를 들어 TripAdvisor 사이트를 크롤링할 때 언어 설정 때문에 내가 참고한 css selector와 RSelenium이 보는 css selector가 달라질 수 있다. 내 경우가 그랬다. 나는 영문판을 보고 있었고, RSelenium은 한글판을 보고 있었다. 이럴 때 사용해보자. phantomjs와 거의 똑같다.

```py
dyn.load('/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/server/libjvm.dylib')

RSelenium::checkForServer()
RSelenium::startServer()
myDriver <- RSelenium::remoteDriver(browserName = "firefox")
myDriver$open()
myDriver$navigate("http://www.naver.com")
```

역시 내 경우에는 KoNLP 때와 마찬가지로 RStudio가 Java를 잘 못 불러온다. path가 잘못된 것 같은데 아쉬운데로 dyn.load 함수를 써서 해결했다. 만약 `Summary: UnknownError, Detail: An unknown server-side error occurred while processing the command, class: org.openqa.selenium.WebDriverException`와 같은 에러가 뜬다면 자바 문제다. 그리고 자기 컴퓨터의 jdk 버전은 맞게 지정해줘야한다. 나는 1.8.0에 73 버전이라서 `jdk1.8.0_73.jdk` 이렇게 적었다 각자 맞게 적어야 한다. 

## 3. 주요 함수들

- `findElement(using='css selector', 'selector_string')` : using에 원하는 찾기 방법을 입력하고, 그에 맞는 값을 두번째 매개변수로 넣어준다. 주로 css selector를 쓴다. 찾는 값 하나를 리턴한다. 찾은 값에서 또다시 remoteDriver 객체에서 호출할 수 있는 함수를 사용할 수 있다.
- `findElements(using='css selector', 'selector_string')` : findElement와 같지만 찾는 값 여러개를 리턴한다. 그래서 결과에 뭔가를 적용하고싶다면 apply 계열 함수를 사용하면 된다.
- `clickElement()` : 주로 findElement로 찾은 값에서 호출한다. 클릭하는 기능
- `getElementText()` : 텍스트 부분을 리턴한다.
- `getElementAttribute('attribute')` : 원하는 속성 값을 리턴한다.
- `findChildElement`, `findChildElements` : remoteDriver 객체에서 어떤 요소를 뽑아내고 그 요소 내에서 다시 다른 요소를 찾을 때 호출하는 함수다. 즉 remoteDriver가 아니라 webElement 객체에서 호출할 수 있는 함수

## 4. 셀레늄 팁

- 클릭해서 팝업을 띄우는 경우(새 윈도우 창 말고 같은 창 내에서): 브라우저의 화면에서 그 버튼이 보이는 범위로 스크롤되어있지 않은 경우에 에러난다. 아래 코드처럼 `scrollIntoView()` 함수를 선택 객체에서 호출해서 스크롤 위치를 조정해준다. 사이트에 따라서 navigation menu가 버튼을 가리는 경우도 있는데 `window.scroll(x, y)` 함수로 살짝 조정해주면 된다. 스크롤이 코드 실행 속도보다 느릴 수 있으니 짧게 딜레이를 준다.

    ```js
    remDr$executeScript("arguments[0].scrollIntoView();", list(gt))
    remDr$executeScript("window.scrollBy(0, -150)")
    Sys.sleep(0.5)
    ```

- `findElements('css selector', 'blah#blah blah.blah')` 함수를 통해 객체를 여러개 찾게 되면 찾아진 모든 webElement들이 list에 담기게 된다. 하나하나 for 문으로 뽑아낼 수 있는데 가끔은 이 뽑아진 객체가 하나의 webElement로 작동하지 않는 경우가 있다. 이 땐 에러가 나는 부분 전에 `findElement` 함수로 같은 element를 하나만 뽑아보면 해결된다. 의미없이 실행하는 코드지만 신기하게 에러가 사라지는 것을 볼 수 있다. 이유는 모르겠다.
- 페이지에서 '덩어리' 별로 반복을 돌아야할 경우가 있다. 구체적으로 말하면 한 페이지에 10개의 평가가 있는데, 이 평가를 10개 잡아내서 하나 하나 for 반복을 돌리는 경우다. 리뷰 하나 하나를 객체로 만들어 db에 저장하거나, 한 평가 덩어리에서 없는 요소가 있을 수 있는 경우 이 방법을 통해 걸러내거나 NA 처리를 해주면 된다. 이 때 문제가 되는 것은 요소에서 다시 `findChildElement`를 호출해 자식 요소들을 고를 때 아무것도 리턴되지 않는 경우가 생길 수 있다. html 문서에서 분명 하나 밖에 없는 요소라도 높은 확률로 2개가 골라질 수 있기 때문이다. 그렇기 때문에 만약 에러가 난다면 `findChildElements` 함수를 써야하며 이 때도 이 중에 하나는 빈 요소이며 list로 리턴될 때 앞에 올지 뒤에 올지 모르기 때문에 if문으로 비었는지 여부를 체크해가며 자료에 넣어줘야 한다.
