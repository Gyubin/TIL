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
