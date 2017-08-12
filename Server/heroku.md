# Heroku

참고 : Heroku tutorial [python](https://devcenter.heroku.com/articles/getting-started-with-python), [node](https://devcenter.heroku.com/articles/getting-started-with-nodejs#deploy-the-app)

## 1. 설치 및 로그인

- `brew install heroku` : CLI 설치
- `heroku login` : 아이디와 비밀번호 입력하면 로그인된다.
- `heroku create project-name`
    + 적어준 프로젝트명으로 프로젝트 생성된다. 로컬에 프로젝트가 생성되는게 아니라 원격 저장소에 생김
    + 터미널에 뜬 주소로 들어가보면 실제로 해당 페이지를 볼 수 있다.

## 2. 예제 프로젝트

- `git clone https://github.com/heroku/node-js-getting-started.git` : 샘플 프로젝트 다운로드
- `cd node~~` : 해당 프로젝트 디렉토리로 들어가서
    + `heroku create` : 원격 저장소가 만들어지고, heroku라는 이름으로 remote가 자동 설정된다.
    + `git push heroku master` : heroku에 현재 프로젝트 push
- `heroku ps:scale web=1`
    + 1개의 인스턴스로 웹앱 실행하겠다는 의미(최소 1개)
- `heroku open` : 주소를 치고 들어가도 되지만 이 명령어로 브라우저에서 해당 주소를 열 수 있다.
- `heroku logs --tail` : 로그 보기. tail 옵션을 붙이면 계속 띄워둘 수 있다. 없이 실행하면 그 시점의 로그를 출력
