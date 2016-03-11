# TASK 1: FFIEC -> LEI

## 0. 기본 정보

- 데이터
    + FFIEC.csv: Federal Financial Institution Examination Council에서 제공된 데이터다. 이 기관과 관련된 곳에서 통제되는 재정 기관과 은행들의 정보가 담겨있다.
    + LEI.csv: 광범위한 기관들의 LEI 정보가 담겨있다.
- 태스크
    + FFIEC, LEI 파일에서 매칭되는 것끼리 묶는 작업이다.
    + 결과 파일 명: `ORG_FFIEC_LEI_TP_X.csv`
    + 컬럼 2개: `FFIEC_IDRSSD`, `LEI_LEI`
    + 매칭되지 않는 데이터들은 아예 적지 않는다.(빈칸 X)
    + `FFIEC_IDRSSD` 컬럼만 담긴 `ORG_FFIEC_LEI_TN_X.csv` 파일을 만들어서 LEI에 없는 FFIEC 파일의 데이터를 정리해보자.

## 1. 비교 컬럼

비교할 만 한 컬럼들만 추렸다. 서로 비교가 어려운 날짜나, 법인 종류 등의 컬럼들은 제외했다. 크게 이름과 주소로 나뉘어지는데 매칭되는 비슷한 컬럼 중에서도 가장 데이터가 많고 비슷한 내용의 컬럼끼리 묶었다. 아래 표에서 '사용'이라고 되어있는 두 컬럼들을 서로 비교할 것이다.

|   kind  |               FFIEC                |               LEI               | etc  |
|---------|------------------------------------|---------------------------------|------|
| name    | Financial.Institution.Name.Cleaned | LegalNameCleaned                | 사용 |
|         | Financial.Institution.Name         | LegalName                       |      |
| zipcode | Financial.Institution.Zip.Code.5   | LegalAddress_PostalCode_5       | 사용 |
|         | Financial.Institution.Zip.Code     | LegalAddress_PostalCode_Numbers |      |
|         |                                    | LegalAddress_PostalCode         |      |
| city    | Financial.Institution.City         | LegalAddress_City               | 사용 |
| state   | Financial.Institution.State        | LegalAddress_Region_2           | 사용 |
|         |                                    | LegalAddress_Region             |      |
|         |                                    | LegalAddress_Country            |      |
| address | Financial.Institution.Address      | LegalAddress_Line_Combined      | 사용 |
|         |                                    | LegalAddress_Line_Cleaned       |      |
|         |                                    | LegalAddress_Line1              |      |
|         |                                    | LegalAddress_Line2              |      |
|         |                                    | LegalAddress_Line3              |      |
|         |                                    | LegalAddress_Line4              |      |

- name: name, name.cleaned
    + FFIEC: 기호(&->and)와 이름 맨 뒤에 붙어있는 쓸데없는 단어(', THE')를 없애서 cleaned 컬럼을 만들었다.
    + LEI: clened에서 기호 변환을 하지 않았다. 따로 데이터 처리를 해야 한다.
    + LEI 기호 변환 후 cleaned를 쓰는 것으로 한다.
- zipcode: zipcode, zipcode5
    + FFIEC: zipcode가 길 경우 앞 5자리만 뽑아서 zipcode5를 만들었다. 맨 앞 숫자가 0이면 없앤다. 직접 zipcode를 zipcode.5로 만들어보고 같음을 확인했다.
    + LEI: 전체(문자열), 전체(숫자), 앞5자리(숫자)의 세 가지 컬럼이 있다. FFIEC와 맞춰서 앞5자리를 쓰는데 비교를 위해 문자열로 바꿔준다. FFIEC 쪽을 숫자로 바꿔주는 것도 좋다.
    + 전체가 좀 더 세부적이라서 쓰려고했지만 LEI의 전체 zipcode에서 알파벳이 들어간 경우가 있었다. 알파벳 처리하느니 5자리를 쓰는걸로 하겠다. 전체 zipcode를 쓰는 것보다는 구분 덜 되겠지만 어쩔 수 없다.
- city는 각각 하나씩밖에 없어서 둘을 매칭한다.
- state는 FFIEC에만 존재해서 LEI 중에 state 정보가 있는 LegalAddress_Region_2 컬럼을 사용한다.
- address
    + FFIEC: 컬럼 하나밖에 없다. 사용한다.
    + LEI: combined, cleaned, line1, 2, 3, 4 컬럼이 존재한다. 이 중에 cleaned에는 회사 이름이 빠져있다. 없는 것보다는 나을 것 같아서 line1, 2, 3, 4 모두 포함되어있는 combined를 사용하는 것으로 결정했다.
- headquarter에 대한 주소 정보도 다음처럼 존재한다. 하지만 city 부분을 기본 정보와 본사 정보를 비교해봤을 때 총 53,958개 중 같은 것은 16,214개 밖에 없었다. 나머지 컬럼들도 거의 의미 없는 것으로 보고 제외했다.
    + HeadquartersAddress_Line1
    + HeadquartersAddress_Line2
    + HeadquartersAddress_Line3
    + HeadquartersAddress_Line4
    + HeadquartersAddress_City
    + HeadquartersAddress_Region
    + HeadquartersAddress_Country
    + HeadquartersAddress_PostalCode

## 2. 비교 방식

