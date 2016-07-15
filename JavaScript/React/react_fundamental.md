# React

[udemy 강의](https://www.udemy.com/react-redux/) 정리

- 강사 이메일: ste.grider@gmail.com
- 트위터: @sg_in_sf
- GitHub: [github.com/stephengrider](https://github.com/stephengrider)

## 0. 구동 방식

![js-tooling](http://i.imgur.com/lHNqzoZ.png)

- 우리가 만든 js 코드 파일과 라이브러리 파일들이 있을 것이고, 아마 이것은 ES6와 JSX로 되어있을 것이다.
- babel을 이용하여 js 코드를 ES5 코드로 바꾸고, webpack을 통해 하나의 application.js 파일을 만든다.
- 그래서 최종적으로 만들어진 파일만 실행하면 된다.

## 1. ReduxSimpleStarter

![Imgur](http://i.imgur.com/nUS8vwu.png)

- [ReduxSimpleStarter](https://github.com/StephenGrider/ReduxSimpleStarter)를 이용해 샘플 프로젝트를 만들 것임.
- README에 나온 것처럼 하면 되는데 `npm install`은 dependency를 설치하는 용도다.
- 터미널의 해당 디렉토리에서 `npm start` 명령어를 입력하면 8080 포트에서 해당 프로젝트가 실행된다.
- `bundle.js` 파일이 애플리케이션 src 폴더의 모든 js 파일들을 하나로 뭉친 파일이다.
- `app.js` 파일을 건드리면 메인 페이지가 수정된다.

## 2. About React

- HTML DOM을 만드는 js 라이브러리
- `JSX`: js 코드 안에 HTML DOM이 있다. 이런 문법을 JSX라고 하고 react에서 사용한다. 그리고 babel이 이를 해석해서 브라우저가 이해하고 같은 동작을 하는 일반적인 js 코드로 바꿔준다. [babeljs.io](http://babeljs.io/)에서 테스트해볼 수 있다.

    ```js
    ////////////////
    // 이 코드가
    const App = function() {
      return (
        <ol>
          <li>1</li>
          <li>2</li>
          <li>3</li>
        </ol>
      );
    }

    ////////////////
    // 이렇게 바뀐다.
    "use strict";

    var App = function App() {
      return React.createElement(
        "ol",
        null,
        React.createElement(
          "li",
          null,
          "1"
        ),
        React.createElement(
          "li",
          null,
          "2"
        ),
        React.createElement(
          "li",
          null,
          "3"
        )
      );
    };
    ```

- 내가 만든 일반 js 코드 파일에서 다른 파일의 객체를 가져와서 사용하려면 `import`하면 된다. 자바스크립트에선 원래 이런 모듈 개념이 없었지만 npm과 webpack이 이를 가능하게 했다.
    + 폴더 트리에 보면 `node_modules`가 있다. `npm install` 명령어를 통해 설치한 dependency들이다.
    + `import React from 'react';`를 내가 만든 app.js에서 맨 위에 적어주면 된다. node_modules 폴더의 react 폴더에서 React를 가져오겠다는 의미다.
- `React`, `ReactDOM`의 차이
    + `React`는 component를 만들고 관리하는데 사용하고
    + `ReactDOM`은 실제 DOM과 인터랙션할 때 사용한다.
- render할 때는 `ReactDOM`을 이용한다.
    + `React`와 마찬가지로 `ReactDOM`을 import하고
    + 마지막 줄에 render할 때 사용한다.

    ```js
    import React from 'react';
    import ReactDOM from 'react-dom';

    // Create a new component.
    // This component should produce some HTML.
    const App = function() {
      return (
        <ol>
          <li>AAA</li>
          <li>BBB</li>
          <li>CCC</li>
        </ol>
      );
    }

    // Take this component's generated HTML and put it ont the page in the DOM.
    ReactDOM.render(<App />);
    ```

- Component class: 바로 위 코드에서 `App`이다.
    + 위 코드처럼 함수를 만들면 이것은 component는 클래스 혹은 factory 등의 의미로 사용된다. React에서 하나의 component class로 여겨진다는 의미다.
    + 그래서 render할 때 App 자체를 넘기는게 아니라 instance를 만들어서 넘겨야한다.
    + `React.createElement` 함수가 그 역할을 하고 이 함수를 만드는 JSX 문법이 `<App />` 형태다. babeljs.io에서 테스트를 해보면 다음처럼 나온다. 그리고 `<App></App>` 할 필요 없이 `<App />`하면 편하다.

    ```js
    /////////////
    // 이렇게 쓰면
    const App = function() {
      return (
        <ol>
          <li>AAA</li>
        </ol>
      );
    }
    <App />

    /////////////
    // 이렇게 바뀐다.
    "use strict";

    var App = function App() {
      return React.createElement(
        "ol",
        null,
        React.createElement(
          "li",
          null,
          "AAA"
        )
      );
    };

    React.createElement(App, null);
    ```

### 2.1 타겟 지정하기

```js
const App = () => {
  return (
    <ol>
      <li>AAA</li>
    </ol>
  );
}
ReactDOM.render(<App />, document.querySelector('.container'));
```

- 어느 위치에 렌더할지 두 번째 매개변수로 꼭 결정해줘야 한다.
- 그리고 App을 ES6 문법인 arrow function으로 수정해준다. 이렇게 많이 쓴다.

### 2.2 Components

- 1 component per file
- src 폴더에 `components` 폴더를 만들고 거기에 component 별로 파일을 각각 만든다.

### 2.3 Youtube Search API 예제

- [console.developers.google.com](https://console.developers.google.com) 접속
    + API manager 페이지 접속
    + Youtube data API 들어가서 Enable 버튼 클릭
    + Credentials 메뉴로 들어가서 Create credentials 버튼 누르고 API Key 버튼에서 Browser key 버튼 누르기 
    + 딱히 바꿀건 없고 Create 버튼 눌러서 완료한다.
    + `index.js` 파일의 윗 부분에 `const API_KEY = "sdkjflskdjflskdjf";` 형태로 선언해준다.
- npm의 youtube search module을 설치한다. API key를 가지고 검색어를 던지면 데이터를 받아오는 모듈이다.
    + 해당 프로젝트 디렉토리에서 다음 명령어로 설치한다. `npm install --save youtube-api-search`
    + `--save`의 의미는 디렉토리의 `package.json` 파일에 해당 모듈을 기록하겠다는 의미다. 이 파일만 있으면 나중에 `npm install` 명령어로 필요한 모듈을 한 번에 모두 설치할 수 있다.
    + index.js 파일에서 import해준다. `import YTSearch from 'youtube-api-search';` 
- js 파일들끼리는 silo이기 때문에 서로 필요한 것을 사용하기 위해선 `import`, `export`가 필요하다.
    + index.js 파일엔 맨 위에 `import SearchBar from './components/search_bar';` 라고 쓴다. search_bar.js 파일에서 SearchBar를 가져와서 쓰겠다는 의미다. React를 import 해올 때는 path 없이 그냥 폴더 디렉토리만 썼는데 node_modules 폴더에 있는건 알아서 가져오는 것 같다.
    + `search_bar.js` 코드를 다음처럼 넣는다.

    ```js
    import React from 'react';
    const SearchBar = () => {
      return <input />;
    }
    export default SearchBar;
    ```

- 일반적으로 여러 줄의 JSX 코드는 `()`로 묶어주는 편이다.
    + 만약 괄호를 쓰지 않는다면 return과 같은 줄에 첫 JSX 코드를 써줘야한다. 안 쓰면 에러 난다. 괄호를 썼을 때만 아래처럼 줄 바꿈해도 됨.

    ```js
    const App = () => {
      return (
        <ol>
          <li>AAA</li>
        </ol>
      );
    }
    ```

### 2.4 Class based components

```js
class SearchBar extends React.Component {
  render () {
    return <input />;
  }
}
```

- 지금까지 Function으로 돼있던 components들을 Class로 바꾸기
- 위에 `extends`는 상속의 의미고, React.Component의 모든 기능을 활용할 수 있다는 의미가 된다.
- 다만 `render` 메소드를 필수로 구현해야한다. 위 예제처럼 간단히 적을 수 있다. function 적지 않아도 된다.
- `React.Component`처럼 앞에 React를 붙이고 싶지 않다면
    + `import React, { Component } from 'react';`
    + 위 코드처럼 쓰면 된다. `const Component = React.Component;`의 의미와 같다.
- 속도는 함수형이 클래스형보다 더 빠르다.

### 2.5 EventHandler

```js
class SearchBar extends React.Component {
  render() {
    return <input onChange={this.onInputChange} />;
    /// JSX에서 js variable은 {} 안에 써준다. 아래처럼 줄일 수 있다.
    // return <input onChange={event => console.log(event.target.value)} />;
  }

  onInputChange(event) {
    console.log(event.target.value);
  }
}
```

- 일반적으로 `on`이나 `handle`을 함수 앞에 붙인다.
- JSX에서 js 변수를 쓰려면 `{ }`안에다 써야한다.
- HTML element에서 event에 쓰이는 콜백 함수는 매개변수로 event를 받는다. 
- arrow function에서 매개변수, 실행문이 한 줄이면 각각 괄호, 중괄호를 없앨 수 있다.

### 2.6 State object

#### 2.6.1 개념

- plain JavaScript Object다. 사용자의 이벤트를 기록하고 반응하는데 사용한다.
- class-based component는 고유의 state object를 가지고 있는데 이게 변하면 곧바로 페이지를 re-render한다. 자식 components 역시 모두 렌더링한다.
- fuctional component는 state가 없다.

#### 2.6.2 constructor

```js
class SearchBar extends React.Component {
  constructor(props) {
    super(props);

    this.state = { term: ' ' };
  }

  render() {
    return (
      <input onChange={event => this.setState({ term : event.target.value})} />; ///
    );
  }
}
```

- `constructor`: 모든 ES6 클래스가 가지는 함수다. instance가 만들어질 때 무조건 호출된다.
- instance들은 고유의 state를 가지고, 내부의 property-value 쌍은 개발자 마음대로 지정할 수 있다.
- state를 변경할 때는 `this.setState({ term: value })` 함수를 사용한다. 자연스럽게 떠올릴만 한 this.state.term = something; 형태는 지양한다. 리액트는 뒤에서 많은 처리를 하는데 이런식으로 값만 딱 바꿔버리면 state가 변경되었는지 리액트가 모르기 때문이다.
- 위처럼 onChange의 콜백 함수를 arrow function으로 하면 알아서 this가 lexical로 된다. 즉 arrow function의 scope가 아니라 함수가 실행된 surrounding이 this로 지정되는 것. 그래서 this에서 setState 함수가 호출 가능하다. 하지만 arrow function 대신 일반 함수를 onInputChange로 만들어서 아래에다 선언해두고 함수명만 적어서 활용하는 경우엔 `this.onInputChange.bind(this)` 이런 형태로 surrounding을 함수에 bind시켜줘야한다.

#### 2.6.3 Controlled element

```js
render() {
    return (
      <div className="search-bar">
        <input
          value={this.state.term + '..'}
          onChange={event => this.setState({term: event.target.value})} /> ///
        <p>Value of the input: {this.state.term}</p>
      </div>
    );
  }
```

- render 함수가 위와 같은 꼴일 때 input element의 value는 state에 의해 정해지게 된다. 이 때 input element를 controlled element라고 한다.
- 위 코드의 경우 순서는 다음과 같다.
    + input field에 키보드로 문자를 입력한다.
    + arrow function이 실행되고 state의 term 값이 바뀐다.
    + input의 value가 state의 term 값에 의해 바뀌게 된다.

### 2.7 Youtube 2

```js
YTSearch({key: API_KEY, term: 'surfboards'}, function(data){
  console.log(data);
});
```

- 첫 번째 매개변수: configuration object다. API_KEY로 인증해서, term에 들어가는 단어를 youtube에 검색하겠다는 의미.
- 두 번째: call-back function

```js
// index.js
import React from 'react';
import ReactDOM from 'react-dom';
import YTSearch from 'youtube-api-search';
import SearchBar from './components/search_bar';
import VideoList from './components/video_list';
import VideoDetail from './components/video_detail';
const API_KEY = "AIzaSyDDLeZ8zqTBtZNk2dRnbC17u0drwNevrQc";

// Create a new component.
// This component should produce some HTML.
class App extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      videos : [],
      selectedVideo : null
    };
    YTSearch({key: API_KEY, term: 'surfboards'}, videos => {
      this.setState({
        videos:videos,
        selectedVideo: videos[0]
      });
    });
  }
  render() {
    return (
      <div>
        <SearchBar />
        <VideoDetail video={this.state.selectedVideo}/> ///
        <VideoList
          videos={this.state.videos}
          onVideoSelect={selectedVideo => this.setState({selectedVideo})} />
      </div>
    );
  }
}

// Take this component's generated HTML and put it ont the page in the DOM.
ReactDOM.render(<App />, document.querySelector('.container'));
```

- 그리고 index.js에 원래 있던 `App` functional component를 class 형태로 바꿔준다.
- ES6에서 key, value가 같으면 object에서 한 번만 써주면 된다.

```js
// video_list.js 파일
import React from 'react';
import VideoListItem from './video_list_item';

const VideoList = (props) => {
  const videoItems = props.videos.map((video) => {
    return (
      <VideoListItem
        onVideoSelect={props.onVideoSelect}
        key={video.etag}
        video={video} /> ///
    );
  });

  return (
    <ul className="col-lg-12 col-md-4 list-group">
      {videoItems}
    </ul> ///
  );
};

export default VideoList;
```

- video_list.js 파일을 편집한다.
- JSX에서 HTML 클래스를 적용하려면 `className`으로 써주면 된다.
  + 대부분의 기본 HTML의 속성들은 JSX에서 snakeCase 형태로 적어주면 된다. `onClick`처럼 첫 글자만 소문자, 다음부터는 단어 간격으로 대문자를 처음에 적어주면 대부분 먹힌다고 보면 된다.
- index.js 파일로 되돌아와서 VideoList를 import하고 render 메소드 안에서 init한다.
    + 아래 코드에서 VideoList를 init할 때 값을 전달할 수 있는데 `videos`를 props라고 한다.
    + 만약 function-based components를 class-based로 refactoring 해야한다면 props를 모두 this.props로 바꿔줘야한다. 중요.
    + 아래 코드는 videos 하나만 보냈는데 공백으로 구분해서 여러개의 variable을 보낼 수 있다.

    ```js
    import VideoList from './components/video_list';
    <VideoList videos={this.state.videos} /> /// in render method
    ```

- 다시 video_list.js 파일로 돌아와서 `import VideoListItem from './video_list_item';` 해준다.

```js
// video_list_item.js 파일 편집
import React from 'react';

const VideoListItem = ( {video, onVideoSelect} ) => {
  // const video = props.video;
  // 매개변수로 props를 받아서 위 코드처럼 video를 고르는 것은
  // 매개변수로 {video} 를 넣는 것과 동일하다. 여러개 넣을 수도 있음.

  const imageUrl = video.snippet.thumbnails.default.url;

  return (
    <li onClick={()=>onVideoSelect(video)} className="list-group-item">
      <div className="video-list media">
        <div className="media-left">
          <img className="media-object" src={imageUrl} />
        </div>
        <div className="media-body">
          <div className="media-heading">{video.snippet.title}</div>
        </div>
      </div>
    </li>
  );
}

export default VideoListItem;
```

- 위 코드처럼 VideoListItem component를 만든다. props를 받는 형태로 하는데 VideoList에서도 VideoListItem init할 때 매개변수로 video를 전달해준다.
- map 함수를 이용해서 array의 video 하나하나를 VideoListItem으로 init해서 li로 만든다.
- 그리고 ul 안에다가 새로 만들어진 array를 바로 넣는데 그냥 이렇게 넣으면 에러가 난다. 이유는 다음과 같다.
    + 정보들이 적혀있는 수십장의 카드를 가지고 있다고 가정하자.
    + 근데 갑자기 누가 와서 중간에 어떤 카드의 정보를 수정해야한다고 말한다.
    + 어떤 카드인지는 모르겠는데 그냥 바꿔줘!라고 말하면 나는 전체 카드를 싹 바꿀 수 밖에 없다.
    + 하지만 카드에 id가 있다면, 특정 id의 카드만 수정하면 된다.
    + 이처럼 React는 array의 아이템 하나하나에 unique id를 필요로 한다. 변경된 부분만 바꿀 수 있도록.
- 해결 방법은 리스트 아이템을 생성하는 함수를 init할 때 property로 `key`와 유니크한 값을 전달하면 된다. 끝이다. 위위 코드를 보면 key를 video.etag로 전달한 것을 볼 수 있다.

```js
// video_detail.js 파일 편집
import React from 'react';

const VideoDetail = ({video}) => {
  if (!video) {
    return <div>Loding...</div> ///
  }
  const videoId = video.id.videoId;
  const url = `https://www.youtube.com/embed/${videoId}`;

  return (
    <div className="video-detail col-md-8">
      <div className="embed-responsive embed-responsive-16by9">
        <iframe className="embed-responsive-item" src={url}></iframe>
      </div>
      <div className="details">
        <div>{video.snippet.title}</div>
        <div>{video.snippet.description}</div>
      </div>
    </div>
  );
}

export default VideoDetail;
```

- 위 코드의 가장 위에 `!video`로 조건 달아준 것은 props가 Null일 경우를 처리해주는 코드다.
- ES6 문법에서 `` `code` `` 처럼 쓰면 일종에 format 형태로 사용할 수 있다. 정확한 명칭은 나중에 따로 알아보겠지만 위 코드의 url 부분이 사용예이다.
- div의 className은 강의에 나온 것을 그대로 쓴 것이고, iframe에 src 부분을 넣으면 그 url의 내용을 보여준다.
- VideoDetail component는 props의 video 요소를 활용해서 youtube 영상을 재생하고 상세 정보를 띄워주는 부분이다.
- 동시에 이 Component를 index.js 파일에서 SearchBar init한 위치 바로 아래에서 init해주는데 video라는 props 요소 이름으로 state의 selectedVideo를 넣어주는 것이다.
    + 아래 코드에서 보면 state에 selectedVideo라는 값을 추가했고
    + VideoDetail init할 때 넣어주는 것을 볼 수 있다.

    ```js
    this.state = {
      videos : [],
      selectedVideo : null
    };
    <VideoDetail video={this.state.selectedVideo}/> ///
    ```

- VideoList에 이벤트 구현
    + 우선 첫 번째 코드 그룹에서 VideoList component를 init할 때 props 요소를 하나 더 써준다. 아래처럼 onVideoSelect에 함수를 넣어 전달하면 된다.
    + 두 번째 코드 그룹에서 보면 전달받은 onVideoSelect를 다시 VideoListItem에 전달한다.
    + 세 번째 코드그룹에서 전달받은 onVideoSelect를 li element의 onClick의 callback function으로 활용한다. 각각의 아이템에 video가 할당되어있으므로 매개변수로 바로 써주면 된다. 여기서 onclick에 그냥 `onVIdeoSelect(video)`를 바로 넣어주는 것이 아니라 굳이 arrow function을 활용하는 것은 this가 가리키는 것이 달라서 그러는 것 같다.

    ```js
    //index.js에서 init할 때 
    <VideoList
      videos={this.state.videos}
      onVideoSelect={selectedVideo => this.setState({selectedVideo})} /> ///

    // video_list.js에서 VideoListItem init할 때
    <VideoListItem
      onVideoSelect={props.onVideoSelect}
      key={video.etag}
      video={video} /> ///

    // video_list_item.js
    return (
      <li onClick={()=>onVideoSelect(video)} className="list-group-item">
        // ... 생략
      </li> ///
    );
    ```

- css 파일을 수정한다. style 폴더의 style.css 파일이다.
    + component의 class나 function을 만들 땐 SearchBar 형태의 camel case로 하고, 파일명은 under bar로 search_bar.js 형태, css에서 클래스 명은 dash를 활용하면 좋다. `className="search-bar"`

    ```css
    search-bar {
      margin: 20px;
      text-align: center;
    }

    .search-bar input {
      width: 75%;
    }

    .video-item img {
      max-width: 64px;
    }

    .video-detail .details {
      margin-top: 10px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }

    .list-group-item {
      cursor: pointer;
    }

    .list-group-item:hover {
      background-color: #eee;
    }
    ```

### 2.8 SearchBar 검색어 적용하기

#### 2.8.1 

```js
// index.js 파일 수정

class App extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      videos : [],
      selectedVideo : null
    };

    this.videoSearch('클래시로얄');
  }

  videoSearch(term) {
    YTSearch({key: API_KEY, term: term}, videos => {
      this.setState({
        videos:videos,
        selectedVideo: videos[0]
      });
    });
  }

  render() {
    return (
      <div>
        <SearchBar onSearchTermChange={term => this.videoSearch(term)}/>
        <VideoDetail video={this.state.selectedVideo}/>
        <VideoList
          videos={this.state.videos}
          onVideoSelect={selectedVideo => this.setState({selectedVideo})} />
      </div>
    );
  }
}

// Take this component's generated HTML and put it ont the page in the DOM.
ReactDOM.render(<App />, document.querySelector('.container'));
```

- YTSearch 메소드를 constructor 바깥으로 뺀다. init할 때만 실행되는게 아니라 callback function으로 활용하기 위함이다.
- SearchBar init할 때 props로 위에서 만든 메소드를 넘겨준다.

```js
// search_bar.js 파일 수정
import React, { Component } from 'react';

class SearchBar extends Component {
  constructor(props) {
    super(props);
    this.state = { term: ' ' };
  }

  render() {
    return (
      <div className="search-bar">
        <input
          value={this.state.term}
          onChange={event => this.onInputChange(event.target.value)} />
      </div>
    );
  }

  onInputChange(term) {
    this.setState({term});
    this.props.onSearchTermChange(term);
  }
}

export default SearchBar;
```

- input이 `onChange`할 때마다 props로 전달받은 `onSearchTermChange` 메소드를 호출하도록 만든다.
- 맨 위에서 search_bar.js 파일을 처음 만들 때 위처럼 함수를 따로 빼서 onChange에 넣으려고 `bind(this)`를 썼는데 위처럼 사용하면 되겠다.

#### 2.8.2 Throttling user input: lodash

```sh
npm install --save lodash
```

- terminal에서 `lodash`를 인스톨한다.
- 설치 후 index.js 파일에서 `import _ from 'lodash';` 로 불러온다.

```js
//index.js 파일
render() {
  const videoSearch = _.debounce((term) => { this.videoSearch(term) }, 300);
  return (
    <div>
      <SearchBar onSearchTermChange={videoSearch}/>
      <VideoDetail video={this.state.selectedVideo}/>
      <VideoList
        videos={this.state.videos}
        onVideoSelect={selectedVideo => this.setState({selectedVideo})} />
    </div>
  );
}
```

- `render` 메소드 부분만 편집한다.
- 원래 썼던 `this.videoSearch(term)` 부분을 lodash의 `debounce`로 감싸주면 된다.
- 두 번째 매개변수로 오는 것이 지연시간이다. 즉 함수 실행을 지연시킬 때 활용한다. 밀리세컨드 단위다. 300이면 0.3초.
