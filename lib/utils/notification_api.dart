import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifictions = FlutterLocalNotificationsPlugin();
  static int idValue = 0;
  static final onNotification = BehaviorSubject<String>();

  static Future<void> initState({bool initScheduled = false}) async {
    var initializationSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // <- default icon name is @mipmap/ic_launcher
    var initializationSettingsIOS = DarwinInitializationSettings(
        // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
        );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    print("object");
    await _notifictions.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        onNotification.add(details.payload!);
      },
    );
  }

  static Future _notifictionsDetails() async {
    final bool granted = await _notifictions
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
    print(granted);
    // _notificationsEnabled = granted;

    return const NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          channelDescription: 'channel description',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker'),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future<void> showNotification({
    // int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notifictions.show(
      idValue++,
      title,
      body,
      await _notifictionsDetails(),
      payload: payload,
    );
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
