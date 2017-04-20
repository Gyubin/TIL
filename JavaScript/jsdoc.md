# JSDoc

- 코드에 주석을 정해진 형식으로 달면 이를 바탕으로 API 문서를 자동 생성해준다.
- [공식 문서](http://usejsdoc.org/), [repo](https://github.com/jsdoc3/jsdoc)

## 0. 설치 및 예제

- `npm install jsdoc -g` : 글로벌로 설치한다.
- js 파일을 다음처럼 만들고 함수 위에 주석을 작성한다.

    ```js
    /**
     * This is Class of Person.
     * @constructor
     * @param {string} name - name of person
     * @param {number} age - age of person
     */
    function Person(name, age) {
      this.name = name;
      this.age = age;
    }
    ```

- `jsdoc <file-name.js>` : 해당 js 파일의 주석을 활용해 API 문서 생성. 결과물은 html, css이고 `./out` 디렉토리에 저장된다.
- 주석
    + 문서화를 할 코드의 바로 위에 적어야 한다.
    + `/** */` 이렇게 주석의 첫 시작은 별 2개로 시작해야한다. 별 1개나 3개 이상은 무시한다.

## 1. JSDoc tags

태그를 이용하면 설명하려는 대상에 더 적합한 API 문서 템플릿을 만들 수 있다. [Use JSDoc](http://usejsdoc.org/)에 해당 태그들이 모두 나와있다.

- `/** This is a description of the foo function. */` : 태그가 없으면 description이다.
- `@constructor`(=`@class`), `@member {type}`: 클래스의 constructor라는 의미, 멤버 변수임을 설명

    ```js
    /** @class */
    function Data() {
        /** @member {Object} */
        this.point = {};
    }
    ```

- `@param {string} title - The title of the book.` : 매개변수로 어떤 타입의, 어떤 이름으로 들어가고, 어떤 내용인지 적어준다.
- `@author Gyubin Son <geubin0414@gmail.com>` : 누가 작성한건지 적어줌. 이메일은 옵션이다.
- `@constant` : 상수임을 설명
- `@example` : 활용예를 적어준다. 태그 뒤에 caption을 적을 수도 있다.

    ```js
    /**
     * Solves equations of the form a * x = b
     * @example <caption>Example usage of method1.</caption>
     * // returns 2
     * globalNS.method1(5, 10);
     * @example
     * // returns 3
     * globalNS.method(5, 15);
     * @returns {Number} Returns the value of x for the equation.
     */
    globalNS.method1 = function (a, b) {
        return b / a;
    };
    ```

- `@type {typeName}` : 해당 변수의 타입을 적어준다. 내용이 굉장히 많으니 [공식문서](http://usejsdoc.org/tags-type.html)를 참고한다. 여러 타입을 적을 수도 있고, Object나 Array의 원소의 타입을 설정할 수도 있다.

## 2. jsdoc-to-markdown

아예 다른 라이브러리다. 기존 jsdoc의 형식대로 주석을 달고 다음처럼 설치하고 실행하면 된다.

- 설치: `npm install -g jsdoc-to-markdown`
- 사용: `jsdoc2md file-name.js > markdown-file-name.md`
