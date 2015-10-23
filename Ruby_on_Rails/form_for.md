#Rails Form Helper - form_for
참고 링크: [레일즈 공식 문서(영문)](http://guides.rubyonrails.org/form_helpers.html), [RORLAB(한글)](http://guides.rorlab.org/form_helpers.html), [Jonathan Yeong's blog](http://jonathanyeong.com/saving-form-model-rails/)(Thanks Jonathan.)

가이드 문서에 form_for로 받은 객체를 어떻게 save 해야하는지 설명이 없었다. 단순하게 save하면 되겠지 했다가 많은 삽질을 했다. 결국 검색을 했고 나와 똑같은 상황과, 똑같은 시도를 했던(나보다는 더 많이 시도..) 분의 블로그를 발견했다. 큰 도움이 되었다.

##플로우

1. 브라우저에 articles/new 를 입력한다.
2. 라우터는 이 리퀘스트와 연관되는 컨트롤러와 액션을 찾고 전달한다. -> articles#new
3. ArticlesController의 new 액션에서 @article 객체를 생성하고 뷰로 전달한다.
4. form_for는 전달받은 @article 객체를 가지고 form builder를 만든다. Article 모델의 속성인 title과 body를 심볼러 필드에 적어줘서 매칭시켜준다. submit을 누르면 create action으로 POST 리퀘스트가 전달된다.
5. 라우터는 이 요청을 받아서 'articles#create' 컨트롤러, 액션으로 전달한다.
6. create 액션에서 Article의 클래스 메소드인 create을 가지고 객체를 생성한다. 이 때 create 메소드의 파라미터로 article_params라는 private method가 들어간다.
7. 마지막으로 전체 정보를 나타내는 의미를 갖고 있는 '/articles/index' URL로 리다이렉트 시키고 이것은 라우터를 거쳐 index 액션을 거쳐서 반복문을 통해 모든 데이터를 보여준다. **중요한것은 redirect_to 할 때 맨 앞에 / 꼭 붙여줘야 한다.**

```ruby
# routes.rb
get 'articles/new' => 'articles#new'
post 'articles' => 'articles#create'
get 'articles/index' => 'articles#index'

# ArticlesController
def new
  @article = Article.new
end
def create
  Article.create(article_params)
  redirect_to '/articles/index'
end
def index
  @articles = Article.all
end
private
  def article_params
    params.require(:article).permit(:title, :body)
  end

# new.erb
<%= form_for @article, url: {action: "create"}, html: {class: "nifty_form"} do |f| %>
  <%= f.text_field :title %>
  <%= f.text_area :body, size: "60x12" %>
  <%= f.submit "Create" %>
<% end %>

# index.erb
<% @articles.each do |article| %>
  <h2><%= article.title %></h2>
  <p><%= article.body %></p>
<% end %>
```
> private method인 article_params에서 require 메소드의 파라미터는 모델 명과 일치해야 하고, permit의 파라미터는 각 속성들을 의미한다. 저런 형태 잘 기억.
