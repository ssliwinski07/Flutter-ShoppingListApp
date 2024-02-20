import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setString({String? key, String? value}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key!, value!);
  }

  Future getString({String? key}) async {
    String? value;
    final SharedPreferences prefs = await _prefs;
    value = prefs.getString(key!);

    return value;
  }
}
