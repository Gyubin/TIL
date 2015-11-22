# Extract the domain name from a URL

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

- '?'를 적절하게 활용했다. 1번 그룹인 '//'는 있어도 되고 없어도 된다. '//'라는 문자열이 URL에 포함되어서 들어올지 안들어올지를 모르므로 유용한 코드다.
- 그다음은 '-'를 포함한 문자들이 여러 개 나올 수 있는 것, 즉 도메인과 '.'이 합쳐진 문자열이 여러번 반복될 수 있다는 의미다. 즉 'www.', 'github.', 'naver.' 같은 문자열들이 반복해서 나올 수 있다는 패턴이다. 즉 'github.com'같은 경우는 'github.'만 골라질 것이고, 'www.naver.com'같은 경우는 'www.naver.'까지만 골라질 것이다.
- 여기서도 역시 그룹을 활용해서 도메인만 뽑아냈는데 재밌는 것은 `http://www.cnet.com`같은 경우에서 search.group()의 결과는 'www.cnet.'이다. 여기서 group(1)을 하게 되면 '//'일 것이고, group(2)를 하면 재밌게도 'cnet.'이다. 왜 여기서 'www.'이 결과가 되진 않는 것일까. 디폴트로 뒤쪽이 선택되는 것일까.

```python
import re
def domain_name(url):
    result = re.search("(//)?(([a-zA-Z0-9_-]+)\.)+", url)
    return result.group(3) if result else None
```
