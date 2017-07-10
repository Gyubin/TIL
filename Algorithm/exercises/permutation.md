# Permutation

a부터 시작해서 n개의 알파벳에서 r 만큼 permutation을 한다. => nPr

```py
def getPermutation(n, r) :
    alphabets = [chr(i + 97) for i in range(n)]
    if r == 1:
        return alphabets
    else:
        prev = getPermutation(n, r - 1)
        result = []
        for el in prev:
            for c in alphabets:
                if c not in el:
                    result.append(el + c)
        return result

def main():
    firstLine = [int(x) for x in input().split()]
    print('\n'.join(getPermutation(firstLine[0], firstLine[1])))

if __name__ == "__main__":
    main()
```

- 예를 들어 n = 4, r = 2라면 "ab ac ad ba bc bd ca cb cd da db dc"를 리턴하면 된다.
- 핵심 아이디어는 먼저 나올 알파벳을 구하고("a, b, c, d"), 이 결과값에 다음에 붙을 수 있는 알파벳을 붙이는 것으로 반복하는 것이다. 즉 "a"는 "ab ac ad"로 원소가 1개에서 3개가 된다.
- 재귀를 이용했고 r을 1씩 줄여나가면서 깊이 들어갔다. r이 1일 때는 그대로 하나짜리 알파벳들 리스트를 리턴한다.
- r이 1이 아닐 때는 재귀를 호출하고, 결과값에 더 붙일 수 있는 알파벳을 체크해서 붙인 결과를 최종 리턴하게 된다.
