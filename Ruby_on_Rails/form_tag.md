#Rails Form Helper - form_tag
참고 링크: [레일즈 공식 문서(영문)](http://guides.rubyonrails.org/form_helpers.html), [RORLAB(한글)](http://guides.rorlab.org/form_helpers.html)

웹 애플리케이션 보안을 위해 레일즈에서 기본적으로 해주는 것 중 하나가 form helper이다. html만 활용해서 form을 만들지 않고 레일즈의 form helper를 사용하면 레일즈의 기본 보안 기능을 사용할 수 있다.
##A. form_tag 기본
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

##B. 검색 form
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

##C. form helper 호출할 때 인자 넣기
form tag 헬퍼는 두 개의 인자를 사용한다. 하나는 액션 경로, 하나는 옵션이다. 옵션 인자에는 메소드 형식, 클래스명 등이 가능하다. 아래 코드를 보면 컨트롤러와 액션을 하나의 해시로 묶어두었다. 액션 경로와 관련된 인자를 하나로 묶어둔 것이다. 이렇게 묶지 않으면 액션에 method:'get'과 클래스 정보가 모두 들어가버린다.

즉 액션 경로와 옵션이라는 다른 인자를 { }로 묶어주면 오류가 안난다.
```html
<%= form_tag({controller: "hiforms", action: "search"}, method: "get", class: "nifty_form") do %>
  <%= label_tag(:q, "Search for:") %>
  <%= text_field_tag(:q) %>
  <%= submit_tag("Search") %>
<% end %>
```

##D. 다양한 form tag 만들기
- _tag로 끝난다. text_field_tag, check_box_tag 등등
- 첫 번째 파라미터로 받는 심볼은 그 input tag의 name, id로 입력된다.
- label 태그는 조금 달라서 첫 번째 심볼이 for attribute이 되고 두 번째 문자열이 label 내용이 된다.
- 심볼로 넣어주면 그걸 컨트롤러에서 params(:some_symbol)로 받을 수 있다. 

###(1) 체크박스
```html
<!-- 이렇게 넣으면 -->
<%= check_box_tag(:pet_dog) %>
<%= label_tag(:pet_dog, "I own a dog") %>
<%= check_box_tag(:pet_cat) %>
<%= label_tag(:pet_cat, "I own a cat") %>

<!-- 이렇게 나온다. -->
<input id="pet_dog" name="pet_dog" type="checkbox" value="1" />
<label for="pet_dog">I own a dog</label>
<input id="pet_cat" name="pet_cat" type="checkbox" value="1" />
<label for="pet_cat">I own a cat</label>
```
위 코드가 나타내는 모양은 체크박스와 label이 한 줄 씩 띄워져서 나온다. 이건 css로 조절해야 한다고 스택오버플로우 답변들이 나와있다. 부트스트랩 쓰라고 함. 체크 박스에 두 번째로 파라미터를 넣으면 value attribute의 값이 된다. 아무것도 안넣으면 디폴트로 1이 되는 것 같다.
###(2) 라디오버튼
```html
<!-- 이렇게 넣으면 -->
<%= radio_button_tag(:age, "child") %>
<%= label_tag(:age_child, "I am younger than 21") %>
<%= radio_button_tag(:age, "adult") %>
<%= label_tag(:age_adult, "I'm over 21") %>

<!-- 이렇게 나온다. -->
<input type="radio" name="age" id="age_child" value="child">
<label for="age_child">I am younger than 21</label>
<input type="radio" name="age" id="age_adult" value="adult">
<label for="age_adult">I'm over 21</label>
```
라디오 버튼은 기본적으로 하나만 선택된다. 그렇기 때문에 체크박스처럼 하나하나가 다른 의미를 지닌게 아니라 어떤 범주 안에 라디오버튼들이 속한 형태다. 그래서 라디오버튼에 첫번째 파라미터로 들어가는 심볼은 범주를 의미하는 큰 의미의 심볼이 들어가야 한다. 위에서 보면 :age 라고 들어가있다. 그리고 두 번째 파라미터의 문자열이 그 라디오 버튼의 의미를 나타내게 된다.

이것이 실제로 html로 나타내어지면 name은 범주인 age가 되고, id 값은 첫 번째 두 번째 파라미터가 언더바로 연결된 age_child, age_adult로 되는 것이다. value는 그대로 각각 두 번째 파라미터 값이 그대로 들어간다.
>위 체크박스와 라디오버튼의 예처럼 label을 for attribute을 사용하여 각각의 태그와 연결시킨 것은 사용자를 배려한 것이다. 저렇게 해두면 라벨을 클릭하더라도 각 태그가 선택되기 때문에 편리하다.
###(3) 다른 태그들

다른 태그들은 아래처럼 사용할 수 있다. 역시 첫 번째 파라미터로 심볼이 들어감. 
```html
<%= text_area_tag(:message, "Hi, nice site", size: "24x6") %>
<%= password_field_tag(:password) %>
<%= hidden_field_tag(:parent_id, "5") %>
<%= search_field(:user, :name) %>
<%= telephone_field(:user, :phone) %>
<%= date_field(:user, :born_on) %>
<%= datetime_field(:user, :meeting_time) %>
<%= datetime_local_field(:user, :graduation_day) %>
<%= month_field(:user, :birthday_month) %>
<%= week_field(:user, :birthday_week) %>
<%= url_field(:user, :homepage) %>
<%= email_field(:user, :address) %>
<%= color_field(:user, :favorite_color) %>
<%= time_field(:task, :started_at) %>
<%= number_field(:product, :price, in: 1.0..20.0, step: 0.5) %>
<%= range_field(:product, :discount, in: 1..100) %>
```
