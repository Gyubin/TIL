# Flask 기초

파이썬에서 백엔드를 담당하는 대표적인 microframework. [튜토리얼](http://flask.pocoo.org/docs/0.11/tutorial/introduction/)을 따라하면서 정리한다.

## 0. 웹 서버 개념

- 초기 웹서버는 단순히 정적인 파일을 클라이언트에게 전달하는 역할이었다.
- 동적으로 서버에서 어떤 연산을 해서 결과를 가공해서 주고싶었고, 그래서 나온게 **CGI**(Comman Gateway Interface)다.

![cgi](https://upload.wikimedia.org/wikipedia/commons/7/7c/CGI_common_gateway_interface.png)

- CGI는 단순히 클라이언트에서 어떤 입력(request)이 들어왔을 때 어떤 출력을 낼건지를 정의한 프로그램이다. 위 이미지에서처럼 예전엔 요청이 들어오면 CGI가 받아서, application server를 실행하는 형태로 이루어졌다.
- 이젠 서버 컴퓨터 성능이 좋아져서 web server가 CGI의 기능을 흡수했다. 그것이 **WAS**(Web Application Server)다. JSP나 ASP가 WAS의 예다.
- **WSGI**(Web Server Gateway Interface)는 파이썬에서만 쓰이는 WAS 통신규약이다. CGI의 superset으로 웹서버에서 받은 request에 대해 프로세스를 포크할건지 말건지를 정할 수 있다. 기존 CGI는 그냥 모든걸 포크한다.
- WSGI는 서버와 미들웨어 사이, 미들웨어와 앱 사이에 껴있다.
- 위 내용들을 알아서 처리해주는게 대표적으로 Flask와 Django다.

## 1. 기본

### 1.1 설치 및 띄워보기

- flask 설치: `pip install Flask`
- `hello.py` 파일을 만들고 `python hello.py` 실행

    ```py
    # hello.py
    from flask import Flask
    app = Flask(__name__)

    @app.route("/")
    def hello():
        return "Hello World!"

    if __name__ == '__main__':
        app.run('0.0.0.0', 5000, debug=True)
    ```

- `app`은 WSGI application을 의미
- `'0.0.0.0'` : 어떤 IP로 내 서버에 접속해도 오케이
- `debug=True` : 개발 모드로 서버를 실행하라는 의미로 파일이 변경되면 알아서 재시작해준다. 그리고 에러가 있을 때 디버깅이 쉽도록 브라우저에서 띄워준다. production에선 에러 정보가 잘못 사용될 여지가 있으므로 True 값을 주면 안됨

### 1.2 url로 변수 받기

```py
@app.route('/user/<username>')
def show_user_name(username):
    return f'User { user }'

@app.route('/post/<int:post_id>')
def show_post(post_id):
    return f'Post { post_id }'
```

- `<type:var_name>` : 이렇게 라우팅을 하면 URL의 부분을 변수로 받아서 사용할 수 있다.
- type : 자동으로 type casting해서 변수로 받아주고, 다른 타입이면 에러 일으킨다.
    + `string` : 기본값
    + `int` : 정수
    + `float` : 실수
    + `path` : 기본 string과 같지만 slash도 받는다
    + `any` : matches one of the items provided
    + `uuid` : accepts UUID strings

### 1.3 url_for

```py
from flask import Flask, url_for
app = Flask(__name__)

@app.route('/')
def index(): pass

@app.route('/login')
def login(): pass

@app.route('/user/<username>')
def profile(username): pass

with app.test_request_context():
    print(url_for('index')) # /
    print(url_for('login')) # /login
    print(url_for('login', non_exist_var='hihi')) # /login?non_exist_var=hihi
    print(url_for('profile', username="Gyubin Son")) # /user/Gyubin%20Son
```

- `url_for` : 지정한 매개변수들이 나타내는 URL을 문자열로 만들어서 리턴
- 첫 번째 매개변수인 문자열은 도메인 바로 다음에 오는, 파일에서는 함수명을 의미하고
- 두 번째로 오는 매개변수는 변수명과 값이 매칭되어서 URL이 된다
    + 변수가 함수 정의할 때 존재한다면 자연스럽게 URL이 만들어지고
    + 변수명이 존재하지 않는거라면 해당 pair가 query string으로 만들어진다.

## 2. 디렉토리 구조

- `/flaskr` : 
- `/flaskr/static` : CSS, JavaScript, 이미지, 음성 파일 등이 위치
    + `url_for('static', filename='style.css')` 형태로 불러쓸 수 있다.
- `/flaskrtemplates` : Jinja2 템플릿이 위치.

## 3. Application module

`flaskr.py` 파일을 생성

### 3.1 config 파일 관리하기

```py
import os
import sqlite3
from flask import Flask, request, session, g, redirect,\
                  url_for, abort, render_template, flash

app = Flask(__name__)
app.config.from_object(__name__)

app.config.update(dict(
    DATABASE = os.path.join(app.root_path, 'flaskr.db'),
    SECRET_KEY='development key',
    USERNAME='admin',
    PASSWORD='default'
))
app.config.from_envvar('FLASKR_SETTINGS', silent=True)
```

- 설정 파일을 관리한다. 순서대로 앱을 구해서, 기본 설정 파일을 가지고, 업데이트하고, 대체하는 코드다.
- 일반적으로 별도의 configuration file들(여러개 가능하다)을 가지고 있는 것이 좋은데 마지막 코드를 보자. `FLASKR_SETTINGS`는 설정 파일을 가리키고, silent 속성은 기존 config 객체에 매칭되는 키가 없더라도 오류메시지를 띄우지 않는다.
- 키는 항상 영문 대문자여야 한다.

### 3.2 DB connection

```py
def connect_db():
    rv = sqlite3.connect(app.config['DATABASE'])
    rv.row_factory = sqlite3.Row
    return rv
    
def get_db():
    if not hasattr(g, 'sqlite_db'):
        g.sqlite_db = connect_db()
    return g.sqlite_db

@app.teardown_appcontext
def close_db(error):
    if hasattr(g, 'sqlite_db'):
        g.sqlite_db.close()
```

- config 파일에서 설정된 DB와 연결한다.
- `rv.row_factory = sqlite3.Row` : row를 딕셔너리로 다룰 수 있게 한다.
- DB connection 싱글톤
    + DB connection은 긴 시간 지속되어야하고 오직 하나여야한다.
    + Flask는 application context, request context 두 가지를 제공한다. 전자가 `g` 모듈, 후자가 `request` 모듈과 관계있다. request context는 `request`란 전역 객체로 언제 어디서나 접근할 수 있으며 항상 현재 수행되고 있는 스레드의 proxy로 동작. 즉 그 순간의 request로 매번 대입되기 때문에 편하게 사용하면 됨
    + 연결을 끊을 때는 `teardown_appcontext()` 데코레이터를 사용한다. 마킹된 함수는 application context가 tear down 될 때 항상 호출된다. 즉 app context는 request가 오기 전에 만들어지고, request가 끝날 때 사라진단 뜻이다.

## 4. Database Schema

### 4.1 Code

```py
def init_db():
    db = get_db()
    with app.open_resource('schema.sql', mode='r') as f:
        db.cursor().executescript(f.read())
    db.commit()

@app.cli.command('initdb')
def initdb_command():
    init_db()
    print 'Initialized the database.'
```

- cli 데코레이터: 커맨드라인 스크립트에 해당 함수를 등록한다.
- 커맨드라인 스크립트가 실행되면 Flask는 자동으로 app context를 만든다.
- `open_resource()` : application object에 속해있고, application이 제공하는 리소스들을 활용할 수 있다. 리소스 폴더, 여기선 flaskr 폴더의 파일에 접근할 수 있다.
- 마지막엔 꼭 커밋을 명시적으로 해줘야한다.

### 4.2 Schema

```sql
drop table if exists entries;
create table entries (
  id integer primary key autoincrement,
  title text not null,
  'text' text not null
);
```

- SQLite를 사용한다. 위 코드처럼 `schema.sql` 파일을 만든다.
- `sqlite3 /tmp/flaskr.db < schema.sql` : schema를 만든다.

## 5. 실행

```sh
export FLASK_APP=flaskr.py
export FLASK_DEBUG=1
flask initdb
flask run
```

## 6. View function

### 6.1 라우팅

```py
@app.route('/')
def show_entries():
    db = get_db()
    cur = db.execute('select title, text from entries order by id desc')
    entries = cur.fetchall()
    return render_template('show_entries.html', entries=entries)

@app.route('/add', methods=['POST'])
def add_entry():
    if not session.get('logged_in'):
        abort(401)
    db = get_db()
    db.execute('insert into entries (title, text) values (?, ?)',
                 [request.form['title'], request.form['text']])
    db.commit()
    flash('New entry was successfully posted')
    return redirect(url_for('show_entries'))
```

- `@app.route(url, methods)` : 이 데코레이터는 매칭되는 url과 POST인지 GET인지를 나타내는 methods를 포함.
- 크게 두 가지 패턴인 것 같다.
    + db를 가져오고 -> 쿼리를 날려서 cursor를 얻고 -> 데이터를 변수에 넣고 -> 템플릿에 전달하는 것
    + db를 가져오고 -> 쿼리를 실행하고 -> commit해서 최종 저장하는 단계
- db를 사용할 땐 SQL injection에 대비해서 곡 `?`를 이용해서 쿼리를 날리도록 한다.
- `flash("Hello world")` : 잠깐 화면에 메시지를 띄움

### 6.2 로그인

```py
@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        if request.form['username'] != app.config['USERNAME']:
            error = 'Invalid username'
        elif request.form['password'] != app.config['PASSWORD']:
            error = 'Invalid password'
        else:
            session['logged_in'] = True
            flash('You were logged in')
            return redirect(url_for('show_entries'))
    return render_template('login.html', error=error)

@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    flash('You were logged out')
    return redirect(url_for('show_entries'))
```

- 역시 라우팅과 관련해서 데코레이터가 붙는다.
- 로그인: `app.config[key]`에 회원 정보가 저장되어있다. 아이디, 비밀번호를 차례로 확인하고, 세션에 로그인되어있음을 저장한 다음 리다이렉트한다.
- 로그아웃: dict에서 pop 메소드를 써서 쉽게 해결한다.
    + 첫 번째 매개변수로 들어간 key가 딕트에 존재하면 아예 그 키-밸류 쌍을 삭제한다.
    + 만약 딕트에 존재하지 않는다면 두 번째 매개변수대로 행동하는데 None을 넣어서 아무것도 하지 않게 한다. 두 번째 매개변수로 아무것도 안넣어주면 키가 없을 때 에러가 난다.

## 7. Template

```html
<!-- layout.html -->
<!doctype html>
<title>Flaskr</title>
<link rel=stylesheet type=text/css href="{{ url_for('static', filename='style.css') }}">
<div class=page>
  <h1>Flaskr</h1>
  <div class=metanav>
  {% if not session.logged_in %}
    <a href="{{ url_for('login') }}">log in</a>
  {% else %}
    <a href="{{ url_for('logout') }}">log out</a>
  {% endif %}
  </div>
  {% for message in get_flashed_messages() %}
    <div class=flash>{{ message }}</div>
  {% endfor %}
  {% block body %}{% endblock %}
</div>
```

```html
<!-- add_entries.html -->
{% extends "layout.html" %}
{% block body %}
  {% if session.logged_in %}
    <form action="{{ url_for('add_entry') }}" method=post class=add-entry>
      <dl>
        <dt>Title:
        <dd><input type=text size=30 name=title>
        <dt>Text:
        <dd><textarea name=text rows=5 cols=40></textarea>
        <dd><input type=submit value=Share>
      </dl>
    </form>
  {% endif %}
  <ul class=entries>
  {% for entry in entries %}
    <li><h2>{{ entry.title }}</h2>{{ entry.text|safe }}
  {% else %}
    <li><em>Unbelievable.  No entries here so far</em>
  {% endfor %}
  </ul>
{% endblock %}
```

```html
<!-- login.html -->
{% extends "layout.html" %}
{% block body %}
  <h2>Login</h2>
  {% if error %}<p class=error><strong>Error:</strong> {{ error }}{% endif %}
  <form action="{{ url_for('login') }}" method=post>
    <dl>
      <dt>Username:
      <dd><input type=text name=username>
      <dt>Password:
      <dd><input type=password name=password>
      <dd><input type=submit value=Login>
    </dl>
  </form>
{% endblock %}
```

- 위 구조는 layout이 재사용되는 구조다. view function이 layout을 렌더링하는 것이 아니라 `extends`가 들어있는 코드를 렌더링한다.
- layout 파일에서 `{% block body %} {% endblock %}` 이부분이 대치되는데 동일한 이름의 블락이 대치된다.

## 8. File upload

```py
from flask import Flask, render_template, request
from werkzeug.utils import secure_filename
app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def upload():
    if request.method == 'GET':
        return render_template('upload.html')
    else:
        f = request.files['file']
        f.save(secure_filename(f.filename))
        return 'file uploaded successfully'

if __name__ == '__main__':
    app.run(debug=True)
```

- `upload` : GET, POST 두 방식으로 받고 각각 다르게 처리. 업로드 템플릿을 보여줄지, 파일 업로드를 할지
- 아래 html form에서 POST method로 보내면 POST로 받는다.
- `request.files['file']` : 여기서 `file`은 아래 html에서 input의 name과 매칭된다.
- `secure_filename` 함수는 유저가 업로드하는 파일을 믿지 않기 때문에 사용하는 함수이고, 자세한 내용은 [공식문서](http://flask.pocoo.org/docs/0.12/patterns/fileuploads/)를 참조
- 마지막 return 문은 단순히 저 문자열을 브라우저에 띄워줌

```html
<html>
  <body>
    <form action="http://localhost:5000/" method="POST" enctype="multipart/form-data">
      <input type="file" name="file" />
      <input type="submit" />
    </form>
  </body>
</html>
```
