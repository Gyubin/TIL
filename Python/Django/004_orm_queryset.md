# #4 Django ORM, QuerySet

ORM은 Object-relational mapping의 줄임말이다. 프레임워크, 여기서는 Django가 ORM을 지원한다. 이 개념이 나오기 전에 데이터를 사용하려면 DB의 쿼리문(ex: select ~ where ...)을 직접 써줘야했다. DB와 연결을 하고, DB에 쿼리문을 문자열 형태로 날려서 결과값을 받고, 다시 작업을 해주는 형태다. 하지만 ORM에서는 데이터와 Object(객체)가 매칭되어서 마치 해당 언어(Python)의 변수를 다루듯 데이터를 다룰 수 있다.

## 1. shell에서 데이터 다뤄보기

### A. 객체 불러오기

```bash
python manage.py shell
```

위 명렁어를 입력하고 프로젝트의 데이터를 건드릴 수 있는 shell로 들어간다. 대충이라도 해보기 위해서 글이 한 두 개 있어야하므로 admin 페이지에서 2~3개 정도 글을 입력해둔다.

```python
from blog.models import Post
Post.objects.all()
# [<Post: first post>, <Post: second post>, <Post: third post>]
```

models.py 모듈에서 Post 클래스를 import 한다. 그리고 Post 클래스의 모든 객체를 출력해보는 코드다. 그러면 위와 같이 객체가 리스트 형태로 묶여서 리턴된다.

### B. 객체 생성하기

```python
from django.contrib.auth.models import User
User.objects.all()  # [<User: ola>]
me = User.objects.get(username='ola')
Post.objects.create(author=me, title='Sample title', text='Test')
```

User 클래스를 import해서 author 객체를 만들어놓고, 이를 이용해서 Post 객체를 만드는 코드다. 위처럼 하고 `Post.objects.all()`해서 새 객체가 추가되었는지 확인한다.

### C. 필터링하기

```python
Post.objects.filter(author=me)
Post.objects.filter(title__contains='first')
Post.objects.filter(published_date__lte=timezone.now())
```

조건으로 객체를 찾는 과정이다. filter를 사용하고 매개변수로 조건을 정해주면 된다. 두 번째 코드에서 `__` 더블 언더바(dunder)가 보일 것이다. 장고 ORM은 dunder를 이용해서 필드 이름("title")과 필터("contains")를 구분한다. 필터 메소드는 다음과 같다.

| filter name |                 context                 |
|-------------|-----------------------------------------|
| gt          | greater than                            |
| lt          | less than                               |
| gte         | greater than or equal                   |
| lte         | less than equal                         |
| length_gt   | value's length is greater than          |
| length_lt   | value's length is less than             |
| length_gte  | value's length is greater than or equal |
| length_lte  | value's length is less than equal       |

### D. 정렬하기

```python
Post.objects.order_by('created_date')   # 오름차순
Post.objects.order_by('-created_date')  # 내림차순
```

## 2. 실제 view에서 활용해보기

```python
from django.shortcuts import render
from .models import Post            # added
from django.utils import timezone   # added

def post_list(request):
    posts = Post.objects.filter(published_date__lte=timezone.now()).order_by('published_date')  # added
    return render(request, 'blog/post_list.html', {'post':post})

```

- `blog/views.py` 에 위 코드를 추가한다. models.py가 views.py와 같은 디렉토리에 있기 때문에 앞에 '.'을 붙인 것이다.
- `filer`와 `order_by` 메소드가 연결해서 사용되었다. 이런걸 chain이라 한다. 두 메소드 모두 'django.db.models.query.QuerySet' 이라는 클래스 객체이기 때문에 이러한 연결 사용이 가능한 것이다.
- return 문에서 마지막에 `{'post':post}`는 템플릿에 객체를 전달하는 것이다. 'post'라는 이름으로 post 객체를 전달하는 것이다. {}를 보아 dict 형태로 전달하는 것 같다. 이름은 역시 같게 해주면 편하다. template 파일에서 이 post 객체를 쓸 수 있게 된다.

## 3. 뷰에서 전달한 객체를 템플릿에서 활용하기

전달된 객체를 활용하는 방식은 2가지다. `{{ }}` 혹은 `{% %}`를 활용하는 것. 차이점은 전자는 내용이 html에 출력이 되고, 후자는 출력이 안된다는 점이다. 예를 들어 아래와 같은 코드에선 for 반복 구문은 html에 표시되지 않고 오직 post만 브라우저에 나타난다. `post_list.html` 파일에 입력하고 결과를 확인한다.

```html
{% for post in posts %}
    <p>{{ post }}</p>
{% endfor %}
```

최종 예제 코드는 다음과 같다.

```html
{% for post in posts %}
    <div>
        <p>published: {{ post.published_date }}</p>
        <h1><a href="">{{ post.title }}</a></h1>
        <p>{{ post.text|linebreaks }}</p>
    </div>
{% endfor %}
```

- post 객체에서 `.`을 이용해서 내부 속성들에 접근할 수 있다.
- 템플릿 태그 사이에서 `|linebreaks` 는 줄바꿈을 의미한다.
