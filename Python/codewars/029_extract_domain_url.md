# #29 Extract the domain name from a URL

URL을 매개변수로 받아서 도메인 이름만 뽑아내는 것이다.

## 1. 내 코드

- 정규표현식을 이용했다. re 모듈의 search를 활용했고, 패턴은 `.`을 기준으로 바로 앞 문자열, 바로 뒤 문자열을 찾았다. 도메인엔 `-` 하이픈도 들어갈 수 있으므로 추가해줬다.
- 앞 문자열과 뒤 문자열을 그룹으로 지정했다. 'www'를 붙이는 경우와 붙이지 않는 경우가 있기 때문에 앞 문자열 그룹이 'www'라면 선택하지 않고 뒤 문자열을 리턴했다.

```python
import re
def domain_name(url):
    REGEX = re.compile(r'([-\w]+)\.([-\w]+)', re.IGNORECASE)
    result = REGEX.search(url)
    if result:
        if result.group(1) == 'www':
            return result.group(2)
        return result.group(1)
```

## 2. 다른 코드

### A. split만을 활용

'//'로 구분해서 이후 문자열 전체를 구하고, 'www.'로 또 구분해서 뒤 전체를 구했다. 'www.'가 없으면 어차피 전체가 선택될 것이므로 상관없다. 그리고 '.'을 기준으로 구분해서 첫 원소를 리턴하면 그게 도메인이다.

```python
def domain_name(url):
    return url.split("//")[-1].split("www.")[-1].split(".")[0]
```

### B. 정규표현식 활용

```python
import re
def domain_name(url):
    result = re.search("(//)?(([a-zA-Z0-9_-]+)\.)+", url)
    return result.group(3) if result else None
```

- `(//)?`
    + '?'를 활용했다. 1번 그룹인 '//'는 있어도 되고 없어도 된다. '//'라는 문자열이 URL에 포함되어서 들어올지 안들어올지를 모르므로 쓴 것 같은데 맨 앞에 붙어있다보니 굳이 없어도 되는 코드다. 여러 URL을 테스트해보니 없어도 동일한 결과가 나왔다.
- `(([a-zA-Z0-9_-]+)\.)+`
    + '-'를 포함한 문자들이 여러개 나올 수 있는데 마지막엔 `.`이 붙어야한다. 이 패턴이 또다시 여러개 나올 수 있다는 패턴이다.
    + 즉 'www.', 'github.', 'naver.' 같은 문자열들이 반복해서 나올 수 있다.
    + 'github.com'같은 경우는 'github.'만 골라질 것이고, 'www.naver.com'같은 경우는 'www.naver.'까지 골라질 것이다.
- 의문점: `"http://www.zombie-bites.com"`의 경우
    + result.group(0)의 결과는 '//www.zombie-bites.'이다.
    > (result.group(1)의 결과는 당연하게도 '//'다. 넘어간다.)
    + 문제는 그룹2부터 나온다. result.group(2)의 결과는 'zombie-bites.'이다. 왜 'www.'은 배제되는 것일까? 'www.'도 가능하고 'zombie-bites.'도 되는데 왜 뒷 부분이 선택되는 것일까?
    + result.group(3)은 그룹2에서 이어지는 것이므로 'zombie-bites'라고 도메인만 매칭시킬 수 있다.
    + [Python Korea](https://www.facebook.com/groups/pythonkorea/) 그룹에 질문을 올렸더니 역시 [답변](https://www.facebook.com/groups/pythonkorea/permalink/921335711282924/)이 정확하게 달렸다. 정말 감사드립니다. 내용은 다음과 같다. 역시 내가 공식 문서를 꼼꼼하게 안 읽은 탓이다.
    + 김덕환님: "If a group is contained in a part of the pattern that matched multiple times, the last match is returned.": [https://docs.python.org/3/library/re.html#re.match.group](https://docs.python.org/3/library/re.html#re.match.group) 원하시는 결과를 얻으시려면 `re.findall(r"\w+\.", "abc.def.ghi.")` 혹은 `re.finditer(r"\w+\.", "abc.def.ghi.")`을 사용하셔야 될 듯합니다.
    + 그러면 저 코드를 짠 사람은 마지막이 매칭된다는 것을 알고 저렇게 짠걸까? 엄청난데!!???

### C. 정규표현식으로 여러 예외처리를 다 한 모습

```python
from re import compile, match
def domain_name(url):
    REGEX = compile(r'(http[s]*://)?(www.)?(?P<domain>[\w-]+)\.')
    return match(REGEX, url).group('domain')
```

- http 도 되고 https도 된다.
- http:// 까지가 전체 URL에 있어도 되고 없어도 된다.
- www.이 있어도 되고 없어도 된다.
- 앞에서 `?`를 사용했기 때문에 그 다음 패턴은 무조건 도메인이 된다.
- 깔끔하게 도메인이 매칭되는 부분을 domain이란 이름으로 그룹으로 만든다.
