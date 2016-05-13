# Alarm Manager

참고 링크: [아라비안나이트 블로그](http://arabiannight.tistory.com/entry/%EC%95%88%EB%93%9C%EB%A1%9C%EC%9D%B4%EB%93%9CAndroid-dd)

## 1. 기본 개념

- 특정 시간 기준: 특정 시간을 기준으로 경과된 시간(ELAPSED_REALTIME) 혹은 실제 시간 (RTC; Real-time clock)으로 설정
- 대기모드에서 수행 여부:
    + `AlarmManager.ELAPSED_REALTIME` : 단말기가 부팅된 이후 경과된 시간을 기준으로
    + `AlarmManager.ELAPSED_REALTIME_WAKEUP` : ELAPSED_REALTIME과 동일. 대기상태일 경우 단말기를 활성상태로 전환한 후 작업을 수행
    + `AlarmManager.RTC` : 실제 시간을 기준으로.
    + `AlarmManager.RTC_WAKEUP` : RTC와 동일하며, 대기상태일 경우 단말기를 활성 상태로 전환한 후 작업을 수행
- 반복 수행 여부: 단발성으로 끝나는지 계속 반복되는지.
- 정확한 시간에 수행되는지: 어느 정도 오차 여부 있어도 되는지 정한다. 정확하게 수행하려면 배터리가 더 소모된다.

## 2. 코드

기본적인 순서는 AlarmManager 객체를 만드는 것부터 시작한다. 그리고 객체가 속한 Activity에서 알람이 실행될 때 동작할 코드가 있는 Activity로 넘어가는 Intent를 만든다. AlarmManager 객체에 시간 정보와 Intent를 매개변수로 넣어서 세부 내용을 `set`한다. 그리고 넘어간 Activity 클래스 java 파일에서 원하는 행동을 설정한다.

- `makeAlarm`: 알람을 만드는 메소드
    + 내 경우엔 사용자가 누구냐에 따라 다른 알람을 설정하도록 되어있어서, 사용자번호를 매개변수로 받아서 분기했다.
    + `AlarmManager` 객체를 만들고 Intent를 위 설명과 같이 설정한다. 그리고 객체를 통해 세부 내용을 set한다.
    + 만약 알람을 여러개 만들고싶다면 `PendigIntent` 객체를 생성할 때 `getBroadcast` 메소드의 두 번째 매개변수의 값을 다르게 주면 된다. 같은 값을 주면 계속 알람을 override하게된다. 반복문을 돌려서 객체를 여러개 생성하고 알람매니저로 `set`하면 된다.

    ```java
    public void makeAlarm(int userNum) {
        if (userNum >= 1 && userNum <= 18) {
            AlarmManager am = (AlarmManager)getSystemService(Context.ALARM_SERVICE);
            Intent intent = new Intent(MainActivity.this, AlarmReceive.class);
            PendingIntent pIntent = PendingIntent.getBroadcast(MainActivity.this, 0, intent, 0);

            Calendar calendar = Calendar.getInstance();
            calendar.setTimeInMillis(System.currentTimeMillis());
            calendar.add(Calendar.SECOND, 6);

            am.set(AlarmManager.RTC_WAKEUP, calendar.getTimeInMillis(), pIntent);
            Log.v("mth", "makeAlarm 끝");
        } else {
            // something
        }
    }
    ```

- `AlarmReceive`: 원하는 동작이 정의되어있음.
    + Activity 클래스는 `BroadcastReceiver`를 상속받아야 한다. 상속받으면 `onReceive` 메소드를 필히 override해야한다. 이 메소드 내에 원하는 작업을 한다.
    + 세부 내용은 일반적인 notification을 만드는 과정과 같다.

    ```java
    public class AlarmReceive extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            NotificationManager manager= (NotificationManager)context.getSystemService(Context.NOTIFICATION_SERVICE);

            NotificationCompat.Builder builder= new NotificationCompat.Builder(context)
                    .setSmallIcon(R.mipmap.dd3)
                    .setTicker("진동 알림 발생")
                    .setContentTitle("스트레칭을 해주세요.")
                    .extend(new NotificationCompat.WearableExtender().setBackground(
                            BitmapFactory.decodeResource(context.getResources(), R.mipmap.metaphor_none_big)
                    ).addPage(detailPage));

            builder.setVibrate(new long[]{200,300, 200, 300});
            builder.setAutoCancel(true);

            Notification notification= builder.build();
            manager.notify(0, notification);
        }
    }
    ```

- `AndroidManifest.xml`
    + 아래 코드를 추가한다.
    + `<applicatoin> ... </application>` 안에 넣어주면 된다.

    ```xml
    <receiver android:name=".AlarmReceive" android:process=":remote" />
    ```
