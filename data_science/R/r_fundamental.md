# R 기초 정리

## 0. 설치

- homebrew 설치한다. [brew.sh](brew.sh) 참고. 터미널에서 다음 코드 입력

```sh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

- 다음 코드 순서대로 터미널에 입력한다. 첫번째 업데이트, 업그레이드를 실행한 후에 `brew doctor`를 입력해서 현재 homebrew에 문제가 없는지 확인해보는 것도 좋다. 두 번째 tap 명령어는 homebrew가 패키지를 다운받기 위해 접속하는 repository를 추가하는 명령어다. r을 실제 설치하기 전에 저 장소를 추가해두면 과학과 관련된 다른 여러 의존성 라이브러리들을 자동으로 설치할 수 있다.

```
brew update && brew upgrade
brew tap homebrew/science
brew install r
```

## 1. 기본

- 터미널에서 `r`을 입력하면 r 전용 REPL이 뜬다. 연습하면 된다. 혹은 Rstudio 써도 괜찮다.
- 확장자 명은 `file_name.R` 이다.
- `?func` : 앞에 물음표를 붙이고 함수이름을 치면 함수 정보가 뜬다.
- 주석은 `#`
- operator
    + 다른 프로그래밍 언어처럼 `+ - *`는 똑같다.
    + 나누기는 `/` 표현은 같지만 정수를 정수로 나눠도 결과가 정수인 것이 아니라 실수가 된다. 3/2 를 하면 1.5가 나온다. 정수 결과를 얻고싶다면 `3%/%2`를 하면 되고 결과는 1이다.
    + 승수는 `3^2` 형태로 쓴다. 결과는 9
    + 나머지는 `5 %% 3` 형태로 쓴다. 결과는 2
- 논리, 비교연산자 : `<, <=, >=, >` 부등호 연산 다 똑같고, `==, !=` 도 똑같이 쓰이고, not도 `!x` 같은 형태로 사용된다. 논리연산 역시 or은 `|` and는 `&`으로 같다.
- boolean : TRUE, T, FALSE, F 로 쓴다. `isTRUE(x)`로 boolean 체크할 수도 있다. 그런데 이 함수에서 매개변수로 `1`을 넣으면 FALSE가 리턴되는데 `1 == T`를 하면 TRUE다. ~~뭘까 이놈의 R은. 이런거 발견할 때마다 다른 언어랑 차이가 느껴짐~~
- NULL(정의되지 않은 값), -Inf, Inf(무한대), NaN(연산 불능일 때), NA(Missing value)
- 복소수는 실제 수학에서 쓰는 그대로 `1 + 2i` 이런식으로 쓰면 된다.
- 대입 : `a = 3` or `a <- 3` 두 형태 모두 가능. 예전엔 `<-`만 있었다는데 `=`가 추가된 것이라고 한다.
- `sum(1, 2, 3, 4)` : sum 함수 내에 바로 숫자 넣어서 합 구할 수도 있다. `sqrt(16)`도 마찬가지.
- NA 값이 벡터에 섞여있을 때 sum 함수 실행하면 결과값은 NA다. sum 함수에 옵션을 집어넣으면 NA값을 제외시킬 수 있다. `sum(a, na.rm = TRUE)`
- boolean 값이 원소로 들어있을 때 sum 함수는 TRUE를 1, FALSE를 0으로 취급한다.
- `print(object)` : 출력함수

## 2.1 Data Mode

가장 기초가 되는 Data Mode(유형)이다. 가장 작은 데이터 그 자체의 속성.

- 기본 유형
    + numeric : integer, double
    + complex: 1+1i, 3i
    + character: 문자나 문자열
    + logical : TRUE, FALSE(T,F는 전역변수)
- 특수 데이터
    + NULL: 값이 없음
    + NAN: 수학적으로 정의 불가능
    + NA: 결측치
    + Inf, -Inf: 양 음 무한대

연산 우선순위가 있다. 예를 들어 동질적 데이터가 모여야 하는 vector, matrix, array에서 다른 타입의 원소를 가지고 생성하면 다음처럼 data mode가 강제 형변환된다. `문자형 > 복소수형 > 수치형 > 논리형`

