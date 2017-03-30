# Kaldi asr

음성인식 오픈소스 라이브러리

## 0. 설치

설치 참고 링크: [jrmeyer](http://jrmeyer.github.io/kaldi/2016/01/26/Installing-Kaldi.html)

- `git clone https://github.com/kaldi-asr/kaldi.git` : GitHub 저장소에서 소스 파일을 클론해온다.
- 루트 디렉토리에 `INSTALL`이라는 파일이 있을 것이고 설치하는 방법이 적혀있다.
    + `tools/` 디렉토리에서 INSTALL 따라하기
    + `src/` 디렉토리에서 INSTALL 따라하기

### 0.1 tools INSTALL

- `cd tools` 해당 디렉토리로 들어가서
- `extras/check_dependencies.sh` : prerequisites가 갖춰져있는지 확인하는 스크립트 파일 실행한다. 없다고 뜨면 설치하기
- `sysctl -n hw.ncpu` 명령어로 내 CPU 프로세서가 몇 개인지 확인하고
- `make -j 8` : 프로세서가 8개면 이렇게 명령어를 입력하면 된다.
- 아마 다음과 같은 warning이 뜰 것이다. [IRSTLM](http://hlt-mt.fbk.eu/technologies/irstlm)은 language modeling toolkit이다.

    ```sh
    Warning: IRSTLM is not installed by default anymore. If you need IRSTLM
    Warning: use the script extras/install_irstlm.sh
    ```

- `extras/install_irstlm.sh` : IRSTLM 설치 스크립트 실행. 설치가 끝나면 `/usr/local`에서 확인할 수 있다.

### 0.2 src INSTALL

- `cd ../src/` : tools 디렉토리에서 빠져나가 src로 들어간다.
- `./configure` : 설정 스크립트 실행
- `make depend -j 8` : 의존성 설치
- `make -j 8` : 마지막 설치하면 끝
 







