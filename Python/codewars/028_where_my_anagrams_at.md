# #028 Where my anagrams at.

첫 매개변수로 단어 하나를, 두 번째 매개변수로 여러 단어를 모아둔 리스트를 받는다. 리스트의 단어 중 첫 매개변수의 anagram인 것만 다시 리스트에 담아서 리턴한다.

## 1. 내 코드

```python
def anagrams(word, words):
    return [w for w in words if sorted(w) == sorted(word)]
```

`sorted` 함수를 활용하면 문자열이 정렬되어 리스트가 된다. anagram이 결국 단어 종류와 개수는 똑같으므로 이게 같은지만 확인하면 된다. 문제가 쉬워서 그런지 다들 답변이 비슷했고 내 것과 일치했다.

오히려 모든 애너그램 단어들을 다 찾아서 리스트로 리턴하는 문제가 더 어려울 것 같다.
