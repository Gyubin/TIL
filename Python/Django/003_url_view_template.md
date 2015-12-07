# #3 URL, View, Template 설정하기

참고 링크: [django girls tutorial](http://tutorial.djangogirls.org/ko/django_urls/index.html)

## 1. URL

`mysite/urls.py`는 가장 상위에 위치하는 URLconf 파일이다. foodgram이라고 django 프로젝트를 만들었을 때 여러가지 앱이 속할 수 있다. 여기처럼 blog라는 앱이 있을 수도 있고, 추가로 food라는 앱이 있을 수도 있다. 만약 `mysite/urls.py`에 모든 앱의 url 매칭 정보를 다 적어넣는다면 나중에 알아보기가 힘들 것이다. 그래서 url 파일을 앱 별로 만드는게 더 좋다.

### A. Including another URLconf

```python
from django.conf.urls import url, include
from django.contrib import admin

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'', include('blog.urls')),     # added
]
```

`url(r'', include('blog.urls')),` 코드를 추가해서 blog 앱의 URLconf를 가져온다. 만약 admin/으로 시작하는 URL이 없다면 blog 앱의 URLconf에서 매칭되는 정보를 찾을 것이다.

### B. blog 앱의 URLconf

```python
from django.conf.urls import url
from . import views     # 이 파일의 현재 디렉토리인 blog 디렉토리의 뷰 사용

urlpatterns = [
    url(r'^$', views.post_list, name='post_list'),
]
```

- `blog/urls.py` 파일을 생성하고 위 코드를 입력한다.
- 기본적으로 URL 패턴은 정규표현식을 사용한다. `r'^$'`는 raw string으로 되어있고 `^`으로 시작해서 `$`로 끝나는 URL과 매칭된다는 패턴이다. 즉 ^ 뒤에 아무것도 없고, $ 앞에 아무것도 없으므로 도메인 뒤에 아무것도 입력하지 않은 경우를 의미한다. 즉 만약 네이버라면 `www.naver.com`이 매칭되는 것이다. `www.naver.com/something`은 매칭 안된다.
- url 함수의 두 번째 매개변수는 뷰를 지칭한다. 특정 뷰를 지칭해서 그 뷰가 띄워지게 하는 것이다. 세 번째 매개변수는 뷰의 이름을 내 임의로 짓는 것이다. 같은 이름으로 하는게 편하다.
- 즉 정리하면 도메인만 입력했을 경우 post_list라는 뷰를 띄우겠다는 URL 매칭 정보를 입력한 것이다.

## 2. View

MVC 패턴에서 Controller에 해당한다. 컨트롤러 역할인데 왜 이름을 View로 했는지는 모르겠지만 어쨌든 그렇다. URLconf에서 request URL과 맞는 정보를 찾으면 위에서 우리가 설정한 view로 보내게된다. 위에서 도메인만 입력했을 때 post_list로 보내기로 했으므로 view엔 그에 맞는 post_list 함수가 있으면 된다. 

```python
from django.shortcuts import render

# Create your views here.
def post_list(request):
    return render(request, 'blog/post_list.html', {})
```

- `blog/views.py` 파일을 만들고 위 코드를 입력한다.
- `post_list(request)` : URL과 매칭되는 뷰가 post_list라면 이 함수가 실행된다. 여기서 여러가지 작업을 할 수 있다. 아직 작업이 없으므로 바로 return한다.
- render 함수를 사용해서 request와 뷰에 맞는 템플릿 파일을 지정해준다. 즉 최종적으로 사용자에게 보여지는 웹페이지의 html 파일이 `blog/post_list.html`이라는 것이다.

## 3. Templates

```
blog
└───templates
    └───blog
              post_list.html
```

`blog/templates/blog/post_list.html` 파일을 만든다. 경로가 조금 복잡하다. 위 뷰에서 지정한 것은 'blog/post_list.html' 뿐이었음을 살펴보면 템플릿 파일들의 기본 위치가 'blog/templates/'인 것임을 알 수 있다. 이 위치를 잘 기억해둔다.

```html
<html>
    <head>
        <title>Django Girls blog</title>
    </head>
    <body>
        <div>
            <h1><a href="">Django Girls Blog</a></h1>
        </div>

        <div>
            <p>published: 14.06.2014, 12:14</p>
            <h2><a href="">My first post</a></h2>
            <p>Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
        </div>

        <div>
            <p>published: 14.06.2014, 12:14</p>
            <h2><a href="">My second post</a></h2>
            <p>Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut f.</p>
        </div>
    </body>
</html>
```

마지막으로 위 템플릿 예제 코드를 입력한다. 그리고 다시 `python manage.py collectstatic` 명령어를 bash에서 입력해서 정적 파일을 정리한다. runserver해서 브라우저에서 확인해본다.
