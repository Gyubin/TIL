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

Class for active learning deduplication. Use deduplication when you have data that can contain multiple records that can all refer to the same entity.

```py
class Dedupe(variable_definition[, data_sample=None[, num_cores]])
```

Parameters: 

- variable_definition (dict) – A variable definition is list of dictionaries describing the variables will be used for training a model.
- data_sample – is an optional argument that we discuss below
- num_cores (int) – the number of cpus to use for parallel processing, defaults to the number of cpus available on the machine
