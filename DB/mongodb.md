# MongoDB

참고 링크: [공식문서](https://docs.mongodb.com/manual/core/databases-and-collections/), [velopert](https://velopert.com/436)

## 1. 개념

- 설치 및 실행
    + `brew install mongodb` 로 설치 끝
    + `sudo mkdir -p /data/db` 로 MongoDB가 사용할 디렉토리를 만들고
    + `sudo mongod`로 실행하면 몽고DB가 구동된다.
    + `mongo` 명령어로 몽고DB 서버 접속할 수 있다.
- Document: RDBMS의 record에 해당한다. key, value 쌍으로 이루어져있고 JSON 객체와 똑같이 생겼다.
- Collection: Document의 그룹. RDBMS의 테이블과 비슷하지만 스키마를 따로 갖고있진 않다. 즉 정해진 것이 없고, 같은 Collection 내에서 서로 다른 키를 가진 Document가 존재할 수 있다.
- Join, 스키마가 없고 빠르다.

## 2. Modeling

### 2.1 RDBMS와 다른점

- RDBMS와 달리 다양한 쿼리가 없고 `Put`, `Get`만 지원한다. 각각 insert, select라고 생각하면 된다.
- 쿼리가 다양하지 않기 때문에 데이터 모델링을 할 때 RDBMS와는 방식이 반대다.
    + RDBMS: 도메인 모델을 분석한 후에 -> 테이블 만들고 -> 쿼리로 가져온다.
    + NoSQL: 도메인 모델을 분석한 후에 -> 어떤 쿼리 사용할지 정하고 -> 테이블을 만든다.
- 또한 RDBMS처럼 정규화(Normalization)를 거의 하지 않는다. join이 없기 때문에 쿼리의 효율성을 위해 의도적으로 데이터를 중복 저장하는 비정규화(Denormalization) 방식을 사용한다.
    + 정규화는 "쓰기"가 빠르고, 비정규화는 "읽기"가 빠르다
    + 정보가 읽혀지는 빈도에 비해 얼마나 자주 변경되는가를 본다. 자주 갱신되는 정보라면 정규화하지만 아니라면 비정규화한다.
    + 또한 증가량이 적거나, 작은 데이터라면 역시 비정규화가 낫다.
- 정규화, 비정규화 예
    + "포스트"와 "댓글"이 있다면 한 Document에 다 집어넣는다. RDBMS처럼 테이블을 나눠서 join하지 않는다.
    + 계정 설정: 해당 사용자만 관련이 있는 정보이기 때문에 내장
    + 최근 활동: 가장 최근의 약 10개 정도만 보여줄거라면 내장
    + 친구: 소셜 서비스에서 일반적으로 내장하지 않는다.
    + 사용자가 언급되는 포스트: 내장하지 않는다.

### 2.2 예제

- 간단한 블로그를 만든다고 생각하면 RDBMS에서라면 아래와 같을 것.
    + 글 테이블: primary key, 작성자, 제목, 내용, 날짜
    + 댓글 테이블: primary key, foreign key(글), 작성자, 내용, 날짜
    + 태그: primary key, foreign key(글), 태그명
- NoSQL에서라면 다음 코드처럼 한 방에 때려넣는다.

    ```mongodb
    {
      _id: POST_ID,
      title: POST_TITLE,
      content: POST_CONTENT,
      username: POST_WRITER,
      tags: [ TAG1, TAG2, TAG3 ],
      time: POST_TIME
      comments: [
        { 
          username: COMMENT_WRITER,
          mesage: COMMENT_MESSAGE,
          time: COMMENT_TIME
        },
        { 
          username: COMMENT_WRITER,
          mesage: COMMENT_MESSAGE,
          time: COMMENT_TIME
        }
      ]
    }
    ```

## 3. 사용법

- 몽고DB shell에서 JavaScript의 모든 작업 가능. 함수 정의도 라이브러리 사용도 가능하다. 
- `db` : 명령어 입력하면 현재 사용 중인 데이터베이스 확인 가능하다.
- `use db_name` : 사용할 데이터베이스 선택하고 사용
- `db.collection_name` : db 변수를 통해 콜렉션에 접근 가능
- Collection 접근
    + Collection을 따로 생성하는 것이 아니라 `db.something` 형태로 접근해서 바로 사용하면 된다.
    + `db.wow.find()` 명령어로 db의 wow 콜렉션의 document들을 볼 수 있는데 없으면 안 뜨고 있으면 보인다.

### 3.1 Create

```js
db.blog.save({title: 'title', content: 'content'})
db.blog.insert({title: 'title', content: 'content'})
```

- blog라는 Collection에 obj라는 document를 추가하는 것
- `save`, `insert`의 차이: 만약 저장하는 객체에 `_id` 필드가 있다면 `save`는 `upsert`와 동일하게 행동한다. 없다면 insert와 save는 똑같이 데이터를 추가하는 역할
- `insertOne`, `insertMany`가 `insert`를 대체하기 위해 새로 나왔다고 한다. one은 똑같고 many는 매개변수를 배열 형태로 여러 객체를 집어넣어서 한 번에 여러 데이터를 insert할 수 있다.

### 3.2 Read

- `db.blog.find()`: blog Collection의 모든 document를 read
- `db.blog.findOne(query)`: query에 맞는 데이터를 하나만 읽어온다.
- `$or` : 배열 형태로 들어간 각 원소들 중 하나만 맞으면 읽어온다.

    ```js
    db.blog.find({
      $or: [{title: 'wow'}, {content: 'hey?'}]
    })
    ```

- `$lt`, `$gt`, `lte`, `gte` : 수치에 대해서 대소를 비교해서 가져올 수 있음

    ```js
    db.blog.find({
      likes: { $lt: 100 }
    })
    ```

- document 내의 객체의 속성을 잡아올 때 dot notation과 문자열 표시로 가능하다: `db.blog.find({'property.author': 'GB'})`
- 배열의 경우. 예를 들어 like를 누른 사람들의 배열이 `peopleLiked : ['a', 'b', 'c']`로 데이터가 존재한다면 `db.blog.find({peopleLiked: 'a'})` 처럼 단순하게 하면 된다.
- projection: find 관련 함수 두 번째 매개변수로 객체를 넣어주어서 찾은 객체에서 가져올 속성을 지정하는 것이다. 갖고오고싶은 필드 키에 `true` 값을 주면 된다.
- `$in`: 해당 값이 배열의 원소 중 하나일 때
    + `$or`과 비슷한 메커니즘이다. 아래같은 데이터가 있을 때 `vals`라는 배열에 bb, c가 들어있는 document를 찾고싶다고하자.
    + 만약 a만 들어있는 문서를 찾는다면 위에서 설명한대로 오퍼레이터를 쓸 필요도 없이 바로 쿼리에 적어주면 된다.(위위 목록)
    + 근데 bb, c가 적어도 하나 들어있는거를 한 번에 찾으려면 아래 쿼리처럼 `$in` 오퍼레이터를 사용하면 된다.

    ```js
    // documents
    { "_id" : 1, "vals" : [ "a", "b", "c", "d" ] }
    { "_id" : 2, "vals" : [ "aa", "bb", "cc", "d" ] }
    { "_id" : 3, "vals" : [ "aa", "bb", "c", "dd" ] }

    // query
    db.blog.find({ vals : { $in: [ 'bb', 'c' ] } } )
    ```

- 정규표현식 사용 가능: `{"x" : /foobar/}`
- 종합 응용

    ```js
    { status: "A", age: { $lt: 30 } } // status가 "A"이고, age가 30보다 작은 것
    { $or: [ { status: "A" }, { age: { $lt: 30 } } ] } // status가 A이거나 age가 30보다 작거나
    { status: "A", $or: [ { age: { $lt: 30 } }, { type: 1 } ] } // status가 A인데 age가 30보다 작거나 type이 1이거나.
    ```

### 3.3 Update

- `db.blog.update(query, newDoc)`: update 함수. query로 여러 document가 선택되면 첫 번째 것만 newDoc으로 변경된다.
    + 첫 번째 매개변수: 수정할 문서를 가리키는 filter 역할. 쿼리다.
    + 두 번째 매개변수: 바꿀 문서
- `update`에서 `$set`을 쓰면 특정 부분만 변경할 수 있다.
    + 첫 예: query로 선택된 blog Collection의 document를 통으로 바꾸는게 아니라 title만 바꾼다.
    + 둘째 예: query로 선택된 blog Collection의 document에서 address 속성의 street 값을 바꾸겠다. address가 object 형태인 경우 저런식으로 해준다.

    ```js
    db.blog.update(query, {
      $set: {
        title: title,
      }
    })
    db.blog.update(query, {
      $set: {
        "address.street": "Main Street",
      }
    })
    ```

- `update`에서 `$inc`를 쓰면 숫자를 올리거나 내릴 수 있다. 간단하게 +를 하거나 -를 할 때 유용
- `$push`: array에 원소 추가하기
    + 원하는 document를 골라서 `$push`를 쓴다.
    + value로 Object를 넣는데 키 값이 array를 가리킨다.
    + array 키의 값으로 처음 넣으려했던 원소를 넣으면 된다.
    + 만약 `$each`를 사용해서 배열을 넣으면 여러 원소를 한 번에 추가할 수 있다.
    + `$sort`는 DB에 넣을 때 알아서 정렬까지 추가로 하겠다는 거고, slice는 처음부터 개수만큼 끊고 나머지는 버린다.

    ```js
    // append one
    db.blog.update(query, {
      $push: {authors: 'addElementOfArray'}
    })

    // append multiple values, another operation
    db.blog.update(query, {
      $push: {authors: { $each: [ 'a', 'b', 'c' ] }},
      $sort: { score: -1 },
      $slice: 3
    })
    ```

- 옵션
    + `upsert`: 수정할 대상이 없을 때 `update`는 아무 것도 하지 않고 종료된다. 없으면 생성하는 것까지 하고싶을 때 `upsert`를 사용한다.
    + `multi`: 선택된 여러 문서들을 모두 업데이트하고싶을 때 true로. false면 하나만 업데이트된다.

    ```js
    db.blog.update(query, update,
      {
        upsert: boolean,
        multi: boolean,
      }
    })
    ```

- `updateOne`은 multi가 false인 상황, `updateMany`는 multi가 true, `replaaceOne`은 set을 안 썼을 때의 update와 같은 함수다.
- `findAndModify(query, update, new:boolean)`: 수정한 다음에 결과까지 리턴하는 함수. new가 true면 수정한것을 가져오고, false면 수정 이전의 것을 가져온다.
- document의 속성 중 array가 있고, 그 원소의 특정 부분만 업데이트하고싶을 때
    + `user` collection이 있고,  Object 타입의 `profiles` 속성이 있다. 또 거기서 내가 읽은, 읽고싶은 책을 기록하는 array 타입의 `readBooks` 속성이 존재한다. 각각의 원소는 Object 타입이며 책의 title, rate, status(읽었는지 안 읽었는지) 속성이 존재한다.
    + 현재 user의 `_id` 값과 읽은 책의 `title`을 알고 있다. 검색해서 그 유저의, 그 책의 status를 "읽음" 상태로 바꾸고 평점을 기록하고싶다.
    + query에는 array 타입의 `readBooks`에 dot notation을 사용해서 조건을 입력하고, set할 때는 검색된 객체를 가리키는 `$` 기호를 써서 원하는대로 변경한다.

    ```js
    // db structure
    {
      _id: 'String',
      ...,
      profiles: {
        ...,
        readBooks: [
          {title: 'AAA', rate: 7, status: 'complete'},
          {title: 'BBB', rate: 8, status: 'complete'},
          {title: 'How Google Works', status: 'yet'},
          ...,
        ],
        ...,
      }
    }

    // update query
    db.getCollection('user').update({
      _id: '937',
      'profiles.readBooks.title': 'How Google Works',
    }, {
      $set: {
        'profiles.readBooks.$.status':'complete',
        'profiles.readBooks.$.rate':10,
      }
    })
    ```

### 3.4 Delete

`db.blog.remove(query)`: 삭제
