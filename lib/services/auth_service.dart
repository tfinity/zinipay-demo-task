import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zini_pay_demo/services/api_service.dart';

class AuthService {
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<bool> setLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('isLoggedIn', true);
  }

  static Future<bool> login(String email, String apiKey) async {
    try {
      Response response = await ApiService().post(
        '/app/auth',
        data: {
          'email': email,
          'apiKey': apiKey,
        },
      );
      return response.data['success'] == true;
    } catch (e) {
      debugPrint('error: $e');
      return false;
    }
  }
}
