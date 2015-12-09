# #7 URL로 변수 전달, 링크 이동

## 1. a 태그 URL 설정

```html
<h1><a href="{% url 'post_detail' pk=post.pk %}">{{ post.title }}</a></h1>
```

다음과 같은 형태로 href 속성을 넣어준다. `{% %}` 안에 `url`을 쓰고 한 칸씩 띄워서 속성을 입력하면 `/`로 구분된다.
- `'post_detail'` : Django의 'reverse match'다. URLconf에서 name이 `'post_detail'`인 것으로 가라는 의미다. URLconf에서 맞는 이름을 찾으면 그에 맞는 URL이 된다. 즉 이 시점에선 아직 어떤 URL이 될지 정해지지 않았고 URLconf에서 정해진다.
- `pk=post.pk` : pk 변수는 post의 pk값을 넣어준다.
- 즉 다음처럼 URL이 된다. `domain/post/1` 형태다. post는 아래 URLconf 설정할 때 이렇게 정해줄거고, 1은 포스트의 번호의 예를 든 것이다.

## 2. URLconf

`http://127.0.0.1:8000/post/1/` 형태로 만들고자 한다. 도메인 뒤에 post가 붙고, 그 다음 포스트의 unique id인 primary key가 붙는 구조다. 정규 표현식으로 다음처럼 표현할 수 있다. `blog/urls.py`에 추가해준다.

```python
url(r'^post/(?P<pk>\d+)/$', views.post_detail, name='post_detail'),
```

- 정규표현식
    + post로 시작한다. 즉 post 앞에 뭐가 오면 안된다.
    + 그 다음 /가 붙고, 숫자가 여러개 올 수 있다.
    + /가 붙는 것으로 끝이다. 즉 마지막 / 뒤에 아무것도 오면 안된다.
    + 중간에 `?P<pk>`는 `( )`로 grouping 되었을 때 그룹명을 설정한 것이다. 이 그룹명을 변수처럼 활용할 수 있다.
- 뷰
    + 두 번째 매개변수: views.py 파일의에서 `post_detail` 함수로 보낸다는 의미다.
    + 세 번째 매개변수: 1번에서 URL을 'post_detail'로 보냈으므로 name 속성을 똑같이 맞춰준다.

## 3. View

위에서 포스트의 번호를 그루핑해서 pk 변수로 보냈다. 즉 이것을 받을 수 있다. `blog/urls.py` 파일에서 함수를 만들 때 매개변수에 하나를 더 추가해준다. 물론 매개변수이기 때문에 pk 말고 post_id 이름으로 바꿔줄 수도 있다. 하지만 헷갈리기 때문에 같은 것으로 해준다. 그루핑되어서 넘어온 변수를 모두 매개변수로 받지 않으면 오류가 난다. 물론 받아놓고 안 쓸 수는 있다. 받긴 다 받아야한다.

```py
from django.shortcuts import render, get_object_or_404

def post_detail(request, pk):
    post = get_object_or_404(Post, pk=pk)
    return render(request, 'blog/post_detail.html', {'post' : post})
```

- 위 코드처럼 변수 pk를 매개변수로 받아준다.
- `get_object_or_404` 함수를 import한다. pk에 해당하는 포스트가 없을 경우 에러페이지가 아닌 404페이지를 띄워준다. 이 페이지 커스터마이징 가능하다.

## 4. Template

역시 최종으로 사용자에게 보여질 템플릿 파일을 이름에 맞게 만들어준다. 전달받은 post 객체를 활용하면 된다.

```html
{% extends 'blog/base.html' %}

{% block content %}
    <div class="post">
        {% if post.published_date %}
            <div class="date">
                {{ post.published_date }}
            </div>
        {% endif %}
        <h1>{{ post.title }}</h1>
        <p>{{ post.text|linebreaks }}</p>
    </div>
{% endblock %}
```
