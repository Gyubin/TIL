# Regular Expression : 정규표현식

참고 링크: [wikidocs.net](https://wikidocs.net/1642), [공식문서](https://docs.python.org/3.5/howto/regex.html)

## 1. 개념

문자열 처리를 더 쉽고 강력하게 하기 위한 기법이다. 파이썬만이 가지고 있는 것이 아니라 대부분의 언어에서 공유하고 있는 공통 약속이라고도 할 수 있겠다. 예를 들어 회원가입 창에서 전화번호를 입력받았다고 할 때 사용자가 숫자만 써서 '01012341234'라고 했을 수도 있고 '010-1234-1234'로 했을 수도 있다. 이런 입력에서 원하는 '숫자'만 정확하게 가져오는데 정규표현식이 아주 강력한 기능을 제공한다.

## 2. 요소 별 예제

활용에 대해 아직 설명하지 않았지만 요소마다 직접 간단한 테스트를 해보면서 공부하는게 더 도움될 것 같아서 아래 코드를 준비했다. 아래 코드에서 `'!!!!여기!!!!'` 부분에서 정규표현식을 살짝살짝 바꿔가며 테스트를 하겠다.

```python
import re
text = 'some string'
REGEX = re.compile('!!!!여기!!!!')
result = REGEX.findall(text)
print(result)
```

### A. 메타 문자: `. ^ $ * + ? { } [ ] \ | ( )`

#### 1) `[ ]` : 문자 클래스

- `[abc]` : 문자열이 a, b, c 중 아무거나 하나만 포함한다면 매치된다. 'abc', 'aaa', 'bike' 같은 경우 매치되고, 'dude'는 매치 안된다.
- `[a-z]` : [ ] 안에 '-' 하이픈이 들어가면 범위를 나타낸다. 이 예는 a부터 z까지의 모든 문자를 나타낸다. 즉 `[abcdefghijklmnopqrstuvwxyz]` 와 같은 의미다. 숫자도 통한다. `[0-9]` 는 모든 숫자를 나타낸다.
- `[^a-zA-Z]` : '^'는 not을 의미한다. 왼쪽 예제는 문자가 아닌 것을 매치시키는 정규표현식이다.
- [0-9]와 [a-zA-Z]같은 자주 쓰는 표현식은 따로 표기법이 만들어졌다.
    + `\d` : `[0-9]`, 숫자와 매치
    + `\D` : `[^0-9]`, 숫자가 아닌 것과 매치
    + `\s` : `[ \t\n\r\f\v]`, whitespace 문자들과 매치. 맨 앞의 공백 포함
    + `\S` : `[^ \t\n\r\f\v]`, 공백이 아닌 것들
    + `\w` : `[a-zA-Z0-9]`, alphanumeric
    + `\W` : `[^a-zA-Z0-9]`, alphanumeric이 아닌 것.

#### 2) `.` : `\n`을 제외한 모든 문자와 매칭된다.

- `re.DOTALL` 옵션을 주면 개행문자도 적용 가능하다.
- `'a.b'` : 'a' + 모든 문자 중 한 개 + 'b'의 의미다. a와 b 사이에 뭐 하나는 꼭 있어야 하고 여러 개 있는건 안된다. 즉 'aab', 'acb'는 되지만, 'accb' 는 매칭 안된다. 예를 들어 다음 문자열이라면 `'aab ab aaaaab acccv a.b'` 결과는 `['aab', 'aab', 'a.b']` 를 리턴한다. findall 메소드는 매칭되는 문자열을 텍스트에서 모두 찾아서 리스트로 리턴한다. 텍스트에서 aaaaaab는 a와 b 사이에 한 문자만 있는게 없다. 그래서 매칭되는 문자열이 여기선 안나오는 것.
- `'a[.]b'` `'a\.b'` : 말 그대로 `.`을 문자 그 자체로 취급하는 경우다. 바로 위 예의 텍스트를 매치시켜보면 `['a.b']` 만 리턴된다.

#### 3) 반복에 관하여 `*, +, {m,n}, ?`

- `*`
    + 바로 앞의 문자가 0번 이상 반복될 수 있다는 의미
    + `'ab*c'` : ac, abc, abbbbc 모두가 매칭된다.
- `+`
    + 앞의 문자가 1번 이상 반복될 수 있다는 것.
    + 0번, 즉 아예 없는거는 적용 안되는 점에서 '*'와 다르다.
    + `'ab+c'` : abc, abbbbc 는 매칭되지만 ac는 안된다.
- `{m, n}`
    + 바로 앞의 문자가 m 이상 n 이하 반복되는 것과 매치된다.
    + {m} : 무조건 m번 반복되어야 한다.
    + {, m}, {m, } : 순서대로 m 이하 반복되는 것(0번 포함), m 이상 반복되는 것과 매칭된다.
    + `'ab{2, 4}c` : abbc, abbbc, abbbbc는 매칭. abc, ac, abbbbbc는 매칭 안된다.
- `?` 
    + 바로 앞에 있는 문자가 있어도 되고 없어도 된다는 의미다. 즉 {0, 1}과 같다.
    + `'ab?c'` : ac, abc 매칭. abbc, abbbc, abbbbbbc 는 매칭 안된다.
- 어쩔 수 없는 경우가 아니라면, 그리고 표현이 가능하다면 주로 `*, +, ?`를 쓰는것을 추천한다. 표현도 간결하고 이해도 쉽다.

## 3. 실행 메소드

### A. re 모듈과 compile 메소드

다음 순서로 쓰면 된다. 모듈 import 하고, 패턴으로 정규표현식 객체를 만들고, 객체를 이용해 매칭되는 문자열을 뽑아낸다.

```python
import re
REGEX = re.compile('pattern', re.IGNORECASE)
result = REGEX.findall("Some String")
```

compile 메소드는 매개변수로 패턴 뿐만 아니라 flag 정수 값도 받는다. 디폴트는 0이고 위의 re.IGNORECASE는 2를 나타낸다. 2가 들어가면 대소문자를 무시한다.

### B. backslash(`\`)와 raw string

- 위의 예 중에서 `\d`나 `\W`같은 패턴을 봤을 것이다. 이렇게 백슬래시를 쓰는 패턴들이 있기 때문에 백슬래시 문자 자체를 찾고싶은 경우 종종 문제가 발생한다. 예를 들어 '\section'이나 '\dragon'같은 경우엔 각각 순서대로 `[ \t\n\r\f\v]ection`, `[0-9]ragon` 과 같은 패턴이 되어버린다. 내가 원하는건 그게 아닌데 말이다.
- 그래서 백슬래시를 백슬래시 자체로 인식하기 위해 2번 써주면 되지 않을까? 생각하지만 안된다. 왜 안될까. 이번엔 파이썬 엔진이 `\\`를 `\` 문자로 바꿔주기 때문이다. 그래서 결국 세 개를 써줘야 된다. `re.compile('\\\section')` 이라고 해줘야 텍스트 중에서 `'\section'`을 뽑아낼 수 있다. 이 얼마나 복잡한가.
- 그래서 raw string이 생겼다. 문자열을 그 자체로 인식하게 해주는 파이썬 문법이다. 문자열 앞에 `r`을 붙여주면 된다. 그래서 위 같은 경우 `re.compile(r'\\section')` 이라고 쓰기만 하면 된다. raw string이면서 왜 또 2개를 적어주냐면 이건 파이썬 컴파일러에게 적용되는 것이기 때문이다. 파이썬 컴파일러가 저 두 개의 백슬래시를 하나로 만들어주지 않도록 하는 것이 raw string인 것이다. 그래서 정규표현식 엔진이 \s를 공백으로 인식하지 않게 하기 위해선 여전히 두 개를 써줘야 한다.
- 정리: 정규표현식에서 백슬래시 문제는 파이썬 엔진과 정규표현식 엔진이 동시에 작용하기 때문이다. 그래서 raw string을 활용해서 파이썬 엔진의 작용을 배제해야 한다. 그러면 정규표현식 엔진에 대해서만 백슬래시 문자 처리를 해주면 된다.

### C. match, search

- 패턴이 문자열과 매치되는지 찾는 메소드들이다. `match`는 전체 문자열에서 처음부터 바로 패턴이랑 일치하는지 찾는 것이고, `search`는 문자열 처음이 패턴과 맞지 않더라도 이후에도 맞는게 있는지 쭉 찾아나가는 것이다.
- 매치되는게 있으면 match object를 리턴한다. 없으면 None
- 예를 들어 패턴이 `'\w+'`라면 `'!@#abcde00 hello'` 문자열에 대해서 match는 첫 문자가 특수기호이므로 바로 None을 리턴한다. 하지만 search는 계속 검사를 해서 'abcde00'에 대한 match object를 리턴한다.
- match object는 다음 코드에서와 같이 `group()`, `start()`, `end()`, `span()` 네 가지 메소드를 가지고 있다. group은 매치된 첫 번째 문자열을 리턴하고, start는 전체 텍스트에서 그 매치된 문자열의 시작 인덱스, end는 매치된 문자열의 마지막 인덱스+1을 리턴한다. span은 시작, 끝 인덱스를 튜플로 리턴한다. 아래 코드를 참조한다.

```python
import re

text = '!@#abcde00 hello'
REGEX = re.compile('\w+')
result = REGEX.search(text)

if result:
    print('group: ', result.group())
    print('start: ', result.start())
    print('end: ', result.end())
    print('span: ', result.span())
else:
    print("No match")
```

### D. findall

- 위의 예제에서처럼 match와 search는 `'!@#abcde00 hello'`의 경우 뒤에 있는 `'hello'`는 리턴하지 않는다. 이렇게 패턴과 매칭되는 모든 문자열을 찾고 싶다면 findall을 쓰면 된다.
- 매칭되는 모든 문자열을 리스트에 담아서 리턴한다.

```python
find_result = REGEX.findall(text)
print(findresult)
# -> ['abcde00', 'hello']
```

### E. finditer

- 하지만 findall은 그 문자열의 인덱스는 알 수 없다. 그렇다고 match나 search를 쓰기엔 모든걸 찾지 못한다. 그래서 나온게 finditer다. 전체 텍스트에서 패턴과 매칭되는 모든 문자열을 찾지만 인덱스도 알 수 있도록 각각의 match object를 iterator로 만들어 리턴한다.

```python
iter_result = REGEX.finditer(text)
if iter_result:
    for mo in iter_result:
        print('group: ', mo.group())
        print('start: ', mo.start())
        print('end: ', mo.end())
        print('span: ', mo.span())
```


### F. re 모듈에서 바로 사용하기

매개변수를 순서대로 패턴, 문자열로 주면 모듈에서 바로 사용할 수있다. 

```python
result = re.search('\d+', text)
print(result.group())
```

## 컴파일 옵션

|   변수명   | 약어 |                                      의미                                     |
|------------|------|-------------------------------------------------------------------------------|
| DOTALL     | S    | `.` 이 줄바꿈 문자를 포함하여 모든 문자와 매치할 수 있도록 한다.              |
| IGNORECASE | I    | 대소문자 관계없이 매치                                                        |
| MULTILINE  | M    | 여러 줄과 매치할 수 있도록 함. (^, $ 메타 문자와 관련 있다.)                  |
| VERBOSE    | X    | verbose 모드 사용 가능. 정규식을 보기 편하게 만들 수 있고 주석 등을 활용 가능 |

> `re.DOTALL`과 `re.IGNORECASE`는 쉬워서 예제는 생략하겠다.

### `re.MULTILINE`

- 우선 `^`와 `$`에 대하여
    + `re.MULTILINE`은 다음 두 메타 문자와 관련있다: `^` - 문자열의 처음, `$` - 문자열의 마지막
    + `'^python'`의 패턴이라면 전체 텍스트가 'python'으로 시작해야 한다는 의미다. `'python$'`의 패턴은 전체 텍스트의 마지막이 'python'으로 끝나야 한다는 의미다.
    + 아래 코드에서 두 결과 모두 `['python']` 다. 딱 하나씩만 python이 담겨 나온다. 즉 전체 텍스트에서 맨 앞, 맨 끝을 검사하는거다.

```python
import re
text = '''python hihi 
python aslkdj1249sk
ldkjfsd92 23 
asldkf python'''

REGEX_front = re.compile('^python')
REGEX_end = re.compile('python$')
f_result = REGEX_front.findall(text)
e_result = REGEX_end.findall(text)
if f_result: print('^ result:', f_result)
if e_result: print('$ result:', e_result)
```

- `re.MULTILINE`
    + 즉 한마디로 설명하면 `^`, `$`를 사용할 때 전체 텍스트를 대상으로 하지말고 개행문자 기준으로 한 줄씩 대상으로 한다는 의미다.
    + 위 코드에서 만약 `REGEX_front = re.compile('^python', re.M)` 으로 수정한다면 f_result 출력 결과는 `['python', 'python']`이 된다. 끝. 쉽죠?
    + 추가로 `^`와 `$`를 문자 그 자체로 이용하고 싶다면 `\`를 붙이든가, `[ ]` 안에 넣는다.

### `re.VERBOSE`

한마디로 '복잡한 정규식의 경우 이해하기가 어려우므로 의미 단위로 라인을 구분하고, 주석을 달 수 있도록 해주는 flag 값이다!' 라고 정의할 수 있겠다.

- 정말 알아보기 힘들다. ↓

```python
charref = re.compile(r'&[#](0[0-7]+|[0-9]+|x[0-9a-fA-F]+);')
```

- 같은 의미지만 훨씬 이해가 편하다. ↓

```python
charref = re.compile(r"""
 &[#]                # Start of a numeric entity reference
 (
     0[0-7]+         # Octal form
   | [0-9]+          # Decimal form
   | x[0-9a-fA-F]+   # Hexadecimal form
 )
 ;                   # Trailing semicolon
""", re.VERBOSE)
```

`re.VERBOSE` flag를 적용하면 저렇게 라인과 탭 등으로 구분해서 들어가게된 white space는 컴파일할 때 다 사라진다. 하지만 `[ ]` 내에서 사용된 것은 남는다.

## 추가 메타문자

- `|` : or 와 동일하다. 패턴을 몇 개 겹칠 수 있다.
- `\A`, `\Z` : 순서대로 `^`, `$`와 의미가 같다. 다른 점은 `re.MULTILINE` 옵션이 추가되더라도 여전히 첫 번째, 마지막만 가리킨다.
- `\b` : 단어 구분자다. 패턴을 `r'\bcode\b'` 라고 쓴다면 'code'만 딱 매칭되고 'xcode', 'supercodefighter' 이것들은 매칭 안된다. 주로 whitespace로 구분되지만 `- , : . @`같은 거도 구분된다. `\b`를 파이썬 컴파일러가 백스페이스로 인식하므로 이것을 쓸 땐 꼭 raw string으로 써야한다.
- `\B` : 역시 대문자로 쓰면 반대다. 만약 `r'\Bcode\B`라고 썼다면 좌우에 다 써서 감쌌으므로 양쪽에 뭔가 문자나 숫자로 감싸져있는 것만 매칭된다. 'xcodex'는 매칭되고 'xcode', 'codex'는 매칭안된다. 그리고 저 패턴대로라면 findall의 결과물은 단순히 'code'다. 'xcodex'가 결과 리스트에 포함되는 것이 아니다. 전체 문자열을 다 뽑고 싶으면, 즉 'xcodex'를 뽑고 싶으면 `r'\w+\Bcode\B\w+`라고 패턴을 설정하면 된다.

## Grouping : `( )`

- 그룹 단위 속성 적용: 말 그대로 그룹이다. +나 *, ?를 문자 하나가 아니라 문자 집단에 적용하고싶을 때 사용한다. `(ABC)+` 라면 'ABC'가 1번 이상 반복된다는 의미다.
- 매치된 텍스트에서 특정 부분만 뽑아낼 때: 이름과 전화번호가 연달아 적힌 패턴을 찾아낸다고 가정했을 때 거기서 이름만 뽑아내고자 한다. 이럴 때 그룹이 굉장이 유용하다. 아래와 같은 코드에서 group() 메소드의 매개변수에 들어가는 숫자로 그룹을 지정할 수 있다. 0은 전체, 1은 첫 번째 그룹, 2는 두 번째 그룹이다.
- 재밌는건 그룹을 중첩시킬 수도 있다는 것이다. 바깥에서부터 안으로 들어가는 순서다. 아래 예제를 보면 마지막 5674가 출력된다.

```python
import re
REGEX = re.compile(r"(\w+)\s+((\d+)[-](\d+)[-](\d+))")
text = "park 010-1234-5674"
print(REGEX.search(text).group(5))
```






