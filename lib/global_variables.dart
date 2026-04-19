import 'package:shared_preferences/shared_preferences.dart';

class FirstTime {
  static bool isFirstTime = true;

  static Future<void> registerFirstTime() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTime', false);
    } catch (e) {
      // Log error but don't crash the app
      print('Error registering first time: $e');
    }
  }

  static Future<void> getFirstTime() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isFirstTime = prefs.getBool('isFirstTime') ?? true;
    } catch (e) {
      // Log error but don't crash the app, default to true (first time)
      print('Error getting first time status: $e');
      isFirstTime = true;
    }
  }
}