- Type check, coercion: 앞에 is. as. 붙이고 이름 적어주면 된다.
    + `is.integer(x)`, `is.double(x)`, `is.numeric(x)` 
    + `is.complex(x)` 복소수
    + `is.character(x)` 문자열
    + `is.logical`
    + `is.na(x)` NA 값인지
    + `is.null(x)`
    + `is.nan(x)`
    + `is.infinite(x)`

## 2.2 Data Object

### A. Vector

- 벡터는 **모든 속성이 동질적**이다. 만들 때 `c(1, 2, 3, 4, 'hi')` 이렇게 만들면 1, 2, 3, 4가 모두 자동으로 문자열로 형 변환이 된다.
- 생성 방법: `c` Combine의 약자다.
    + `c(1, 2, 3, 4, 10, 100, 1000)` : 원소 특정
    + `c(1, 2, c(5, 7, 10))` : c 함수를 섞을 수도 있음. 1, 2, 5, 7, 10 됨.
    + `1:10` : 1에서 10까지(10 포함이다) 순서대로 벡터 만들기. 숫자가 `5:1`처럼 역순이 될 수도 있다.
    + `seq(from, to, by)` : from부터 to까지 by 간격으로 벡터 생성. 매개변수 이름 없이 입력하면 from, to, by가 들어간다. 이 때 by는 1이 디폴트값이다. by 대신 `length.out`을 쓸 수도 있는데 원소 수를 지정할 때 쓴다. seq(1, 10, length.out=19) 를 하면 0.5 간격이 자동으로 계산되고 총 19개 원소의 벡터가 생성된다.
    + `rep(data, times, each)` : 반복문 같은 함수를 사용해서도 벡터 생성 가능. 첫 번째 매개변수로는 반복할 자료(벡터)가 들어가고 매개변수 이름 지정해줄 필요 없다. 두 번째 매개변수로 매개변수 이름 지정하지 않으면 디폴트로 times 값이 되고 전체 반복 횟수를 의미한다. each를 써서 원소별 반복횟수를 지정할 수도 있다.
- `length(vector)` : 길이 리턴한다.
- 벡터의 첫 시작 인덱스는 1이다. 그리고 범위로 쓸 때 '어디까지'를 나타내는 수는 포함이다. 
- `vector[ ]` 대괄호 용법. index 시작은 1부터
    + 값 하나 추출 : `A[1]` 숫자 하나 입력하면 그 숫자에 맞는 index의 value 리턴
    + 값 여러개 추출 : 다음처럼 생각하기 쉽지만 에러난다. `A[1, 2, 3]` 처럼 `,` comma로 구분된 숫자 입력하면 차원을 의미한다. 숫자 수 만큼이 차원의 수다. x, y, z 좌표가 각각 1, 2, 3인 원소를 리턴한다. 그런데 벡터는 1차원이므로 이렇게 하면 오류가 난다. 다른 자료형에선 가능함
    + 다시 값 여러개 추출 : `A[c(1, 2, 10)]` 이렇게 대괄호 안에 벡터를 써 줘야 함. 즉 매개변수를 하나만 넣는 것이고, 벡터 형태로 하면 여러개 추출 가능하다. 자연스럽게 `A[1:3]` 도 가능하다.
    + 선택 인덱스 제외하기 : `A[-c(1, 2, 3)]` 앞에 `-`를 붙이면 1, 2, 3 인덱스 원소는 제외한 A 벡터를 리턴한다.
    + 조건을 넣는 경우 필터링 가능: `A[A>1]`, `subset(A, A>1)`, `A[which(A>1)]`을 하면 1보다 크다는 조건에 맞는 원소만 뽑힌 벡터가 리턴된다. 그냥 `A>1` 하면 1보다 큰지에 대한 TRUE, FALSE 값이 원소별로 출력된다.
- 위 대괄호를 사용해서 값을 변경할 수도, 새로운 원소를 집어넣을 수도 있다. 만약 1에서 4 인덱스까지 원소가 있는데 6 인덱스에다 원소를 집어넣으면 5 인덱스는 자동으로 `NA` 값이 된다.
- 벡터 연산
    + 스칼라값과 연산: 모든 원소에 적용된다. `A + 2` 모든 A 벡터 원소에 2가 더해진다.
    + 벡터끼리 덧셈 : 벡터가 이어지지 않는다. 동일한 크기면 같은 위치 간에 덧셈이 일어난다. 만약 길이가 같거나, 배수관계에 있다면 정상 동작한다. 배수관계일 때는 짧은 쪽이 반복된다. 하지만 길이가 다른데 배수관계도 아니면 반복되긴 하는데 되다 만다. 그래서 경고 메시지 띄워짐.
    + 벡터끼리 `==` : 각 원소별로 비교된다. 각각 TRUE, FALSE가 리턴됨.
