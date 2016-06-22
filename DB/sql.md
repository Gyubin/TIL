# SQL

참고 링크: [코드카데미 SQL](https://www.codecademy.com/learn/learn-sql), 헤드퍼스트 책

## 1. 테이블 만들기

```sql
CREATE TABLE table_name (
    column_1 data_type, 
    column_2 data_type, 
    column_3 data_type
);
```

- 항상 명령은 `;`으로 끝나야 한다.
- `CREATE TABLE` 같은 command를 하나의 clause(절)이라고 한다. 대문자로 쓰는 것이 컨벤션이다.
- 괄호 안에 들어가는 것이 parameter다.

## 2. 데이터 넣기

```sql
INSERT INTO celebs (id, name, age) VALUES (1, 'Justin Bieber', 21);
SELECT * FROM celebs;
```

- `INSERT INTO 테이블 (컬럼, 컬럼, 컬럼) VALUES (v, v, v);`의 형태다.
- `SELECT 컬럼 FROM 테이블`의 형태로 데이터 받아오기

## 3. 데이터 수정

```sql
UPDATE celebs
SET age = 22
WHERE id = 1;
```

## 4. 테이블 변경

```sql
ALTER TABLE celebs ADD COLUMN twitter_handle TEXT;

UPDATE celebs 
SET twitter_handle = '@taylorswift13' 
WHERE id = 4; 

DELETE FROM celebs WHERE twitter_handle IS NULL;
```

- `ALTER TABLE` : 테이블을 변경하겠다는 clause
- `ADD COLUMN` : 컬럼을 추가하겠다는 clause
- `NULL`은 SQL에서 missing이거나 unknown 데이터를 의미한다.
- `DELETE FROM` : 테이블에서 데이터를 삭제하겠다는 clause
- `IS` : 마지막 명령어에서 `WHERE`과 같이 쓰여서 twitter_handle과 NULL이 **같다면** 이라는 의미로 쓰인다.
