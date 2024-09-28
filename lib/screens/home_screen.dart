import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zini_pay_demo/core/colors.dart';
import 'package:zini_pay_demo/core/extensions.dart';
import 'package:zini_pay_demo/core/strings.dart';
import 'package:zini_pay_demo/core/typography.dart';
import 'package:zini_pay_demo/screens/widgets.dart/active_check_widget.dart';
import 'package:zini_pay_demo/services/background_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSyncing = false, _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActiveCheckWidget(
                isActive: _isSyncing,
              ),
              18.0.height,
              Text(
                _isSyncing ? Strings.active : Strings.inActive,
                style: AppTypography.acmeH1,
              ),
              168.0.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: _toggleSync,
                  child: _isLoading
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        )
                      : Text(
                          _isSyncing ? Strings.stop : Strings.start,
                          style: AppTypography.acmeH1
                              .copyWith(color: AppColors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initialize() async {
    _toggleLoading();
    await BackgroundService.initialize(true);
    _isSyncing = await BackgroundService.isTaskRunning();
    _toggleLoading();
  }

  void _toggleSync() async {
    _toggleLoading();
    await checkNotificationPermission();
    if (_isSyncing) {
      await BackgroundService.stopService();
    } else {
      await BackgroundService.startService();
    }

    _isSyncing = !_isSyncing;

    _toggleLoading();
  }

  _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> checkNotificationPermission() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }
}
