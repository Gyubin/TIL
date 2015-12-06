# #1 Django 기초

참고 링크: [hannal blog](http://blog.hannal.com/category/start-with-django-webframework/), [Django Girls Tutorial](http://tutorial.djangogirls.org/ko/django/index.html)

장고 초반 세팅과 기본 명령어들 정리해본다. 우선 가상환경을 설정해야하는데 이 문서 바로 위 디렉토리에 `virtual_environment.md` 파일을 보고 따라하면 된다.

## 1. 프로젝트 생성 직후 구조

```
djangogirls
├───manage.py
└───mysite
        settings.py
        urls.py
        wsgi.py
        __init__.py
```

- `manage.py` : 이 파일을 통해 별도 설치 없이 서버를 실행하는 등의 작업을 수행할 수 있다.
- `settings.py` : 설정 파일
- `urls.py` : url과 맞는 view를 매칭시키는 작업을 `urlresolver`가 한다. 이 매칭 정보가 이 파일에 적혀있다.

## 2. 프로젝트-모델까지 생성 루틴

### A. 프로젝트 생성 및 초기 설정

- 프로젝트 생성: `django-admin startproject mysite .` ('.'은 현재 디렉토리 의미)
- 타임존 변경: `/mysite/settings.py` 파일을 열고 `Asia/Seoul` 로 시간대 변경
- 정적파일 경로 추가: `STATIC_URL` 항목 바로 아래줄에 다음 코드 추가. `STATIC_ROOT = os.path.join(BASE_DIR, 'static')`

### B. DB 설정

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
```

- `settings.py`에 이미 위 코드처럼 sqlite3가 설정되어있다. 따로 설치할 필요 없다.
- 데이터베이스 생성: `python manage.py migrate`

### C. 프로젝트 내 App 만들기

- 앱 생성 명령어: `python manage.py startapp blog`

```
# 앱 생성 후 구조
djangogirls
├── mysite
|         __init__.py
|         settings.py
|         urls.py
|         wsgi.py
├── manage.py
└── blog
    ├── migrations
    |         __init__.py
    ├── __init__.py
    ├── admin.py
    ├── models.py
    ├── tests.py
    └── views.py
```

- 앱 등록하기: `mysite/settings.py` 파일의 INSTALLED_APPS에 생성한 앱 이름을 추가한다.

```
INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'blog',
)
```

### D. 모델 만들기

- 모델 생성: `blog/models.py` 파일에 원하는 데이터 형태를 추가한다.
- 아래 코드는 블로그 앱일 때 예시 데이터 형태

```python
from django.db import models
from django.utils import timezone

# Create your models here.

# Model 상속받아 Post 클래스 만든다. 데이터베이스에 저장 가능해짐.
class Post(models.Model):
    author = models.ForeignKey('auth.User')     # 다른 모델에 대한 링크 의미
    title = models.CharField(max_length=200)    # 짧은 길이 문자열 저장
    text = models.TextField()                   # 글자 수 제한 없는 긴 문자열
    created_date = models.DateTimeField(        # 날짜, 시간 의미
            default=timezone.now)
    published_date = models.DateTimeField(      # 날짜, 시간 의미
            blank=True, null=True)

    def publish(self):                          # 발행 메소드
        self.published_date = timezone.now()    # 메소드 실행 = 발행 시간
        self.save()                             # 저장

    def __str__(self):                          # 객체를 출력하면 title이 출력
        return self.title
```

- `python manage.py makemigrations blog` : `blog/models.py` 파일을 수정했으니 blog를 makemigrations 해준다. 이 명령어는 방금 Post 모델을 만들면서 변한 모델 상태를 'git에서 stage 상태로 올리는 것'처럼 변경하는 것이다. `0001_initial.py: - Create model Post` 이 출력될 것이다. 이렇게 변하라는 명령을 저장하는 것이다. 아직 데이터베이스가 변하진 않았다. 예로 여기서 만약 한 번 더 Post 모델의 필드를 수정한 다음에 같은 명령어를 입력하면 `0002_some_text.py` 라는 파일이 생겨날 것이다.
- `python manage.py migrate blog` : 데이터 베이스 변경을 실제로 행하는 코드다. 만약 2개의 변경 파일이 있다면 둘 모두가 데이터베이스에 적용된다.

## 3. Django 관리자

### A. 슈퍼유저 만들기

- `python manage.py createsuperuser` : 슈퍼 유저를 만든다. 아이디와 이메일, 비밀번호 입력하면 된다.
- `http://127.0.0.1:8000/admin/` 에서 아이디와 비밀번호를 입력하고 들어가면 된다.

### B. 관리자 페이지에 모델 등록

- `blog/admin.py` 파일에 다음 코드처럼 Post 모델을 등록한다. 등록하면 관리자 페이지에서 Post 모델을 GUI로 조작할 수 있다.

```python
from django.contrib import admin
from .models import Post

admin.site.register(Post)
```

## 부록: 명령어'만' 순서대로 모음

- 프로젝트 만들기: `django-admin startproject mysite .` (뒤에 '.'은 현재 디렉토리를 의미한다.)
- 데이터베이스 생성: `python manage.py migrate`
- 앱 생성 명령어: `python manage.py startapp blog`
- 모델 변경 파일: `python manage.py makemigrations blog`
- 데이터베이스에 모델 변경 적용: `python manage.py migrate blog`
- 서버 실행하기: `python manage.py runserver` -> `http://127.0.0.1:8000/`
