# facebook 댓글 크롤링하기

특정 포스트에서 댓글을 쓴 사람을 모두 뽑아달라는 의뢰를 받았다. 그 중에서도 이미지를 업로드한 댓글만 선정해야한다. 언어를 하나만 쓰면 더 좋았을텐데 그냥 생각나는 방법대로 JavaScript, Python 둘 다 썼다.

## 1. 이미지가 있는 댓글 선택

```js
const replWithImg = document.getElementsByClassName('scaledImageFitHeight')

const result = []
for (var i = 0; i < replWithImg.length; i++) {
  result.push(replWithImg[i].parentNode.parentNode.parentNode.parentNode.parentNode.childNodes[0].childNodes[0].innerHTML)
}
```

- `scaledImageFitHeight` : 댓글에 있는 이미지의 클래스 명이다.
- 이미지를 골라서 부모, 부모, 부모....등으로 찾아올라가서 댓글을 쓴 부분을 찾았다.
- 아이디(유저명)이 들어가있는 result 를 출력해서 복사해서 파일을 하나 만들어 붙여넣었다.(원래라면 이걸 바로 csv 파일로 저장하면 되는데 그 방법을 못찾아서 그냥 익숙한 Python으로 해버렸다.)

## 2. csv로 저장

```py
import csv

result = []
i = 0
with open('tmp.dat') as fp:
    for line in fp:
        if (i + 1) %3 == 0:
            result.append(str(line)[1:-2])
        i += 1

with open('result.csv', 'w') as fp:
    wr = csv.writer(fp, quoting=csv.QUOTE_ALL)
    for row in result:
        wr.writerow([row])
```

- 출력해서 복사하면 `1, :, name, 2, :, name, 3, :, .........` 이런식으로 한 줄에 하나씩 쭉 붙여넣어진다. 그래서 name 부분만 집어서 새로운 리스트에 넣었다.
- csv 라이브러리를 활용해 새로운 csv 파일로 썼다. 마지막 라인의 row를 리스트로 감싸준 이유는 이것을 하나의 row로 인식하게 하기 위해서다.
