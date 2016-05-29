# Xcode 시작하기

## 0. 메뉴 및 프로젝트 종류

- playground는 swift 언어 연습장.
- 새 프로젝트 시작하면 선택할 수 있는 템플릿이 존재
    + Master-Detail : 업무용 앱 제작 템플릿. 하나를 선택하면 상세 페이지가 뜨는 형태
    + Page-Based : 책 형태의 앱. 여러장의 페이지를 넘길 수 있는 뷰.
    + Single View : 기본 뷰 하나가 제공. 간단한 기능을 구현해 볼 때 가장 많이 사용.
    + Tabbed : 화면 아래에 탭을 가지는 형태의 뷰
    + Game : 게임 제작

## 1. 프로젝트 생성 옵션

- Organization Identifier는 자기 도메인 역순으로. 앱 구분.
- Device Universal: 아이폰, 아이패드 동시 지원
- Core Data: sqlite 데이터베이스를 사용할건지.
- Unit Tests: 단위 테스트 할건지
- UI Tests: 앱의 UI가 정상적으로 동작하는지 확인

## 2. Panel

- Navigator Panel(좌측): 프로젝트를 구성하는 파일들의 목록
- Debug Area(하단)
    + Variables View: 실행이 멈췄을 때 Heap과 Stack의 오브젝트들을 보여줌
    + Console: 로그 메시지를 보여줌
- Utilities Panel(우측)
    + Navigator Panel의 선택에 따라 달라진다.
    + File Inspector와 Quick Help Inspector는 비교적 덜 중요
    + 스토리보드 파일을 선택하면 나오는 Identity , Attribute , Size, Connections Inspector가 더 중요함
    + 아래쪽에 붙어있는 4개의 라이브러리 패널중 가장 활용도 높은 건 Object Library

## 3. Editor

- Standard Editor: 에디터 영역 전체 사용
- Assistant Editor: 화면을 반으로 갈라서 UI와 코드를 연결할 때 사용
- Version Editor - Git나 Mercurial 같은 소스코드 버전 컨트롤을 할 때 사용.

## 4. 시뮬레이터

왼쪽 상단 재생버튼, 즉 Run 버튼을 누르면 시뮬레이터에서 현재 프로젝트가 열린다.
