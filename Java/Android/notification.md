# Notification

## 1. 기본 알림 띄우기

- 알림 띄우는 방법이다. layout xml파일에 버튼을 하나 만들고, onClick 속성에서 실행할 메소드를 지정해둔다. 아래 예제에선 makeNotification 메소드다.

    ```xml
    <Button android:id="@+id/button"
            android:layout_width="match_parent"
            android:layout_height="50dp"
            android:text="generate Notification"
            android:onClick="makeNotification"/>
    ```

- 그리고 manifest xml 파일에서 진동 permission을 허가해준다.

    ```xml
    <uses-permission android:name="android.permission.VIBRATE" />
    ```

- 실제 실행할 메소드다. 여기서 알림을 만든다.
    + 메소드는 View 객체를 매개변수로 받는다. 터치한 View다. 터치한 것이 어떤 것이냐에 따라서 활동을 달리해줄 것이므로 switch 문을 사용했다.
    + Notification builder를 활용해서 노티의 제목과 본문을 지정할 수 있다.

    ```java
    public void makeNotification(View v){
        switch( v.getId() ){
            case R.id.button:
                NotificationManager manager= (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);

                NotificationCompat.Builder builder= new NotificationCompat.Builder(this)
                        .setSmallIcon(android.R.drawable.ic_dialog_alert)
                        .setTicker("Notify")
                        .setContentTitle("Title")
                        .setContentText("Contents");

                builder.setLargeIcon(BitmapFactory.decodeResource(getResources(), android.R.drawable.ic_dialog_info));

                Uri soundUri= RingtoneManager.getActualDefaultRingtoneUri(this, RingtoneManager.TYPE_NOTIFICATION);
                builder.setSound(soundUri);
                builder.setVibrate(new long[]{0,3000});
                builder.setAutoCancel(true);

                Notification notification= builder.build();
                manager.notify(0, notification);
                break;
        }
    }
    ```

## 2. Android wear 알림 배경 및 노티

```java
// 첫 화면 배경화면과 메시지 타이틀.
NotificationCompat.Builder builder= new NotificationCompat.Builder(this)
        .setContentTitle("스트레칭을 해주세요.")
        .extend(new NotificationCompat.WearableExtender().setBackground(
                BitmapFactory.decodeResource(getResources(), R.mipmap.data_designer)
        ));

// 두 번째 화면. 배경화면과 상세 메시지
Notification detailPage = new NotificationCompat.Builder(this)
                .setContentText("잠시 기지개를 활짝 펴보세요.")
                .extend(new NotificationCompat.WearableExtender()
                    .setBackground(BitmapFactory.decodeResource(
                        getResources(), R.mipmap.dd3)
                ))
                .build();

// 연결고리
Notification extendedNotification = builder
                .extend(new NotificationCompat.WearableExtender()
                    .addPage(detailPage))
                .build();

Notification notification= builder.build();
manager.notify(0, notification);
```

- `NotificationCompat.WearableExtender`를 활용한다.
- 배경은 `setBackground`를 쓰고, 안에 bitmap 객체를 넣어주면 되는데 스마트워치의 사이즈가 400*400이라서 딱 그 픽셀에 맞춰서 넣어줘야한다. drawable-nodpi를 쓰기 때문에 픽셀 사이즈를 맞춰주는 것이 좋다. 안그러면 늘어진다.
- 연결은 builder 객체에 extend 함수에서 내부에 extender 객체 만들고 `addPage` 함수를 쓰면 된다.

















