# #5 CSS Linking

## 1. Bootstrap 사용하기

트위터가 만든 HTML, CSS [라이브러리](http://getbootstrap.com/getting-started/)다. 사람들이 워낙 많이 써서 웹페이지들이 다 비슷비슷해졌다는 지적도 있지만 잘 쓰면 정말 개발이 편리해진다. 그렇다고 너무 이것만 잘하기보다 직접 라이브러리를 만들어봐도 좋고, 요소를 직접 제어할 수 있는 기본기도 갖춰야 한다. 아래 코드를 `post_list.html` 파일의 head 태그 사이에 넣는다.

```html
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
```

## 2. static 폴더, html, css 링크하기

- 정적 파일을 관리하기 위해 파일들을 모아두는 폴더를 만든다. 루트 디렉토리에도 static 폴더가 있지만 앱 별로 관리하기 위해 `blog/static` 디렉토리를 따로 만든다. 이러면 장고는 알아서 static 폴더의 파일들을 찾을 것이다. 다음 구조처럼 디렉토리를 만들고 파일을 추가한다.

```
foodgram
└─── blog
     └─── static
          └─── css
               └─── blog.css
```
> static 디렉토리 내에 img, js, fonts 디렉토리가 추가로 들어가서 해당 파일들을 관리하게 된다.

- 웹 페이지를 꾸미고싶으면 위 경로에 css 파일을 만들어서 적용하면 된다. 그리고 이 css 파일이 적용될 html 파일엔 2가지 변화만 주면 된다. 
    + html 파일 맨 위에 `{% load staticfiles %}` 코드 추가하기
    + head 태그 사이에 원하는 css 파일 링크하기 `<link rel="stylesheet" href="{% static 'css/blog.css' %}">`
    + etc: font도 추가할 수 있는데 맨 아래에다가 이런 형태로 해주면 된다. `<link href="http://fonts.googleapis.com/css?family=Lobster&subset=latin,latin-ext" rel="stylesheet" type="text/css">`

## 3. 예제 코드

- `blog.css`

```css
.page-header {
    background-color: #ff9400;
    margin-top: 0;
    padding: 20px 20px 20px 40px;
}

.page-header h1, .page-header h1 a, .page-header h1 a:visited, .page-header h1 a:active {
    color: #ffffff;
    font-size: 36pt;
    text-decoration: none;
}

.content {
    margin-left: 40px;
}

h1, h2, h3, h4 {
    font-family: 'Lobster', cursive;
}

.date {
    float: right;
    color: #828282;
}

.save {
    float: right;
}

.post-form textarea, .post-form input {
    width: 100%;
}

.top-menu, .top-menu:hover, .top-menu:visited {
    color: #ffffff;
    float: right;
    font-size: 26pt;
    margin-right: 20px;
}

.post {
    margin-bottom: 70px;
}

.post h1 a, .post h1 a:visited {
    color: #000000;
}
```

- `post_list.html`

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
        <div class = "page-header">
            <h1><a href="">Django Girls Blog</a></h1>
        </div>

        <div class="content container">
            <div class="row">
                <div class="col-md-8">
                    {% for post in posts %}
                        <div class="post">
                            <div class="date">
                                {{ post.published_date }}
                            </div>
                            <h1><a href="">{{ post.title }}</a></h1>
                            <p>{{ post.text|linebreaks }}</p>
                        </div>
                    {% endfor %}
                </div>
            </div>
        </div>
    </body>
</html>
```
