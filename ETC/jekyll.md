# GitHub hosting으로 jekyll 블로그 이용하기

참고 링크: 오라일리 ebook `Static Site Generator`, [ilmol님 블로그](http://ilmol.com/2015/01/워드프레스에서%20Jekyll로%20마이그레이션.html), [nolboo님 블로그](https://nolboo.github.io/blog/2013/10/15/free-blog-with-github-jekyll/), [codecademy deploy](https://www.codecademy.com/en/courses/deploy-a-website/)

## 0. 기본

- 웹 사이트의 발전: static -> dynamic
    + static: DB 통신 없이 html text를 바로 쏴주면 돼서 매우 빠르다. 하지만 단순하고, 자체 기능이 부족하고, 콘텐츠 수정이 힘들다.
    + dynamic: DB와 연동하여 댓글, 좋아요 등 다양한 기능이 가능하고, 콘텐츠 수정, 추가가 용이하다.
- 하지만 개인 블로그나 간단한 사이트의 경우 필요로 하는 기능이 많지 않다. 대표적인 추가 기능들(댓글, form, 글 검색 등)이 각각 서비스화되면서(disqus, wufoo, google 등등) 정적 사이트로 블로그를 만들더라도 원하는 대부분의 기능을 충족할 수 있게 됐다.
- 정적 사이트 엔진이 jekyll 말고도 무려 400개나 된다.([참고링크](https://staticsitegenerators.net/))
- jekyll 창시자가 GitHub의 창업자이자 전 CEO인 Tom Preston-Werner다. 괜히 GitHub에서 호스팅도 제공하고 GitHub Pages에서도 자주 사용되는 등의 연결고리가 있는게 아니다.
- jekyll은 ruby 언어 기반이지만 엔진을 커스텀해서 사용할 것이 아니라면 루비 문법을 알 필요는 없다.
- 만약 서브라임텍스트를 쓴다면 jekyll 플러그인 설치하면 좋다. `cmd + option + p` 눌러서 `install package` 선택하고, `jekyll` 검색하면 하나 딱 뜬다.

## 1. 세팅 (OS X)

- jekyll, github-pages 설치: 맥에는 루비가 기본으로 설치되어있기 때문에 gem으로 바로 설치한다. github pages는 github이 호스팅해주는 서비스다.

    ```sh
    sudo gem install jekyll
    gem install github-pages
    ```

- 원하는 디렉토리에 jekyll 프로젝트를 생성한다. GitHub 호스팅을 활용하려면 remote, local repository 이름을 모두 `username.github.io`로 해야한다. 나 같은 경우는 GitHub username이 'gyubin'이라서 [gyubin.github.io](http://gyubin.github.io/)로 했다.

    ```sh
    jekyll new username.github.io
    cd username.github.io
    jekyll build
    ```

- 이제 GitHub에 remote repository를 만들고 로컬과 연결시킨다. 먼저 GitHub에 역시 같은 이름(username.github.io)으로 repository를 만드는데 README나 License 파일 없이 **빈 것**으로 만든다. 다음 git 명령어를 차례로 실행해서 연결한다.

    ```sh
    # username.github.io 디렉토리에서
    git init
    git remote add origin git@github.com:Gyubin/gyubin.github.io.git # 같은 이름으로 만든 remote의 주소를 로컬의 remote origin으로 지정한다.
    git add . # 모든 파일을 stage로
    git commit -m "Initialize Blog" # commit 하기
    git push origin master
    ```

- 잠시 기다리면(난 바로 됐다) [http://gyubin.github.io/](http://gyubin.github.io/)로 새로운 URL이 생기고 접속이 가능할 것이다. 이제 로컬에서 블로깅 작업을 하고 GitHub에 push하기만 하면 자동으로 반영된다. 로컬 서버를 띄워서 push 전 모습을 확인하려면 다음 명령어를 친다. URL은 `localhost:4000` 이다. 서버 명령어를 더 알아보려면 `jekyll serve -h`

    ```sh
    cd username.github.io # 만들어진 디렉토리로 들어가서
    jekyll serve
    ```

## 2. 내 도메인 연결하기

### 2.1 도메인 구입

어디서든 원하는 곳에서 해도 된다. 다음은 AWS의 **Route 53**에 대한 내용이다.

- AWS 콘솔 메뉴에서 네트워킹 타이틀의 **Route 53**으로 들어간다.
- **Domain Registration**의 시작 버튼 클릭
- **Register Domain** 클릭. io 도메인이 39달러라서 다른 곳에 비해 싼 편.

### 2.2 지킬과 연결

`CNAME` 이란 파일 명으로 github repo에 파일을 생성하고 첫 줄에 내 도메인을 적는다. 나같은 경우는 'qbinson.io'로 했다. 그러면 repo 세팅의 'Github Pages' 란에 'Your site is published at http://qbinson.io' 라고 뜬다.

### 2.3 DNS

- 이제 AWS에서 DNS record를 설정해준다. Route 53 페이지에 다시 들어가서 왼쪽 메뉴 중 **Hosted Zone**으로 들어가서 내 도메인을 선택한다.
- NS Type의 4가지 값을 카피해둔다. 다시 왼쪽 메뉴의 Domains의 Registered domains 메뉴로 들어가서 내 도메인을 클릭해보면 4가지 값이 이미 설정되어있는 것을 볼 수 있다.
- 다시 Hosted Zone으로 간다. DNS record엔 몇 가지 타입이 있는데 A 타입을 조정할 것이다. `A`는 `Address` 레코드를 뜻하며 도메인 이름을 IP 주소로 이동시켜준다. 우측 메뉴의 'Create Record Set'에서 Name 부분은 넘어가고, Type을 `A - IPv4 address`로 선택한다. 아래 TTL은 기본 세팅인 300으로 두고 Value 부분을 다음처럼 줄바꿈해서 적어준다. GitHub 주소다.

    ```
    192.30.252.153
    192.30.252.154
    ```

### 2.4 Subdomain

- 내 루트 도메인은 `qbinson.io`다. 이 앞에 `www.qbinson.io` 혹은 `blog.qbinson.io` 등으로 앞에 붙는 것들이 subdomain이다.
- `CNAME` 레코드(Canonical Name)를 통해 subdomain을 설정할 수 있다. CNAME 레코드는 도메인 이름이 진짜 domain name의 alias 혹은 substitute로 사용될 수 있도록 해준다.
    + CNAME record specifies that a domain name will be used as an alias, or substitute, for the true (canonical) domain name.
- Hosted Zone 메뉴에서 Create Record Set 버튼을 선택하고, 우측 창이 나타나면 값들을 입력하고 저장한다.
    + Name: www
    + Type: CNAME - Canonical name
    + Value: `gyubin.github.io`
- dig, domain information groper: 잘 되었는지 `dig www.qbinson.io` 명령어를 터미널에 쳐서 확인할 수 있다. A, CNAME 레코드 정보가 보일 것이다.

## 3. 디렉토리 살펴보기

- `_config.yml`: configuration file. 수정 사항이 jekyll serve 중일 때는 변하지 않는다. 재시작해야 적용됨.
- `_includes/`: 코드 재사용을 위한 `template partials`가 위치하는 곳.
- `_layouts/`: post(글)을 위한 템플릿이 위치.
- `_posts/`: 마크다운 파일. 글 원본이 위치하는 폴더. jekyll의 naming convention을 따라서 파일명이 지정되어야 함.
- `_sass/`: css 전처리기인 SASS가 위치. 지킬에서 기본적으로 지원하지만 꼭 쓸 필요는 없다. pure css도 가능하고, SASS 안 쓸거면 지워도 된다.
- `css/`: main.scss 파일이 존재. 확장자가 scss지만 pure css로 작성해도 되고 특별한 경로 없이 바로 `_sass` 폴더의 파일을 불러올 수 있다. ex) `@import "base";` `@import "layout"`
- `feed.xml`: rss feed를 생성한다.
- `index.html`: 사이트의 홈페이지.

## 4. _config.yml 세팅하기

```
title: Gyubin's learning
email: geubin0414@gmail.com
description: > # this means to ignore newlines until "baseurl:"
  1. 오늘보다 조금 더 발전한 내일이 되자.<br>
  2. 중요한 것은 포기하지 않는 것.<br>
  &nbsp; &nbsp; 더딘 것을 염려하지 말고, 멈출 것을 염려하자.<br>
  3. 공부 슬럼프는 공부로 극복한다.
baseurl: "" # the subpath of your site, e.g. /blog
url: "http://qbinson.com/" # the base hostname & protocol for your site
twitter_username: geubin0414
github_username:  gyubin

# Build settings
markdown: kramdown
# markdown: redcarpet
# redcarpet:
#   extensions: ["no_intra_emphasis", "fenced_code_blocks", "autolink", "strikethrough", "superscript", "with_toc_data"]

#permalink
permalink: pretty
```

- title, email: 사이트 제목과 사이트에 표시될 내 이메일
- description: 사이트 설명. 기본 폼에선 하단 우측에 표시된다. `>` 표시는 `baseurl:`을 만날 때까지 개행문자를 무시하는 의미다.
- baseurl: 다른 사이트를 URL로 구분해서 띄울 때 쓰지만(예를 들어 domain/blog 식으로) 개인 블로그로 사용할 경우 비워둔다.
- url: 개인 도메인을 쓴다면 입력한다. 기본 주소는 "http://gyubin.github.io/"으로 적어두면 된다.
- markdown: jekyll이 버전 3이 되면서 마크다운 방식에 [변화](https://github.com/blog/2100-github-pages-now-faster-and-simpler-with-jekyll-3-0)가 생겼다. kramdown만 지원되고, GFM을 완벽하게 지원한다. 단순하게 markdown: kramdown만 쓰면 된다. ~~GitHub Flavored Markdown을 쓰기 위해 redcarpet으로 바꿨다. 바꾸는 방식은 다음 [링크](https://github.com/nono/Jekyll-plugins)에서 확인했다. `redcarpet`, `albino` gem을 모두 설치했고, 나는 링크에서처럼 버전을 지정하지 않고 최신 버전을 설정했다. 그리고 redcarpet2를 치면 에러가 나서 redcarpet을 입력했다.~~
- permalink: pretty를 쓰면 각 포스트의 URL이 `카테고리/연/월/일/제목`이 된다. [공식문서](http://jekyllrb.com/docs/permalinks/#built-in-permalink-styles) 참고
- yml 파일에 이름과 값을 설정하면 global 변수가 된다. 어디서든 `{{ site.정한이름 }}`으로 호출 가능하다.

## 5. Liquid 문법

jekyll은 블로깅 플랫폼이라기보단 하나의 웹 프레임워크에 가깝다. 어떤 글을 끌어올 것이고, 날짜와 제목은 어떻게 설정할 것인지에 대한 최소한의 문법이 존재한다. 근데 웃긴건 ruby 기반이면서 liquid 문법은 Python Django랑 똑같다.

- `{{ }}` : Output markup. 안에 쓴 객체가 html에 그대로 출력된다. `{{ page.title }}` 이라면 저 객체가 갖고 있는 값이 그대로 html에서 보여진다. 변수 정보는 다음 [링크](http://jekyllrb.com/docs/variables/)에 나와있다.
- `{% %}` : Tag markup. 안에 쓴 내용이 html에 보이지 않는다. 반복 시작과 끝, 조건 시작과 끝을 나타낸다.
- filter: `<p>Posted {{ post.date | date: "%b %-d, %Y" }}</p>` 처럼 쓴다. [GitHub](https://github.com/Shopify/liquid/wiki/Liquid-for-Designers#standard-filters), [공식문서](http://jekyllrb.com/docs/templates/) 참조. 

## 6. 글 쓰기

- 글 제목은 언제나 `년-월-일-제목.markdown`으로 한다. ex) 2016-01-31-welcome-to-jekyll.markdown
- Front Matter: post 폴더의 markdown 파일에서 `---`로 구분된 부분.
    + `layout` : `_layout` 폴더의 형식을 불러온다. 이 부분을 활용해서 다양한 스타일 제작 가능하다.
    + `published`: false 로 두면 드래프트 상태가 된다.
    + `category`, `categories` : 글의 카테고리를 지정. 여러 카테고리로 지정하려면 복수형으로 쓰고 comma로 구분된 문자열을 대입한다.
    + `title`: 글 제목
    + `date`: 글 작성 시간
    + `tags`: 태그
    + `author`: 글쓴이
    + `comment`: true로 두면 댓글 기능 가능. disqus 이용하면 좋다.
    + [추가 정보](http://jekyllrb.com/docs/frontmatter/ )
- disqus는 아래 코드를 `_layouts` 폴더의 `post.html`에 삽입한다. Front Matter에서 `comment: true`로 두는 것 잊지 말자.

    ```html
    {% if page.comments %}
      <section id="comments" role="comments">
        <div id="disqus_thread"></div>
        <script type="text/javascript">
          var disqus_developer = 1; // github 에 올리기 전 확인하고 싶다면 //를 지우고 명령어로 수정
          var disqus_shortname = 'gyubinson'; // required: replace example with your forum shortname
          /* * * DON'T EDIT BELOW THIS LINE * * */
          (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
          })();
        </script>
        <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
      </section>
    {% endif %}
    ```
