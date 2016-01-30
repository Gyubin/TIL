# jekyll

## 0. 기본

- 참고: 오라일리 ebook `Static Site Generator`
- 웹 사이트의 발전: static -> dynamic
    + static: DB 통신 없이 html text를 바로 쏴주면 돼서 매우 빠르다. 하지만 단순하고, 자체 기능이 부족하고, 콘텐츠 수정이 힘들다.
    + dynamic: DB와 연동하여 댓글, 좋아요 등 다양한 기능이 가능하고, 콘텐츠 수정, 추가가 용이하다.
- 하지만 개인 블로그나 간단한 사이트의 경우 필요로 하는 기능이 많지 않다. 대표적인 추가 기능들(댓글, form, 글 검색 등)이 각각 서비스화되면서(disqus, wufoo, google 등등) 정적 사이트로 블로그를 만들더라도 원하는 대부분의 기능을 충족할 수 있게 됐다.
- 정적 사이트 엔진이 jekyll 말고도 무려 400개나 된다.([참고링크](https://staticsitegenerators.net/))
- jekyll 창시자가 GitHub의 창업자이자 전 CEO인 Tom Preston-Werner다. 괜히 GitHub에서 호스팅도 제공하고 GitHub Pages에서도 자주 사용되는 등의 연결고리가 있는게 아니다.
- jekyll은 ruby 언어 기반이지만 엔진을 커스텀해서 사용할 것이 아니라면 루비 문법을 알 필요는 없다.
- 만약 서브라임텍스트를 쓴다면 jekyll 플러그인 설치하면 좋다. `cmd + option + p` 눌러서 `install package` 선택하고, `jekyll` 검색하면 하나 딱 뜬다.

## 1. 세팅 (OS X)

- jekyll 설치: 맥에는 루비가 기본으로 설치되어있기 때문에 gem으로 바로 설치한다.

    ```sh
    sudo gem install jekyll
    ```

- 원하는 디렉토리에 jekyll 프로젝트를 생성한다.(아래 코드에서 실제로 칠 때는 대괄호[] 는 쓰지 않는다.)

    ```sh
    jekyll new [project name]
    ```

- 디렉토리 살펴보기
    + `_config.yml`: configuration file. 설정 파일이다.
    + `_includes`: template partials 가 위치하는 곳
    + `_layouts`: post(글)을 위한 템플릿이 위치.
    + `_posts`: 마크다운 파일. 글 원본이 위치하는 폴더.
    + `_sass`: css 전처리기인 SASS가 위치. 지킬에서 기본적으로 지원하지만 꼭 쓸 필요는 없다. pure css도 가능하고, SASS 안 쓸거면 지워도 된다.
    + `css`: css or Sass 파일 위치
    + `feed.xml`: rss feed를 생성한다.
    + `index.html`: 사이트의 홈페이지.
- 이제 다음 명령어로 로컬 서버를 띄워서 생김새를 살펴본다. `localhost:4000`으로 살펴보면 된다. 그리고 서버 명령어를 더 알아보려면 `jekyll serve -h`

    ```sh
    cd [project name] # 만들어진 디렉토리로 들어가서
    jekyll serve
    ```

## 2. Liquid template

jekyll은 블로깅 플랫폼이라기보단 하나의 웹 프레임워크에 가깝다. 어떤 글을 끌어올 것이고, 날짜와 제목은 어떻게 설정할 것인지에 대한 최소한의 문법이 존재한다. Rails랑 비슷하다.

- 변수: `{{ page.title }}` 처럼 변수는 중괄호 2개로 감싼다. 이런 변수 정보는 다음 [링크](http://jekyllrb.com/docs/variables/)에 나와있다.
- filter: [GitHub](https://github.com/Shopify/liquid/wiki/Liquid-for-Designers#standard-filters), [공식문서](http://jekyllrb.com/docs/templates/) 참조.























