import "package:shared_preferences/shared_preferences.dart";
import "package:sleep_app/features/email/data/email_remote_repository.dart";

class EmailService {
  static Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  static Future<bool> tryToEnroll(String email) async {
    if (await EmailRemoteRepository.doesEmailExist(email)) {
      final prefs = await _prefs;
      await prefs.setString("email", email);
      return true;
    } else {
      return false;
    }
  }

  static Future<String?> getEnrolledEmail() async {
    final prefs = await _prefs;
    return prefs.getString("email");
  }
}
