# git

다른 사람 가르쳐줄 때 제일 기본적인 것만 정리

## 1. git 쓰기에 앞서 Command-line 명령어

- `cd my_directory`
    + change directory의 약자
    + cd 다음에 경로를 입력해주면 그 폴더로 이동됩니다.
    + `cd ..`을 하면 상위 디렉토리로 가는 의미이고
    + `cd a/b/c` 형태로 a 폴더 내의 b 폴더 내의 c 폴더로 한 번에 이동할 수 있습니다.
    + 경로는 tab을 눌렀을 때 자동완성 되니까 앞의 한 두 글자 쳐 놓고 자동완성하면 편리합니다.
- `pwd` : 현재 디렉토리가 어딘지 출력
- `ls` : 현재 디렉토리의 파일들을 출력
    + `ls -al` : 숨김 폴더도 출력해줍니다. 예를 들어 맥에서는 폴더명 앞에 `.`이 붙으면 숨김폴더인데 이것도 출력해줍니다.
- `mkdir hi` : hi 란 이름으로 디렉토리 생성합니다.

## 2. 우리가 쓸 git 명령어

### 1.1 처음 한 번만 하면 될 것들

- 이름, 이메일 설정

    ```sh
    git config --global user.name "Gyubin Son"
    git config --global user.email "geubin0414@gmail.com"
    ```

- `git init` : git으로 폴더 초기화
    + 아래 코드는 순서대로 디렉토리를 만들고
    + 그 디렉토리로 들어가서
    + 들어간 폴더를 git init, 즉 이 폴더 하위의 모든 내용을 git으로 관리하겠다라고 선언하는 것
    + `ls -al` 해보면 `.git` 이라는 폴더가 생깁니다.

    ```sh
    mkdir sample_repo
    cd sample_repo
    git init
    ```

### 1.2 반복해서 사용할 것들

- `git status` : 현재 폴더에서 어떤 파일이 바뀌었는지, 어떤 파일이 새로 생겼는지 등등의 상태를 한 번에 볼 수 있습니다.
- `git log` : commit 기록들을 한 번에 쭉 볼 수 있어요
- `git add file_name` : git add 뒤에 파일명을 입력해서 stage 단계로 이동시킵니다. stage 단계에 있는 파일들만 commit 할 수 있어요.
- `git commit -m "Message about this commit."`
    + 변경사항에 대한 기록을 commit이라고 하고
    + commit은 항상 어떤 커밋인지에 대한 60자 정도의 짧은 메시지를 가져요.
    + 저 메시지가 없으면 커밋이 되지 않습니다.
- `git clone https://github.com/some-repository.git`
    + GitHub에 있는 좋은 소스코드들을 편하게 다운받을 수 있는 명령어
- `git push`
    + 내가 한 commit을 업로드하는 것(파일을 업로드하는게 아니에요). 변경 이력을 업로드하는 것입니다.
    + 변경 이력이 쌓이는 형태가 git이기 때문에 편하게 버전관리를 할 수 있는 것입니다.
    + 우리는 GitHub에서 clone하는 것부터 시작했기 떄문에 "어디로" 업로드할지는 이미 정해져있어요. 그냥 git push 하면 됩니다.
- `git pull`
    + push와 반대로 업로드가 아니라 변경이력을 다운로드 하는 명령어입니다.
    + 우리는 Sample_repo라는 repository를 공동으로 관리할 거라서 이 명령어가 꼭 필요합니다.
    + 하나의 통합된 변경이력을 모든 개발자가 공유하는 것이므로 -> 내가 새로운 commit 기록을 쌓는다면 다른 사람의 기록 "위에" 쌓아야합니다.
    + 그래서 commit 하기 전에 다른 사람이 먼저 commit해둔 기록이 GitHub에 업로드되어있다면 먼저 `pull`로 다운을 받아야하는겁니다.
    + 원래 이 pull 명령어에서 가장 많은 conflict들이 나타나는데 우리는 같은 파일을 편집하진 않을테니 그냥 편하게 쓰시면 됩니다.

### 1.3 Flow 정리

**git pull -> 내 코드 파일 작업 -> git pull -> git add -> git commit -> git push**

- `git pull` : git pull은 자주 해줄수록 좋습니다. 다른 사람 업로드한거를 그냥 받아오는 것 뿐이니 편하게 자주자주 실행해주세요.
- 열심히 코딩합니다.
- `git pull` : 내가 코딩을 마쳤다면 다시 한 번 git pull 해주세요. 혹시 그 사이에 누가 git push를 했을 수도 있으니까요.
- `git add mycode.py` : 내가 작업한 파일을 stage 상태로
- `git commit -m "My new work"` : 기록을 추가하고
- `git push` : 업로드합니다.

위 명령어들만 계속 반복하면 됩니다. 자연스럽게 외워질거예요.

## 2. 공동 repository 관리

### 2.1 할 일들

- [Sample](https://github.com/Gyubin) 여기에다가 모두 같이 작업할겁니다.
- 폴더별로 문제를 정할거고, 각자 코드 파일을 만들어서 올리시면 됩니다.
- 예를 들어 SumArray 문제라면 `SumArray_Gyubin.py` 처럼 자기 이름을 뒤에 붙여서 구분해서 올려주세요.
- 매일 매우 간단한 문제들을 풀면서 Git과 Python에 익숙해지는게 목표입니다.

### 2.2 기본 세팅

- 원하는 디렉토리로 들어가세요.
    + `cd ~/Desktop` 혹은 `cd ~/Documents` 처럼 하면 바탕화면 혹은 내 문서로 갈 수 있을거예요.
    + 위에서 물결표는 home directory를 의미합니다. 윈도우라면 C의 Users의 내 유저이름의 폴더를 의미하고, 맥도 비슷하게 `/Users/gyubin` 같은 경로를 갖습니다.
- `git clone https://github.com/Gyubin/Sample-repo.git`
    + 우리 repository를 clone 합니다.
    + 그대로 복붙하면 됩니다.
- `cd Sample-repo` : clone이 끝나면 Sample-repo 이름으로 폴더가 만들어져있을거예요. 그리로 들어갑니다.
- 이제 이 폴더를 각자의 에디터로 여세요. 그리고 코딩하면 됩니다.
- 자기 코드 파일이 완성됐으면 위의 **Flow**를 따르면 됩니다.
