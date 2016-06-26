# SQL

참고 링크: [코드카데미 SQL](https://www.codecademy.com/learn/learn-sql), 헤드퍼스트 책

## 1. 기본 쿼리

### 1.1 테이블 만들기

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

### 1.2 데이터 넣기

```sql
INSERT INTO celebs (id, name, age) VALUES (1, 'Justin Bieber', 21);
SELECT * FROM celebs;
```

- `INSERT INTO 테이블 (컬럼, 컬럼, 컬럼) VALUES (v, v, v);`의 형태다.
- `SELECT 컬럼 FROM 테이블`의 형태로 데이터 받아오기. SELECT에서 여러 컬럼을 선택할 때는 괄호로 감싸주지 않아도 된다.

## 1.3 데이터 수정

```sql
UPDATE celebs
SET age = 22
WHERE id = 1;
```

## 1.4 테이블 변경

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

## 1.5 SELECT

```sql
SELECT DISTINCT genre FROM movies;
SELECT * FROM movies WHERE imdb_rating > 8;
SELECT * FROM movies WHERE name Like 'Se_en';
```

- `SELECT DISTINCT` : SELECT의 결과에서 중복을 제외하고 유니크한 결과만 리턴하는 clause
- `WHERE`을 활용해서 조건을 지정할 수 있다. `>`, `<`, `<=`, `>=`, `!=`, `=` 를 쓸 수 있다. ==가 아니라 `=`인 것 기억
- `Like`: 패턴을 찾아낼 때 WHERE와 함께 쓰이는 연산자다.
    + `name LIKE Se_en`의 의미는 name 컬럼에서 Se_en 패턴을 찾겠다는 의미.
    + `_`: 이 wildcard character의 의미는 여기에 뭐든 들어가도 된다는 의미.

```sql
SELECT * FROM movies WHERE name LIKE 'A%';
SELECT * FROM movies WHERE name LIKE '%man%';
```

- `%`: 역시 `LIKE`와 사용될 수 있는 whildcard character. 0개 이상의 문자들과 매칭된다.
    + `A%` : A로 시작되는 모든 것. 그냥 'A'와도 매칭된다.
    + `%a` : a로 끝나는 모든 것. 역시 'a'와도 매칭됨.
    + `%man%` : man이 포함된 모든 데이터

```sql
SELECT * FROM movies WHERE name BETWEEN 'A' AND 'J';
SELECT * FROM movies WHERE year BETWEEN 1990 AND 2000;

SELECT * FROM movies
WHERE year BETWEEN 1990 and 2000
AND genre = 'comedy';

SELECT * FROM movies
WHERE genre = 'comedy'
OR year < 1980;
```

- `BETWEEN`: 범위로 조건을 걸 때 사용하는 연산자. 숫자, 날짜, 문자열 모두 가능
- 문자열로 비교하면 첫 글자가 비교된다. 위 예시에는 첫 글자가 A, J 사이의 영화가 골라진다.
- 세 번째 예제에서처럼 조건을 여러개 걸 수도 있다.

```sql
SELECT * FROM movies
ORDER BY imdb_rating ASC
LIMIT 3;
```

- `ORDER BY` : 정렬하겠다라는 clause다. 뒤에 컬럼이 오고, 오름인지 내림인지 순서 지정할 수 있다. `DESC`은 내림, `ASC`은 오름차순이다.
- `LIMIT`: 결과 데이터의 개수 지정 가능하다.

## 2. Aggregate functions

특정 컬럼의 합이나 평균을 구할 때 사용 가능하다.

```sql
SELECT COUNT(*) FROM fake_apps
WHERE price = 0;

SELECT price, COUNT(*) FROM fake_apps
GROUP BY price;
```

- `COUNT()` : 괄호 안에 컬럼을 넣어서 그 컬럼의 NULL이 아닌 값의 개수를 구한다. 단순히 전체 행의 개수를 알고싶으면 위 예제처럼 `*`을 넣으면 된다.
- `GROUP BY` : 뒤에 오는 컬럼의 값을 기준으로 그룹으로 나눠서 보여준다.

```sql
SELECT SUM(downloads) FROM fake_apps;

SELECT category, SUM(downloads) FROM fake_apps
GROUP BY category;

SELECT MAX(downloads) FROM fake_apps;

SELECT name, category, MIN(downloads) FROM fake_apps
GROUP BY category;

SELECT price, AVG(downloads) FROM fake_apps
GROUP BY price;

SELECT price, ROUND(AVG(downloads), 2) FROM fake_apps
GROUP BY price;
```

- `SUM(column)`: 컬럼 값의 합을 계산해서 리턴한다.
- `MAX(column)`, `MIN(column` : 컬럼 값 중 최대값, 최소값 계산
- `AVG(column)`: 컬럼 값의 평균 계산
- `ROUND(value, digit)`: value를 소수점 digit 자리까지 표현. 만약 value만 입력하고 digit은 입력하지 않으면 정수로 표기된다.

## 3. KEY

```sql
CREATE TABLE artists(id INTEGER PRIMARY KEY, name TEXT);
```

- primary key: 고유 구분자로 쓰인다. 위에서럼 컬럼명, 컬럼 타입 뒤에 `PRIMARY KEY`라고 써주면 된다. `id` 컬럼이 그렇게 쓰임.
    + 절대 값이 NULL이어선 안되고
    + 중복되지 않아야 한다.
- foreign key: 다른 테이블의 primary key를 갖는 컬럼이다. 서로 다른 테이블의 row를 이 키 값을 통해 연결한다. 테이블의 foreign key는 다른 테이블의 primary key를 갖는다. 유니크(고유)하지 않아도 되고, NULL 값이어도 된다.

## 4. JOIN

```sql
SELECT albums.name, albums.year, artists.name FROM albums, artists;
```

- `FROM` 뒤에 콤마로 구분해서 여러 테이블을 적어주면 컬럼을 한 번에 뽑을 수 있다. `cross join`이라고 불린다.
- 두 개 이상의 테이블에서 select하려면 위 예처럼 앞에 테이블 이름을 명시해줘야한다. `.`으로 내부 컬럼 접근.
- 각 테이블의 모든 row들을 결과로 주기 때문에 cross join은 별로 유용하지 않다.

```sql
SELECT
  *
FROM
  albums
JOIN artists ON
  albums.artist_id = artists.id;
```

- 그래서 두 번째 예시처럼 사용한다. `albums`와 `artists` 테이블을 JOIN 하는데 artist_id 컬럼과 id 컬럼이 일치하도록 두 테이블의 관계를 정한다는 것. 결과가 그렇게 정렬되어 나온다.
- 다른 테이블의 primary key를 가진 foreign key가 있는 테이블을 먼저 적어주는게 좋다. 그래야 순서가 보기 좋다.

```sql
SELECT * FROM albums LEFT JOIN artists
ON albums.artist_id = artists.id;
```

- `Outer join`은 2개 이상의 테이블도 조합한다. 하지만 `inner join`과는 다르게 결합 조건이 필요 없다.
- Instead, every row in the left table is returned in the result set, and if the join condition is not met, then NULL values are used to fill in the columns from the right table.
- The left table is simply the first table that appears in the statement. Here, the left table is albums. Likewise, the right table is the second table that appears. Here, artists is the right table.
