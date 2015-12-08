# #6 Template Extending

동일한 html 구조를 재사용할 수 있다. 예를 들어 웹페이지 상단에 메뉴바같은 경우는 어떤 페이지마다 동일할 것이다. 이 코드를 매 번 복사 붙여넣기하기엔 귀찮기도 하고, 변경 사항이 생겼을 때 모든 파일에 가서 하나하나 고쳐야 한다. 이 문제를 해결하는게 템플릿 확장이다.

## 1. 작업

짧게 정의하면 '`재사용되는 부분(틀)`과 `페이지별로 달라지는 부분`을 구분한 base html 파일을 만들고, 달라지는 부분만 따로 작은 html 파일로 만들어 `링크`한다.'가 되겠다.

### A. base 파일

- 재사용되는 부분
    + `blog/templates/blog/base.html` 파일을 만든다. 반복되어 재사용되는 부분을 작성한다. 여기까지는 지금까지 해왔던 과정과 다를바가 없다.
- 반복되는 부분
    + 다음 코드로 대체한다.`{% block content %} {% endblock %}`

### B. 개별 페이지 파일

- 코드 맨 위에 `{% extends 'blog/base.html' %}`를 추가한다.
- `{% block content %} {% endblock content %}` : 코드 블락 사이에 원하는 페이지별 코드를 작성하면 된다. 

## 2. 예제 코드

- `base.html`

```html
{% load staticfiles %}
<html>
    <head>
        <title>Django Girls blog</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
        <link rel="stylesheet" href="{% static 'css/blog.css' %}">
        <link href="http://fonts.googleapis.com/css?family=Lobster&subset=latin,latin-ext" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div class="page-header">
            <h1><a href="/">Django Girls Blog</a></h1>
        </div>
        <div class="content container">
            <div class="row">
                <div class="col-md-8">
                {% block content %}
                {% endblock %}
                </div>
            </div>
        </div>
    </body>
</html>
```

- `post_list.html`

```html
{% extends 'blog/base.html' %}

{% block content %}
    {% for post in posts %}
        <div class="post">
            <div class="date">
                {{ post.published_date }}
            </div>
            <h1><a href="">{{ post.title }}</a></h1>
            <p>{{ post.text|linebreaks }}</p>
        </div>
    {% endfor %}
{% endblock content %}
```
