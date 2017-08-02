# Anaconda

기존 세팅이랑 충돌나는 것 때문에 잘 쓰진 않지만 워낙 많이 쓰는 프로그램이라 간단한 기초 사용법 정리해둔다.

## 0. 세팅

- https://www.continuum.io/downloads 링크에서 자기 플랫폼에 맞게 설치
- `conda upgrade --all` : 시작할 때 업그레이드 다 해준다.
- 만약 conda command가 없다고 뜨면 자기가 사용하는 shell 설정 파일에 `export PATH="/Users/{username}/anaconda/bin:$PATH"` 를 아래에 추가해준다.

## 1. 주요 명령어

- 터미널에서 `conda list` 해보면 설치된 패키지 볼 수 있음
- 패키지 설치: `conda install package_name`
    + `conda install numpy`
    + `conda install numpy scipy pandas`
    + `conda install numpy=1.10`
- 패키지 삭제: `conda remove package_name`
- 패키지 업뎃: `conda update package_name`
    + `conda update --all`
- 패키지 검색: `conda search search_term`

## 2. 가상환경

- 생성: `conda create -n env_name list of packages`
    + `conda create -n py3 python=3 or conda create -n py2 python=2`
    + `conda create -n py python=3.3`
- 접속: `source activate my_env`
- 해제: `source deactivate`
- 삭제: `conda env remove -n env_name`

## 3. 패키지 공유

- 설치 패키지 공유: `conda env export > environment.yaml`
- yaml 파일로 가상환경 생성: `conda env create -f environment.yaml`
- 만약 conda를 사용하지 않는 사람들을 위해 패키지들을 공유하려면 `freeze` 이용한다. 그 순간의 패키지 리스트들을 출력해준다.
    + 파일 생성: `pip freeze > requirements.txt`
    + 패키지 설치: `pip install -r requirements.txt`

## 4. 팁

- `conda install nb_conda` : jupyter notebook 실행할 때 좀 더 편리한 툴박스 제공한다.
