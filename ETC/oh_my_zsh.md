# oh-my-zsh

참고 자료: [nolboo blog](https://nolboo.github.io/blog/2015/08/21/oh-my-zsh/), [공식 repository](https://github.com/robbyrussell/oh-my-zsh)

맥 기본 터미널 앱을 계속 써왔다. 슬슬 bash의 단색 테마도 질리고 좀 더 편리하게 터미널을 사용해보고싶기도 해서 추천받은 oh-my-zsh를 쓰기로 했다. 바꾸는 김에 iterm도 사용하려고 바꿨는데 둘 다 만족한다.

## 1. 설치

- 우선 homebrew를 통해 `zsh`를 설치하고, 버전 확인해본다.

    ```sh
    brew install zsh
    zsh --version
    ```

- `/etc/shells` 파일을 vi로 열어서 맨 아래에 아래 코드를 추가해준다. `which zsh` 명령어를 shell에 쳤을 때 나오는 결과다. 잘 됐는지 확인하려면 `echo $SHELL` 했을 때 zsh 경로가 뜨면 된다.

    ```
    /usr/local/bin/zsh
    ```

- 기본 쉘을 변경한다. 터미널을 열었을 때 bash가 아니라 zsh를 열게 하는 명령어다.
    ```sh
    chsh -s /usr/local/bin/zsh
    # chsh -s `which zsh`
    ```

- 이제 oh-my-zsh를 설치한다.

    ```sh
    $ curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    ```

## 2. 몇 가지 팁

- 자동완성: 여러 경로를 앞 부분만 입력해도 탭으로 완성시킬 수 있다. 원래 `cd hello/abc/def/gf`를 했어야 하는것을 `cd h/a/d/g`를 치고 탭을 누르면 자동완성된다.
- `cd -`를 입력하면 바로 이전에 위치했었던 디렉토리로 이동할 수 있다. 저 상태에서 탭을 누르면 이전 디렉토리 기록들이 쭉 뜬다.
- 자동 완성에서 탭을 두 번 누르면 파일 목록을 띄워주는데 상하좌우 이동키로 선택할 수 있다.
- git 브랜치 표시된다.
- 명령어 스펠 체크 기능 켜주면 편하다. `setopt correct`