- 벡터 원소에 이름 지정
    + `c(name = 'data', season = 3)`
    + `names(vector)` : vector에 이름이 뭐가 있는지 알려준다.
    + `names(vector) = c('name1', 'name2')` 이렇게 names 함수에 문자열 벡터를 대입해주게 되면 이름을 입력해주는 역할이다. 없으면 자연스럽게 추가되고, 있었으면 교체된다.
    + 값을 이름으로 접근 가능. `c()` 함수를 통해서 이름을 지정할 땐 문자열 표시를 따로 하진 않지만, 접근할 때나 `names` 함수로 이름을 지정할 떄는 문자열 형태로 해야 한다.
- 벡터를 만들 때 쓰는 `:` 이 `-`보다 연산 우선순위가 높다. `1:3-1`과 `1:(3-1)`의 차이가 있음.
- `all(A < 5)`, `any(A < 5)` : 매개변수를 보면 스칼라값과 연산이다. 즉 모든 원소에 적용된다. all은 모든 결과가 TRUE여야 TRUE를 리턴, any는 하나라도 TRUE면 TRUE를 리턴한다.

### B. Matrix

- 모든 원소가 **동질적**
- 매트릭스 생성
    + `matrix(0, 3, 4)` : 첫 번째는 data, 둘셋째는 각각 row, column이다. data에 스칼라값을 넣으면 모든 원소가 그 값으로 초기화된다.
    + `matrix(data, byrow=TRUE, nrow=3, dimnames=list(v1, v2))` : byrow는 data를 행 순으로 채울 것인지 정해준다. 기본은 열부터 순서대로 채워진다. nrow는 행 수를 지정하는 것, dimnames는 벡터가 포함되어있는 list가 들어가는데 순서대로 행, 열의 이름을 의미한다.
    + vector to matrix : `dim(vector) <- c(2, 4)` 함수를 활용해 행, 열을 지정해주면 된다. 2행 4열이 되면서 matrix 자료형이 된다.
- 원소 접근: `[r, c]` r행 c열 값
    + 만약 행, 열 전체를 뽑고 싶다면 `myMatrix[r, ]` 혹은 `myMatrix[, c]` 형태가 되어야 한다. 콤마 필수. 콤마를 안 쓰고 그냥 숫자 하나만 쓰면 마치 벡터에서 뽑는 것처럼 원소가 하나만 뽑힌다. ~~`[[1]]` 이런거 없다.~~
    + 각 행, 열 값에 벡터를 넣을 수도 있다. `myMatrix[1:2, 3:5]`라면 12행, 345열이 뽑혀서 2행 3열 매트릭스가 리턴된다.
- `contour(matrix)` : 매트릭스를 매개변수로 받아서 등고선 그래프를 그린다.
- `persp(matrix, expand = 0.2)` : 3D 투시도법으로 보는 그래프를 그린다. expand 값을 조절해서 그래프 모양을 바꿀 수 있다. `volcano`라는 매트릭스 예시 데이터가 기본 삽입돼있으니 활용해봐도 좋다.
- `image(matrix)` : 매트릭스에 색을 입히는 것 같다. volcano 예시 자료를 대입해보면 heat map이 그려진다.
- 매트릭스 이름 넣기
    + `rownames(my_matrix) <- name_vector` : 행에 이름 넣기
    + `colnames(my_matrix) <- name_vector` : 열에 이름 넣기
- 매트릭스에서 행, 열 합 구하기
    + `rowSums(my_matrix)` : 매트릭스 각 행을 합해서 벡터로 리턴. 행 이름이 스칼라값의 name이 된다.
    + `colSums(my_matrix)` : 행 부분과 원리가 같다.
- 행, 열 추가하기
    + `cbind(v1, v2, m1, v3, m2)` : 매트릭스 합병 또는 컬럼 추가
    + `rbind(m1, m2, c1)` : 행 추가
- 당연하게도(?) 스칼라값을 곱하면 전체 원소에 적용

### C. factor

