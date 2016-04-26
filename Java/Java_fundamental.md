# Java 기초 정리

참고 링크: [Wikidocs](https://wikidocs.net/191)

## 0. 설치

- JDK 설치: [다운로드 페이지](http://www.oracle.com/technetwork/java/javase/downloads/index.html)로 들어가서 `Java Platform (JDK)`를 설치하면 된다. 현재 기준으로 최신 버전은 '8u91 / 8u92'였다.

## 1. 기본

![structure](http://wikidocs.net/images/page/257/jdk.jpg)

- JVM: 자바 가상 머신(Java Virtual Machine)
    + `javac` 명령어로 생성되는 `.class` 파일을 실행할 수 있다.
    + 플랫폼 의존적(윈도우 JVM != 리눅스 JVM)이다.
    + `.class` 파일은 어떤 JVM에서도 동일하게 동작한다.
    + 바이너리 코드를 읽고, 검증하고, 실행하는 역할을 한다.
    + JRE(Java Runtime Environment)의 규격, 즉 필요한 라이브러리와 파일들의 규격을 제공.
- JRE: 자바 실행환경(Java Runtime Environment)
    + JVM이 자바로 된 앱을 동작시킬 때 필요한 라이브러리와 기타 파일들 보유.
    + JRE는 JVM의 실행환경, 규격을 구현한 것.

![java_compiler](http://wikidocs.net/images/page/256/compile.png)

- `javac`, `java`: 
