# #9 인스타그램 만들기

[hannal blog](http://blog.hannal.com/2014/9/start_with_django_webframework_03/)를 보면서 이전에 장고걸스 튜토리얼(001-008)에 없던 내용과, 큰 흐름을 다시 정리해본다. 다음 내용은 흐름 파악을 위해 정말 간결하게 축약한거라서 블로그를 직접 보는게 가장 좋다.

## 1. 프로젝트 명령어만 따오기(흐름 파악 용도)

### A. 초기 세팅

1. `mkvirtualenv pystagram`
2. `workon pystagram`
3. `cd $PROJECT_HOME`
4. `django-admin startproject pystagram`
5. `python manage.py migrate`
6. `python manage.py createsuperuser`

### B. photo app

1. `python manage.py startapp photo`
2. photo app에서 `models.py` 수정. photo class 만들기
    - ImageField를 사용하기 위해서 `pip install Pillow` 해줘야 한다.
3. `settings.py`의 installed_apps에 photo 추가(migration 하기 전에 필수적)
4. `python manage.py makemigrations`
5. 

```py
# models.py
from django.db import models

class photo(models.Model):
    image_file = models.ImageField()
    filtered_image_file = models.ImageField()
    description = models.TextField(max_length=500)
    created_at = models.DateTimeField(auto_now_add=True)
```

## 2. 추가 개념 정리

- `A-4`번 명령어(startproject) 이후 만들어진 디렉토리를 'root' directory라고 흔히 칭한다. 이 자체가 패키지는 아니다.
- `python manage.py runserver 127.0.0.1:8080` 처럼 서버 띄울 때 뒤에 포트를 지정해줄 수 있다. 디폴트는 8000이고 이 예시는 8080으로 지정했다.
- `A-5`번 명령어 `migrate`를 하는 것은 Django가 기본 지정하는 데이터베이스를 설정하겠다라는 의미다. 이 작업이 끝나면 'root' 디렉토리에 `db.sqlite3` 파일이 생긴다. django에서 쓰는 기본 데이터베이스가 sqlite3인데 성능이 서비스용으로는 부족하지만 개발용으로는 적당하다.
- `app`이란: 인스타그램엔 회원, 사진과 관련된 여러 기능들이 있는데 이런 기능들을 `app`이라고 한다. 목적을 가진 행위를 수행하는 것이 application이고 이 기능들의 조합이 프로젝트인 것이다. 이전 foodgram(이름만 foodgram이지 실상은 블로그였지만)에서처럼 blog 앱이 있었고 이 기능들이 패키지로 구분된다. 루트 디렉토리는 패키지가 아니다. 그리고 그 패키지 내에 views.py나 models.py처럼 모듈들이 존재하는 것이다.
- `models.py` 모듈: 데이터의 내용(필드)과 이 데이터를 다루는 메소드를 정의하는 곳
- `tests.py` 모듈: unit test 내용을 담는다.
- `B-2` : 결국 models.py도 파이썬 코드로 이루어진 파일이다. 클래스로 이루어졌으므로 변수들은 클래스 변수들일 것이다. 그런데 여기서 장고에서 정의한 type을 지정해주면 'model field'가 된다. 장고는 이런 필드들은 구분해서 데이터베이스와 연결해준다. 예를 들어 'FileField' 속성은 파일을 다루는 필드다.
- 보통 데이터베이스에서 `VARCHAR`는 통상 200자 정도를 보장한다. 이것과 매칭되는것이 장고의 `CharField`다. 필드 옵션으로 맥스를 지정하는 것이 필수다.
- `DateTimeFiled()`에는 두 가지 옵션이 있다.
    + `auto_now_add` : 객체가 생성될 때 자동 변경
    + `auto_now` : 객체가 저장될 때 자동 변경
    + 위 경우는 `created_at`이므로 첫 번째 필드옵션 적용. 두 옵션을 함께 사용하면 안된다. 하나만 사용해야 한다.
- 

