- 생성: `factor(myVector)` 형태가 일반적이다.
- ordinal(순서가 있는) 범주라면 다음 코드와 같다. ordered 매개변수를 TRUE로 주고, levels 매개변수에 순서를 나타내는 벡터를 넣어준다.

```
temperature_vector <- c("High", "Low", "High","Low", "Medium")
factor_temperature_vector <- factor(temperature_vector, ordered = TRUE, levels = c("Low", "Medium", "High"))
```

- ordinal 범주라면 원소끼리 비교 가능하다. `< > <= >=` 등의 연산 가능.
- 벡터를 매개변수로 넣어서 factor를 생성하면 벡터의 원소 중 unique value만 모은 Levels 속성이 생긴다. 알파벳 순으로 자동 정렬한다. `levels(myFactor)` 를 통해서 범주 자료를 볼 수 있다.
- level을 내가 원하는 자료로 수정하고 싶을 때, 즉 성별 자료에서 M, F로 자료를 받았는데 파악하기 쉽게 하려고 Male, Female 로 바꾸고싶다면 `levels(myFactor) <- c("Male", "Female")` 처럼 벡터를 대입해주면 된다.
- factor를 print해보면 원소가 문자열이 아닌 것을 볼 수 있다. Levels의 원소를 가리키는 Integer 레퍼런스이다.
- `as.integer(myFactor)` : factor의 원소들을 Integer 레퍼런스 형태로 변환해서 리턴한다.
- `plot(rVector, cVector, pch=as.integer(myFactor))` : 산점도를 그릴 때 pch 값으로 factor를 넣어주면 점의 모양을 구분할 수 있다.
- `legend("topright", c('gems', 'gold', 'silver'), pch=1:3)` : 위 산점도가 그려진 상태에서 범주를 덧 그린다. 첫 번째 매개변수는 범주의 위치, 두 번째는 모양별로 적용될 텍스트, pch는 factor와 대응될 숫자를 의미. 즉 좀 더 범용적으로 쓰려면 다음과 같다. `legend('topright', levels(types), pch=1:length(levels(types)))`

### D. Data Frames

- 동질적 데이터인 열 벡터들이 모여서, 다양한 타입의 열벡터가 모인 데이터 프레임이 된다.
- `mtcars` : 내장 데이터 프레임 데이터셋. 공부할 때 쓸 것.
- `head(df1)`, `tail(df1)` : 위, 아래의 약 6개 정도 행을 보여준다.
- `str(df1)` : 데이터 프레임의 구조(structure)를 보여줌. observations 수(몇 행인지), variables 수(몇 열인지), variables 이름(열 이름), variable의 타입과 원소 몇 개 예시로 보여준다.
- 생성: `treasure = data.frame(v1, v2, v3)` 이런식으로 매개변수에 벡터를 넣는다. 각 벡터가 column으로 들어가고, 동일 위치끼리 행으로 묶일 수 있다.
- 열 전체 뽑기(위 데이터프레임에서 2열 뽑기)
    + `treasure[[2]]`
    + `treasure[['v2']]` 열 이름으로 뽑을 수도 있다. 생성할 때 벡터 이름이 열 이름이 되고 문자열 형태로 들어가야 한다.
    + `treasure$v2` dollar sign이 들어가며 문자열 표시 없이 접근한다.
- 필터링하기 : `df`라는 데이터 프레임이 있고, 속해있는 `is_married` 열 벡터 즉 variable이 있다고 하자. 이 때 결혼한 사람의 정보만 뽑아내고 싶을 때 `df[is_married,]` 처럼 한다. 벡터에서 필터링하는 것과 똑같다. 대괄호 안에 숫자가 들어가면 그 인덱스를 정확하게 뽑아내지만 숫자가 아니라 boolean 값(T, F)이 들어간다면 처음부터 순서대로 적용해서 T인 것만 뽑아낸다. df 행(자료 수)이 100개라면 `df[c(T, F), ]` 라고 했을 때 리턴되는 데이터 프레임은 원본의 홀수행만이다. 역시 필터링 정보가 전체 정보보다 숫자가 적으면 반복된다.
- `subset(my_df, subset=some_condition)` : 위 대괄호를 이용한 필터링을 함수화한 것이다. 첫 번째 매개변수는 데이터셋, 두 번째 매개변수는 각 행마다 적용될 조건식이다. ~~함수 이름, 매개변수 이름을 똑같이 한 것은 쫌 어이없다.~~ 이 때 조건식은 주로 열벡터가 어떠하냐~는 식인데 variable 이름을 바로 적어줘도 된다.
- 파일 읽어들여서 DataFrame 생성
    + `read.csv("myFile.csv")` : csv 파일 읽어들이기(Comma Separated Value)
    + `read.table("myFile.txt", sep="\t", header=TRUE)` : csv 형식이 아닐 때 table을 쓴다. 그리고 데이터 구분할 때 쓰인 문자를 지정해준다. 만약 첫 줄이 column의 이름이라면 header 값을 TRUE로 주면 된다. 만약 header가 없다면 열 이름이 자동으로 V1, V2 형태가 된다.
