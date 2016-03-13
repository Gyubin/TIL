# 맥에서 쉽게 로컬 서버 돌리기

사용 서비스: [pow.cx](http://pow.cx/) + [anvli](http://anvilformac.com/)

## 1. pow.cx

### 1.1 기본

- 두 가지 장점이 있다. 첫째로 로컬 서버를 쉽게 돌릴 수 있다는 것, 둘 째로 프로젝트를 여러 개 담아두고 쉽게 서버를 올릴 수 있다는 것.
- Python SimpleHTTPServer를 예로 들면 어떤 프로젝트에서 서버를 돌리려면 그 위치로 가서, 명령어를 실행해야 한다. 여러 개를 동시에 돌리려면 탭을 여러개 생성해서 각각 다른 포트를 지정해서 명령어를 실행해야 한다. 꽤 귀찮다.
- pow.cx를 통해서 서버를 실행하면 위와 같은 귀찮은 경우가 없으며 도메인도 localhost:8000 이런게 아니라 예쁘게 `project.dev` 형태로 나온다.

### 1.2 설치

- homebrew로 설치할 수 있다. 다음 [링크](http://jerryclinesmith.me/blog/2012/08/07/installing-pow-via-homebrew)에 설치 방법이 잘 설명되어있다. 명령어만 나열하면 다음과 같다.

    ```sh
    # 설치 명령어
    brew install pow
    sudo pow --install-system # 방화벽 설정에서 Pow는 무조건 80포트로 지정
    pow --install-local
    sudo launchctl load -w /Library/LaunchDaemons/cx.pow.firewall.plist
    launchctl load -w ~/Library/LaunchAgents/cx.pow.powd.plist
    mkdir -p ~/Library/Application\ Support/Pow/Hosts
    ln -s ~/Library/Application\ Support/Pow/Hosts/ ~/.pow
    ```

- 이제 다음 명령어처럼 서버를 띄우면 된다. 아래 코드에서 `< >` 안에 들어가는게 프로젝트 디렉토리 경로고, 한 칸 띄워서 아래처럼 `myapp` 처럼 적어주면 브라우저에서 `http://myapp.dev` 로 띄워준다. 만약 뒤에 이름을 지정하지 않으면 프로젝트 디렉토리 명으로 도메인을 띄워준다. testapp 디렉토리라면 `http://testapp.dev` 같은 식. 매번 `~/.pow` 디렉토리에서 띄워야되는 건 귀찮지만 그건 아래 Anvil이 해결해준다.

    ```sh
    cd ~/.pow
    ln -s <my Rails project dir> myapp
    ```

- 그럼 항상 서버 실행돼있는건데 중단할 수 없나라는 의문이 들 수 있다. [매뉴얼](http://pow.cx/manual.html)이 정말 잘 돼있다.
    + `~/.powconfig` 파일에다가 서버 죽는 시간을 설정해놓을 수 있다. 나는 5분으로 설정해두었다.
    + 수동으로 `ps aux | grep pow` 해서 프로세스 아이디를 알아낸 다음 `sudo kill -9 <psid>` 명령어로 직접 죽여줄 수도 있다.

## 2. Anvil

로컬 서버 관리 GUI 툴이다. 정말 좋다. 위의 pow는 좋긴 좋은데 매번 터미널의 pow 숨김 폴더에 들어가서, 디렉토리 찾아들어가서, 서버 실행 명령어를 쳐야했다. 이 귀찮음을 Anvil이 해결해준다.

`~/.pow`에다 프로젝트 폴더를 위 pow에서 설명한 명령어로 추가해주면 앱의 메뉴바에서 바로 추가되는게 보인다. 혹은 Anvil 앱에서 내 프로젝트 폴더를 추가해줄 수도 있다. 이후 앱에서 해당 URL을 클릭하면 바로 앱이 브라우저에서 뜬다.

## 추가: gollum Wiki

개인적으로 wiki를 운영하고 싶으면 [gollum](https://github.com/gollum/gollum/wiki)을 써보자. 한글로 설명돼있는 Outsider님의 [블로그](https://blog.outsider.ne.kr/579)를 참고하면 된다.

위 gollum을 pow와 연결하면 참 편하다. 쉽다. 위키 폴더의 루트 디렉토리에 `config.ru` 파일을 추가하고 아래 코드를 입력해두면 된다. 자세한 내용은 다음 [블로그](http://www.juliendesrosiers.com/2011/07/20/run-gollum-on-pow)를 참고한다.

```
require "gollum/app"

Precious::App.set(:gollum_path, File.dirname(__FILE__))
Precious::App.set(:wiki_options, {})
run Precious::App
```
