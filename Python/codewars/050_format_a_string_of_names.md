# #50 Format a string of names like 'Bart, Lisa & Maggie'

key가 'name'이고 value에 이름이 들어있는 dict가 여럿 들어있는 리스트를 매개변수로 받는다. 이 이름들을 comma로 연결시켜서 문자열을 리턴하는데 마지막 둘은 ampersand로 연결해야한다.

## 1. 내 코드

```py
def namelist(names):
  temp = [o['name'] for o in names]
  if len(temp) <= 0: return ''
  elif len(temp) == 1: return ''.join(temp)
  elif len(temp) == 2: return ' & '.join(temp)
  else: return ', '.join(temp[:-1]) + ' & ' + temp[-1]
```

- dict에서 name만 뽑아서 리스트로 만들었다.
- 이 리스트의 길이에 따라서 조건을 걸었다. 0보다 작으면 빈문자열, 1이면 그냥 리턴, 2면 ampersand로 연결, 그 이상일 때는 마지막 원소 제외하고 콤마로 연결한 다음 마지막만 ampersand로 연결했다.

## 2. 다른 해답

```py
def namelist(names):
    if len(names) > 1:
        return '{} & {}'.format(', '.join(name['name'] for name in names[:-1]), 
                                names[-1]['name'])
    elif names:
        return names[0]['name']
    else:
        return ''
```

- 첫 번째 조건만 본다. 
- `'{} & {}'.format(string, string)` : 문자열 안에 중괄호가 들어있을 때 `format` 함수를 호출하면 매개변수의 값이 중괄호에서 대체된다.
- 첫 번째 매개변수는 마지막 원소를 제외한 모든 이름들을 comma로 연결한 문자열이고
- 두 번째는 마지막 원소의 이름 값이다.
- 앞부분과 뒷부분을 ampersand로 이었다.