- `merge(x = df1, y = df2)` : 데이터 프레임을 합친다. 만약 동일한 Column이 있으면 그에 맞춰서 열벡터의 순서가 자동으로 조정된다. 위 아래로 합쳐지는게 아니라 열벡터가 좌우로 추가되는 형태.
- `cor.test(myDF$AAA, myDF$BBB)` : correlation 테스트 할 수 있다. 결과값이 출력된다. t, p-value 등등이 있는데 p-value만 잘 봐도 된다. 0.05 이하면 상관관계가 있다는 의미다.
- `line <- lm(myDF$AAA ~ myDF$BBB)` : 첫 매개변수가 response variable, 두 번째 매개변수가 predictor variable이다. 코드스쿨의 예제에선 해적 활동 횟수가 response, GDP가 predictor 였다. 즉 이 함수의 결과물은 `선`을 준비하는 것이다. 즉 이거 회귀선을 그리는 것.
- `abline(line)` : 이미 plot 함수로 산점도가 그려진 상황에서 `lm` function으로 구한 선을 abline 함수로 산점도에 선을 표시한다.
- `nrow(df)`, `ncol(df)` : 데이터 프레임에서 행 수, 열 수 뽑기

### E. list

- 이질적인 타입이 여러가지 속 한 배열이다. 아래는 datacamp의 비교설명
    + Vectors (**one** dimensional **array**): can hold numeric, character or logical values. The elements in one vector all have the **same datatype**.
    + Matrices (**two** dimensional **array**): can hold numeric, character or logical values. The elements in one matrix all have the **same datatype**.
    + Data frames (**two-dimensional objects**): can hold numeric, character or logical values. Within a column all elements have the same data type, but **different columns can be of different data type**.
- 생성
    + 그냥 생성: `list(object, object, object)` 
    + 이름과 함께 생성: `list(name1=object1, name2=object2, name3=object3)` 생성할 때는 이름을 문자열 표시하지 않아도 되지만 아래 설명에서처럼 접근할 때는 문자열 표시 해야한다.
    + 이미 그냥 생성된 리스트에 이름을 넣으려면 `names(my_list) <- c('name1', 'name2', ...)` 처럼 문자열 벡터를 names 함수를 호출해서 대입하면 된다.
- 원소 접근
    + `my_list[[1]]` : 리스트의 각 원소는 대괄호 2개로 접근한다. 인덱스로 접근한다.
    + `my_list[['element_name']]` : 역시 원소 접근은 대괄호 2개이고, 이름으로 접근할 수 있다. 이름으로 접근하려면 이름을 꼭 지정해줘야 한다. 생성할 때 입력했던 변수 이름이 아니다.
    + `my_list$element_name` : 이름이 설정되어있다면 데이터프레임에서처럼 달러 표시로 접근할 수 있다.
    + 만약 리스트의 원소가 벡터거나, 매트릭스, 데이터프레임이라면 `my_list$element_name][row, col]` 이런식으로 대괄호 하나 더 붙여서 접근 가능.
- 원소 추가: `c(my_list, add_variable)` 여기서 c는 벡터에서의 combine이 아니라 concatenate의 의미다. ~~이런 중복 문법 싫어..~~ 만약 이름을 추가하고 싶다면 `c(my_list, name=add_variable)` 처럼 이름 바로 지정해주면 된다.

### F. array

- 생성: `array(data, dim, dimnames)`
    + 첫 번째 매개변수로 데이터를 넣는다.
    + 두 번째로 차원을 지정하는데 벡터 형태로 넣는다.
    + dimnames는 옵션이고 쓰려면 매개변수 이름을 명시해준다. list 타입을 대입하는데 차원에 맞게 벡터 값들을 comma로 구분한다. 즉 2차원이고 2행 4열이라면 다음처럼 된다. `dimnamearr = list(c("1st", "2nd"), c("1st", "2nd", "3rd", "4rd"))`
    + 예제: `arr = array(1:3, c(2, 4), dimnames=dimnamearr)`

