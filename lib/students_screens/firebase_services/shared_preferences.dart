import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesHelper {
  static Future<void> saveUserProfile(Map<String, dynamic> userProfile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstName', userProfile['First Name'] ?? '');
    prefs.setString('lastName', userProfile['Last Name'] ?? '');
    prefs.setString('email', userProfile['email'] ?? '');
    prefs.setString('phone', userProfile['phn'] ?? '');
  }

  static Future<Map<String, String>> getUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'First Name': prefs.getString('firstName') ?? '',
      'Last Name': prefs.getString('lastName') ?? '',
      'email': prefs.getString('email') ?? '',
      'phn': prefs.getString('phone') ?? '',
    };
  }
}
