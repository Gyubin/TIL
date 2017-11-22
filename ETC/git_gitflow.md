# Git, git-flow

## 1. Git

### 1.1 설치

맥은 기본으로 설치되어있고, 윈도우는 [깃헙 데스크탑](https://desktop.github.com/)를 설치한다. GUI 프로그램과 Git Shell 프로그램이 같이 설치된다. 혹은 [Git Bash](https://git-for-windows.github.io/)를 설치해도 좋다.

### 1.2 설정

- commit 했을 때 자동으로 이름, 이메일이 지정되도록 한다. 설정 내용들은 `~/.gitconfig` 파일에 기록되어있다.

    ```sh
    git config --global user.name "Gyubin Son"
    git config --global user.email "geubin0414@gmail.com"
    git config --global color.ui auto
    cat ~/.gitconfig
    ```

### 1.3 init, add, commit, diff

- `git init` : 버전 관리할 폴더에 처음에 딱 한 번만 해준다. 이 디렉토리를 git으로 버전관리하겠다는 의미.
- 가장 많이 사용하는 명령어는 다음 세 가지다. `status`, `add`, `commit`.

    ```sh
    git status      # 현재 파일들의 상태를 본다.
    git add file_name   # 특정 파일의 현재 상태를 stage 상태로 만들기.
    git commit -m "commit message"  # 짧은 메시지와 함께 커밋
    ```

- `git diff filename`: file이 달라진 부분을 보여준다. `+`는 새로 생긴, `-`는 없어진 부분이다. `q`를 누르면 이탈한다. [똑똑한 diff 만들기](http://blog.weirdx.io/post/27889) 글을 보고 따라해도 좋음.
- `git checkout HEAD filename`: 특정 파일을 수정하다보니 잘못 수정한 것 같을 때 다시 이전 커밋 지점까지 그 파일만 돌리는 것.
- `git reset HEAD filename`: 파일을 수정하고, staging area에 추가했는데 아니다 싶을 때. 즉 add 명령을 취소할 때 쓴다. 수정 내용은 그대로다.

### 1.4 branch

#### 1.4.1 브랜치 만들고 전환하기

```sh
git branch # branch 뭐 있는지 보기.
git branch feature-A # feature-A 라는 이름의 브랜치 생성
git checkout my_branch # my_branch란 branch로 전환하기.
git checkout master # master로 전환하기.

git checkout -b feature-A # A 기능을 만드는 브랜치를 만들고 전환까지.
git checkout - # 바로 이전 브랜치로 전환함. 꽤 편함.
```

- checkout은 **저장**한 지점과 상관없다. 오직 그 브랜치의 **commit**된 지점으로 되돌아간다. 저장만 하고 다른 브랜치로 전환했다면 편집한 내용을 다 날리게 된다.

#### 1.4.2 merge, conflict

- master 브랜치를 항상 안정된 상태(통합 브랜치)로 두고, 작은 기능들을 구현하는 브랜치들을 여럿 만들어서 merge 하는 방식.
- 병합은 마스터에서 브랜치를 병합'하는' 방향이다.

```sh
git checkout master 
git merge --no-ff feature-A # --no-ff 는 이 merge 자체를 커밋으로 남기겠다는 것. 옵션 안주면 commit 없이 머지만 된다.

git log --graph # 시각적으로 git 커밋 기록 보기.
git commit -am "커밋 메시지" # 수정된 부분만 자동 추가해서 commit한다. add할 필요 없어서 간편.
```

- conflict 의미: 특정 파일에서 같은 위치의 코드를 서로 다른 브랜치위에서 편집하면 충돌이 난다. git에서 어느 부분을 선택해야할지 모르기 때문에 선택권을 유저에게 넘긴다.
- `==========` 윗 부분이 마스터의 내용, 아래 부분이 브랜치의 내용이다. git이 충돌난 부분을 알아서 편집하지 않고 다 뭉쳐서 보여준다.
- `--no-ff` 옵션을 줬기 때문에 충돌나서 두 코드가 공존하는 상황이 커밋된 상태다.
- 알아서 편집기를 통해 해당 부분을 적절히 수정한 후 `add`한 후 `commit`하면 된다.

#### 1.4.3 브랜치 지우기

`git branch -d branch_name` 명령어로 지운다. 브랜치의 목적을 달성했다면 지워준다.

### 1.5 commit 기록 삭제, 뭉개기

#### 1.5.1 삭제 및 복구

- commit을 잘못해서 기록을 삭제하고싶을 때 사용한다. `--hard` 옵션을 주면 코드 내용까지 완전히 복구한 지점으로 돌아간다. soft 옵션을 주면 코드 내용 자체는 현재 시점으로 두고, commit 기록만 삭제하게 된다. 아래는 hard 옵션의 예.
- reset으로 커밋 기록을 지웠더라도 Git의 GC(Garbage Collection)가 동작을 하기 전이라면 지운 것을 복구할 수도 있다. `git reflog` 명령어로 지운 커밋의 해시를 확인한 다음 `reset` 명령어로 똑같이 복구할 수 있다.
- 여기서 해시란 40 글자의 코드이며 SHA라고 불린다. 커밋을 개별적으로 구분할 수 있다.

```sh
git reset --hard hash # 지정한 해시의 커밋까지로 복구. 해시는 git log 명령어로 확인할 수 있다. 이상한 숫자와 알파벳이 혼용된 긴 코드.
git reflog
```

### 1.5.2 git 기록 뭉개기(합치기)

```sh
git rebase -i HEAD~2
```

- 위 코드는 최신 커밋 시점을 포함해서 2개를 뽑아내서 조작하겠다는 의미다.
- vi로 편집하는 창이 뜰거다. 2개의 커밋을 합칠 때 없어질 commit을 `pick`에서 `fixup`으로 바꿔준다. 저장하면 선택된 커밋 2개가 하나로 합쳐졌을 것.
- 주로 오타 수정할 때 많이 사용한다.

### 1.6 원격 저장소

```sh
git remote add origin git@github.om:gyubin/git-tutorial.git
# 원격 저장소 등록: git remote add 까지가 명령어같은거고, origin이 식별자, 그 다음이 위치 주소.

git push -u origin master
# -u 는 현재 로컬 작업상황의 브랜치 및 최신 커밋을 뜻함. origin에다가 master라는 이름으로 push하겠다는 의미.
# 이렇게 처음에 해줘야 로컬과 리모트가 연결되서 나중에 그냥 git pull만 하면 알아서 둘 간의 연결을 보고 바로 당겨온다.

git checkout -b feature-D
git push -u origin feature-D
# 이렇게 다른 브랜치를 오리진에 넣어줄 수도 있다. 여러 브랜치 넣어둠. 각각 로컬의 각 브랜치로 연결돼있는것.
```

### 1.7 clone과 브랜치 구분해서 받아오기

#### 1.7.1 clone

```sh
git clone git@github.om:gyubin/git-tutorial.git custom_name
```

#### 1.7.2 브랜치 구분해서 받아오기

- 그냥 clone만 하면 master의 것만 받아오게 된다. clone 후에 로컬에서 `branch` 명령어를 쳐보면 master밖에 없을 것이다. 아래처럼 다른 브랜치를 로컬에 받아본다.
- 아래 코드의 의미는 내 로컬에다가 feature-D라는 브랜치를 만들고 체크아웃하는데 그 원료를 origin의 feature-D로 하겠다는 것이다.

```sh
git branch -a # 로컬에 더불어 리모트의 브랜치들까지 모든 정보 다 보여준다.
# *master
# remotes/origin/HEAD
# remotes/origin/feature-D
# remotes/origin/master
git checkout -b feature-D origin/feature-D
```

### 1.8 pull

- origin의 최신 상태를 로컬로 받아오겠다, 갱신하겠다는 의미다.
- 그냥 `git pull`만 해도 연결된 origin의 브랜치를 받아오지만 아래처럼 브랜치를 지정해서 pull할 수도 있다. `origin`이라는 remote의 `feature-D` 브랜치를 pull하겠다는 의미.

```sh
git pull origin feature-D
```

- `git fetch` : 이 명령어는 리모트의 변화를 로컬에다 merge 하지 않는다. 리모트의 변화를 가져오기만 함. pull이 merge까지 자동으로 수행하는 점이 다르다.

### 1.9 .gitignore

- git이 관리할 필요 없는 파일들을 지정해줄 수 있다. 아예 tracking이 안된다.
- 맥에서 `DS_Store`같은 맥 시스템 파일이나 윈도우의 `thumb` 파일, 파이썬을 쓸 때 생기는 `.pyc` 파일들은 필요없다.
- `.gitignore` 파일을 만들어서 내부에 한 줄 한 줄마다 관리하지 않을 파일을 써주면 된다. 파일명을 똑같이 써줘도 되고 만약 `.pyc` 확장자의 모든 파일을 관리하기 싫다면 `*.pyc`처럼 써주면 된다.

## 2. git-flow

참고링크: [danielkummer](http://danielkummer.github.io/git-flow-cheatsheet/index.ko_KR.html)

브랜치를 만들고 merge하는 과정을 일관된 형식과, 편리한 명령어로 만들어놓았다. 여러 사람들끼리 공동작업하는 경우 feature의 이름이 뒤죽박죽일 수도 있고, 브랜치를 어떻게 할지 미리 상의해야하는데 git-flow를 쓰면 편리하게 정해진대로 따라하면 된다.

![chart](http://danielkummer.github.io/git-flow-cheatsheet/img/git-flow-commands.png)

### 2.1 설치 및 초기화

```sh
brew install git-flow-avh # 설치
git flow init # git이 관리하고 있는 폴더에서 입력한다.
```

### 2.2 기능 branch 관리

#### 2.2.1 기능 시작과 마무리

```sh
git flow feature start MYFEATURE    # 기능 개발 시작. MYFEATURE 브랜치를 만들고 checkout
git flow feature finish MYFEATURE   # 기능 개발 마무리. develop 브랜치에 merge하고 MYFEATURE 브랜치는 삭제된다.
```

#### 2.3.2 원격 저장소에 push, pull

```sh
git flow feature publish MYFEATURE  # 기능 remote에 push
git flow feature pull origin MYFEATURE # pull
```

#### 2.3.3 릴리즈하기

```sh
git flow release start RELEASE [BASE]
git flow release publish RELEASE
git flow release finish RELEASE
git push --tags
```

- start: develop 브랜치에서 RELEASE 브랜치를 생성한다. 뒤에 해시코드를 넣어서 develop의 어느 시점에서 브랜치를 생성할지 지정할 수 있다.
- publish: 바로 push해서 다른 개발자들이 remote에서 활용할 수 있도록 하는게 좋다.
- finish: RELEASE 브랜치를 master 브랜치에 병합하고, tag도 지정하고, develop 브랜치에도 합병한 다음 브랜치를 삭제한다.
- `git push --tags` 마지막엔 태그들도 다 push해준다.

### 2.3 HOT FIX

문제가 발생해서 즉각 대응해야할 때. 핫 픽스 브랜치를 통해 관리한다.

```sh
git flow hotfix start VERSION [BASENAME]
git flow hotfix finish VERSION
```

- start: 역시 마지막에 해시를 통해 특정 지점 지정 가능.
- finish: develop, master로 다 병합되고 삭제된다.
