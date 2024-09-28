import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.reload();
    prefs.setBool('bgTaskRunning', true);

    final connectionResult = await (Connectivity().checkConnectivity());
    if (connectionResult.contains(ConnectivityResult.none)) {
      return Future.value(false);
    }
    
    return Future.value(true);
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
