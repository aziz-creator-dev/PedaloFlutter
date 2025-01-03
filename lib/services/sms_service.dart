import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_pfe/utils/constants.dart';

class SmsService {
  static Future<bool> verifyCode(String phoneNumber, String code, String sid) async {
    final url = Uri.parse('${Constants.apiBaseUrl}/verify');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "to": phoneNumber,
      "code": code,
      "sid": sid,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print("Verification successful");
        return true;
      } else {
        print("Failed to verify code: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error during verification: $e");
      return false;
    }
  }

  static Future<void> sendSms(String phoneNumber) async {
    final url = Uri.parse('${Constants.apiBaseUrl}/sms');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"to": phoneNumber});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("SMS sent successfully to $phoneNumber");
      } else {
        print("Failed to send SMS: ${response.body}");
      }
    } catch (e) {
      print("Error sending SMS: $e");
    }
  }
}
