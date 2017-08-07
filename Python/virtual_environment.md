# Virtual Environment - 'OS X'

참고링크: [python3 공식문서](https://docs.python.org/3/library/venv.html), [hannal blog](http://blog.hannal.com/2014/8/start_with_django_webframework_02/)

프로젝트마다 사용하는 모듈, 패키지, 파이썬 버전 등이 다를 수 있다. 아직 python3를 지원하지 않는 라이브러리들이 많기 때문에 이런 경우는 꽤 흔하다. A 프로젝트를 개발할 때는 python2를 쓰고, B 프로젝트를 개발할 때는 python3를 쓰는 것은 귀찮은 일이다. 더불어 동일한 환경 내에서 작업을 하면 나중에 앱을 deploy 할 때 A 프로젝트에서 쓰지 않는 모듈들까지 한꺼번에 올려질 수 있고, 알 수 없는 버그가 일어날 수도 있다.

이런 문제를 방지하기 위해 파이썬은 개발환경을 앱 단위로 분리하여 독립적인 상황에서 앱을 만들 수 있게 했다. 이 개발환경을 단순히 복사해서 사용할 수도 있다.

## 0. 필요 상황

- 파이썬 패키지를 설치할 때 관리자 권한이 아니라 유저 권한으로 설치
- 파이썬의 실행 환경을 맥 기본 환경의 것과 온전히 구분해서 깔끔하게 사용
- python3을 실행할 때 그냥 python으로 실행
- 개발환경과 실서버환경을 동일하게 맞춤

## 1. 기본 사용법

### 1.1 pyvenv 사용

python3는 기본으로 `pyvenv`라는 이름으로 가상 환경을 제공한다. 터미널에서 아래처럼 pyenv 명령어와 디렉토리를 정해주면 폴더가 생긴다. 내 경우엔 현재 디렉토리에 test_env라는 디렉토리명으로 가상환경을 만들었다.

```
$ pyvenv ./test_env
```

> 가상환경에서 사용할 수 있는 명령어들은 `pyvenv -h`를 터미널에 입력해보면 알 수 있다. upgrade, clear 등등이 있다.

이후 터미널에서 활성화 코드를 입력하면 왼쪽에 (test_env)가 붙어서 나오는데 가상환경에서 실행중이란 의미다.

```bash
$ source ./test_env/bin/activate  # 활성화
$ deactivate  # 비활성화
```

활성화된 상태에서 pip를 활용해서 여러 모듈들을 설치할 수 있으며 여기서 설치한 것들은 다른 가상환경 혹은 기본 환경에 영향을 미치지 않는다.

### 1.2 Python3 venv 사용

- Python3, pip 사용한다면(맥, 리눅스 기준)
- `python3 -m venv ./env_name` 으로 가상환경 디렉토리 생성하고
- `source ./env_name/bin/activate` 하면 가상환경 접속
- `deactivate` 하면 가상환경 빠져나옴

### 1.3 Anaconda

- `conda create -n env_name lib1 lib2`
- 가상환경 생성하면서 동시에 필요한 라이브러리 설치 가능

## 2. virtualenv wrapper

`virtualenvwrapper`는 virtualenv를 좀 더 쉽게 사용할 수 있도록 해주는 도구다. pip를 활용해서 설치한다.

### 2.1 (실패) python3의 내장 pip 활용

내 맥북엔 기본으로 python2가 깔려있고 python3를 설치파일로 깔아두었다. python3에선 pip가 내장이기 때문에(2.7.9 이상에선 버전2에서도 역시 내장) 바로 사용하면 된다. 사용하는 방식은 다음과 같다.([공식문서](https://docs.python.org/3/installing/))

```bash
# $ python3 -m pip install <package>
# $ python -m pip install <package>==1.0.4    # 특정 버전 지정
# $ python -m pip install 'package>=1.0.4'  # 최소 버전 지정
# $ python -m pip install --upgrade SomePackage  # 업그레이드
$ python3 -m pip install virtualenvwrapper
```

하지만 에러가 발생했다. virtualenvwrapper를 bash를 열 때마다 작동시키기 위해서 '.bashrc' 파일을 수정해야 했는데 그 과정에서 기본 설치된 버전인 python2가 동작하는 것 같다. pip를 python2에서 일반적으로 설치하는 과정으로 다시 설치해본다.

### 2.2 (성공!) pip 수동 설치 후 wrapper 설치

우선 다음 [링크](https://bootstrap.pypa.io/get-pip.py)를 다른이름으로 저장해서 `get-pip.py` 파일을 받는다. 그리고 그 경로에서 파일을 실행한다.

```bash
$ sudo python get-pip.py
```

설치가 되면 이 pip를 활용해서 wrapper를 깔아야하는데 `six-1.4.1`을 uninstall하는 과정에서 에러가 날 것이다.(안 나면 좋다!) 왜냐면 엘 캐피탄에서 기본적으로 six를 설치해두고 있는데 이것을 지우는 것은 보안상 막아놨기 때문이다.([참조](https://github.com/pypa/pip/issues/3165)) 예의 그 루트리스 때문인 것 같다. 그래서 이상적인 해결책은 이 삭제 과정을 skip하는 것이다. 다음처럼 실행한다.

```bash
# $ sudo pip install virtualenvwrapper 이건 에러난다.
$ sudo pip install virtualenvwrapper --ignore-installed six
```

그러면 에러가 없이 정상적으로 설치가 된다!(아자!!!)

### 2.3 마무리하기 bash 설정

- virtualenv로 만드는 가상환경이 저장될 공간 설정(WORKON_HOME)
- project 소스 파일이 저장될 공간 설정(PROJECT_HOME)
- 가상환경 파이썬 기본 버전 설정

```bash
$ mkdir ~/.virtualenvs
```

위 코드를 터미널에 입력해서 숨김 폴더를 만든다. 그 후 각자가 쓰는 쉘의 rc 파일에 다음 코드를 추가해준다.(bash라면 `.bashrc` 혹은 `.bash_profile`이고 zsh라면 `.zshrc` 파일이다) 이 파일은 홈 디렉토리에 있다.

```bash
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Documents/dev/test_project
export VIRTUALENV_PYTHON=/usr/local/bin/python3
```

위 경로를 파일에 입력했다면 입력한 파일에 맞게 다음 두 코드 중 하나를 터미널에서 실행한다.

```bash
$ source ~/.bashrc
$ source ~/.bash_profile
```

그러면 이후 `echo $WORKON_HOME` 명령어를 실행했을 때 경로에 맞는 결과가 출력될 것이다. 마지막으로 다시 `.bashrc` 파일을 열고 다음 코드를 추가 입력해준다. bash를 시작할 때마다 다음 shell 스크립트를 실행하도록 하는 코드다.

```bash
source /usr/local/bin/virtualenvwrapper.sh
```

대부분 위 경로에 `virtualenvwrapper.sh` 파일이 있을 것이다. 입력한 후에 다음 명령어를 입력하면 create 했다는 코드들이 주르륵 뜰 것이고 터미널에 `workon`을 입력했을 때 아무런 반응이 없다면 완료된 것이다.

```bash
$ source ~/.bashrc
```

### 2.4 사용하기

- `workon` : 현재 `~/.virtualenvs` 디렉토리에 있는 가상환경 목록을 출력해준다.
- `workon envname` : 가상환경을 activate하는 명령어다.
- `mkvirtualenv envname` : 가상환경을 만드는 명령어
- `mkvirtualenv --python=/usr/local/bin/python3 envname` : `which python3`를 했을 때 나오는 경로를 가지고 가상환경의 파이썬 버전을 지정해줬다. python3 기반의 가상환경을 만들어준다. `which python`을 했을 때 나오는 파이썬 버전2도 이용 가능하다.
- `deactivate` : 가상환경 비활성화
- `rmvirtualenv envname` : 가상환경 삭제
- `mkproject name` : 설정한 이름으로 가상환경과 프로젝트 폴더가 생성된다. 프로젝트 폴더의 경로는 위에서 정했던 `$PROJECT_HOME` 디렉토리다.
