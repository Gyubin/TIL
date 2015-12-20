# #44 Strip Url Params

URL 뒤에 붙는 Query String의 키 밸류 쌍에서 중복된 것과, 매개변수로 들어오는 키 값은 버린다.

## 1. 내 코드

```py
import re
def strip_url_params(url, params_to_strip = []):
    if '?' not in url: return url
    q = url.index('?')
    params = url[q+1:].split('&')

    no_duplicates = set()
    result = []
    for p in params:
        r = re.match(r'.+?(?==)', p).group()
        if r not in params_to_strip and r not in no_duplicates:
            no_duplicates.add(r)
            result.append(p)
    return url[:q+1] + '&'.join(result)
```

- '?'가 없으면 바로 리턴한다.
- '?' 인덱스를 찾고, 그 뒤의 쿼리스트링을 '&'을 기준으로 split한다.
- 키 밸류 쌍을 반복문으로 돈다. 정규표현식으로 '=' 앞에 있는 키를 뽑아내고, 이 키가 params_to_strip 리스트에 없어야 하고, 키를 모아둔 no_duplicates 세트에 없다면 결과값에 추가한다. no_duplicates 세트에도 추가해서 똑같은 키가 또 추가되지 않도록 한다.
- '?'까지의 url과 result 값을 '&'으로 연결시킨 문자열을 리턴한다.

## 2. 다른 해답

```py
def strip_url_params(url, params_to_strip = []):
    if '?' not in url:
        return url
    hier, query = url.split('?')
    params = {}
    for param in query.split('&'):
        k, v = param.split('=')
        if k not in params and k not in params_to_strip:
            params[k] = v
    return '{0}?{1}'.format(hier, '&'.join('='.join(kv) for kv in params.items()))
```

- 나와 같은 흐름이다. 다만 정규표현식 대신 split을 더 사용했고, 중복을 제외하기 위해 세트 대신 딕셔너리를 썼다.
