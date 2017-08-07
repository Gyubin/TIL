# tmux

터미널에서는 일반적으로 하나의 탭이 곧 하나의 세션이다. 탭을 새로 생성하면 세션이 만들어지고, 탭을 종료하면 세션도 종료된다. 만약 굉장히 오랜 시간 연산을 해야하는 프로그램을 실행한다면 터미널을 계속 열어둬야한다. 24시간이 걸린다면 노트북을 덮지 않고 계속 열어둔 상태로 가지고 다녀야한다. 좀 더 편리하게 터미널을 사용해보자.

## 0. 참고 링크

설치는 `brew install tmux`

- official: https://github.com/tmux/tmux
- shoutcut&cheatsheet: https://gist.github.com/MohamedAlaa/2961058
- tmux course: https://robots.thoughtbot.com/a-tmux-crash-course
- tmux guide: http://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/
- tmux book: https://leanpub.com/the-tao-of-tmux/read#leanpub-auto-styles
- outsider: https://blog.outsider.ne.kr/699#footnote_699_1

## 1. 구조

- 가장 상위에 세션이 존재하고, 하나의 세션엔 연결된 여러 하위 window, pane이 존재
    + window는 말 그대로 하나의 창을 말하고,
    + pane은 윈도우를 여러 창으로 나눴을 때 각각을 말한다.
- 세션을 kill하지 않는 이상 네트워크 접속과 상관없이 세션은 계속 유지된다.
- 유지된 세션을 사용자가 추가 작업할 수 있도록 터미널 화면으로 띄우는 것을 attach라고 하고, 백그라운드로 보내는 것을 detach라고 한다.
- 세션을 완전히 종료하고 싶을 때 kill한다.

## 2. 주요 명령어

### 2.1 command

- 세션 시작
    + `tmux` : 세션 시작. 이름 자동 설정
    + `tmux new -s session_name`
- 기존 세션 띄우기: `tmux attach -t session_name`
- 현재 존재하는 세션 리스팅: `tmux ls`
- 현재 존재하는 세션 지우기: `tmux kill-session -t session_name`

### 2.2 shortcut

- 생성소멸 & 붙이고 떼기
    + `Ctrl-b c` : Create new window
    + `Ctrl-b d` : Detach current client
    + `Ctrl-b l` : Move to previously selected window
    + `Ctrl-b &` : Kill the current window
- 윈도우&pane 이동
    + `Ctrl-b n` : Move to the next window
    + `Ctrl-b p` : Move to the previous window
    + `Ctrl-b o` Switch to the next pane
- 윈도우 수정
    + `Ctrl-b ,` : Rename the current window
    + `Ctrl-b %` : Split the current window into two panes
    + `Ctrl-b q` : Show pane numbers (used to switch between panes)
- 헬프: `Ctrl-b ?`
