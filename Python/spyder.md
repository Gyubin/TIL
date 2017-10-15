# Spyder 에디터

아나콘다 없이 스파이더 에디터 사용하기

- 먼저 가상환경 활성화한다. 데이터 분석할 때 사용할 가상환경에 다 설치해두면 좋을 것 같다.
- `pip install PyQt5 spyder` : PyQt로 실행되기 때문에 Spyder와 함께 설치해준다.
- 나는 virtualenvwrapper를 쓰고 있고, `~/.virtualenvs` 디렉토리 안에 있는 가상환경 디렉토리의 `bin` 폴더에 들어가보면 `spyder3` 실행파일이 있을 것
- `./sypder3`으로 실행하면 jupyter처럼 실행된다.

---

편하게 실행하려면 `~/.zshrc` 파일에서 alias를 다음처럼 지정해준다. `data`라는 가상환경을 활성화하고 spyder를 실행하는 alias 설정이다.

```sh
alias sypder="workon data && ~/.virtualenvs/data/bin/spyder3"
```
