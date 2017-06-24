# Pandas 기초

```py
from pandas import Series, DataFrame
import pandas as pd
import numpy as np
```

-자동적으로 혹은 명시적으로 축의 이름에 따라 데이터를 정렬할 수 있는 자료 구조, 잘못 정렬된 데이터에 의한 일반적인 오류를 예방하고 다양한 소스에서 가져온 다양한 방식으로 색인되어 있는 데이터를 다룰 수 있는 기능
-통합된 시계열 기능
-시계열 데이터와 비시계열 데이터를 함께 다룰 수 있는 통합 자료 구조
-산술연산과 한 축의 모든 값을 더하는 등의 데이터 축약연산은 축의 이름 같은 메타데이터로 전달될 수 있어야 한다.
-누락된 데이터를 유연하게 처리할 수 있는 기능
-SQL같은 일반 데이터베이스처럼 데이터를 합치고 관계연산을 수행하는 기능

## 1. Series

- 1차원 배열과 비슷. Numpy 자료형 다 담을 수 있다.
- `index`, `values`로 해당 값들 뽑을 수 있다.
- index는 숫자가 기본값이며, 직접 지정해줄 수도 있다. 인덱스로 접근할 수 있는데 인덱스가 정수형이 아니더라도 Dict에서 접근하는 것처럼 접근 가능.

```py
data = Series([4, 7 ,-5, 3])
# 0    4
# 1    7
# 2   -5
# 3    3
# dtype: int64
data.values # array([ 4,  7, -5,  3])
data.index # RangeIndex(start=0, stop=4, step=1)

data1 = Series([10, 20, 30, 40], index = ['d', 'c', 'b', 'a'])
# d    10
# c    20
# b    30
# a    40
# dtype: int64
data.index # Index(['d', 'c', 'b', 'a'], dtype='object')
data.values # array([10, 20, 30, 40])
```

- R과 비슷하게 `[ ]`안에 조건을 줄 수도 있다. `data[data>20]`같은 형태로 주면 해당 값들만 인덱스와 함께 뽑혀서 리턴된다.
- 덧셈은 같은 인덱스끼리 알아서 더해준다. 순서가 달라도 상관없다.

    ```py
    mine   = Series([10, 20, 30], index=['naver', 'sk', 'kt'])
    friend = Series([10, 30, 20], index=['kt', 'naver', 'sk'])
    mine + friend # 40 40 40
    ```

- 하지만 위와 같은 덧셈은 만약 서로 매칭되는 인덱스가 없을 경우 NaN 값이 들어간다. 이 때는 add를 쓴다.
    + 아래는 data 디렉토리 하위에 "SAMPLING_NPS_200"이라는 글자가 들어간 파일들을 골라서 read_csv로 파일을 읽는 코드다
    + 거기서 "MSICK_CD"라는 컬럼 값을 기준으로 groupby를 하는데 값은 그 크기로 한다.
    + 이 때 리턴값이 Series 객체인데 `add` 함수를 썼다. `fill_value = 0`으로 옵션을 줘서 인덱스 매칭이 안되면 0에서 더해지도록 한다. NaN 회피.

    ```py
    from os import listdir
    files = listdir('./data')
    result = pd.Series()
    for raw_data in filter(lambda x: 'SAMPLING_NPS_200' in x, files):
        temp = pd.read_csv('./data/' + raw_data, dtype=DTYPE_200, parse_dates=PARSE_DATES_200)
        result = result.add(temp.groupby('MSICK_CD').size(), fill_value = 0)
    ```

## 2. DataFrame

```py
data = {
    'foreigner':[603105,-405885,283715,365410, 302876, 393534],
    'sratio':[69.15, 68.99, 69.09, 69.02, 68.93, 68.85],
    'org':[-175461, -491416, -103877, -66765, -200711, -356901],
    'sprice':[37500, 36350, 38100, 37950, 37200, 36800],
    'fluctuation':[3.16, -4.59, 0.40, 2.02, 1.09, -0.67]
}
df = DataFrame(data,
    columns = ['foreigner', 'sratio', 'org', 'sprice', 'fluctuation'],
    index = ['02.06', '02.05', '02.04', '02.03', '02.02', '01.30']
)
```

- 가장 많이 쓰이는 자료구조. Series가 여러개 모여있는 형태이고 2차원 배열과 구조가 비슷하다.
- 생성: dict 형태의 data를 생성자에 넣어주면 된다. 컬럼명을 key, 값을 리스트에 담아서 넣는다.
- 위의 예처럼 `columns` 매개변수를 따로 지정해주지 않아도 데이터프레임이 만들어지지만 컬럼 순서가 뒤죽박죽이 될 수 있기 때문에 순서를 지키고싶으면 정해주면 된다.
- `index` 역시 안넣어줘도 자동으로 0부터 시작하는 인덱스가 가장 좌측에 표시되는데, 지정해주고싶으면 위처럼 하면 된다.
- `df['foreigner']` 형태로 컬럼 단위로 접근 가능. 새로운 컬럼을 넣을 때도 역시 이렇게 접근해서 값을 리스트 형태로 대입해주면 된다.
- `df.ix['02.06']` 형태로 행 단위로도 접근할 수 있다.
    + `df.ix[0:10, 10:20]` : 행, 열 순서로 인덱싱 가능. 이 때 슬라이싱은 끝 인덱스 **"포함"**이다.
    + 인덱싱해서 레이블 벡터를 뽑았다면 다음처럼 nX1 매트릭스로 만든다. `df.ix[:, 2].as_matrix().squeeze()` 
    + feature data 역시 사용하기 쉽게 ndarray로 만든다. `df.ix[:, 0:1].as_matrix().reshape(-1, 2)`
- 위 ix 함수는 deprecated 된다고 한다. 앞으로 `loc`, `iloc` 함수를 쓴다.
    + `df.loc[0:10, column_name]` : 컬럼명을 문자열로 준다.
    + `df.iloc[0:10, collumn_index]` : 컬럼명을 인덱스값으로준다.
- `df.T` : Transpose
- `df.index`, `df.columns` : 전체 인덱스와 컬럼값을 확인할 수 있다.

## 2.1 DataReader

- `pip install pandas-datareader` : 설치
- `import pandas_datareader.data as web`
- `gs = web.DataReader("078930.KS", "yahoo", start, end)`

## 3. 자주 쓰이는 함수

- `pd.read_csv('file_name.csv', header=None, skiprows=2)`
    + 첫 번째 매개변수로 파일명
    + `header=None` : 첫 째줄을 헤더로 인식하지 않고 그냥 데이터만 가져온다.
    + `skiprows=2` : 2행 미포함 이전까지를 읽지 않는다. 즉 0, 1행을 무시
    + `dtype={'a':str, 'b': int, 'c': float}` : 정해놓은 데이터 타입이 있는데 그냥 읽어오면 가장 적합한 데이터타입으로 자동 캐스팅된다. 만약 직접 타입을 지정해주고싶으면 dtype을 사용.
    + `parse_dates=['col1', 'col2']` : 특정 컬럼을 리스트 값으로 지정해놓으면 DataFrame으로 읽어올 때 그 컬럼을 알아서 dates 객체로 파싱한다. 따로 csv에는 date 타입으로 적을 수 없기 때문에 문자열이나 float 형으로 들어가있는 값을 사용할 때 파싱해서 쓴다.
- Series 객체든 DataFrame 객체든 `.to_csv()` 함수를 호출할 수 있다.
    + 매개변수로 아무것도 주지 않으면 문자열을 리턴하고,
    + 경로와 파일명까지 문자열로 지정해주면 바로 파일을 쓴다.
