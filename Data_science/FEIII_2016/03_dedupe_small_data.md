# dedupe with small data

dedupe 라이브러리를 활용해 작은 데이터를 중복 제거하는 방법을 기록한다. 사용한 데이터는 FFIEC.csv와 LEI.csv 데이터다. 10,000 레코드 이하의 작은 파일을 메모리에 통째로 올려서 하는 예제다. 두 데이터가 너무 커서 10시간도 넘게 돌아가느라 중간에 멈췄다. 큰 데이터는 dedupe mysql 버전을 활용해야함

## 0. 전체 흐름

- data
    + 비교할 데이터 정제하기
    + csv 데이터 읽어오기
    + 데이터 전처리(인코딩, 소문자화, 공백 줄이기, 특수기호 제거 등)
- 학습
    + (이전에 학습된 것이 있다면 바로 쓰고, 없으면 아래처럼 학습한다.)
    + 중복 제거할 때 비교할 컬럼 지정
    + Active Learning. 사용자가 직접 몇 개의 데이터 쌍을 비교.
- 클러스터링
    + 중복인 레코드들을 찾아서 하나로 묶어준다.
    + 클러스터링된 묶음들과 중복되지 않은 레코드 수를 합쳐 singleton_id를 만들어가며 최종 결과 파일 기록한다.

## 1. 데이터 정제 with R

하나의 파일에서 중복을 검사하는 형태로 짜여있다. 먼저 FFIEC, LEI 데이터에서 같은 의미를 갖는 컬럼들만 뽑아서 합쳤다. R을 활용했다.

```py
## Integrate data with R

# 데이터 읽어들이기
ffiec <- read.csv("FFIEC.csv", stringsAsFactors = F)
lei <- read.csv("LEI.csv", stringsAsFactors = F)

# 비교할 컬럼들 선택
name <- c(ffiec$Financial.Institution.Name.Cleaned, lei$LegalNameCleaned)
zipcode <- c(ffiec$Financial.Institution.Zip.Code.5, lei$LegalAddress_PostalCode_5)
city <- c(ffiec$Financial.Institution.City, lei$LegalAddress_City)
state <- c(ffiec$Financial.Institution.State, lei$LegalAddress_Region_2)
address <- c(ffiec$Financial.Institution.Address, lei$LegalAddress_Line_Combined)

# 각각의 파일에서 unique_id를 의미하는 자료
FFIEC_IDRSSD <- c(ffiec$IDRSSD, rep(0, 53958))
LEI_LEI <- c(rep(0, 6652), lei$LEI)

result <- data.frame(Id = 1:60610, FFIEC_IDRSSD = FFIEC_IDRSSD,
                     LEI_LEI = LEI_LEI, name = name, zipcode = zipcode,
                     city = city, state = state, address = address,
                     stringsAsFactors = F)

View(result)
write.csv(result, file = "task1_input.csv", row.names = F)
```

## 2. 데이터 전처리, 컬럼 지정

- 다음 파일 명을 지정해준다.
    + `input_file` : 중복 제거할 기본 파일이다.
    + `output_file` : 중복 판별 후 cluster, singleton id가 기록될 결과 파일
    + `settings_file`, `training_file` : 훈련된 결과, 가중치 등이 기록될 파일
- 데이터 전처리 함수: 하나의 컬럼, 즉 문자열이 입력되면 공백, 개행, 좌우 여백, 따옴표를 제거하고 모두 소문자로 바꾼다.

    ```py
    def preProcess(column):
        try : # python 2/3 string differences
            column = column.decode('utf8')
        except AttributeError:
            pass
        column = unidecode(column)
        column = re.sub('  +', ' ', column) # 공백이 2개 이상인 것들을 한 개로 줄임
        column = re.sub('\n', ' ', column) # 개행 문자는 공백으로 바꿈.
        column = column.strip().strip('"').strip("'").lower().strip() # 좌우 여백, 따옴표 제거, 소문자화
        # 데이터가 없으면 None으로 바꿔준다.
        if not column:
            column = None
        return column
    ```