## 4. 자주 쓰이는 함수

- `objects()`, `ls()` : 선언한 함수들을 보여줌
- `rm(object, object, ...)` : 선언한 변수 지우기.
- `list.files()` : 현재 디렉토리 파일, 폴더 목록 보여줌. 매개변수에 경로를 넣으면 당연히 경로의 파일 목록을 보여준다. 폴더 내의 파일을 반복문으로 접근할 수 있다.
- `source("sample.R")` : 파일을 실행한다.
- `barplot(vesselsSunk)` : 벡터 함수를 매개변수로 받아서 bar chart를 그린다. 이 때 벡터의 스칼라값들에 이름이 있다면 표시된다.
- `plot(x, y)` : x와 y 값으로 산점도를 그린다.
- `sin(A)` A의 각 원소들의 sin 값을 구함.
- `mean(vector)`, `median(vector)`, `mode(vector)` 순서대로 평균, 중앙값, 최빈값
- `abline(h = mean(limbs))` : 먼저 그려져있는 bar chart에 수평선을 특정 값에 맞춰 그리는 함수다. 즉 이 함수 이전에 `barplot` 함수가 먼저 호출된 적이 있어야한다. 계속 그리면 선이 계속 누적된다. 여러 개 그릴 수 있음. h 값에 mean, median, mode 값 등 다양한 값을 줄 수 있다.
- `sd(vector)` : 표준편차 구하기
- `getwd()` , `setwd("directory/dir")` : 경로 조회, 경로 지정
- `my_vector[order(my_vector, decreasing=T)]` : order 함수는 매개변수로 들어가는 벡터의 원소들을 기본으로 오름차순으로 정렬하고 decreasing 값을 TRUE로 주면 내림차순이 된다. 리턴 값은 원소 값이 아니라 원본 벡터에서의 인덱스로 표현된 벡터다. 즉 `v = c(1, 100, 50)` 일 때 `order(v)`를 하면 `1 3 2` 벡터가 리턴된다. 즉 이것을 다시 원본 벡터의 대괄호 안에 집어넣으면 실제 값들로 정렬되어 출력이 되는 것.
- `tail(object, num)` : tail 함수는 벡터, 데이터프레임, 매트릭스 모두에 적용된다. 매개변수로 객체 하나만 주면 마지막 6개 행을 보여주고, 만약 숫자를 두 번째 매개변수에 지정하게 되면 그 수만큼 행을 보여준다. 만약 2라면 마지막 2개 행을, 3이라면 마지막 3개 행인 식이다.
- `class(object)`, `typeof(object)`, `mode(object)` 차이점
    + `mode` : R 기본 구조에 따른 상호 배타적인 분류.
        * 'atomic' mode는 `numeric`, `complex`, `character`, `logical`이다.
        * Recursive objects는 `list`, `function` 등이 있다.
    + `class` : object에 할당된 속성이다. 이 타입이 내장함수 동작 여부를 결정한다. 클래스는 mutually exclusive 하지 않다. 만약 숫자 벡터를 정의했을 때 따로 특정 클래스를 적용하지 않았다면 mode 값과 같다. 벡터지만 numeric이다.
    + mode를 바꾸는 것은 coercion이라고 부르는데 class 변경 없이도 가능하다.

- `class()` : 객체 지향 프로그래밍 관점에서 객체가 어떤 타입인지 define, identify하는 함수다.
- `typeof()` : R의 관점에서 type을 보여준다. 이걸 사용하다보면 오류가 많이 난다.

## 5. ggplot2 활용

- `install.packages('ggplot2')` : 패키지 설치
- `help(package = "ggplot2")` : 패키지 설명
- `library(ggplot2)` : 라이브러리 사용하기 전에 import 하는 의미인듯.
- `qplot(myV1, myV2, color=myFactor)` : ggplot2에 속해있는 qplot 함수. x, y축 벡터 두 개와 범주를 의미하는 factor를 매개변수로 받는다.
- 이 외에도 `dplyr`, `data.table`, `ggvis` 등의 패키지들 존재.
