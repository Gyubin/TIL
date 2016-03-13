# Tkinter: Python GUI Package

참고 링크: [tutorialspoint](http://www.tutorialspoint.com/python/python_gui_programming.htm)

# 0. 시작

- `class Tkinter.Tk(screenName=None, baseName=None, className='Tk', useTk=1)`
- `Tkinter.Tk` 클래스는 toplevel 위젯이다. 앱의 메인 윈도우로 작용한다. 매개변수 없이 아래 코드처럼 인스턴스를 만든다.
- `mainloop()` 함수는 무한 반복을 도는 함수다. 스택오버플로우의 [질답](http://stackoverflow.com/questions/8683217/when-do-i-need-to-call-mainloop-in-a-tkinter-application)에서 흐름을 잘 설명해놓았다. 항상 이벤트를 받고 처리하기 위해 계속 반복을 도는 것이다. 이 함수가 실행되면 윈도우 창이 하나 뜬다.

```py
import Tkinter
top = Tkinter.Tk()
top.mainloop()
```

# 1. Tkinter 요소들

- Widgets
    + `Button` : 말 그대로 버튼.
    + `Canvas` : 선이나 원, 다각형, 사각형 등을 그리는데 사용된다.
    + `Checkbutton` : 체크박스로 옵션을 나타내기 위해 쓰인다. 복수 선택 가능하다.
    + `Entry` : 유저에게 한 줄짜리 문자열을 입력받기 위해 사용한다.
    + `Frame` : 다른 위젯을 담아두는 container 역할을 한다.
    + `Label` : 다른 위젯에 한 줄짜리 caption을 달아준다. image도 담을 수 있다.
    + `Listbox` : 옵션들의 리스트를 사용자에게 제공.
    + `Menubutton` : menu를 보여주는 위젯
    + `Menu` : 사용자가 다양한 명령을 지시할 수 있도록 하는 위젯. Menubutton 위젯 안에 포함된다.
    + `Message` : 사용자가 입력하는 여러 줄의 문자열 공간을 나타낸다.
    + `Radiobutton` : 많은 옵션을 라디오버튼으로 나타내게 한다. 하나만 선택 가능.
    + `Scale` : 슬라이더 위젯을 나타냄
    + `Scrollbar` : Listbox 같은 위젯에 스크롤링을 가능하게 해준다.
    + `Text` : 여러 줄의 텍스트를 보여주는데 사용
    + `Toplevel` : 분리된 윈도우 container를 제공한다.
    + `Spinbox` : Entry 위젯의 변형이다. 고정된 숫자값을 선택해야할 때 사용
    + `PanedWindow` : 수평 또는 수직으로 정렬된 pane을 포함하는 container다.
    + `LabelFrame` : 단순한 container 위젯이다. 복잡한 윈도우 레이아웃에서 간격을 벌리거나 container로서 작용한다.
    + `tkMessageBox` : 메시지 박스를 나타낸다.
- Attributes
    + Dimensions
    + Colors
    + Fonts
    + Anchors
    + Relief styles
    + Bitmaps
    + Cursors
- Geometry Management : 위젯을 부모 위젯 안에서 잘 정돈하기 위해 여러 메소드를 가지고 있다.
    + `pack()` : 부모 위젯에 넣기 전에 위젯들을 하나의 블록에다 담는 것.
    + `grid()` : 그리드 구조로 부모 위젯에 담는다.
    + `place()` : 부모 위젯의 특정 위치에 위치시키는 것.
