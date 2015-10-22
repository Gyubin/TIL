#Rails Form Helper - model object helper
참고 링크: [레일즈 공식 문서(영문)](http://guides.rubyonrails.org/form_helpers.html), [RORLAB(한글)](http://guides.rorlab.org/form_helpers.html)

##모델 객체 헬퍼
html form에서 각 태그에 id값을 지정하고, controller에서 params로 값을 불러오는 작업은 꽤 귀찮다. 각 id 값과 params 값이 똑같이 되어있는지 하나하나 체크해야하기 때문이다. 그래서 form에서부터 객체에 맞는 형태로 만들어서 정보를 컨트롤러로 보낼 수 있고 그것을 객체 변수로 바로 받을 수 있도록 한 것이 model object helper다. 뒤에 _tag를 안쓰면 된다.

문서에 form을 시작할 때 어떻게 하는지 언급이 없어서 바로 이전 예제의 form_tag를 그대로 썼다. 내부 form contents만 model object helper를 사용했다. 일반적인 form_tag 사용법과 다르게 text_field 다음에 _tag가 붙지 않는다. 그리고 첫 번째 파라미터에 변수명 심볼, 두 번째 파라미터에 변수의 속성명 심볼을 전달해주면 된다.
```html
<%= form_tag(controller: "hiforms", action: "search") do %>
  <%= text_field(:person, :name) %>
  <%= submit_tag("GO") %>
<% end %>
```
현재 파일의 구조는 **hiforms 컨트롤러**와 **hi.erb 뷰 파일**, **search.erb 뷰 파일**을 가지고 있으며 각 파일의 내용은 다음과 같다.
```ruby
# routes.rb
get 'form-test' => 'hiforms#hi'
post 'form-test/search' => 'hiforms#search'

# hiforms_controller.rb
  def hi
    #@person = Person.new({name: "Gyubin"})
  end
  def search
    @name = params[:person][:name]
  end

# hi.erb
<%= form_tag(controller: "hiforms", action: "search") do %>
  <%= text_field(:person, :name) %>
  <%= submit_tag("GO") %>
<% end %>

# search.erb
<%= @name %>
```

> hi 액션에서 주석처리한 부분은 뷰를 띄울 때부터 컨트롤러에서 뷰로 객체를 전달해주는 과정이다. 저 코드에 주석이 없다면 text_field 태그의 밸류값에 "Gyubin"이 들어가있을 것이다. 기본적으로 값을 처음에 넣어주는 것 뿐이고 수정해서 submit 버튼을 누르면 수정된 값이 value가 되어 넘어간다.

### 플로우는 다음과 같다.

1. localhost:3000/form-test URL을 입력한다.
2. 리퀘스트는 라우터로 이동해서 hiforms 컨트롤러의 hi 액션과 매칭된다.
3. hiforms 컨트롤러의 hi 액션으로 가서 코드가 있다면 코드가 실행된다.
4. 액션과 이름이 같은 hi.erb 뷰 파일로 리퀘스트는 전달된다.
5. hi.erb 뷰 파일이 브라우저에 보여지고 hiforms 컨트롤러의 search 액션과 매칭된 form을 통해서 유저는 정보를 입력한다. 
6. text_field의 파라미터인 첫 번째 person은 인스턴스변수를 나타내고, 두 번째 파라미터인 name은 person의 한 속성을 나타낸다. 즉 person 객체의 name 속성에 텍스트 필드 밸류값을 집어넣는다는 의미다.
7. submit 버튼을 누르면 정보가 POST 메소드로 'hiforms#search 컨트롤러#액션'으로 전달된다. routes.rb 파일을 수정해보면서 테스트해본 결과 이 방식에선 라우터로 URL이 전달되는게 아니라 컨트롤러와 액션 매칭 정보가 전달되는 것 같다. 그에 맞는 라우터 정보가 post 'form-test/search' => 'hiforms#search'인 것이다. 그래서 이후 뷰파일이 브라우저에서 보여질 때의 URL이 form-test/search다. 현재 hi.erb 파일의 form 태그 코드는 URL 정보는 전달하지 않는다. 그래서 라우터 파일에서 URL 값을 수정하니 다른것은 전혀 영향을 받지 않으면서 브라우저의 URL 값이 변경되는 것을 볼 수 있었다. 다만 post는 꼭 맞춰줘야 한다.
8. 이후 hiforms 컨트롤러의 search 액션으로 정보가 가고, params를 통해 전달받은 person 인스턴스 변수의 name 속성을 @name에 저장했다.
9. search 액션과 연동된 search.erb 파일에서 @name을 띄워보면 form에서 입력한 값이 뜨는 것을 볼 수 있다.



