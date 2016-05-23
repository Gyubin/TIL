# Peeky Placeholder

참고: [Luke Reid](http://codepen.io/lukeandrewreid/pen/OVPGXN)

살짝 들여다보는 placeholder 라는 의미인 것 같다. 일반적으로 placeholder는 텍스트를 입력하는 동시에 사라지는데 계속 보이게 하는 트릭이다. 실제로 내가 지금 입력하는 input 박스가 id인지 email인지 헷갈릴 때가 많다.

## html

- form 안에 두 개의 label을 넣고 각각 안에 input 태그와 span 태그를 child로 둔다. label 안에 input을 넣는 것도, 두 개 이상 태그를 넣는 것도 처음 봤다.
- 여기서 label 안의 span의 역할은 텍스트를 입력해도 남아있는 placeholder와 같은 텍스트가 그대로 남아있기 하기 위함이다.

```html
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>peeky placeholder</title>
  <link rel="stylesheet" href="style.css" type="text/css">
</head>
<body>
  <p>by <a href="http://codepen.io/lukeandrewreid/pen/OVPGXN">Luke Reid</a> in codepen</p>
  <h1>placeholder example</h1>
  <form action="POST">
    <label>
      <input type="text" id="fname" placeholder="Name">
      <span>Name</span>
    </label>

    <label>
      <input type="email" placeholder="Email">
      <span>Email</span>
    </label>

    <input type="submit" value="Send">
  </form>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="script.js"></script>
</body>
</html>
```

## css

- 참고 링크를 보면 CSS가 SASS 형태로 되어있다. 아직 SASS를 몰라서 하나 하나 감으로 CSS 형태로 바꿨는데 그러면서 SASS 정말 좋구나 느꼈다. 스타일 안에 스타일을 설정할 수 있게 해서 중복을 획기적으로 줄였다.
- 아래 CSS의 핵심은 input 박스 윗부분에 `opacity`를 0으로 줘서 span을 작게 숨기는 것이고 input field가 focus 되거나, 글자가 입력되면 opcity를 1로 바꿔서 텍스트를 보이게 하는 것이다.
- 위에 span이 보여지면 input 박스에 결국 두 개의 텍스트가 존재하게 되므로 위치 조정이 필요하다. 역시 focus되거나 글자가 있으면 패딩값이 조절돼서 입력 글자가 살짝 아래로 내려간다. 디테일이다.

```css
body {
  background: #35dc9b;
}

h1 {
  display: table;
  margin: 40px auto;
  color: #fff;
  font: 20px Helvetica;
  text-transform: uppercase;
  letter-spacing: 3px;
}

form {
  display: table;
  margin: 40px auto;
}

form label {
  position: relative;
  display: block;
}

form label input {
  font: 18px Helvetica, Arial, sans-serif;
  box-sizing: border-box;
  display: block;
  border: none;
  padding: 20px;
  width: 300px;
  margin-bottom: 20px;
  font-size: 18px;
  outline: none;
  transition: all 0.2s ease-in-out;
}

form label input::-webkit-input-placeholder {
  transition: all 0.2s ease-in-out;
  color: #999;
  font: 18px Helvetica, Arial, sans-serif;
}

form label input:focus, form label input.populated {
  padding-top: 28px;
  padding-bottom: 12px;
}

form label input:focus::-webkit-input-placeholder, form label input.populated::-webkit-input-placeholder {
  color: transparent;
}

form label input:focus + span, form label input.populated + span {
  opacity: 1;
  top: 10px;
}

form label span {
  color: #35dc9b;
  font: 13px Helvetica, Arial, sans-serif;
  position: absolute;
  top: 0px;
  left: 20px;
  opacity: 0;
  transition: all 0.2s ease-in-out;
}

form input[type="submit"] {
  transition: all 0.2s ease-in-out;
  font: 18px Helvetica, Arial, sans-serif;
  border: none;
  background: #1aaf75;
  color: #fff;
  padding: 16px 40px;
}

form input[type="submit"]:hover {
  background: #109f67;
}
```

## js

- jQuery를 이용했다. 두 가지의 함수가 존재한다.
- 첫째로 input 태그를 잡아와서 만약 변화가 있으면 함수를 실행한다. 함수는 그 선택된 input 박스의 value의 길이를 기준으로 뭔가가 있으면 populated라는 클래스 속성을 추가하고, 없으면 제거하는 기능을 한다.
- 둘째로 setTimeout(func) 함수다. 트리거가 되는 것이 없다. 페이지가 띄워지면 바로 실행되는데 0.5초 이후에 실행된다. id가 fname인 것을 잡아서 focus 시킨다. 실제로 페이지를 띄우면 잠시 있다가 자동으로 커서가 이름 input field로 이동하는 것을 볼 수 있다.

```js
$(function() {
  $('input').on('change', function() {
    var input = $(this);
    if (input.val().length) {
      input.addClass('populated');
    } else {
      input.removeClass('populated');
    }
  });

  setTimeout(function() {
    $('#fname').trigger('focus');
  }, 500);
});
```
