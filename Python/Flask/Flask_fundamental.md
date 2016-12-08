# Flask 기초

파이썬에서 백엔드를 담당하는 대표적인 microframework. [튜토리얼](http://flask.pocoo.org/docs/0.11/tutorial/introduction/)을 따라하면서 정리한다.

## 1. 설치 및 띄워보기

- flask 설치: `pip install Flask`
- `hello.py` 파일을 만들고 `python hello.py` 실행

    ```py
    # hello.py
    from flask import Flask
    app = Flask(__name__)

    @app.route("/")
    def hello():
        return "Hello World!"
    ```

## 2. 디렉토리 구조

- `/flaskr` : 
- `/flaskr/static` : CSS, JavaScript 파일이 위치
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
    + Flask는 application context, request context 두 가지를 제공한다. 전자가 `g` 모듈, 후자가 `request` 모듈과 관계있다.
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
