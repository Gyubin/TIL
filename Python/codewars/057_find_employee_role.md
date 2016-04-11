# #57 Find an employees role in the company

dict로 된 직원 정보가 여럿 담긴 리스트를 활용해서 특정 이름의 직원 정보를 찾고, 직책을 리턴하면 된다. 간단하다.

## 1. 내 코드

```py
def find_employees_role(name):
    for i in employees:
        if (i['first_name'] + ' ' + i['last_name']) == name:
            return i['role']
    return "Does not work here!"
```

다른 답변들과 같다.
