# MongoDB

참고 링크: [공식문서](https://docs.mongodb.com/manual/core/databases-and-collections/), [velopert](https://velopert.com/436)

## 1. 개념

- 설치 및 실행
    + `brew install mongodb` 로 설치 끝
    + `sudo mkdir -p /data/db` 로 MongoDB가 사용할 디렉토리를 만들고
    + `sudo mongod`로 실행하면 몽고DB가 구동된다.
    + `sudo mongo` 명령어로 몽고DB 서버 접속할 수 있다.
- Document: RDBMS의 record에 해당한다. key, value 쌍으로 이루어져있고 JSON 객체와 똑같이 생겼다.
- Collection: Document의 그룹. RDBMS의 테이블과 비슷하지만 스키마를 따로 갖고있진 않다. 즉 정해진 것이 없고, 같은 Collection 내에서 서로 다른 키를 가진 Document가 존재할 수 있다.
- Join, 스키마가 없고 빠르다.

## 2. Modeling

### 2.1 RDBMS와 다른점

- RDBMS와 달리 다양한 쿼리가 없고 `Put`, `Get`만 지원한다. 각각 insert, select라고 생각하면 된다.
- 쿼리가 다양하지 않기 때문에 데이터 모델링을 할 때 RDBMS와는 방식이 반대다.
    + RDBMS: 도메인 모델을 분석한 후에 -> 테이블 만들고 -> 쿼리로 가져온다.
    + NoSQL: 도메인 모델을 분석한 후에 -> 어떤 쿼리 사용할지 정하고 -> 테이블을 만든다.
- 또한 RDBMS처럼 정규화(Normalization)를 거의 하지 않는다. 쿼리의 효율성을 위해 의도적으로 데이터를 중복 저장하는 비정규화(Denormalization) 방식을 사용한다.
- 예를 들어 "포스트"와 "댓글"이 있다면 한 Document에 다 집어넣는다. RDBMS처럼 테이블을 나눠서 join하지 않는다.

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

## 3. filter

```js
db.users.find(obj)
```

find의 기본 형태. obj에 조건을 넣어주면 된다.

```js
{ status: { $in: [ "P", "D" ] } } // status가 P, D 중 하나인 것
{ status: "A", age: { $lt: 30 } } // status가 "A"이고, age가 30보다 작은 것
{ $or: [ { status: "A" }, { age: { $lt: 30 } } ] } // status가 A이거나 age가 30보다 작거나
{ status: "A", $or: [ { age: { $lt: 30 } }, { type: 1 } ] } // status가 A인데 age가 30보다 작거나 type이 1이거나.
```
