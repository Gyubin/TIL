# flex 정렬

## 1. 양 끝에 붙이기

참고링크: http://stackoverflow.com/questions/10272605/align-two-inline-blocks-left-and-right-on-same-line

### 1.1 flex 사용

```html
<!-- html -->
<div class="header">
  <h1>Title</h1>
  <div class="nav">
    <a>A Link</a>
    <a>Another Link</a>
    <a>A Third Link</a>
  </div>
</div>
```

```css
/* css */
.header {
  background: #ccc; 
  display: flex;
  justify-content: space-between;
}
```

- `display:flex` 를 활용한 예인데 IE는 버전 10부터 지원한다.

### 1.2 IE7 이상 적용하기

```html
<!-- html -->
<div class="header">
  <h1>Title</h1>
  <div class="nav">
    <a>A Link</a>
    <a>Another Link</a>
    <a>A Third Link</a>
  </div>
</div>
```

```css
/* css */
.header {
  background: #ccc;
  text-align: justify;

  /* IE special */
  width: 100%;
  -ms-text-justify: distribute-all-lines;
  text-justify: distribute-all-lines;
}

.header:after {
  content: '';
  display: inline-block;
  width: 100%;
  height: 0;
  font-size:0;
  line-height:0;
}

h1 {
  display: inline-block;
  margin-top: 0.321em;

  /* ie 7*/ 
  *display: inline;
  *zoom: 1;
  *text-align: left;
}

.nav {
  display: inline-block;
  vertical-align: baseline;
  
  /* ie 7*/
  *display: inline;
  *zoom:1;
  *text-align: right;
}
```

- `text-align: justify` 활용
