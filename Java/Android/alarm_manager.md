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
    + `isCell` 변수를 써서 실험 시작 버튼인지, 취소 버튼인지 구분했다.
    + `cellNum` 변수로 실험 종류를 구분했다. intent의 extra로 전달해서 리시버에서 구분했다.
    + `AlarmManager` 객체를 만들고 Intent를 위 설명과 같이 설정한다. 그리고 객체를 통해 세부 내용을 set한다.
    + `PendigIntent` 객체 생성 (1): 만약 알람을 여러개 만들고싶다면 `getBroadcast` 메소드의 두 번째 매개변수인 intent의 id 값을 다르게 주면 된다. 같은 값을 주면 계속 알람을 override하게된다. 반복문을 돌려서 객체를 여러개 생성하고 알람매니저로 `set`하면 된다.
    + `PendigIntent` 객체 생성 (2): PendingIntent로 intent를 전달할 때 extra를 함께 보낼 때가 있다. 아래 코드에선 `count`, `cellNum` 변수를 설정해서 보내줬다. 아래 코드에선 `getBroadcast`의 네 번째 매개변수로 `PendingIntent.FLAG_UPDATE_CURRENT`를 넣어주었는데 extra를 갱신한다는 의미다. 한 번 같은 아이디로 이미 intent를 보낸적이 있다면 디폴트로 intent에 포함된 extra는 갱신 불가다. 저 값을 넣어줘야 보낼 떄마다 extra를 갱신할 수 있다. AlarmManager 객체로 모든 알람을 cancel해도 저렇게 설정하지 않으면 갱신되지 않는다.

    ```java
    public void makeAlarm(boolean isCell, int cellNum) {
        // 실험 시작 버튼을 눌렀을 때
        if (isCell) {
            // 공통 처리: 알람매니저, 인텐트 생성
            AlarmManager am = (AlarmManager)getSystemService(Context.ALARM_SERVICE);
            PendingIntent[] sender = new PendingIntent[6];
            int count = 0;
            long alarmTime;

            Calendar target = Calendar.getInstance();
            target.setTimeInMillis(System.currentTimeMillis());

            int[][] times = new int[][]{
                    {13, 5}, {14, 1}, {15, 9}, {16, 22}, {17, 7}, {18, 9}
            };
            for (int[] time : times) {
                Intent intent = new Intent(MainActivity.this, AlarmReceive.class);
                intent.putExtra("count", count);
                intent.putExtra("cellNum", cellNum);    // 메시지, 진동 구분.

                sender[count] = PendingIntent.getBroadcast(MainActivity.this, count, intent, PendingIntent.FLAG_UPDATE_CURRENT);

                target.set(Calendar.HOUR_OF_DAY, time[0]);
                target.set(Calendar.MINUTE, time[1]);
                target.set(Calendar.SECOND, 0);
                target.set(Calendar.MILLISECOND, 0);
                alarmTime = target.getTimeInMillis();
                am.set(AlarmManager.RTC_WAKEUP, alarmTime, sender[count]);
                count++;
            }
            Toast toast = Toast.makeText(getApplicationContext(), "실험이 시작됩니다.", Toast.LENGTH_SHORT);
            toast.setGravity(Gravity.CENTER, 0, 0);
            toast.show();

        // 중단 버튼을 눌렀을 때
        } else {
            EditText pw = (EditText)findViewById(R.id.editText);
            if (pw.getText().toString().equals("0948")) {
                // 모든 알람 없애기
                PendingIntent[] sender = new PendingIntent[6];
                AlarmManager am = (AlarmManager)getSystemService(Context.ALARM_SERVICE);
                Intent intent = new Intent(MainActivity.this, AlarmReceive.class);
                for(int i = 0; i < 6; i++) {
                    sender[i] = PendingIntent.getBroadcast(MainActivity.this, i, intent, 0);
                    am.cancel(sender[i]);
                }

                Toast toast = Toast.makeText(getApplicationContext(), "모든 실험이 중단되었습니다", Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER, 0, 0);
                toast.show();
            } else {
                pw.setText("");
                Toast toast = Toast.makeText(getApplicationContext(), "비밀번호 틀림", Toast.LENGTH_SHORT);
                toast.setGravity(Gravity.CENTER, 0, 0);
                toast.show();
            }
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
