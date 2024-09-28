import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:zini_pay_demo/services/sms_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.reload();
    prefs.setBool('bgTaskRunning', true);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    final connectionResult = await (Connectivity().checkConnectivity());
    if (connectionResult.contains(ConnectivityResult.none)) {
      flutterLocalNotificationsPlugin.show(
        0,
        'No internet connection',
        'Please connect to the internet to sync sms',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'sms-sync-channel',
            'sms-sync-channel',
            channelDescription: 'sms-sync-channel',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
      return Future.value(false);
    } else {
      flutterLocalNotificationsPlugin.show(
        0,
        'Syncing sms time: ${DateTime.now()}',
        'Please wait while we sync your sms',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'sms-sync-channel',
            'sms-sync-channel',
            channelDescription: 'sms-sync-channel',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
      try {
        await SmsService.sendSms({
          "message": "Test message now from Talha",
          "from": "+1234567899",
          "timestamp": DateTime.now().toString(),
        });
      } catch (e) {
        return Future.value(false);
      }
      return Future.value(true);
    }
  });
}

class BackgroundService {
  static Future<void> initialize(bool isDebug) async {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: isDebug,
    );
  }

  static Future<void> startService() async {
    await Workmanager().registerPeriodicTask(
      "sms-sync",
      "sms-sync",
      frequency: const Duration(minutes: 15),
      initialDelay: const Duration(seconds: 5),
    );
  }

  static Future<void> stopService() async {
    await Workmanager().cancelAll();
    final prefs = await SharedPreferences.getInstance();
    prefs.reload();
    await prefs.setBool('bgTaskRunning', false);
  }

  static Future<bool> isTaskRunning() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.reload();
    return prefs.getBool('bgTaskRunning') ?? false;
  }
}
