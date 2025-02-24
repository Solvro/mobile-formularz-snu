import "../data/email_local_repository.dart";
import "../data/email_remote_repository.dart";

class EmailService {
  static Future<bool> tryToEnroll(String email) async {
    if (await EmailRemoteRepository.doesEmailExist(email)) {
      await EmailLocalRepository.saveEmail(email);
      return true;
    } else {
      return false;
    }
  }
}
