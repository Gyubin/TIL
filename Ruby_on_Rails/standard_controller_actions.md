#Standard Controller Actions
참조 링크: [Codecademy article](https://www.codecademy.com/articles/standard-controller-actions)

루비 온 레일즈는 7가지 표준 컨트롤러 액션을 미리 정의해놨다. 코드카데미 루비 과정에서 '반복하지마!' 라고 말했듯이 데이터를 가공하고 보여주는 액션들이 일반적으로 많이 쓰이기 때문에 아예 디폴트로 설정해둔 것이다.

[standard_controller_actions](https://s3.amazonaws.com/codecademy-content/projects/3/seven-actions.svg)

위 표에서처럼(이걸 코드카데미에서 벡터 이미지로 만들어놨다. 헐 짱이다..) 총 7가지 액션이 존재한다. 데이터를 모두 보여주는 액션, 만드는 HTML form 창 보여주는 액션, 데이터 받아서 저장하는 액션, 특정 데이터 보여주는 액션, 특정 데이터 수정하는 form 보여주는 액션, 수정된 데이터 받아서 데이터 다시 저장하는 액션, 특정 데이터 지우는 액션 이렇게 7가지다.

즉 위 설명(표)순서대로 index, new, create, show, edit, update, destroy 액션이 만들어진다.

##사용법
7개 모든 액션을 routes에 적용하는 방법은 routes.rb에 다음 코드처럼 *resources*와 컨트롤러 명을 심볼 형태로 적어주면 된다.
```ruby
# /config/routes.rb
resources :messages  # messages는 컨트롤러 명
resources :signups, only [:index, :show]  # signups 컨트롤러에 index, show 액션만 추가하고 싶다면 지정해줄 수 있다.
```
위와 같이 routes.rb 파일을 수정한 후에 shell에다 *rake routes* 명령어 입력하면 끝.
