# dedupe: python deduplication library

Java에 익숙하지 않아서 duke 라이브러리를 활용하지는 못했다. 대안으로 파이썬 라이브러리 `dedupe`를 사용하기로 했다. duke에 비해 성능이 어떨진 모르겠지만 실행이나 코드 해석하기가 훨씬 편하다.

## 0. 자료

- Github repository: [https://github.com/datamade/dedupe](https://github.com/datamade/dedupe)
- 예제 파일: [https://github.com/datamade/dedupe-examples)](https://github.com/datamade/dedupe-examples))
- 공식 문서: [http://dedupe.rtfd.org/](http://dedupe.rtfd.org/)
- 2013 호주 파이콘 발표 자료: [https://www.youtube.com/watch?v=Z6mlvrYEYnk](https://www.youtube.com/watch?v=Z6mlvrYEYnk)

## 1. 설치

```sh
pip install numpy
pip install dedupe
```

## 2. API

### 2.1 Dedupe Objects

중복제거를 학습하는 클래스다. 한 entity에 대한 여러 record를 가지고 있을 때, 즉 여러 컬럼을 가지고 있는 데이터가 있을 때 중복 제거할 수 있다.

> Class for active learning deduplication. Use deduplication when you have data that can contain multiple records that can all refer to the same entity.

```py
class Dedupe(variable_definition[, data_sample=None[, num_cores]])
```

- variable_definition : 데이터에서 variable(컬럼)을 의미하 dict가 여럿 담긴 리스트다. 이 리스트는 model을 학습하는데 사용된다.
    + A variable definition is list of dictionaries describing the variables will be used for training a model.
- data_sample : optional이다. 아래에서 자세히 설명
    + data_sample is an optional argument that we discuss below
- num_cores : 병렬처리할 때 사용할 cpu 개수를 의미. 디폴트는 컴퓨터에서 사용할 수 있는 cpu 최대 개수.
    + the number of cpus to use for parallel processing, defaults to the number of cpus available on the machine

#### 2.1.1 data_sample

중복 제거하는 것을 학습하려면 몇 개의 샘플 record(컬럼)가 필요하다. 데이터가 크지 않다면, 즉 메모리가 충분히 데이터를 커버할 수 있다면 단순히 `sample` 메소드에 데이터를 매개변수로 넣어주면 된다.

> In order to learn how to deduplicate records, dedupe needs a sample of records you are trying to deduplicate. If your data is not too large (fits in memory), you can pass your data to the sample() method and dedupe will take a sample for you.

```py
# initialize from a defined set of fields
variables = [
             {'field' : 'Site name', 'type': 'String'},
             {'field' : 'Address', 'type': 'String'},
             {'field' : 'Zip', 'type': 'String', 'has missing':True},
             {'field' : 'Phone', 'type': 'String', 'has missing':True}
             ]
deduper = dedupe.Dedupe(variables)
deduper.sample(your_data)
```

메모리가 데이터 크기를 커버하지 못한다면 직접 샘플을 만들어서 Dedupe에다 넣어줘야 한다.

> If your data won’t fit in memory, you’ll have to prepare a sample of the data yourself and pass it to Dedupe.

`data_sample`은 tuple로 이루어져있어야 한다. 아래 코드를 보면 data_sample은 리스트이고 원소가 튜플 하나다. 그리고 그 튜플 안에 여러개의 dedupe.frozendict가 들어있다. 즉 `[( dedupe.frozendict(), dedupe.frozendict() )]` 이런 식이다. "리스트 - 튜플 - frozendict's". frozendict에는 컬럼명이 key로 들어가고, 그 값이 value로 들어간다.

> data_sample should be a sequence of tuples, where each tuple contains a pair of records, and each record is a frozendict object that contains the field names you declared in field_definitions as keys.

```py
data_sample = [(
                dedupe.frozendict({'city': 'san francisco',
                                   'address': '300 de haro st.',
                                   'name': "sally's cafe & bakery",
                                   'cuisine': 'american'}),
                dedupe.frozendict({'city': 'san francisco',
                                   'address': '1328 18th st.',
                                   'name': 'san francisco bbq',
                                   'cuisine': 'thai'})
               )
              ]

deduper = dedupe.Dedupe(variables, data_sample)
```

#### 2.1.2 sample()

```py
sample(data[, [sample_size=15000[, blocked_proportion=0.5]]])
```

Dedupe Object를 data_sample로 초기화하지 않았다면(옵션으로 데이터 샘플을 넣어서 인스턴스 생성할 수 있었다) 이 메소드를 통해 학습할 임의의 샘플 데이터를 집어넣어줘야 한다.

> If you did not initialize the Dedupe object with a data_sample, you will need to call this method to take a random sample of your data to be used for training.

- data: dictinary 타입의 객체다. sample 메소드에서 사용할 데이터를 만드는 아래 코드를 보면 좀 더 쉽게 이해할 수 있다. 데이터에서 각 record(컬럼)를 나타내는 unique ID가 key가 되고, vallue는 `{column name: column value}`로 나타나는 dict 객체가 된다.
    + dictionary-like object indexed by record ID where the values are dictionaries representing records.

    ```py
    def readData(filename):
        data_d = {}
        with open(filename) as f:
            reader = csv.DictReader(f)
            for row in reader:
                clean_row = [(k, preProcess(v)) for (k, v) in row.items()]
                row_id = int(row['Id'])
                data_d[row_id] = dict(clean_row)

        return data_d
    ```

- sample_size (int): 리턴할 record tuple의 개수다. default는 15,000
    + Number of record tuples to return. Defaults to 15,000.
- blocked_proportion (float): 임의로 뽑은 record가 아니라, 비슷한 record들에서 샘플링될 record 쌍의 비율을 정해준다. 디폴트값은 0.5
    + The proportion of record pairs to be sampled from similar records, as opposed to randomly selected pairs. Defaults to 0.5.

```py
data_sample = deduper.sample(data_d, 150000, .5)
```

#### 2.1.3 uncertainPairs()

샘플 중에서 Dedupe가 가장 구분하기 힘든 record 쌍을 리스트에 담아 리턴한다. 이 메소드를 가지고 User Interface를 만들어서 사람이 직접 학습시킬 때 사용하면 좋다.

> Returns a list of pairs of records from the sample of record pairs tuples that Dedupe is most curious to have labeled. This method is mainly useful for building a user interface for training a matching model.

```py
pair = deduper.uncertainPairs()
print pair
# [({'name' : 'Georgie Porgie'}, {'name' : 'Georgette Porgette'})]
```

#### 2.1.4 markPairs(labeled_examples)

사용자가 판별한 record 쌍을 training data에 넣고, matching models을 업데이트한다. 이 메소드 역시 UI를 통해 matching model을 훈련시키거나, 기존 소스에 training data를 추가하기에 좋다.

> Add users labeled pairs of records to training data and update the matching model. This method is useful for building a user interface for training a matching model or for adding training data from an existing source.

매개변수로 들어가는 `labeled_examples`는 2개 키(match, distinct)를 갖고 있는 dictionary다. value는 record 쌍의 두 dictionary가 들어있는 튜플이다.

> a dictionary with two keys, match and distinct the values are lists that can contain pairs of records.

```py
labeled_examples = {'match'    : [],
                   'distinct' : [({'name' : 'Georgie Porgie'},
                                  {'name' : 'Georgette Porgette'})]
                   }
deduper.markPairs(labeled_examples)
```
