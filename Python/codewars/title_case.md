# #12 Title Case
첫 번째 매개변수로 받은 문자열을 제목 포맷으로 바꾼다. 첫 단어는 무조건 대문자로 시작하고, 나머지 단어들도 첫 단어를 대문자로 바꾸지만 두 번째 매개변수로 들어온 문자열에 포함된 단어라면 그냥 모두 소문자로 둔다. 두 번째 매개변수는 white space로 구분되어 이루어진 문자열이다.

## 내 코드와 최고 득표 코드 비교

다른 해답 중 가장 압도적인 득표를 받았던 코드와 내 코드가 매우 흡사해서 기분이 좋다.

- 공통점
    + 매개변수 minor_words를 받을 때 디폴트 값으로 빈 문자열을 지정한 점
    + capitalize, lower, split을 사용하여 매개변수로 받은 두 문자열을 리스트 형태로 바꾼 점
    + 타이틀 리스트를 for문으로 돌리고 if문으로 각 단어가 minor 리스트에 포함되는지 안되는지 분기해서 capitalize 적용한 점.
    + 마지막 join 써서 리턴한 것.
- 차이점
    + 입력 받은 title 문자열을 나는 title_list라는 새로운 변수로 받았는데 어차피 title 문자열이 다시 쓰이진 않았다. 변수를 괜히 하나 더 쓴 셈이었다. minor_words 역시 마찬가지.
    + capitalize()라는 함수가 첫 글자에만 적용되는 것인 줄 알았다. 그래서 일부러 사전에 lower()를 통해 모든 글자를 소문자로 바꿨다. 하지만 그게 아니라 자동으로 첫 글자 빼고는 모두 소문자로 바꿔주더라. 즉 title 문자열에 lower()는 필요없었던 셈.
    + for문과 if문의 내용 자체는 동일했지만 나와는 다르게 리스트 내포 for문을 활용하고, 한 줄짜리 if문을 표현식으로 활용해서 한 줄로 적었다. 한 줄짜리를 보니 간결하긴 하지만 가독성은 내 코드가 더 좋지 않은가 생각도 조금 들지만, 고수들이 보기엔 나보다 해답 코드가 더 가독성이 좋을 수도 있겠다 생각이 들었다. 

```python
#### 내 코드 
def title_case(title, minor_words=''):
    title_list = title.lower().capitalize().split()
    minor_list = minor_words.lower().split()
    for index, word in enumerate(title_list):
        if word not in minor_list:
            title_list[index] = word.capitalize()
    return ' '.join(title_list)

#### 최고 득표 코드
def title_case(title, minor_words=''):
    title = title.capitalize().split()
    minor_words = minor_words.lower().split()
    return ' '.join([word if word in minor_words else word.capitalize() for word in title])
```
