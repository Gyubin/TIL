# Weather AJAX tutorial

검색창을 만들어서 지역을 검색하면 아래쪽에 날씨 정보가 추가되는 예제. 다음 [보일러플레이트](https://github.com/StephenGrider/ReduxSimpleStarter)를 사용한다.

## 0. 구조

![Imgur](http://i.imgur.com/WNFZhFU.png)

## 1. SearchBar

- 위 구조에서 봤을 때 SearchBar는 Container다. 입력된 검색어를 관리해줘야 한다. `src/containers/search_bar.js` 파일을 생성하고 해당 class를 다음처럼 생성.

    ```js
    import React, { Component } from 'react';

    export default class SearchBar extends Component {
      constructor(props) {
        super(props);
        this.state = { term: '' };
        this.onInputChange = this.onInputChange.bind(this);
      }
      onInputChange(event) {
        this.setState({ term: event.target.value });
      }
      render() {
        return (
          <form className="input-group">
            <input
              placeholder="Get a five-day forecast in your favorite cities."
              className="form-control"
              value={ this.state.term }
              onChange={ this.onInputChange }
            />
            <span className="input-group-btn">
              <button type="sumbmit" className="btn btn-secondary">Submit</button>
            </span>
          </form>
        );
      }
    }
    ```

- `components/app.js` 파일에 위에서 만든 SearchBar 클래스를 import하고 init한다.
- controlled field 개념 다시 짚기: form element이 value가 state의 value에 의해 결정되는 것. 우리가 입력한 것이 아니다.
- 검색어는 redux-level까지 갈 필요가 없으므로 해당 Component의 state로만 구현해서 쓴다. class를 만들고 내부 constructor에서 `this.state`를 만든다.
- `onChange` 속성에 함수 레퍼런스를 지정할 때 this 설정하는 문제는 위처럼 bind를 활용할 수 있다. constructor에서 bind를 해준 것으로 재설정하는 방식.
