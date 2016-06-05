# Git, GitFLow

## 1. Git

### 1.1 설치

맥은 기본으로 설치되어있고, 윈도우는 [깃헙 데스크탑](https://desktop.github.com/)를 설치한다. GUI 프로그램과 Git Shell 프로그램이 같이 설치된다. 혹은 [Git Bash](https://git-for-windows.github.io/)를 설치해도 좋다.

### 1.2 설정

- commit 했을 때 자동으로 이름, 이메일이 지정되도록 한다.

    ```sh
    git config --global user.name "Gyubin Son"
    git config --global user.email "geubin0414@gmail.com"
    git config --global color.ui auto
    vi ~/.gitconfig
    ```

- ssh 설정
    + 첫 번째 명령어로 ssh key를 생성하고, 둘째 명령어로 파일 내용을 보고 처음부터 이메일 부분 직전까지 복사한다.
    + GitHub 홈페이지에서 **Settings**의 ssh 메뉴에서 새로운 키를 등록한다. 타이틀은 마음대로 해도 되고, 내용 부분에 위에서 복사한 내용을 붙인다.

    ```sh
    ssh-keygen -t rsa -C "geubin0414@gmail.com"
    cat ~/.ssh/id_rsa.pub
    ```

- ssh 잘 됐는지 확인하기.
    + `ssh -T git@github.com` 명령어를 쉘에 입력해서 잘 됐는지 테스트한다.
    + 처음 나오는 항목은 그냥 엔터 치고 넘어가고
    + 두 번째 비밀번호는 입력해준다.
    + successfully 무엇무엇 내용이 나오면 성공.

### 1.3 init, add, commit

- `git init` : 버전 관리할 폴더에 처음에 딱 한 번만 해준다.
- 가장 많이 사용하는 명령어

    ```sh
    git status      # 현재 파일들의 상태를 본다.
    git add file_name   # 특정 파일의 현재 상태를 stage 상태로 만들기.
    git commit -m "commit message"  # 짧은 메시지와 함께 커밋
    ```

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

#### 1.4.2 merge, conflict

- master 브랜치를 항상 안정된 상태(통합 브랜치)로 두고, 작은 기능들을 구현하는 브랜치들을 여럿 만들어서 merge 하는 방식.
- 병합은 마스터에서 브랜치를 병합'하는' 방향이다.

```sh
git checkout master 
git merge --no-ff feature-A # --no-ff 는 이 merge 자체를 커밋으로 남기겠다는 것. 옵션 안주면 commit 없이 머지만 된다.

git log --graph # 시각적으로 git 커밋 기록 보기.
```

- conflict 의미: 특정 파일에서 같은 위치의 코드를 서로 다른 브랜치위에서 편집하면 충돌이 난다. git에서 어느 부분을 선택해야할지 모르기 때문에 선택권을 유저에게 넘긴다.
- `==========` 윗 부분이 마스터의 내용, 아래 부분이 브랜치의 내용이다. git이 충돌난 부분을 알아서 편집하지 않고 다 뭉쳐서 보여준다.
- `--no-ff` 옵션을 줬기 때문에 충돌나서 두 코드가 공존하는 상황이 커밋된 상태다.
- 알아서 편집기를 통해 해당 부분을 적절히 수정한 후 `add`한 후 `commit`하면 된다.

### 1.5 되돌리기

```sh
git reset --hard hash # 지정한 해시의 커밋까지로 복구. 해시는 git log 명령어로 확인할 수 있다.
git reflog # 지웠던 기록까지 다 보여줌. reset 했더라도 Git의 GC(Garbage Collection)가 로그 안 지웠다면. 미래로 복구 역시 reset으로.

# checkout은 항상 그 브랜치의 최신 커밋된 곳으로 돌아감.
만약 충돌이 나면 ===== 윗부분이 현재 마스터, 아랫 부분이 merge하려는 브랜치다.
git merge --no-ff fix-B # 주로 이렇게 합병하고 머지 자체를 남긴다. 그리고 충돌 난거 수정한다음에 "fix conflict"로 다시 커밋.

git commit -am "수정된 부분만 추가해서 커밋하는 것. 빠르게 쓸 떄 좋음."
```

### 1.6 git 기록 뭉개기

- 최신 커밋 시점을 포함해서 2개를 뽑아내서 조작하겠다.
- 메시지 창이 뜰거고, 없애서 기존 커밋에 합칠 놈을 pick 에서 fixup 으로 바꿔준다. 저장하고 끝.

```sh
git rebase -i HEAD~2
```

### 1.7 원격 저장소

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

### 1.8 clone과 브랜치 구분해서 받아오기

#### 1.8.1 clone

```sh
git clone 주소
git branch -a # 로컬에 더불어 리모트의 브랜치들까지 모든 정보 다 보여준다.
# *master
# remotes/origin/HEAD
# remotes/origin/feature-D
# remotes/origin/master
```

#### 1.8.2 브랜치 구분

```sh
git checkout -b feature-D origin/feature-D
# 내 로컬에다가 feature-D라는 브랜치를 만들고 체크아웃하는데 그 원료를 origin의 feature-D로 하겠다는 의미.
git push

## 3. pull
git pull origin feature-D
```

### 1.9 .gitignore
