import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zini_pay_demo/core/router.dart';
import 'package:zini_pay_demo/core/theme.dart';
import 'package:zini_pay_demo/screens/home_screen.dart';
import 'package:zini_pay_demo/screens/login_screen.dart';
import 'package:zini_pay_demo/services/Auth_service.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final isAuthorized = await AuthService.isLoggedIn();
    runApp(MyApp(
      isAuthorized: isAuthorized,
    ));
  }, (error, stackTrace) {});
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isAuthorized,
  });
  final bool isAuthorized;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZiniPay Demo',
      theme: AppTheme.theme,
      navigatorKey: AppRouter.navigatorKey,
      home: isAuthorized ? const HomeScreen() : const LoginScreen(),
    );
  }
}
