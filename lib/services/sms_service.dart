import 'package:zini_pay_demo/services/api_service.dart';

class SmsService {
  static Future<bool> sendSms(Map<String, dynamic> data) async {
    final response = await ApiService().post('/sms/sync', data: data);
    if (response.data['success'] == true) {
      return true;
    }
    return false;
  }
}
