import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class Notifyhelper{

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin
  = new FlutterLocalNotificationsPlugin();


  initializenotification() async{
     tz.initializeTimeZones();
     const AndroidInitializationSettings initializationSettingsAndroid=
         AndroidInitializationSettings(
          "appicon"
        );

    const InitializationSettings initializationSettings=
        InitializationSettings(
          android: initializationSettingsAndroid,
        );
    await flutterLocalNotificationsPlugin
        .initialize(initializationSettings,onSelectNotification:selectNotification);


  }
  displaynotification({required String title,required String body }) async{
    var androidplatformchannelspecific= new AndroidNotificationDetails(
        "themeid", "theme",importance: Importance.max,priority: Priority.max);
    var platformchannelspecifics= new NotificationDetails(
        android: androidplatformchannelspecific
    );
    await flutterLocalNotificationsPlugin.show(0, title, body, platformchannelspecifics,payload: 'default_sound');
  }

  Future selectNotification(String? payload)async{
    if(payload!=null){
      print('notificationpayload:$payload');

    }
    else{
      print("Notification Done");
    }
    Get.to(()=>Container(color: Colors.red));
  }
  schedulednotification(String title, String body) async{

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
       const  NotificationDetails(
          android:AndroidNotificationDetails(
              "themeid", "theme",importance: Importance.max,priority: Priority.max)
        ),
        androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,

    );
  }

}