- 데이터 읽어오기: dict 타입으로 저장한다. key는 record의 unique ID이고 값은 record name, value 쌍의 dict다.

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

    data_d = readData(input_file)
    ```

## 3. 학습

- settings 파일이 있다면 학습 단계를 생략한다.
- 바로 중복 제거하는 dedupe 객체를 만들고 클러스터링으로 넘어간다.

    ```py
    if os.path.exists(settings_file):
        print('reading from', settings_file)
        with open(settings_file, 'rb') as f:
            deduper = dedupe.StaticDedupe(f)
    ```

- 여기서부터 settings 파일이 없는 else 구문 하의 내용
- 학습할 필드를 지정해주는데 필드명(컬럼명)과 타입을 지정해준다. 미리 정해뒀던 entity name, zipcode, city, state, address를 지정해줬다. 타입은 모두 문자열.

    ```py
    fields = [
        {'field' : 'name', 'type': 'String'},
        {'field' : 'zipcode', 'type': 'String'},
        {'field' : 'city', 'type': 'String'},
        {'field' : 'state', 'type': 'String'},
        {'field' : 'address', 'type': 'String'},
    ]
    ```

- 비교할 컬럼들을 가지고 dedupe 객체를 생성한다.
- 학습할 때 사용할 데이터를 sample 함수의 매개변수로 넣는데 데이터가 작을 때는 따로 작업할 것 없이 그냥 넣는다.

    ```py
    deduper = dedupe.Dedupe(fields) # dedupe 객체 생성
    deduper.sample(data_d, 15000) # 학습위해 data를 집어넣는다.
    ```

- 이전에 dedupe를 돌려서 트레이닝 데이터를 가지고 있다면 찾아서 로드한다. 이전에 같은지, 다른지 입력해놓은 데이터가 있으면 이어서 사용한다. 처음부터 다시 판단하고다면 training_file을 지운다.

    ```py
    if os.path.exists(training_file):
        print('reading labeled examples from ', training_file)
        with open(training_file, 'rb') as f:
            deduper.readTraining(f)
    ```

- 확실하지 않은 레코드 쌍을 애매한 순서대로 하나씩 보여준다. y, n, u, f를 입력받아서 레코드 쌍을 판별한다. 순서대로 중복이다, 중복이 아니다, 잘 모르겠다, 그만하겠다는 의미다.

    ```py
    dedupe.consoleLabel(deduper) # 유저가 훈련 시킴
    deduper.train() # 훈련한 데이터를 기반으로 학습
    ```

- 학습이 끝나면 training, settings 파일을 저장한다. training은 우리가 판별한 기록을 의미하고, settings는 판별한 값을 가지고 훈련해서 가중치를 기록한 파일이다.

    ```py
    with open(training_file, 'w') as tf:
        deduper.writeTraining(tf)

    with open(settings_file, 'wb') as sf:
        deduper.writeSettings(sf)
    ```

- else 구문이 끝났다. 위 if/else 분기문에서 만들어진 dedupe 객체를 가지고 실제 데이터를 중복 제거한다. 가중치 평균을 최대화하는 지점을 찾는다.
- recall weight를 2로 두면 예측할 때 recall에 대해서 2배로 신경쓴다는 의미다.

    ```py
    threshold = deduper.threshold(data_d, recall_weight=1)
    ```

## 4. 클러스터링

- match 함수는 dedupe가 같은 것으로 생각하는 record ID 세트를 리턴한다.

    ```py
    clustered_dupes = deduper.match(data_d, threshold)
    ```

- 원본 데이터를 CSV로 저장하는데 'Cluster ID'라는 컬럼을 추가한다. 중복인 레코드가 클러스터링된 덩어리들을 가리킨다.
    ```py
    cluster_membership = {}
    cluster_id = 0
    # 위 match 함수를 통해 리턴된 클러스터들이 모인 객체를 활용한다.
    for (cluster_id, cluster) in enumerate(clustered_dupes):
        id_set, scores = cluster # cluster는 튜플 형태로 되어있어서 해체로 할당한다. 같은 id, score.
        cluster_d = [data_d[c] for c in id_set] # 원본 데이터에서 모든 id들에 해당하는 행을 뽑는다.
        canonical_rep = dedupe.canonicalize(cluster_d) # 정렬한다.
        for record_id, score in zip(id_set, scores): # id_set과 scores에서 하나씩 뽑아서 for 반복한다.
            # 키는 record_id가 되고, 값은 dict가 되는데 아래 cluster_id, canonical, confidence가 들어간다.
            cluster_membership[record_id] = {
                "cluster id" : cluster_id,
                "canonical representation" : canonical_rep,
                "confidence": score
            }
    singleton_id = cluster_id + 1 # 유니크한 개체들의 개수 의미.
    ```

## 5. 결과 파일 출력

```py
# 파일스트림을 동시에 열어서 읽는 동시에 바로 쓴다.
with open(output_file, 'w') as f_output, open(input_file) as f_input:
    writer = csv.writer(f_output)
    reader = csv.reader(f_input)

    heading_row = next(reader) # 첫 행에 컬럼 추가한다.
    heading_row.insert(0, 'confidence_score')
    heading_row.insert(0, 'Cluster ID')
    canonical_keys = canonical_rep.keys()
    for key in canonical_keys:
        heading_row.append('canonical_' + key)

    writer.writerow(heading_row) # 첫 행 쓰기.

    # input_file에서 한 행씩 읽어들인다.
    for row in reader:
        row_id = int(row[0])
        if row_id in cluster_membership: # 만약 중복 클러스터 집단에 row가 있다면 새로 생긴 컬럼에 값 대입.
            cluster_id = cluster_membership[row_id]["cluster id"]
            canonical_rep = cluster_membership[row_id]["canonical representation"]
            row.insert(0, cluster_membership[row_id]['confidence'])
            row.insert(0, cluster_id)
            for key in canonical_keys:
                row.append(canonical_rep[key].encode('utf8'))
        else:
            row.insert(0, None)
            row.insert(0, singleton_id)
            singleton_id += 1
            for key in canonical_keys:
                row.append(None)
        writer.writerow(row)
```
