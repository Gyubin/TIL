# FEIII Challenge 2016

[소개 페이지](https://ir.nist.gov/dsfin/index.html)

FEIII는 Financial Entity Identification and Information Integration의 약자다. FEIII 챌린지의 목적은 재무적 객체들을 구분하는 reference를 만드는 것이다. 이 reference의 기준은 entity를 구분하는 다양하고 이질적인 구분자들을 연결시켜서 만들어진다.(다양한 구분자가 이미 존재하고 있다.) 즉 계약서, 법률, 뉴스 기사, 소셜 미디어 등의 재무적인 정보들 속에서 특정 개체가 언급된다는 것이 어떤 의미인지 도출해내면 된다.

예를 들어보자. 계약서에서 'J. P. Morgan'이 멘션된다는 것은 SEC(Securities and Exchange Commission)에 의해 발행된 CIK(Central Index Key)가 '0000019617'인, 그리고 이 키를 기준으로 New York Stock Exchange에서 'JPM'으로 나타나는 법인인 'JPMorgan Chase & Co'가 계약서에 서명하고, 합의를 했다는 의미다.

## 0. 타임라인

- Data release: November 16, 2015
- Task guidelines: December 14, 2015
- Example ground truth release: January 15, 2016
- **Deadline for submission of results: March 15, 2016**
    + Advisory committee, organizing committee 소속이 Michigan, Maryland Baltimore인 것으로 보아 2016년 3월 15일 24시까지 제출이라고 했을 때 한국 시간으로는 2016년 3월 16일(수) 14시까지 제출하면 될 것 같다. 늦어도 3월 16일(수) 오전까지는 제출하자.
- Evaluation scores and ground truth released to participants: April 15, 2016
- One page report from invited participants: May 6, 2016
- Workshop report from organizers: May 6 2016
- Workshop event: Friday July 1, 2016 in conjunction with SIGMOD

## 1. 용어 설명

### 1.1 LEI

The Legal Entity Identifier 의 약자다. 즉 법인 구분자다. 재무적 거래에서 한 축이 되는 모든 legal entity(법인)을 어떤 법적 관할 영역 아래서도 unique하게 구분할 수 있는 글로벌 참조 데이터 시스템(global reference data system)을 만들기 위해 LEI가 디자인되었다.

G20의 지지를 받아서 GLEIS(Global LEI System)가 설립되었고, 덕분에 규제기구가 각 법인들을 평가하고, 리스크를 모니터링하는 것이 굉장히 효율적으로 변했다. 각 지역별로 운영되는 LOUs(Local Operating Units)가 생겼고 지역의 사법기구와 함께 LEI 적용에 힘쓰고 있다.

### 1.2 resolving mentions

계약서나 문서에 특정 법인의 mention이 있을 때 LEI의 그 법인을 의미하는 부분과 연결시켜야 한다는 것

### 1.3 entity integration(record linkage)

다양한 데이터에서 어떤 법인이 언급된 것을 찾아서 LEI와 연결시키는 것.

## 2. Task

financial entity에 대한 네 개의 데이터 파일을 받는다. 그리고 파일들 사이에서 연결되는 entity들을 구분하면 된다.

### 2.1 Input Data

- FFIEC.csv: Federal Financial Institution Examination Council에서 제공된 데이터다. 이 기관과 관련된 곳에서 통제되는 재정 기관과 은행들의 정보가 담겨있다.
- LEI.csv: 광범위한 기관들의 LEI 정보가 담겨있다.
- SEC.csv: Securities and Exchange Commission에서 제공되는 데이터다. SEC에 등록된 법인들에 대한 정보가 담겨있다.
- FHLB.csv: Federal Home Loan Banks에서 제공된 데이터다. FHLB 시스템 하에 있는 은행의 정보들이 있다.

규제 기관이 다르면 같은 법인임에도 불구하고 데이터가 다른 경우가 있다. 파일 별로 주소가 약간씩 다르게 표현될 수도 있고, 표현된 컬럼이 1개일 수도 3개로 나뉘어 값이 입력되어 있을 수도 있다. 이름 역시 마찬가지로 “Jim Smith”, “Smith, Jim”, “James T. Smith” 등으로 다양하게 표현될 수 있다. 'Overview on Entity Identification' 파일에서 분류하는 방식에 대해 간단히 소개해놓았다.

### 2.2 Task 설명

#### 2.2.1 FFIEC -> LEI

FFIEC, LEI 파일에서 매칭되는 것끼리 묶는 작업이다. `ORG_FFIEC_LEI_TP_X.csv` 파일을 만드는데 컬럼은 `FFIEC_IDRSSD`, `LEI_LEI` 2개만 만든다. 두 파일에서 행들을 구분하는 identifier들을 매칭되는 것 끼리 한 행으로 적어주면 되는 것이다. 매칭되지 않는 데이터들은 아예 적지 않는다.(빈칸 X)

원한다면 `FFIEC_IDRSSD` 컬럼만 담긴 `ORG_FFIEC_LEI_TN_X.csv` 파일을 만들어서 ffiec 파일의 내용 중 LEI 파일과 매칭되지 않는 자료들만 넣어보라.

#### 2.2.2 FFIEC -> SEC

`FFIEC`, `SEC` 파일을 매칭시킨다. `ORG_FFIEC_SEC_TP_X.csv` 파일을 만드는데 역시 첫 번째 task와 비슷하게 `FFIEC_IDRSSD`, `SEC_CIK` 두 개의 컬럼만 만든다. 두 파일의 identifier 정보만 담아서 연관되는 데이터를 담는다.

원한다면 `ORG_FFIEC_SEC_TN_X.csv` 파일에 `FFIEC_IDRSSD` 컬럼만 담아서 SEC 파일에 없는 FFIEC 파일의 데이터들을 담아둘 수 있겠다.

#### 2.2.3 FFIEC -> LEI, SEC(optional)

FFIEC의 데이터 중 LEI, SEC 둘 모두에 속한 것을 찾아내는 것이다. `ORG_FFIEC_LEI_SEC_TP_X.csv` 파일에 다음 세 컬럼이 담기면 된다. `FFIEC_IDRSSD`, `LEI_LEI`, `SEC_CIK`

#### 2.2.4 LEI -> SEC(optional)

LEI와 SEC 파일을 매칭시킨다. 파일명은 `ORG_LEI_SEC_TP_X.csv`이고 `LEI_CEI`, `SEC_CIK` 두 컬럼만 존재한다. 다 대 다 매칭이 될 수 있다.

### 2.3 Scoring

얼마나 많은 수의 매칭이 이루어졌는지, 제대로 매칭되었는지(Ground truth matches)를 통해서 점수를 내는데 ground truth matches는 [Duke](https://github.com/larsga/Duke)라는 중복 제거 엔진을 사용한다. 엔진 설명은 다음 [링크](https://ir.nist.gov/dsfin/data/Resources/FEIII_Slides.pdf)에서.
