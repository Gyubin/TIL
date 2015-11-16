# 파이썬에서 날짜와 시간 사용 기초

참고: [wikidocs](https://wikidocs.net/33)

## 1. 날짜 사용 - datetime

- ```from datetime import datetime ``` : datetime module에서 datetime 클래스를 가져온다.
- ```now = datetime.now()``` : 현재 시간(연월일시분초)을 객체로 담아 리턴한다.
- now 객체에서 year, month, day, hour, minute, second를 ```now.year``` 형태로 호출할 수 있다. 문자열 형태로 리턴된다.
- 공식 문서 [datetime](https://docs.python.org/3.5/library/datetime.html)

## 2. 시간 사용 - time

- `import time` -> `time.time()` : 1970년 1월 1일을 기준으로 몇 초가 지났는지 리턴해준다.
- `localtime`

```python
import time
time.localtime(time.time())
# 리턴 객체
time.struct_time(tm_year=2015, tm_mon=11, tm_mday=16, tm_hour=20, tm_min=45, tm_sec=40, tm_wday=0, tm_yday=320, tm_isdst=0)
```

- `time.asctime(time.localtime(time.time()))` : 위 localtime 리턴값을 넣어서 보기 좋게 만들어준다. "Sat Apr 28 20:50:20 2001" 이런 형태 리턴.
- `time.ctime()` : 현재 시간 예쁘게 asctime처럼 표현
- `time.strftime('출력할 형식포맷코드', time.localtime(time.time()))` : 시간 데이터를 세밀하게 나타낼 수 있는 포맷을 제공한다.

| 포맷 코드 |             설명             |        예         |
|-----------|------------------------------|-------------------|
| %a        | 요일 줄임말                  | Mon               |
| %A        | 요일                         | Monday            |
| %b        | 달 줄임말                    | Jan               |
| %B        | 달                           | January           |
| %c        | 날짜와 시간 출력             | 06/01/01 17:22:21 |
| $d        | 날(day)                      | [00,31]           |
| %H        | 시간 - 24시간 형태           | [00,23]           |
| %I        | 시간 - 12시간 형태           | [01,12]           |
| %j        | 1년 중 누적 날짜             | [001,366]         |
| %m        | 달                           | [01,12]           |
| %M        | 분                           | [01,59]           |
| %p        | AM or PM                     | AM                |
| %S        | 초                           | [00,61]           |
| %U        | 1년 중 누적 주 - 일요일 시작 | [00,53]           |
| %w        | 숫자로 된 요일               | [0(일요일),6]     |
| %W        | 1년 중 누적 주 - 월요일 시작 | [00,53]           |
| %x        | 현재 설정 로케일 기반 날짜   | 06/01/01          |
| %X        | 현재 설정 로케일 기반 시간   | 17:22:21          |
| %Y        | 년도 출력                    | 2001              |
| %Z        | 시간대 출력                  | 대한민국 표준시   |
| %%        | 문자 퍼센트                  | %                 |
| %y        | 세기부분 제외한 년도         | 01                |

```python
import time
time.strftime('%x', time.localtime(time.time()))
# '05/01/01' 
time.strftime('%c', time.localtime(time.time())) 
# '05/01/01 17:22:21'
```

- `time.sleep(초)` : 주로 반복문에서 일정한 시간 간격 주기 위해 사용한다. time.sleep(1)이면 1초 쉬는 것, time.sleep(0.5)는 0.5초 쉬는 것

## 3. 달력 사용

`import calendar`

- 연도의 전체 달력 출력: `print(calendar.calendar(2015))` or `calendar.prcal(2015)`
- 월단위 출력: `calendar.prmonth(2015, 11)`
- 특정 날짜의 요일 알아내기: `calendar.weekday(2015, 11, 16)` 월요일부터 일요일까지 0에서 6까지의 값을 리턴한다.
- 연도와 달을 입력해서 그 달의 1일이 무슨 요일인지, 그 달이 며칠까지 있는지 리턴받기: `calendar.monthrange(2015, 11)`
