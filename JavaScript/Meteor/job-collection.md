# job-collection

## 1. 기본

- `meteor add vsivsi:job-collection` : meteor 프로젝트 디렉토리에서 왼쪽처럼 라이브러리를 추가한다.
- Mongo DB의 콜렉션에 생성한 태스크들이 기록된다. 이 정보를 활용해서 태스크를 수행함.
- 태스크를 생성하고 -> 시간을 지정해서 시작시키면 -> 정해진 시간에 실행된다.

## 2. Server

```js
import { Meteor } from 'meteor/meteor'

if (Meteor.isServer) {
  var myJobs = JobCollection('myJobQueue')
  myJobs.allow({
    admin: (userId, method, params) => {
      return true
    }
  })

  Meteor.startup(() => {
    Meteor.publish('allJobs', () => {
      return myJobs.find({})
    })
    return myJobs.startJobServer()
  })
}
```

- server 파일에서 `JobCollection` 클래스 객체를 생성한다.
    + 매개변수로 주는 문자열은 Mongo DB의 collection 이름이 된다.
- 생성한 객체에서 `allow` 메소드를 사용해서 권한을 지정해줄 수 있다.
    + 위 코드에선 조건 없이 바로 true를 리턴해서 모든 권한을 주게 되어있다.
- startup 함수 내부에서 만든 JobCollection 객체를 publish한다.
    + publish하는 키를 'allJobs'라고 둔 것이고 subscribe할 때 이를 이용해 받는다.
    + 딱히 조건 없이 모든 태스크 document들을 리턴한다.
- `myJobs.startJobServer()` : JobServer를 실행. 이걸 실행해야 예정된 시기에 태스크들이 실행된다.

## 3. Client

### 3.1 JavaScript

```js
import { Template } from 'meteor/templating';
import { ReactiveVar } from 'meteor/reactive-var';

import './main.html';

const jobs = JobCollection('myJobQueue');

Meteor.startup(function () {
  Meteor.subscribe('allJobs')
})

Template.hello.onCreated(function helloOnCreated() {
  this.counter = new ReactiveVar(0);
});

Template.hello.helpers({
  counter() {
    return Template.instance().counter.get()
  }
});

Template.hello.events({
  'click #count-button'() {
    Template.instance().counter.set(Template.instance().counter.get() + 1)

    if (Template.instance().counter.get() === 5) {
      const job = new Job(jobs, 'please', {
        address: 'geubin0414@naver.com',
        subject: 'Critical rainbow hair shortage',
        message: 'LOL; JK, KThxBye.'
      });

      job.priority('normal')
        .retry({ retries: 5, wait: 1*1000 })
        .delay(1*1000)
        .save()
    }
  },

  'click #job-process-button'() {
    const workers = Job.processJobs('myJobQueue', 'please', (job, cbFunc) => {
      console.log('job.data:', job.data)
      job.done
      cbFunc()
    })
  }
});
```

- `const jobs = JobCollection('myJobQueue')` : 콜렉션을 활용하므로 먼저 인스턴스 생성
- `Meteor.subscribe('allJobs')` : startup 안에 넣어서 시작부터 subscribe하도록 한다.
- onCreated, helpers에 있는 것들은 단순히 이벤트를 넣기 위함이다. meteor 프로젝트를 처음 생성하면 있는 것들이고, 다섯 번 클릭하면 태스크를 생성하도록 했다.
- Task 생성
    + 첫 번째 매개변수는 콜렉션의 인스턴스다.
    + 두 번째는 해당 job의 식별자. 나중에 process할 때 사용한다.
    + 세 번째는 넘겨줄 데이터.

    ```js
    const job = new Job(jobs, 'please', {
      address: 'geubin0414@wow.com',
      subject: 'I MISS YOU',
      message: 'LOL. Just a kidding.'
    });
    ```

- Task의 속성 설정
    + `priority` : 태스크의 중요도 나타냄
    + `retry`
        * `retries` : 만약 태스크 실행이 실패했을 때 몇 번 다시 시도할 것이냐. 디폴트 값은 무제한으로 `Job.forever` 값이다.
        * `wait` : 시도 사이 사이에 얼마나 간격을 줄건지. 기본값은 300000으로 5분이다.
        * `until` : Date 객체를 넣어줘서 언제까지 재시도할지 설정
    + `delay` : 해당 job이 ready 상태가 되어서 process하면 바로 동작할 수 있도록 할 때까지 얼마의 딜레이를 줄 것인가. 기본값은 0이다.
    + `after` : Date 객체를 줘서 이 시점 이후에 바로 실행되도록 한다.
    + `save` : 콜렉션에 insert한다.

    ```js
    job.priority('normal')
      .retry({ retries: 5, wait: 1*1000 })
      .delay(1*1000)
      .after(new Date('2017-06-09T19:00:00'))
      .save()
    ```

- Task 구동
    + `Job.processJobs` 메소드를 활용해서 ready 상태의 task를 running으로 바꾼다.
    + 첫 번째 매개변수는 콜렉션의 이름
    + 두 번째 매개변수는 구동시킬 job의 식별자
    + 세 번째는 구동될 때 실행될 콜백함수다. 내 경우는 job의 데이터를 콘솔에 찍기만 했고, 마지막엔 꼭 `job.done`과 전달받은 함수를 실행해주면서 끝내야한다.

    ```js
    const workers = Job.processJobs('myJobQueue', 'please', (job, cbFunc) => {
      console.log('job.data:', job.data)
      job.done
      cbFunc()
    })
    ```

### 3.2 HTML

```html
<head>
  <title>job-collection-test</title>
</head>

<body>
  <h1>Welcome to Meteor!</h1>
  {{> hello}}
</body>

<template name="hello">
  <button id="count-button">Click Me</button>
  <p>You've pressed the button {{counter}} times.</p>
  <hr>
  <button id="job-process-button">Go</button>
</template>
```
