import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  static FlutterLocalNotificationsPlugin flutterNotification =
      FlutterLocalNotificationsPlugin();
  static onTap(NotificationResponse not) {}
  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    flutterNotification.initialize(settings,
        onDidReceiveBackgroundNotificationResponse: onTap,
        onDidReceiveNotificationResponse: onTap);
        showNotificationRepeated();
  }

  static void showNotification(String title,String body) {
    NotificationDetails details = const NotificationDetails(
      
        android: AndroidNotificationDetails('id 1', "my channel",priority: Priority.high,importance: Importance.max));
    flutterNotification.show(0, "$title", '$body', details,
        payload: "Hi there is Mahlloal");
        
  }
  static void showNotificationRepeated() {
    NotificationDetails details = const NotificationDetails(
        android: AndroidNotificationDetails('id 2', "my channel two",priority: Priority.high,importance: Importance.max));
    flutterNotification.periodicallyShow(0,"هيا بنا", "مقدمين الخدمه علي استعداد لمساعدتك",RepeatInterval.daily, details,
        payload: "hi there is Mahlola");
}
static void cancelNotification(int id){
  flutterNotification.cancel(id);
}
}