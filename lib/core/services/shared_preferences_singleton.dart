import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static late SharedPreferences _instance;

  static Future<void> init() async{
    _instance = await SharedPreferences.getInstance();
  }
  static Future<void> setString(String key, String value) async{
    await _instance.setString(key, value);
  }
  static String getString(String key){
    return _instance.getString(key) ?? '';
  }

  static void deleteString(String key){
    _instance.remove(key);
  }
}