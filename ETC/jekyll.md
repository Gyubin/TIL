# Jekyll 개론

참고 링크

- 오라일리 ebook **Static Site Generator**
- [ilmol님 블로그](http://ilmol.com/2015/01/워드프레스에서%20Jekyll로%20마이그레이션.html)
- [nolboo님 블로그](https://nolboo.github.io/blog/2013/10/15/free-blog-with-github-jekyll/)
- [codecademy deploy](https://www.codecademy.com/en/courses/deploy-a-website/)
- [xho95님 블로그](https://xho95.github.io/blog/github/pages/jekyll/minima/theme/2017/03/04/Jekyll-Blog-with-Minima.html)
- [saltfactory 블로그](http://blog.saltfactory.net/jekyll/upgrade-github-pages-dependency-versions.html)

---

목차

1. 소개
2. 설치와 GitHub 연동
3. 구동 방식

## 1. 소개

### 1.1 등장 배경

- 웹 사이트의 발전: static -> dynamic
    + static: DB 통신 없이 html, css 등의 정적 파일의 text를 바로 전달한다. 단순해서 빠르지만 자체 기능이 부족하고, 콘텐츠 수정이 힘들다.
    + dynamic: DB와 연동하여 댓글, 좋아요 등 다양한 기능이 가능하고, 콘텐츠 수정, 추가가 용이하다.
- 하지만 개인 블로그나 간단한 사이트의 경우 필요로 하는 기능이 많지 않다. 대표적인 추가 기능들(댓글, form, 글 검색 등)이 각각 서비스화되면서(disqus, wufoo, typeform, google 등등) 정적 사이트로 블로그를 만들더라도 원하는 대부분의 기능을 충족할 수 있게 됐다.
- 정적 사이트 엔진이 Jekyll 말고도 무려 400개나 된다.([참고링크](https://staticsitegenerators.net/))
- Jekyll 창시자가 GitHub의 창업자이자 전 CEO인 Tom Preston-Werner다. 괜히 GitHub에서 호스팅도 제공하고 GitHub Pages에서도 자주 사용되는 등의 연결고리가 있는게 아니다. 현재는 [Parker Moore](https://github.com/parkr)(GitHub 직원)가 리딩하고 있다.
- Jekyll은 ruby 언어 기반이지만 엔진을 커스텀해서 사용할 것이 아니라면 루비 문법을 알 필요는 없다.

### 1.2 단순 소개 페이지를 원한다면

- 만약 단순히 어떤 페이지 하나를 소개 목적으로 만들고 싶은거라면(예: [모두의 딥러닝 페이지](http://hunkim.github.io/ml/)) 정말 간단해진다. Jekyll까지 갈 필요도 없다.
- GitHub pages와 [Jekyll Theme Chooser](https://help.github.com/articles/creating-a-github-pages-site-with-the-jekyll-theme-chooser/)를 이용해서 테마 샘플 하나 선택하고, 내용은 `README.md` 파일로 대체하면 된다.

## 2. 설치와 GitHub 연동

### 2.1 Ruby 설치

- OS X
    + 기본적으로 Ruby가 설치되어있지만, 구버전일 수도있어서 업데이트해야 한다고한다.
    + Homebrew 패키지 매니저 설치 : `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
    + 루비 설치 : `brew install ruby`
- Window
    + 루비 설치파일(2.4 버전 이상)을 다운받고 실행 : https://rubyinstaller.org/downloads/
    + 블로그 글 검색에서 DevKit을 설치하라는 건 2.4 미만 버전에 대한 것이므로 무시한다.
    + 설치 마지막에 `MSYS2`에 대한 언급이 있는데 설치해준다. 새 창이 떠서 1, 2, 3 중에 선택하라고 하는데 1번 정도까지는 추가로 설치해주자. 그 후엔 그냥 엔터 쳐서 종료.

### 2.2 라이브러리 설치

- OS X : 터미널 열고 `sudo gem install jekyll bundler`
- Window: cmd 열고 `gem install jekyll bundler`

### 2.3 GitHub 연동

- 저장소 생성: GitHub에서 `username.github.io` 이름으로 repository를 만든다. username은 자신의 것으로 대체. 내 경우는 GitHub username이 'gyubin'이라서 [gyubin.github.io](http://gyubin.github.io/)로 했다.
- 생성된 빈 repository를 clone하고(ex: `git clone git@github.com:Gyubin/gyubin.github.io.git`) 해당 디렉토리로 들어간다.
- 내 로컬의 저장소에 들어간 상태에서 아래 명령어 순차 실행
    + new 뒤에 이름을 지정해서 새로운 디렉토리를 만드는 것이 일반적인데 우리는 로컬 저장소 디렉토리에 있기 때문에 현재 디렉토리로 `.` 지정해서 그냥 파일만 생성한다.
    + 로컬 서버 실행(`http://localhost:4000/`)되는 동안엔 파일 변화가 바로바로 적용된다. 미리보기 가능.

    ```sh
    jekyll new .
    bundle exec jekyll serve
    ```

- 만들어진 파일을 실제 적용하고 싶다면 아래처럼 모든 파일을 commit하고 push하면 된다. 잠시 기다리면 내 주소([http://gyubin.github.io/](http://gyubin.github.io/))에서 미리보기에서 봤던 내용이 뜰 것이다.

    ```sh
    git add . # 모든 파일을 stage로
    git commit -m "Initialize Blog" # commit 하기
    git push
    ```

기본적으로 한 사이클은 돌았다. 앞으로 할 일은 웹사이트를 구성하는 html, css, js 파일들을 입맛에 맞게 수정하면 된다.

## 3. Jekyll 디렉토리 구조

Jekyll은 말 그대로 Static site generator다. 정해진 디렉토리에, 정해진 양식대로 파일을 넣으면 내 웹 사이트를 구성하는 html 파일들을 생성한다. 그리고 디렉토리 path와 동일하게 URI로 접근할 수 있다. 아래가 기본적인 파일 트리 구성이다.

```
.
├── _config.yml
├── _data
|   └── members.yml
├── _drafts
|   ├── begin-with-the-crazy-ideas.md
|   └── on-simplicity-in-technology.md
├── _includes
|   ├── footer.html
|   └── header.html
├── _layouts
|   ├── default.html
|   └── post.html
├── _posts
|   ├── 2007-10-29-why-every-programmer-should-play-nethack.md
|   └── 2009-04-26-barcamp-boston-4-roundup.md
├── _sass
|   ├── _base.scss
|   └── _layout.scss
├── _site
├── .jekyll-metadata
└── index.html # can also be an 'index.md' with valid YAML Frontmatter
```

앞에 `_` 언더바가 붙은 폴더들은 Jekyll이 감지해서 build할 때 사용하는 폴더들이므로 규칙에 맞게 사용해야한다. 모두 안의 내용들을 건드릴 수 있지만 `_site` 폴더는 자동으로 생성되는 것이므로 건드려봤자 소용이 없다.(수정해봤자 다음 빌드 때 원상복귀된다)

> `jekyll build --source <source> --destination <destination> --watch` 명령어로 옵션을 줘서 어떤 디렉토리를 이용할건지, 최종 생성될 폴더는 어디인지를 직접 지정할 수 있다. 디폴트는 각각 현재 디렉토리, 그리고 \_site 폴더다. `--watch` 옵션은 파일 감지해서 자동 생성 가능하게 한다.

### 3.1 \_includes

- 코드 재사용을 위한 `template partials`가 위치하는 곳이다.
- 한 웹사이트에서 footer, header 같은 것들은 어떤 페이지를 들어가도 같다. 그래서 하나의 파일을 만들어두고, 이 파일을 가져다가 쓴다.
- 수정할 때 모든 페이지, 모든 포스트에 가서 header를 하나하나 수정할 필요없이 내 header 파일만 수정하면 되므로 수정에 매우 용이하다.
- 확장자는 필요한 어떤 확장자도 가능하고, header 내용이 필요한 다른 파일에서 아래처럼 가져와서 사용한다. 아래는 html 파일에서 html partial을 가져와 쓰는 예다.

    ```
    ...
    {% include header.html %}
    ...
    ```

### 3.2 \_layouts

- 내 사이트에서 필요로하는 모든 템플릿 html 파일들이 위치한다.
    + 대표적으로 글마다 반복적으로 활용되는 `post.html`
    + 사이트 혹은 내 소개 내용을 담는 `about.html`
    + 내 연락처를 담는 `contact.html`
- 내 사이트에서 어떤 페이지를 만들고싶다면 무조건 여기에 파일이 있어야한다고 생각하자.
- 이 템플릿을 이용해서 다양한 글들이 만들어지고, 각 글의 제목 혹은 permalink에 따라 위치한 path가 달라지므로 css나 js를 불러올 때는 꼭 absolute path를 쓰는게 좋다.
- 인터넷에 공개되어있는 좋은 theme을 보면 잘 만들어둔 html 파일들이 있을 것이다. 그런것들을 `_layouts` 폴더에 넣으면 된다.

### 3.3 \_posts

- Front matter 내용이 추가된 마크다운 형식의 **글**들이 위치하는 디렉토리다.
- **무조건** 다음 포맷 `YEAR-MONTH-DAY-title.MARKUP` 으로 파일명을 지정해줘야한다.
- 따로 permalink를 지정하지 않으면 저 파일명대로 디렉토리가 나눠져서 최종 내 글(html) 파일이 위치하게 된다.

### 3.4 \_site

- 따로 destination 디렉토리를 지정하지 않으면 디폴트로 `_site`에 모든 최종 파일들이 생성되게 된다.
- 건드려서도, 건드릴 필요도 없는 디렉토리다.
- 어차피 GitHub에 올리면 따로 생성되기 때문에 `.gitignore` 파일에 이 디렉토리를 추가해주는 것이 좋다.

### 3.5 \_data

- 사이트에서 활용할 정형화된 데이터 파일들이 위치한다. `.yml`, `.yaml`, `.json`, `.csv` 파일들이 위치함
- `site.data` 로 어떤 파일에서든 호출해서 사용할 수 있다.
- 만약 `members.yml` 파일이라면 `site.data.members`로 호출해서 사용 가능

### 3.6 \_drafts, \_sass

- `_drafts` : 발행하지 않은 글 파일들은 단순히 `title.markup` 형태로 여기다 넣어두면 된다.
- `_sass` : sass partials들이 위치한다.
    + main.scss 파일에서 호출해서 쓸 수 있다. ex) `@import "base";` `@import "layout"`
    + main.scss는 build될 때 main.css로 알아서 jekyll이 만들어준다.
- `feed.xml`: rss feed를 생성한다.

### 3.7 기타

- 앞에 `_`가 붙지 않은 폴더들(css, images, js 등)과 일반 파일들은 Jekyll이 건드리지 않고 그대로 `_site` 폴더로 보내진다.
- `favicon.ico`은 마음에 드는거 골라서 root 디렉토리에 넣어둔다.
- `_config.yml` 파일은 아래에서 자세히 설명. 그리고 이 파일은 `--watch` 옵션이 설정되어있더라도 로컬서버 실행 중엔 변경 사항이 적용되지 않는다. 재시작해야함.

## 4. \_config.yml

한 마디로 말해서 변수값들의 집합이다. Jekyll이 빌드할 때 사용하는 지정된 변수, 즉 **Global configuration**과 사용자가 어디서든 편하게 사용할 **임의의** 변수들도 있다. 지정한 변수들은 `{{ site.var_name }}`으로 어디서든 호출해서 사용할 수 있다.

[공식문서 configurations](https://jekyllrb.com/docs/configuration/)에 엄청나게 많다. 대표적인 것만 추린다.

- `source: DIR` : 디폴트는 현재 디렉토리 `./`이고, 지정된 DIR path가 소스가 된다. 웹사이트에 대한 내용이 아니라 다른 코드도 해당 repository에 존재한다면 이렇게 구분하는 것도 좋은 방법이다.
- `destination: DIR` : 디폴트는 `./_site` 이고, 지정해서 다른 폴더로 만들 수 있다.
- `safe: BOOL` : 플러그인이나 symbolic link들이 실행되지 않도록 한다.
- `exclude: [DIR, FILE, ...]` : 빌드할 때 웹사이트와 관계없어서 제외할 파일들 명시
- `keep_files: [DIR, FILE, ...]` : Jekyll이 빌드하지 않는, 다른 빌드 툴이 생성하는 파일들을 destination dir에 포함하고 싶을 때 사용한다.
- `timezone: TIMEZONE` : `America/New_York` 혹은 `Asia/Seoul` 로 세팅
- `encoding: utf-8` : encoding 설정. utf-8이 디폴트값이다.
- `port: PORT` : 로컬 서버에서 포트 설정
- `baseurl: "/blog"` : 사이트의 기본 subpath 지정한다. index.html 파일이 표현되는 URI가 `domain/blog` 형태로 된다.
- `url: ""` : hostname과 protocol까지 지정할 수 있다. 만약 내 고유 도메인을 이용하고 싶으면 지정해준다. ex) http://example.com
- `markdown: kramdown` : 이게 기본이고 굳이 바꾸지말자.

## 5. Front matter

```yaml
---
layout: post
permalink: about-jekyll
title: Blogging Like a Hacker
date: 2017-11-19 18:00:00 -0900
categories: ml optimizer
---
```

어떤 파일이든 YAML 형식의 block을 포함하고 있으면 jekyll이 다른 파일로 변환시킨다.(md 파일 뿐만 아니라 html 역시) 파일의 맨 처음 위치해야하고 dash 3개로 위처럼 구분되어야한다.

- `layout` : 어떤 템플릿을 사용할건지 지정. 위 예는 `_layouts/post.html` 이라는 파일을 사용하고 있다.
- `permalink` : 디폴트는 날짜와 title로 이루어진 URI인데, 위처럼 지정하면 `gyubin.github.io/about-jekyll`로 브라우저에서 접근할 수 있다. html 파일의 위치도 URI 구조처럼 root 디렉토리로 된다. permalink를 지정하면 categories와 date로 결정되던 파일 위치는 무시된다.
- `published` : True, False로 설정해서 글로 안보여지게 할 수도 있다.
- `date: YYYY-MM-DD HH:MM:SS +/-TTTT` 꼴로 쓰고 연월일 뒤는 생략가능하다. 파일명에 있는 날짜 정보를 오버라이드한다.
- `categories: ml optimizer` : 공백으로 구분해서 카테고리 위계를 설정할 수 있다. 빌드하면 디렉토리가 ml 폴더 안에 optimizer 폴더 안에 날짜로 구분되어 html파일들이 생긴다.
- `tags: aa bb cc dd` : 공백 구분해서 여러 태그를 설정해줄 수 있다.
- `comments: true` : disqus로 댓글 설정할 때 꼭 이렇게 지정해줘야한다.

이렇게 설정된 변수들은 `{{ page.title }}` 형태로 템플릿에서 사용한다.

## 6. Liquid 문법

- `{{ }}` : Output markup. 안에 쓴 객체가 html에 그대로 출력된다. `{{ page.title }}` 이라면 저 객체가 갖고 있는 값이 그대로 html에서 보여진다. 변수 정보는 다음 [링크](http://jekyllrb.com/docs/variables/)에 나와있다.
- `{% %}` : Tag markup. 안에 쓴 내용이 html에 보이지 않는다. 반복 시작과 끝, 조건 시작과 끝을 나타낸다.
- filter: `<p>Posted {{ post.date | date: "%b %-d, %Y" }}</p>` 처럼 쓴다. [GitHub](https://github.com/Shopify/liquid/wiki/Liquid-for-Designers#standard-filters), [공식문서](http://jekyllrb.com/docs/templates/) 참조. 

## 7. Disqus

- [Disqus 사이트](https://disqus.com/)로 들어가서 회원가입하고, "site"를 하나 만든다.
- 만드는 과정 중 아래와 비슷한 코드를 줄 것이다. 복사해서 `_layouts` 폴더에 "글"을 나타내는 템플릿에 붙여넣는다.

    ```html
    {% if page.comments %}
      <div id="disqus_thread"></div>
      <script>
        var disqus_config = function () {
          this.page.url = "https://gyubin.github.io" + "{{ page.url }}";
          this.page.identifier = "{{ page.url }}";
        };
        (function() { // DON'T EDIT BELOW THIS LINE
        var d = document, s = d.createElement('script');
        s.src = 'https://gyubin.disqus.com/embed.js';
        s.setAttribute('data-timestamp', +new Date());
        (d.head || d.body).appendChild(s);
        })();
      </script>
      <noscript>
        Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a>
      </noscript>
    {% endif %}
    ```

- 다음 두 변수 정도만 수정해주면 된다.
    +  `this.page.url` : 해당 페이지(글)의 url을 지정해준다.
    +  `this.page.identifier` : 페이지만의 유니크한 값을 지정해준다. 나는 domain 뒷부분 문자열을 사용했다.
- 위처럼 `url`과 `identifier`를 설정해줘야 블로그의 글 마다 댓글을 다르게 띄울 수 있고 꼭 다른 값으로 설정하자. 같은 값으로 설정하면 conflict가 난다.
- 글 내용 파일의 Front Matter에서 `comments: true`로 주는 것 잊지말자.

## 8. 내 도메인 연결하기

### 8.1 도메인 구입

어디서든 원하는 곳에서 해도 된다. 다음은 AWS의 **Route 53**에 대한 내용이다.

- AWS 콘솔 메뉴에서 네트워킹 타이틀의 **Route 53**으로 들어간다.
- **Domain Registration**의 시작 버튼 클릭
- **Register Domain** 클릭. io 도메인이 39달러라서 다른 곳에 비해 싼 편.

### 8.2 지킬과 연결

`CNAME` 이란 파일 명으로 github repo에 파일을 생성하고 첫 줄에 내 도메인을 적는다. 나같은 경우는 'qbinson.io'로 했다. 그러면 repo 세팅의 'Github Pages' 란에 'Your site is published at http://qbinson.io' 라고 뜬다.

### 8.3 DNS

- 이제 AWS에서 DNS record를 설정해준다. Route 53 페이지에 다시 들어가서 왼쪽 메뉴 중 **Hosted Zone**으로 들어가서 내 도메인을 선택한다.
- NS Type의 4가지 값을 카피해둔다. 다시 왼쪽 메뉴의 Domains의 Registered domains 메뉴로 들어가서 내 도메인을 클릭해보면 4가지 값이 이미 설정되어있는 것을 볼 수 있다.
- 다시 Hosted Zone으로 간다. DNS record엔 몇 가지 타입이 있는데 A 타입을 조정할 것이다. `A`는 `Address` 레코드를 뜻하며 도메인 이름을 IP 주소로 이동시켜준다. 우측 메뉴의 'Create Record Set'에서 Name 부분은 넘어가고, Type을 `A - IPv4 address`로 선택한다. 아래 TTL은 기본 세팅인 300으로 두고 Value 부분을 다음처럼 줄바꿈해서 적어준다. GitHub 주소다.

    ```
    192.30.252.153
    192.30.252.154
    ```

### 8.4 Subdomain

- 내 루트 도메인은 `qbinson.io`다. 이 앞에 `www.qbinson.io` 혹은 `blog.qbinson.io` 등으로 앞에 붙는 것들이 subdomain이다.
- `CNAME` 레코드(Canonical Name)를 통해 subdomain을 설정할 수 있다. CNAME 레코드는 도메인 이름이 진짜 domain name의 alias 혹은 substitute로 사용될 수 있도록 해준다.
    + CNAME record specifies that a domain name will be used as an alias, or substitute, for the true (canonical) domain name.
- Hosted Zone 메뉴에서 Create Record Set 버튼을 선택하고, 우측 창이 나타나면 값들을 입력하고 저장한다.
    + Name: www
    + Type: CNAME - Canonical name
    + Value: `gyubin.github.io`
- dig, domain information groper: 잘 되었는지 `dig www.qbinson.io` 명령어를 터미널에 쳐서 확인할 수 있다. A, CNAME 레코드 정보가 보일 것이다.
