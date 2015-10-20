#Request-Response Cycle
request/response cycle은 유저의 request가 어떤 flow를 타고 흘러가는지에 대한 정보다. 이 플로우를 잘 이해하면 오류가 났을 때 어느 부분을 봐야 하고 어디를 어떻게 수정해야하는지 알 수 있다. Codecademy article인 Request-Response Cycle 1, 2, 3편을 간추려봤다.

1. [Request-Response Cycle 1](https://www.codecademy.com/articles/request-response-cycle-static)
2. [Request-Response Cycle 2](https://www.codecademy.com/articles/request-response-cycle-dynamic)
3. [Request-Response Cycle 3](https://www.codecademy.com/articles/request-response-cycle-forms)

##1편, 2편
1편 내용에 db가 추가된 것이 2편이라서 2편만 나타낸다.
![How it Works](https://s3.amazonaws.com/codecademy-content/projects/3/request-response-cycle-dynamic.svg)
========
1. 브라우저에 http://localhost:8000/welcome 을 입력하고 엔터를 친다. 이것은 도메인과 연결된 프로젝트에 /welcome 이라는 request를 날리는 것을 의미한다.
2. request는 /config/routes.rb의 **router**를 만나게 된다.
3. router는 routes.rb에 적힌대로 URL을 구분하여 맞는 controller로 request를 보낸다.
4. controller는 request를 받아서 처리한다. 내부에 db 관련 소스가 있다면 model에 데이터를 달라고 요청을 보낸다.
5. 모델이 데이터를 다시 컨트롤러의 액션에게 준다.
6.처리가 끝나면 controller는 매칭되는 view로 request를 전달한다.
7.view는 HTML 형식으로 페이지를 render한다.
8.마지막으로 controller가 HTML 파일을 브라우저로 전송한다.

##3편
form이 있을 때 request flow가 어떻게 되는지 나타낸다. 1, 2편과 크게 다를 것이 없으며 db가 없는 플로우가 GET, 있는 플로우가 POST이다.
