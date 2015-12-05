# Virtual Environment - 'OS X'

참고링크: [python3 공식문서](https://docs.python.org/3/library/venv.html), [hannal blog](http://blog.hannal.com/2014/8/start_with_django_webframework_02/)

프로젝트마다 사용하는 모듈, 패키지, 파이썬 버전 등이 다를 수 있다. 아직 python3를 지원하지 않는 라이브러리들이 많기 때문에 이런 경우는 꽤 흔하다. A 프로젝트를 개발할 때는 python2를 쓰고, B 프로젝트를 개발할 때는 python3를 쓰는 것은 귀찮은 일이다. 더불어 동일한 환경 내에서 작업을 하면 나중에 앱을 deploy 할 때 A 프로젝트에서 쓰지 않는 모듈들까지 한꺼번에 올려질 수 있고, 알 수 없는 버그가 일어날 수도 있다.

이런 문제를 방지하기 위해 파이썬은 개발환경을 앱 단위로 분리하여 독립적인 상황에서 앱을 만들 수 있게 했다. 이 개발환경을 단순히 복사해서 사용할 수도 있다.

## 필요 상황

- 파이썬 패키지를 설치할 때 관리자 권한이 아니라 유저 권한으로 설치
- 파이썬의 실행 환경을 맥 기본 환경의 것과 온전히 구분해서 깔끔하게 사용
- python3을 실행할 때 그냥 python으로 실행
- 개발환경과 실서버환경을 동일하게 맞춤

## 사용법

python3는 기본으로 `pyvenv`라는 이름으로 가상 환경을 제공한다. 터미널에서 아래처럼 pyenv 명령어와 디렉토리를 정해주면 폴더가 생긴다. 내 경우엔 현재 디렉토리에 test_env라는 디렉토리명으로 가상환경을 만들었다.

```
pyvenv ./test_env
```

> 가상환경에서 사용할 수 있는 명령얻르은 `pyvenv -h`를 터미널에 입력해보면 알 수 있다. upgrade, clear 등등이 있다.

이후 터미널에서 활성화 코드를 입력하면 왼쪽에 (test_env)가 붙어서 나오는데 가상환경에서 실행중이란 의미다.

```bash
source ./test_env/bin/activate  # 활성화
deactivate  # 비활성화
```

활성화된 상태에서 pip를 활용해서 여러 모듈들을 설치할 수 있으며 여기서 설치한 것들은 다른 가상환경 혹은 기본 환경에 영향을 미치지 않는다.

## virtualenv wrapper

`virtualenvwrapper`는 virtualenv를 좀 더 쉽게 사용할 수 있도록 해주는 도구다. pip를 활용해서 설치한다.

내 맥북엔 기본으로 python2가 깔려있고 python3를 설치파일로 깔아두었다. python3에선 pip가 내장이기 때문에(2.7.9 이상에선 버전2에서도 역시 내장) 바로 사용하면 된다. 사용하는 방식은 다음과 같다.([공식문서](https://docs.python.org/3/installing/))

```bash
# python3 -m pip install <package>
# python -m pip install <package>==1.0.4    # 특정 버전 지정
# python -m pip install 'package>=1.0.4'  # 최소 버전 지정
# python -m pip install --upgrade SomePackage  # 업그레이드
python3 -m pip install virtualenvwrapper
```

하지만 에러가 발생했다. virtualenvwrapper를 bash를 열 때마다 작동시키기 위해서 '.bashrc' 파일을 수정해야 했는데 그 과정에서 기본 설치된 버전인 python2가 동작하는 것 같다. pip를 python2에서 일반적으로 설치하는 과정으로 다시 설치해본다.
