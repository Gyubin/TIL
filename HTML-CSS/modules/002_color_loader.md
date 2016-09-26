# #2 Color Blend Loader Animation

참고: Ryan's [codepen](http://codepen.io/rydaly/pen/PGpRzy)

알록달록한 로딩 애니메이션이다.

```html
<div class="vertical-centered-box">
  <div class="content">
    <div class="loader-circle"></div>
    <div class="loader-line-mask one">
      <div class="loader-line"></div>
    </div>
    <div class="loader-line-mask two">
      <div class="loader-line"></div>
    </div>
    <div class="loader-line-mask three">
      <div class="loader-line"></div>
    </div>
    <div class="loader-line-mask four">
      <div class="loader-line"></div>
    </div>
  </div>
</div>
```

```css
@import "lesshat";

@blendmode: hard-light;

@blue: #247BA0;
@green: #77C170;
@red: #F25F5C;
@yellow: #FFE066;
@bgcolor: #2D2D2C;

@timing1: 2s;
@timing2: 1.8s;

body {
  -webkit-font-smoothing: antialiased;
  text-rendering: optimizeLegibility;
  font-family: "proxima-nova-soft", sans-serif;
  -webkit-user-select: none;
  overflow: hidden;
  
  .vertical-centered-box {
    position: absolute;
    .size(100%);
    text-align: center;
    &:after {
      content: '';
      display: inline-block;
      height: 100%;
      vertical-align: middle;
      margin-right: -0.25em;
    }
    .content {
      .box-sizing(border-box);
      display: inline-block;
      vertical-align: middle;
      text-align: left;
      font-size: 0;
    }
  }
}


body {
  background: @bgcolor;
}

.loader-line-mask {
  position: absolute;
  left: 50%;
  top: 50%;
  .size(60,120);
  margin-left: -60px;
  margin-top: -60px;
  overflow: hidden;
  .transform-origin(60px 60px);
  -webkit-mask-image: -webkit-linear-gradient(top, rgba(0,0,0,1), rgba(0,0,0,0));
  mix-blend-mode: @blendmode;
  opacity: 0.8;
  
  .loader-line {
    .size(120);
    border-radius: 50%;
  }
  
  &.one {
    .animation(rotate @timing1 infinite linear);
    .loader-line {
      box-shadow: inset 0 0 0 8px @green;
    }
  }
  
  &.two {
    .animation(rotate @timing2 0.5s infinite linear);
    .loader-line {
      box-shadow: inset 0 0 0 8px @red;
    }
  }
  
  &.three {
    .animation(rotate @timing1 1s infinite linear);
    .loader-line {
      box-shadow: inset 0 0 0 8px @yellow;
    }
  }
  
  &.four {
    .animation(rotate @timing2 1.5s infinite linear);
    .loader-line {
      box-shadow: inset 0 0 0 8px @blue;
    }
  }
}

.keyframes(~'rotate, 0% { transform: rotate(0deg);} 100% { transform: rotate(360deg);}');
.keyframes(~'fade, 0% { opacity: 1;} 50% { opacity: 0.25;}');
.keyframes(~'fade-in, 0% { opacity: 0;} 100% { opacity: 1;}');
```
