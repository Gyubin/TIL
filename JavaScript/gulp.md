# Gulp

프로젝트를 dev, production, testing 등등 여러가지로 빌드 가능. `make`와 비슷하다.

## 0. 설치

- `npm init -y` : 프로젝트 npm 초기화. y 플래그는 옵션을 모두 디폴트로.
- `npm install gulp -g` : 글로벌 옵션으로 설치
- `npm install gulp --save-dev` : 개발용으로 프로젝트 내부에 설치. 글로벌이 있는데도 불구하고 설치하는 이유는 이것을 필요로하는 플러그인들이 있기 때문.
- `npm install gulp-[plugin name] --save-dev` : 플러그인 설치
- `npm install gulp-cli -g` : gulp cli 설치

## 2. 폴더 구조

```
node_modules/
public/
    src/
        index.html
        img/
        js/
        scss/
    dist/
        index.html
        img/
        js/
        css/
    lib/
        vanilla.js
        fancybox.js
gulpfile.js
package.json
```

- 프로젝트 루트 디렉토리엔 `node_modules`, `public`, `gulpfile.js`, `package.json` 파일만 있다.
- `public` 폴더 안에 소스가 있는데
    + `src`는 실제 작업하는 곳
    + `dist`는 Gulp로 인해 만들어지는 파일들이 위치하는 곳
    + `lib` 폴더는 외부 라이브러리 파일을 위치시키는 곳이다.

## 3. gulpfile.js

### 3.1 task

```js
var gulp = require('gulp');
var concat = require('gulp-concat');

//...

gulp.task('combine-js', ['lint-js'], function () {
    return gulp.src('/public/js/**/*.js')
    .pipe(concat('all.js'))
    .pipe(gulp.dest('public/dist/js'));
});

//... 

gulp.task('default', ['combine-js']);
```

- `gulp`, `gulp-concat`을 로드한다. 미리 --save-dev 플래그로 설치한 것들이다.
- `gulp.task(name, deps, func)` : task의 기본 형태다.
    + `name`: task의 이름
    + `deps`: dependency를 의미. 해당 task 수행 전에 먼저 실행되어야 하는 것. 위의 예제에선 `lint-js`라는 이름을 가진 task를 먼저 실행하게 되어있음. 만약 선행되어야할 것이 없다면 그냥 비워두면 된다. 즉 task의 매개변수로 이름과 함수만 넣어주면 된다.
    + `func`: 실제 수행할 내용들.

### 3.2 src

```js
gulp.src([
    'public/src/js/loginForm.js'
    'public/src/js/slider/*.js'
    '!public/src/js/slider/slider-beta.js'
    ] ...);
```

- `gulp.src(files)` : files 부분에 파일명이 문자열이나 배열로 오면 된다.
- 작업할 파일을 로드하는 것에 쓰인다.
- 3.1 예에서는 `*` 와일드카드를 사용한 것을 볼 수 있다. 가능하다.
- 위 3.2 예에서 `!`를 맨 앞에다 쓴 것은 해당 파일을 포함하지 않겠다는 의미. 윗 줄에서 `*` 와일드카드를 쓴 것을 볼 수 있는데 그래서 쓴 것이다.

### 3.3 pipe

```js
gulp.src('public/src/js/*.js')
    .pipe(stripDebug())
    .pipe(uglify())
    .pipe(concat('script.js'))
    .pipe(gulp.dest('public/dist/js'));
```

- 원하는 작업을 쭉 이어서 할 때 유용하다.
- 위 예제는 `src` 함수로 가져온 파일들을
    + `stripDebug`: 모든 alert, console.log들을 지우고
    + `uglify`: 압축하고
    + `concat`: script.js라는 이름으로 한 파일로 병합한다.
    + `gulp.dest`: 병합된 파일을 해당 path에 위치시키는 것.

### 3.4 default

- `gulp.task('default', [task1, task2, ...])`
- 커맨드라인에서 `gulp`라고 쳤을 때 실행되는 task를 설정하는 것.
- 특정 task 실행하려면 `gulp taskname` 처럼 입력하면 된다.

### 3.5 watch

- `gulp.watch(folder, [actions])`
- 특정 디렉토리를 계속 보고 있다가 변화가 감지되면 해당 task를 실행하는 것.

## 4. 예제

```js
var gulp = require('gulp');
var webserver = require('gulp-webserver');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var minifyhtml = require('gulp-minify-html');
var sass = require('gulp-sass');
var livereload = require('gulp-livereload');

var src = 'public/src';
var dist = 'public/dist';

var paths = {
    js: src + '/js/*.js',
    scss: src + '/scss/*.scss',
    html: src + '/**/*.html'
};

// 웹서버를 localhost:8000 로 실행한다.
gulp.task('server', function () {
    return gulp.src(dist + '/')
        .pipe(webserver());
});

// 자바스크립트 파일을 하나로 합치고 압축한다.
gulp.task('combine-js', function () {
    return gulp.src(paths.js)
        .pipe(concat('script.js'))
        .pipe(uglify())
        .pipe(gulp.dest(dist + '/js'));
});

// sass 파일을 css 로 컴파일한다.
gulp.task('compile-sass', function () {
    return gulp.src(paths.scss)
        .pipe(sass())
        .pipe(gulp.dest(dist + '/css'));
});

// HTML 파일을 압축한다.
gulp.task('compress-html', function () {
    return gulp.src(paths.html)
        .pipe(minifyhtml())
        .pipe(gulp.dest(dist + '/'));
});

// 파일 변경 감지 및 브라우저 재시작
gulp.task('watch', function () {
    livereload.listen();
    gulp.watch(paths.js, ['combine-js']);
    gulp.watch(paths.scss, ['compile-sass']);
    gulp.watch(paths.html, ['compress-html']);
    gulp.watch(dist + '/**').on('change', livereload.changed);
});

//기본 task 설정
gulp.task('default', [
    'server', 'combine-js', 
    'compile-sass', 'compress-html', 
    'watch' ]);
```

- `npm install gulp-webserver gulp-concat gulp-uglify gulp-minify-html gulp-sass gulp-livereload --save-dev`
    + `gulp-webserver`: webserver처럼 동작 가능
    + `gulp-concat`: 파일 병합
    + `gulp-uglify`: 파일 압축
    + `gulp-minify-html`: html 파일 minify
    + `gulp-sass`: sass 컴파일 가능
    + `gulp-livereload`: 웹 브라우저 리로드 가능
