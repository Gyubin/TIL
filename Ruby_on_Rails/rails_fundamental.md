# 레일즈 사용법 기초 정리

참고

- 멋쟁이 사자처럼 3기 과정 + Codecademy.org
- [railsapps.github.io/](http://railsapps.github.io/installrubyonrails-mac.html)

## 0. 설치

- `mkdir myapp && cd myapp` : 프로젝트 디렉토리를 만들고 그 안에서
- `rvm use ruby 2.4.0@myapp --ruby-version --create` : gemset 만들기
- `gem install rails` : 레일즈 최신버전 설치
- `rails new .` : 현재 디렉토리에 레일즈 프로젝트 생성

## 1. 프로젝트 만들기

```sh
rails new MySite    # 레일즈 프로젝트 생성. 프로젝트 디렉토리 만드는거까지 자동
bundle install      # 패키지 설치. 설치된 패키지는 Gemfile에 기록된다.
rails server        # 서버 스타트. localhost:8000 에서 동작 가능하다. WEBrick. 뒤에 -p 1234 이런식으로 포트를 정해줄 수도 있다.
```

## 2. request/response cyle(중요)

https://www.codecademy.com/articles 여기서 Ruby를 선택하면 좋은 아티클들 정말 많다. 하나하나 번역해봐야겠다. 새로운 TIL 건수 발견.

1. 브라우저에 http://localhost:8000/welcome 을 입력하는 것은 저 도메인의 프로젝트에 /welcome 이라는 request를 날리는 것을 의미한다.
2. request는 /config/routes.rb의 **router**를 만나게 된다.
3. router는 routes.rb에 적힌대로 URL을 구분하여 맞는 controller로 request를 보낸다.
4. controller는 request를 받아서 처리한다. 내부에 db 관련 소스가 있다면 model에 데이터를 달라고 요청을 보낸다.
5. 모델이 데이터를 다시 컨트롤러의 액션에게 준다.
6. 처리가 끝나면 controller는 매칭되는 view로 request를 전달한다.
7. view는 HTML 형식으로 페이지를 render한다.
8. 마지막으로 controller가 HTML 파일을 브라우저로 전송한다.

## 3. controller, action

```sh
rails generate controller Pages
```

- `app/controllers/pages_controller.rb` 라는 파일을, 즉 `Pages`라는 컨트롤러를 만드는 것을 의미한다.
- 위 파일을 열어서 클래스 안에 원하는 메소드를 선언하면(`def home ~~ end`) 이 메소드가 controller의 `action`이 된다.

## 4. router

/config/routes.rb 파일을 열어서 작업하면 된다. 아래 코드 의미는 domain.com이라는 도메인의 프로젝트에서 /welcome 이라는 URL을 pages 컨트롤러의 home 액션과 매칭시키는 것이다. 그 아래 root 는 단순히 도메인만 입력했을 때 어느 액션으로 보내줄건지를 의미한다.

```ruby
get 'welcome' => 'pages#home'
root 'pages#home'
```

## 5. model

```sh
rails generate model Message    # 아래 설명
rake db:migrate    # 마이그레이션 파일에 맞춰서 db를 업데이트 하는 명령어
rake db:seed        # db/seeds.rb 파일에 적혀진 데이터를 입력하는 명령어.
```

generate model 코드를  터미널에서 실행하면 다음 두 개의 파일을 생성한다.

- 모델 파일을 app/models/message.rb 처럼 생성한다. 모델은 데이터베이스에서 하나의 **테이블**을 의미한다.
- migration 파일을 db/migrate/ 디렉토리에 생성한다. 파일 이름은 연월일시간+메소드이름들로 이루어져있다. migration은 데이터베이스를 변경하는 방법 중 하나다.

### 5.1 migration 파일

- db/migrate 폴더 안에 새로 생긴 migration 파일은 안에 change method를 가지고 있다. 체인지 메소드는 레일즈에게 데이터베이스를 이러이러하게 바꾸라고 말해주는 역할을 한다. 기본적으로 체인지 메소드는 내부에 create_table 메소드를 가지고 있는데 새로운 테이블을 만들 때 사용한다.
- t.text :content 라는 코드의 의미는 텍스트를 저장하는 컬럼을 만들고 그걸 content라고 지칭하겠다라는 것이다. t.text 말고도 다양한 컬럼 종류가 존재한다. 예를 들어 t.timestamps는 생성시각과 수정시각을 저장하는 컬럼을 의미한다. 만들어지는 두 개 컬럼은 자동으로 데이터가 들어가게 된다. 우리가 따로 조작을 안해도.
- rake db:migrate 이 명령어는 방금 전에 만든 데이터 모델에 따라서 데이터베이스를 update 하라는 의미다. 근데 한 번 명령어를 통해 데이터베이스를 업데이트한 상황에서 마이그레이션 파일의 테이블을 살짝 수정하고, 다시 명령어를 실행하면 모두 뒤엎어버릴까? 아니다. 명령어는 먹히지 않는다. 한 번 migrate된 상황에서 마이그레이션 파일을 바꾸고 적용하려면 rake db:drop 을 통해 디비를 모두 날린 후에 다시 migration을 해야 한다. 만약 컬럼을 추가하고 드롭하지 않고 마이그레이션을 하면 적용이 안돼서 있는 컬럼인데도 불구하고 없는 메소드라고 오류 메시지를 띄울 것이다.

## 6. Templates

- views 폴더 안에 `.erb` 확장자로 만든다.
- `<% ruby syntax %>`: 꺾쇠 안에 루비코드를 쓰면 된다.
- `<%= ruby syntax%>`: 루비 코드에 의한 값을 출력할 수 있다.

## 기타

- 컨트롤러와 모델을 rails 명령어로 생성할 때는 첫글자를 대문자로 하는 것 같다.
- ERB 같은 파일을 웹 템플릿이라고 한다. HTML에 특정 언어 변수나 플로우가 포함돼있는 것을 말한다.
- 아직 제대로 이해 못한 것들
    + 레일즈에서 데이터를 가공하고 보여줄 때 사용하는 7가지 표준 컨트롤러 액션: https://www.codecademy.com/articles/standard-controller-actions
    + 컨트롤러의 변수를 뷰로 넘겨서 활용하려면 최소 인스턴스 변수여야 한다? 지역변수는 당연히 컨트롤러의 메소드가 끝나는 순간 사라지니까 전달 안될 것이다. 그럼 인스턴스 변수가 뷰로 넘어간다는 것은 뷰도 그 클래스의 일부분이란 소리일까? 혹은 레일즈가 어떤 약속을 통해 알아서 넘기는 것일까? 원리가 궁금하다. 아직은 잘 모르겠다.
    + 레일즈에서 form_for 라는 특화된 form 형태를 어떻게 사용하는 것인지.
