# job-collection

## 1. 설치

- `meteor add vsivsi:job-collection`

## 2. 코드

- 버튼을 5번 클릭할 때 JobCollection 객체를 만든다.
- 그 후 Go 버튼을 누르면 지정한 동작이 실행된다.

### 2.1 JavaScript 파일

- server

```js
import { Meteor } from 'meteor/meteor'

if (Meteor.isServer) {
  var myJobs = JobCollection('myJobQueue')
  myJobs.allow({
    // Grant full permission to any authenticated user
    admin: (userId, method, params) => {
      return true
      // return (userId ? true : false)
    }
  })

  Meteor.startup(() => {
    // Normal Meteor publish call, the server always
    // controls what each client can see
    Meteor.publish('allJobs', () => {
      return myJobs.find({})
    })

    // Start the myJobs queue running
    return myJobs.startJobServer()
  })
}
```

- client

```js
import { Template } from 'meteor/templating';
import { ReactiveVar } from 'meteor/reactive-var';

import './main.html';

const Jobs = JobCollection('myJobQueue');

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
      const job = new Job(Jobs, 'please', {
        address: 'geubin0414@naver.com',
        subject: 'Critical rainbow hair shortage',
        message: 'LOL; JK, KThxBye.'
      });

      job.priority('normal')
        .retry({
          retries: 5,
          wait: 1*1000    // 15 seconds between attempts
        }).delay(1*1000)  // Wait 5 seconds before first try
        .save();          // Commit it to the server. Create JobCollection doc.
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

### 2.2 html

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
