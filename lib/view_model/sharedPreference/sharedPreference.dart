import 'package:prototype/resources/constants/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllLocalData {
  static final AllLocalData _instance = AllLocalData._internal();
  SharedPreferences? _preferences;

  // Private constructor for singleton
  AllLocalData._internal();

  // Singleton accessor
  factory AllLocalData() => _instance;

  // Initialize SharedPreferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Setters
  Future<void> setIsLoggedIn(bool value) async {
    await _preferences?.setBool(ConstantKey.IS_LOGIN, value);
  }

  Future<void> setEmail(String email) async {
    await _preferences?.setString(ConstantKey.KEY_EMAIL, email);
  }

  Future<void> setUsername(String username) async {
    await _preferences?.setString(ConstantKey.KEY_USERNAME, username);
  }

  Future<void> setUserId(String id) async {
    await _preferences?.setString(ConstantKey.KEY_USER_ID, id);
  }

  Future<void> setRemoteUserId(String id) async {
    await _preferences?.setString(ConstantKey.KEY_REMOTE_USER_ID, id);
  }

  // Getters
  bool get isLoggedIn => _preferences?.getBool(ConstantKey.IS_LOGIN) ?? false;

  String? get email => _preferences?.getString(ConstantKey.KEY_EMAIL);

  String? get username => _preferences?.getString(ConstantKey.KEY_USERNAME);

  String? get userid => _preferences?.getString(ConstantKey.KEY_USER_ID);

  String? get remoteuserid =>
      _preferences?.getString(ConstantKey.KEY_REMOTE_USER_ID);

  // Clear all preferences
  Future<void> clearAll() async {
    await _preferences?.clear();
  }
}
