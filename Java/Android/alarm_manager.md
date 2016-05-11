# Alarm Manager

참고 링크: [아라비안나이트 블로그](http://arabiannight.tistory.com/entry/%EC%95%88%EB%93%9C%EB%A1%9C%EC%9D%B4%EB%93%9CAndroid-dd)

## 1. 특정 시간 기준

특정 시간을 기준으로 경과된 시간(ELAPSED_REALTIME) 혹은 실제 시간 (RTC; Real-time clock)으로 설정

## 2. 대기모드에서 수행 여부

- `AlarmManager.ELAPSED_REALTIME` : 단말기가 부팅된 이후 경과된 시간을 기준으로 합니다.
- `AlarmManager.ELAPSED_REALTIME_WAKEUP` : ELAPSED_REALTIME과 동일하며, 대기상태일 경우 단말기를 활성상태로 전환한 후 작업을 수행합니다.
- `AlarmManager.RTC` : 실제 시간을 기준으로 합니다.
- `AlarmManager.RTC_WAKEUP` : RTC와 동일하며, 대기상태일 경우 단말기를 활성 상태로 전환한 후 작업을 수행합니다.

## 3. 반복 수행 여부

단발성으로 끝나는지 계속 반복되는지.

## 4. 정확한 시간에 수행되어야?

어느 정도 오차 여부 있어도 되는지 정한다. 정확하게 수행하려면 배터리가 더 소모된다고 함.