### 2.1 `==` 같은지에 대한 단순 비교 가능한 컬럼

- zipcode: 숫자로 이루어진 문자열이다. 다르게 표현될 여지가 없다. 단순 비교 가능.
- city: 두 컬럼 모두 소문자화(혹은 대문자화)해서 단순 비교할 수 있다.
- state: 두 글자로 이루어진 미국 state의 줄임 표현이다.
    + 하지만 없는 값이 있다. 예를 들어 LEI 파일에서 state 정보가 있는 LegalAddress_Region_2 컬럼의 353-373행은 정보가 없이 아예 비어있다. 빈 문자열이 들어있는 데이터의 총 수는 1074개다. 
    + city-state 연관표를 만들고 그에 맞는 state 값을 집어넣어서 비교하는 것으로 해본다.

### 2.2 단순 비교 불가능한 컬럼

name, address 컬럼들은 단순 비교 불가능하다. 같은 법인이라도 조사기관이 달라서 이름과 주소가 살짝 다를 수 있기 때문이다.

#### 2.2.1 단어 단위 확률 계산(bag of words)

- 가장 기초적인 Supervised learning 활용
- 모든 문자열을 소문자로 바꾸고, `" "`(공백)과 `","`(comma)를 기준으로 컬럼의 값을 구분해서 list로 만든다.
- 단어별로 쪼개진 FFIEC, LEI 파일의 name, address 컬럼의 모든 데이터들을 bag of words로 만든다.
- FFIEC의 데이터가 LEI의 데이터 중 어떤 것에 속할지 확률을 하나하나 계산해서 가장 높은 확률인 값을 하나하나 매칭시킨다. 일정 수준(예를 들어 70%) 이상 확률이 나오지 않으면 매칭이 되지 않는걸로 간주한다.

**문제점**

- 'abcde' 와 'abcd' 처럼 줄임표현된 단어들이 많은데 위 방법으로는 이것의 유사도를 측정할 방법이 없다.
- 비교할 때 동일하게 취급되거나 무시해야 할 단어들이 있다. `sample_data_release_v2.csv` 파일을 보면 다음 단어들은 동일하게 취급되고 혹은 아예 들어가있지 않은데도 같은 법인이다.

|  FFIEC  |     SEC     |
|---------|-------------|
| bank    | corp        |
| company | co          |
| bank    | bancorp inc |
|         | /msd        |
|         | /gfn        |
|         | /ta         |
|         | na          |
| and     | &           |
| route   | rte         |

#### 2.2.2 추천하는 도구를 사용하는 방법

- 1순위: Duke
- 다른 추천 도구들: FRIL, SILK, Karma, Dude, Metanome, Dedupalog, Febri, Choicemaker

## 3. 부록

### 3.1 컬럼 표

|    |                FFIEC                 |               LEI               |
|----|--------------------------------------|---------------------------------|
|  1 | IDRSSD                               | LOU                             |
|  2 | FDIC.Certificate.Number              | LOU_ID                          |
|  3 | OCC.Charter.Number                   | LEI                             |
|  4 | OTS.Docket.Number                    | LegalName                       |
|  5 | Primary.ABA.Routing.Number           | LegalNameCleaned                |
|  6 | Financial.Institution.Name           | AssociatedLEI                   |
|  7 | Financial.Institution.Name.Cleaned   | AssociatedEntityName            |
|  8 | Financial.Institution.Address        | LegalAddress_Line_Cleaned       |
|  9 | Financial.Institution.City           | LegalAddress_Line_Combined      |
| 10 | Financial.Institution.State          | LegalAddress_Line1              |
| 11 | Financial.Institution.Zip.Code       | LegalAddress_Line2              |
| 12 | Financial.Institution.Zip.Code.5     | LegalAddress_Line3              |
| 13 | Financial.Institution.Filing.Type    | LegalAddress_Line4              |
| 14 | Last.Date.Time.Submission.Updated.On | LegalAddress_City               |
| 15 |                                      | LegalAddress_Region_2           |
| 16 |                                      | LegalAddress_Region             |
| 17 |                                      | LegalAddress_Country            |
| 18 |                                      | LegalAddress_PostalCode         |
| 19 |                                      | LegalAddress_PostalCode_Numbers |
| 20 |                                      | LegalAddress_PostalCode_5       |
| 21 |                                      | HeadquartersAddress_Line1       |
| 22 |                                      | HeadquartersAddress_Line2       |
| 23 |                                      | HeadquartersAddress_Line3       |
| 24 |                                      | HeadquartersAddress_Line4       |
| 25 |                                      | HeadquartersAddress_City        |
| 26 |                                      | HeadquartersAddress_Region      |
| 27 |                                      | HeadquartersAddress_Country     |
| 28 |                                      | HeadquartersAddress_PostalCode  |
| 29 |                                      | Register                        |
| 30 |                                      | BusinessRegisterEntityID        |
| 31 |                                      | EntityStatus                    |
| 32 |                                      | InitialRegistrationDate         |
| 33 |                                      | RegistrationStatus              |
| 34 |                                      | LastUpdateDate                  |
| 35 |                                      | EntityExpirationDate            |
| 36 |                                      | EntityExpirationReason          |
| 37 |                                      | NextRenewalDate                 |
| 38 |                                      | SuccessorLEI                    |
| 39 |                                      | LegalForm                       |
