# 레일즈 사용법 기초 정리
멋쟁이 사자처럼 3기 과정 + Codecademy.org

##프로젝트 만들기
```shell
rails new MySite    # 레일즈 프로젝트 생성
bundle install         # 패키지 설치. 설치된 패키지는 Gemfile에 기록된다.
rails server            # 서버 스타트. localhost:8000 에서 동작 가능하다. WEBrick. 뒤에 -p 1234 이런식으로 포트를 정해줄 수도 있다.
```
##request/response cyle
1. 브라우저가 http://localhost:8000에 request를 날린다.
2. request는 /config/routes.rb의 **router**를 만나게 된다. router는 URL을 구분하여 맞는 controller로 request를 보낸다.
3. controller는 request를 받아서 처리한다.
4. 처리가 끝나면 controller는 매칭되는 view로 request를 전달한다.
5. view는 HTML 파일로 페이지를 render한다.
6. 마지막으로 controller가 HTML 파일을 브라우저로 전송한다.

##controller
```shell
rails generate controller Pages     // app/controllers/pages_controller.rb 라는 파일을 만든다. 즉 Pages라는 컨트롤러를 만든다.
```
위 파일을 열어서 클래스 안에 원하는 메소드를 선언하면(def home ~~ end) 이 메소드가 controller의 action이 된다.

##router
/config/routes.rb 파일을 열어서 작업하면 된다. 아래 코드 의미는 domain.com/welcome 이라는 URL을 pages 컨트롤러의 home 액션과 매칭시키는 것이다.
```shell
get 'welcome' => 'pages#home'
```
