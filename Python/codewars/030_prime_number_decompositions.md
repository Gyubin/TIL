# #30 Prime Number Decompositions

소인수분해와 관련해서 함수 3개를 짜는 문제다. 예를 들어 설명하는 것이 더 쉽겠다. 100을 입력받으면 첫 째 함수는 [2, 2, 5, 5]를 리턴하고, 둘 째 함수는 [[2, 5], [2, 2]]를 리턴하고, 셋째 함수는 [4, 25]를 리턴한다. 즉 소인수 전부, 소인수를 개수 표시해서 중복 없이, 소인수를 개수만큼 곱해서 리턴.

## 1. 내 코드

- 예외 2개는 따로 표시했다. n이 1이거나 숫자가 아닐 경우 바로 return 시켰다.
- 2부터 n+1까지 반복을 돌렸다. 수를 나눠서 나머지가 없는 경우만 result 리스트에 추가해줬다. 같은 소인수가 반복될 수 있으니 while문으로 무한반복시켰다.
- 세 함수가 모두 연결돼있어서 각각 호출해서 썼다. 그러면 예외처리도 각 함수별로 안해줘도 된다. 첫 번째 함수에서만 예외처리해주면 끝.

```python
def getAllPrimeFactors(n):
    if n == 1: return [1]
    if not isinstance(n, int): return []
    result = []
    temp = n
    for i in range(2, n+1):
        while True:
            if temp%i: break
            temp /= i
            result.append(i)
        if temp == 1: break
    return result

def getUniquePrimeFactorsWithCount(n):
    prime_factors = getAllPrimeFactors(n)
    prime_set = set(prime_factors)
    return [list(prime_set), [prime_factors.count(i) for i in prime_set]]

def getUniquePrimeFactorsWithProducts(n):
    prime = getUniquePrimeFactorsWithCount(n)
    return [i**j for i, j in zip(prime[0], prime[1])]
```

## 2. 다른 코드

흐름은 다 비슷비슷했다. 사용한 함수가 살짝살짝 달랐을 뿐이다.

```python
import math
import collections

def getAllPrimeFactors(n):
  numberToDecompose = n
  if (not isinstance(numberToDecompose,(int,long)) or numberToDecompose<=0):    return []
  answer = ([1] if (numberToDecompose==1) else  [])
  for possibleFactor in range (2,numberToDecompose+1):
      while (numberToDecompose % possibleFactor == 0):
         answer.extend([possibleFactor])
         numberToDecompose = numberToDecompose / possibleFactor
  answer = sorted(answer)
  return answer


def getUniquePrimeFactorsWithProducts(n):
  ch= getUniquePrimeFactorsWithCount(n)
  x= [a**b for (a,b) in zip (ch[0], ch[1])]
  return x
  
def getUniquePrimeFactorsWithCount(n):
    c = collections.Counter (getAllPrimeFactors(n))
    d=  [a for  (a,_) in c.items()]
    e = [b for  (_,b) in c.items()]
    return [d,e]
```

