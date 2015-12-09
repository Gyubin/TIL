# #8 Django form

## 1. 새 글 추가

### A. `forms.py`

blog 앱 디렉토리에 `forms.py` 파일을 생성하고 다음 코드 입력

```python
from django import forms
from .models import Post

class PostForm(forms.ModelForm):

    class Meta:
        model = Post
        fields = ('title', 'text',)
```

- django 모듈에서 forms를 import한다.
- 같은 경로의 models 모듈에서 Post 클래스를 import 한다. form으로 데이터를 입력받아 만들고싶은 데이터 클래스다.
- 원하는 이름으로 form class를 만든다. Post와 관련된 form이므로 PostForm이라고 지은 것이다. 이름은 뭘로 해도 상관없지만 상속은 forms.ModelForm을 꼭 받아준다.
- 내부에 Meta 클래스를 만드는데 model에 클래스를 넣고, form으로 입력받을 속성들을 fields 변수에 문자열로 튜플 형태로 넣어준다.

### B. 새 글 링크 추가

form이 있는 페이지로 들어가는 링크를 추가한다. 역시 reverse match를 사용했다. URLconf에서 name 속성이 'post_new'인 것을 찾는다.

```html
<a href="{% url 'post_new' %}" class="top-menu">
    <span class="glyphicon glyphicon-plus"></span>
</a>
```

### C. URLconf

정확하게 'post/new'인 URL과 매칭되는 정규식이다. post_new 함수로 보낸다.

```py
url(r'^post/new/$', views.post_new, name='post_new')
```

### D. View

```py
from django.shortcuts import render, get_object_or_404, redirect
from .models import Post
from django.utils import timezone
from .forms import PostForm

def post_new(request):
    if request.method == "POST":
        form = PostForm(request.POST)
        if form.is_valid():
            post = form.save(commit=False)
            post.author = request.user
            post.published_date = timezone.now()
            post.save()
            return redirect('blog.views.post_detail', pk=post.pk)
    else:
        form = PostForm()
    return render(request, 'blog/post_edit.html', {'form': form})

```

- request의 메소드가 POST일 경우와 아닌 경우를 나눈다. 두 가지 경우가 이 함수로 들어오기 때문이다.
    + 글 추가 버튼을 눌러서 들어온 경우엔 링크를 클릭했기 때문에 'GET' 메소드다. 이 땐 빈 form을 보여주면 된다.
    + 빈 form에 데이터를 입력해서 save 버튼을 눌렀을 때 다시 이 함수로 들어오게 된다. 이 때엔 메소드가 POST이므로 데이터를 저장하면 되는 것이다.
- `is_valid()` 메소드를 통해 입력값이 정확한지 확인한다.
- POST 메소드로 form 데이터를 보내면 `request.POST`에 데이터가 담긴다. PostForm 클래스에 매개변수로 이 객체를 넣으면 된다. 
- form의 데이터를 저장하는 save 메소드를 사용하는데 commit 속성을 False로 둬서 바로 Post 데이터 모델에 저장하지 않게 해준다.
- 추가 데이터로 author, published_date를 post 속성에 입력 후 save한다.
- post가 저장되면 그 글을 보여주면 된다. 즉 상세페이지다. 상세 페이지를 로딩하는 코드를 또 작성해서 render할 필요 없이 상세페이지와 관련된 함수로 바로 보내면 된다. 이 때 사용하는 것이 `redirect`이고 함수이름을 특정해주면 된다. 그리고 그 특정 함수인 `post_detail`이 매개변수로 pk를 받으므로 같이 전달한다.

### E. Template

```html
{% extends 'blog/base.html' %}

{% block content %}
    <h1>New post</h1>
    <form method="POST" class="post-form">{% csrf_token %}
        {{ form.as_p }}
        <button type="submit" class="save btn btn-default">Save</button>
    </form>
{% endblock %}
```

- 기존 틀을 사용하기 위해서 extends, block content를 사용했다.
- 일반 html에서 form 태그를 사용하는 것과 똑같이 만든다. 메소드는 POST다.
- form 태그 시작 줄 끝에 보안을 위해 `{% csrf_token %}` 를 삽입한다.
- 내부의 필드를 구현할 필요 없이 `{{ form.as_p }}` 한 줄을 써준다.
    + `as_p` : wrapped in p tags
    + `as_table` : wrapped in tr tags. table cells.
    + `as_ul` : wrapped in li tags
- save 코드를 따로 구현 안해도 된다. type이 "submit"인 버튼을 만들어주면 된다.

## 2. 폼 수정하기

### A. 수정 버튼

post_detail.html에서 post.title 바로 위에 다음 코드 추가한다. name 속성이 'post_edit'인 것을 찾고, post.pk 값을 pk 변수에 넣어서 전달한다. URLconf에서 정규식 grouping name이 pk인 것과 매칭된다.

```html
<a class="btn btn-default" href="{% url 'post_edit' pk=post.pk %}">
    <span class="glyphicon glyphicon-pencil"></span>
</a>
```

### B. URLconf

예를 들어 `domain/post/2/edit/`이 되는 것이다. post_edit 함수로 request가 전달된다.

```py
url(r'^post/(?P<pk>\d+)/edit/$', views.post_edit, name='post_edit'),
```

### C. View

```py
def post_edit(request, pk):
    post = get_object_or_404(Post, pk=pk)
    if request.method == "POST":
        form = PostForm(request.POST, instance=post)
        if form.is_valid():
            post = form.save(commit=False)
            post.author = request.user
            post.published_date = timezone.now()
            post.save()
            return redirect('blog.views.post_detail', pk=post.pk)
    else:
        form = PostForm(instance=post)
    return render(request, 'blog/post_edit.html', {'form': form})
```

- URLconf에서 grouping 된 변수인 pk를 매개변수로 받는다.
- pk를 이용해서 Post object를 구한다.
- 역시 여기서도 이 함수로 들어오는 경우가 2가지라서 분기한다.
    + 글에서 edit 버튼을 눌렀을 경우, 메소드가 GET이다. else로 가서 post를 instance로 써서 PostForm 객체를 만든다. 그 후 이 form 객체를 이용해서 post_edit.html을 render한다.
    + post_edit.html에서 글을 수정한 후 save버튼을 눌렀을 때 POST 메소드로 이 함수로 들어온다. request.Post에 들어있는 데이터를 활용해 PostForm 객체를 만드는데 instance를 처음 pk를 활용해 불러왔던 post로 한다. 이 객체에 덮어씌우겠다는 의미인 것 같다.
    + form 데이터가 유효하면 form 데이터에 글쓴이, 발행일 데이터를 다시 넣어서 save한다. 그 후 detail 페이지로 redirect한다.

### D. Template

```html
{% extends 'blog/base.html' %}

{% block content %}
    <h1>New post</h1>
    <form method="POST" class="post-form">{% csrf_token %}
        {{ form.as_p }}
        <button type="submit" class="save btn btn-default">Save</button>
    </form>
{% endblock %}
```

## 3. 로그인 상태일 때만 보여주기

```html
{% if user.is_authenticated %}
    <a href="{% url 'post_new' %}" class="top-menu"><span class="glyphicon glyphicon-plus"></span></a>
{% endif %}
```

새 글 작성하는 아이콘을 나타내는 링크를 위처럼 if 블록으로 감싼다. 로그인 상태에만 + 버튼이 보일 것이다.



