# #2 git으로 배포하기

참고링크: [Django Girls Tutorial](http://tutorial.djangogirls.org/ko/django/index.html)

## 1. git 설정

### A. init

앞서 만든 프로젝트 디렉토리를 git으로 버전관리하도록 한다. 다음 코드처럼 프로젝트의 루트 디렉토리에서 `init`한다. 이름과 이메일을 설정.

```bash
$ git init
Initialized empty Git repository in /Users/gyubin/Documents/dev/test_project/food/.git/
$ git config --global user.name "Your Name"
$ git config --global user.email you@example.com
```

### B. .gitignore

버전관리할 때 무시할 파일들을 설정한다. 필요없는 시스템 파일이나 가상환경파일, db 관련 파일들이다. `.gitignore` 파일을 만들고 다음을 입력해둔다. 

```
*.pyc
__pycache__
myvenv
db.sqlite3
.DS_Store
```
> myvenv는 가상환경 폴더 명이다.

### C. commit

마지막으로 `git add .` 으로 모든 파일을 stage 시키고, `git commit -m "first commit"` first commit이란 메시지로 커밋한다.

### D. remote with GitHub

우선 자신의 깃헙에 새로운 저장소를 판다. 저장소 이름은 로컬에서 만든 디렉토리명으로 하는게 편하다. 그리고 저장소를 생성할 때 `.gitignore`와 `README.md` 파일은 체크하지 않는다. 처음 리모트를 설정할 때 로컬과 merge하는 것에 아직 익숙하지 못하다. conflict 나지 않는 방향으로 우선 하겠다.

그리고 아래처럼 리모트를 설정하고, push한다. 아래의 경우는 내가 깃헙 이중보안을 해놔서 `ssh` 형태로 pull, push를 해놨기 때문이고 만약 이 설정을 하지 않았다면 `https` 형태의 주소를 복사 붙여넣기한다.

```sh
$ git remote add origin git@github.com:Gyubin/foodgram.git
$ git push -u origin master
```

## 2. PythonAnywhere 사용해보기

### A. clone

[www.pythonanywhere.com](www.pythonanywhere.com)에 가입한다. console을 열어서 GitHub의 repository를 clone한다.

```
git clone https://github.com/Gyubin/foodgram.git
```

### B. virtualenv 설정

다음 명령어로 python 버전을 지정해서 `myvenv`라는 이름의 가상환경을 생성한다. 그리고 가상환경을 activate 하고 django를 설치한다.

```
virtualenv --python=python3.4 myvenv
source ./myvenv/bin/activate
pip install django whitenoise
```

## C. 정적 파일 모으기 - whitenoise

정적파일은 html, css같은 정기적인 수정이 없는, 코드 상에서 변함이 없는 파일을 말한다. 예를 들어 html, css로 이루어진 웹페이지의 틀은 항상 고정이며, 거기에서 로딩되는 데이터만 바뀌면서 우리가 보는 웹페이지가 변하는 방식이다. 우선 다음 명령어로 정적 파일들을 특정 디렉토리로 모두 모은다.

```
python manage.py collectstatic
```

## D. DB 생성 및 superuser 설정

전 단계에서 했던 것처럼 `python manage.py migrate`, `python manage.py createsuperuser` 한다.

## E. web app 설정

- 홈페이지의 Web 탭으로 가서 `Add a new web app` 을 누른다. 적당한 도메인을 선택하고 Django가 아니라 수동옵션을 선택한 후, 3.4버전을 선택하고 마무리한다.
- 아래 가상환경 입력칸에는 `/home/<your-username>/my-first-blog/myvenv/` 형태로 입력해준다.
- `wsgi.py` 파일을 수정해야한다. 가상환경 수정칸 바로 위에 있다. 모든 내용을 삭제하고 다음을 입력한다.

```python
import os
import sys

path = '/home/gyubin/foodgram'  # 수정 요망
if path not in sys.path:
    sys.path.append(path)

os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'

from django.core.wsgi import get_wsgi_application
from whitenoise.django import DjangoWhiteNoise
application = DjangoWhiteNoise(get_wsgi_application())
```
