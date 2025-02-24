import "package:shared_preferences/shared_preferences.dart";

class EmailLocalRepository {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<void> saveEmail(String email) async {
    final prefs = await _prefs;
    await prefs.setString("email", email);
  }

  static Future<String?> getEnrolledEmail() async {
    final prefs = await _prefs;
    return prefs.getString("email");
  }
}
