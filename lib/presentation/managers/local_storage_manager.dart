import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences? _prefs;

  // Initialize SharedPreferences instance
  Future<void> _init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  Future<void> saveFirstName(String firstName) async {
    await _init();
    await _prefs!.setString('firstName', firstName);
  }

  Future<void> saveLastName(String lastName) async {
    await _init();
    await _prefs!.setString('lastName', lastName);
  }

  Future<String?> getFirstName() async {
    await _init();
    return _prefs!.getString('firstName');
  }

  Future<String?> getLastName() async {
    await _init();
    return _prefs!.getString('lastName');
  }
}
