# Virtual Environment - 'OS X'

참고링크: [python3 공식문서](https://docs.python.org/3/library/venv.html), [hannal blog](http://blog.hannal.com/2014/8/start_with_django_webframework_02/)

## 1. 기본

### 1.1 사용 이유

프로젝트마다 사용하는 모듈, 패키지, 파이썬 버전 등이 다를 수 있다. 아직 python3를 지원하지 않는 라이브러리들이 많기 때문에 이런 경우는 꽤 흔하다. A 프로젝트를 개발할 때는 python2를 쓰고, B 프로젝트를 개발할 때는 python3를 쓰는 것은 귀찮은 일이다. 더불어 동일한 환경 내에서 작업을 하면 나중에 앱을 deploy 할 때 A 프로젝트에서 쓰지 않는 모듈들까지 한꺼번에 올려질 수 있고, 알 수 없는 버그가 일어날 수도 있다.

이런 문제를 방지하기 위해 파이썬은 개발환경을 앱 단위로 분리하여 독립적인 상황에서 앱을 만들 수 있게 했다. 이 개발환경을 단순히 복사해서 사용할 수도 있다.

### 1.2 가능한 것들

- 파이썬 패키지를 설치할 때 관리자 권한이 아니라 유저 권한으로 설치 가능
- 파이썬의 실행 환경을 맥 기본 환경의 상태와 온전히 구분해서 깔끔하게 사용 가능
- 버전 3으로 만들면 Python REPL 실행할 때 그냥 `python` 명령으로 실행 가능(`python3` 해도 똑같은 결과)
- 개발환경과 실서버환경을 동일하게 맞출 수 있음

### 1.3 사용 방법 종류

[스포카 테크 블로그](https://spoqa.github.io/2017/10/06/python-env-managers.html)에서 종류별로 잘 설명해놨으니 훑어보길 권장.

이번 글에선 다음 3가지 방법을 정리했다.

- `python3 -m venv 가상환경명` : 버전 3 전용으로 가상환경 설정. 가장 단순.
- Anaconda에서 사용하는 명령어 : Anaconda를 사용한다면 이렇게.
- **virtualenvwrapper 사용(추천)**

> `pyvenv 가상환경명` 형태로 python3 가상환경을 설정할 수도 있는데 이름이 `pyenv`와 비슷해서 deprecated 되었다. 쓰지 않는걸로.

## 2. Python3 venv 사용

- `python3 -m venv ./env_name` : 가상환경 생성. 뒤 env_name 부분을 원하는 이름으로 바꾼다.
- `source ./env_name/bin/activate` : 가상환경 활성화
- `deactivate` : 가상환경 비활성화

## 3. Anaconda

- `conda create -n env_name lib1 lib2`
- 가상환경 생성하면서 동시에 필요한 라이브러리 설치 가능

## 4. virtualenvwrapper(추천)

python3 venv를 사용하는 방법은 해당 가상환경 디렉토리에 항상 접근해서 activate해주는 작업이 필요하다. 가상환경이 여러개 많아지면 각각의 위치를 기억하기도 힘들다. 이런 작업을 좀 더 쉽게 하도록 도와주는 툴이 `virtualenvwrapper`다.

### 4.1 기본 설치

- Python3을 homebrew로 설치한다.
    + homebrew 설치 명령어: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
    + Python 3 설치 명령어: `brew install python3`
- pip 설치(버전 2 전용 패키지 매니저)
    + 다음 [링크](https://bootstrap.pypa.io/get-pip.py)를 **다른이름으로 저장**해서 `get-pip.py` 파일을 다운로드
    + 실행: `sudo python get-pip.py`

> 그냥 pip는 Python2의 패키지 매니저, pip3는 Python3의 패키지 매니저이다. pip3는 Python3에 포함되어있어서 따로 설치할 필요 없다.

- virtualenvwrapper 설치(둘 모두 설치해야함)

    ```sh
    sudo pip install virtualenvwrapper --ignore-installed six
    sudo pip3 install virtualenvwrapper
    ```

> pip를 활용한 커맨드에서 six를 제외하는 이유: 설치 커맨드에서 `six-1.4.1`을 삭제하는 부분이 포함돼있다. 그런데 OSX에서 설치된 six를 삭제하는 것을 보안 상 막아뒀다. 그래서 skip하면 된다.([참조](https://github.com/pypa/pip/issues/3165))

### 4.2 shell 설정

#### 4.2.1 저장 디렉토리 생성

```bash
$ mkdir ~/.virtualenvs
```

- 먼저 위 명령어로 가상환경들이 저장될 디렉토리를 생성한다.
- 모든 가상공간 디렉토리들이 이 디렉토리에 저장된다. 한 곳에 모아둬서 관리 및 사용이 쉽다.

#### 4.2.2 shell 파일 편집

```bash
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENV_PYTHON=/usr/local/bin/python3

source /usr/local/bin/virtualenvwrapper.sh
```

- 위 코드를 shell 설정 파일에 복붙한다. 따로 설정을 한 적이 없다면 기본적으로 bash shell을 이용하고 있을 것이므로 `~/.bashrc` 파일을 편집한다. 만약 ZSH을 따로 설치해서 사용 중이라면 `~/.zshrc` 파일을 편집한다.
- `WORKON_HOME` : 가상환경 저장 디렉토리의 path를 의미한다.
- `VIRTUALENV_PYTHON` : 가상환경 파이썬 기본 버전을 설정해줄 수 있다. 거의 3을 쓰기 때문에 위처럼 적으면 된다. 혹시 모르니 `which python3` 명령어를 입력해서 위 path와 같은지 확인해보고 다르면 바꾸자.

위 shell 파일 편집을 완료했으면 터미널을 껐다 켜거나, shell 파일을 한 번 실행해준다(`source ~/.bashrc` or `source ~/.zshrc`)

### 4.3 사용하기

- `workon` : 현재 `~/.virtualenvs` 디렉토리에 있는 가상환경 목록을 출력해준다. 없으면 아무 출력도 없을 것.
- `workon envname` : 가상환경을 activate하는 명령어다.
- `mkvirtualenv envname` : 가상환경을 만드는 명령어
- `mkvirtualenv --python=/usr/local/bin/python3 envname` : `which python3`를 했을 때 나오는 경로를 가지고 가상환경의 파이썬 버전을 지정해줬다. python3 기반의 가상환경을 만들어준다. `which python`을 했을 때 나오는 파이썬 버전2도 이용 가능하다.
- `deactivate` : 가상환경 비활성화
- `rmvirtualenv envname` : 가상환경 삭제
