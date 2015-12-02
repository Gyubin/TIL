# #36 Caesar Cipher Helper

숫자를 매개변수로 받아 객체를 생성하는 클래스다. 매개변수 숫자만큼 문자열을 이동시킨다. 말그대로 문자열을 모두 대문자로 하고, shift 하면 된다. shift가 5라면, 그리고 문자열이 'abc'라면 encode했을 때 'FGH'로 바꾸면 된다. decode는 그 반대.

# 1. 내 코드

아스키코드값으로 조절했다. 코드 자체는 단순하다.

```python
class CaesarCipher(object):
    def __init__(self, shift):
        self.shift = shift

    def encode(self, str):
        result = []
        for c in str.upper():
            d = ord(c)
            if d >= 65 and d <= 90-self.shift:
                result.append(chr(d+self.shift))
            elif d >= 91-self.shift and d <= 90:
                result.append(chr(d-26+self.shift))
            else:
                result.append(c)
        return ''.join(result)
        
    def decode(self, str):
        result = []
        for c in str.upper():
            d = ord(c)
            if d >= 65+self.shift and d <= 90:
                result.append(chr(d-self.shift))
            elif d >= 65 and d <= 64+self.shift:
                result.append(chr(d+26-self.shift))
            else:
                result.append(c)
        return ''.join(result)
```

# 2. 다른 해답

## A. maketrans

코드를 python3 기반으로 바꿨다. 3에선 maketrans 함수가 static 함수로 바뀌어서 `str.maketrans(from, to)` 형태로 사용한다. 정말 이 문제에서 최고의 함수다. from과 to를 서로 매칭시켜서 글자 하나하나를 바꿔버린다.

```python
class CaesarCipher(object):
    def __init__(self, shift):
        self.alpha = "abcdefghijklmnopqrstuvwxyz".upper()
        self.newalpha = self.alpha[shift:] + self.alpha[:shift]

    def encode(self, str):
        t = str.maketrans(self.alpha, self.newalpha)
        return str.upper().translate(t)

    def decode(self, str):
        t = str.maketrans(self.newalpha, self.alpha)
        return str.upper().translate(t)
```

## B. maketrans 직접 구현

위 maketrans 함수를 직접 구현했다. `ascii_uppercase`를 활용해서 알파벳 리스트를 구하고, shifted 알파벳리스트를 반복문과 pop을 이용해서 만들었다. 엄청 멋진 조합이다. 그리고 이 둘을 dict로 매칭 테이블을 만들었다.

```python
from string import ascii_uppercase as alphabet

class CaesarCipher(object):
    def __init__(self, shift):
        shifted = list(alphabet)
        for _ in range(shift):
            shifted.append(shifted.pop(0))
        self.encode_dict = {alphabet[i]:shifted[i] for i in range(len(alphabet))}
        self.decode_dict = {shifted[i]:alphabet[i] for i in range(len(alphabet))}

    def encode(self, string):
        return "".join(self.encode_dict[c] if c in self.encode_dict else c for c in string.upper())
        
    def decode(self, string):
        return "".join(self.decode_dict[c] if c in self.decode_dict else c for c in string.upper())
```
