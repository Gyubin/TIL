#Rails Form Helper
참고 링크: [레일즈 공식 문서(영문)](http://guides.rubyonrails.org/form_helpers.html), [RORLAB(한글)](http://guides.rorlab.org/form_helpers.html)

웹 애플리케이션 보안을 위해 레일즈에서 기본적으로 해주는 것 중 하나가 form helper이다. html만 활용해서 form을 만들지 않고 레일즈의 form helper를 사용하면 레일즈의 기본 보안 기능을 사용할 수 있다.
##form_tag 기본
form_tag에 인자를 아무것도 안 넣었기 때문에 form의 action은 현재 url이 된다. 자동으로 hidden 타입의 두 input이 만들어지게 된다. 첫 번째 utf-8 인풋은 이 인코딩 타입을 쓰는 것을 강제하는 것이고 모든 메소드(GET, POST)에서 나타난다. 두 번째 토큰 인풋은 POST 메소드에서만 나타난다. 만약 그냥 form을 써서 직접 만들었다면 레일즈의 forgery 관련 에러가 뜨게 될 것이다.
```html
<!-- 내 erb 파일의 코드 -->
<%= form_tag do %>
  Form contents
<% end %>

<!-- 실제 나타나는 코드 -->
<form action="/form-test" accept-charset="UTF-8" method="post">
  <input name="utf8" type="hidden" value="✓">
  <input type="hidden" name="authenticity_token" value="rhxdVn5wmqy+OdJrIO50zKa5mLbxv7gMGoycizMBNGy60wbBOqNglpwPIFYIXAPwmytn9GqaAFd65ARsROdx/g==">
  Form contents
</form>
```

##검색 form
검색 폼을 사용할 때는 GET method를 사용하는 것이 중요하다. 검색 쿼리가 URL에 포함돼야 사용자가 북마크를 하거나 URL을 저장할 때 편리하다.

원하는 필드를 만드려면 태그명+_tag 형태로 적으면 된다. ()안에 첫 번째로 심볼 형태로 적어주게 되는 변수는 label에선 for, text field에선 name, id가 된다. 두 번째로 들어가는 변수는 문자열로 value가 된다. 아래에서 태그 별로 다시 알아보겠다.
```html
<!-- 내 erb 파일의 코드 -->
<%= form_tag("/search", method: "get") do %>
  <%= label_tag(:q, "Search for:") %>
  <%= text_field_tag(:q) %>
  <%= submit_tag("Search") %
<% end %>

<!-- 실제 나타나는 코드 -->
<form action="/search" accept-charset="UTF-8" method="get">
  <input name="utf8" type="hidden" value="✓">
  <label for="q">Search for:</label>
  <input type="text" name="q" id="q">
  <input type="submit" name="commit" value="Search">
</form>
```

##form helper 호출할 때 인자 넣기
form tag 헬퍼는 두 개의 인자를 사용한다. 하나는 액션 경로, 하나는 옵션이다. 옵션 인자에는 메소드 형식, 클래스명 등이 가능하다. 아래 코드를 보면 컨트롤러와 액션을 하나의 해시로 묶어두었다. 액션 경로와 관련된 인자를 하나로 묶어둔 것이다. 이렇게 묶지 않으면 액션에 method:'get'과 클래스 정보가 모두 들어가버린다.

즉 액션 경로와 옵션이라는 다른 인자를 { }로 묶어주면 오류가 안난다.
```html
<%= form_tag({controller: "hiforms", action: "search"}, method: "get", class: "nifty_form") do %>
  <%= label_tag(:q, "Search for:") %>
  <%= text_field_tag(:q) %>
  <%= submit_tag("Search") %>
<% end %>
```


