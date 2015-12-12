# #10 이미지 파일 관리하기

'Photo 모델로 Admin 영역에서 데이터 다루기' [글](http://blog.hannal.com/2014/10/start_with_django_webframework_04/)이다.

## 1. 이미지 파일을 admin에서 관리해보기

- photo app의 `admin.py`에서 `admin.site.register(Photo)` 추가
- `models.py`에서 이미지 파일 경로 추가

```py
image_file = models.ImageField(upload_to='static_files/uploaded/original/%Y/%m/%d')
filtered_image_file = models.ImageField(upload_to='static_files/uploaded/filtered/%Y/%m/%d')
```

- Photo 클래스의 객체가 지워지면 파일도 지워지도록 하려면 Photo 클래스의 `delete` 메소드를 오버라이드해주면 된다. 원래 models.Model에 있는 메소드다.

```python
class Photo(models.Model):
    def delete(self, *args, **kwargs):
        self.image_file.delete()
        self.filtered_image_file.delete()
        super(Photo, self).delete(*args, **kwargs)
```

## 2. 추가 개념 정리

- photo app의 admin.py 파일을 수정하고 저장하면 파이썬 내장 웹서버가 자동으로 재실행된다.
- 예를 들어 created_at 필드처럼 자동 입력이 되도록 해놓았으면 admin 페이지에서 새 객체를 추가하려고 할 때 입력 폼이 나타나지 않는다.
- TextField에서 blank 옵션을 True로 주면 빈 칸으로 저장해도 오류를 띄우지 않는다.
