import "../../email/data/email_local_repository.dart";
import "../data/form_repository.dart";

class FormService {
  static Future<bool> hasTodayAlreadySent() async {
    final email = await EmailLocalRepository.getEnrolledEmail();
    if (email == null) {
      throw Exception("Email not found. Please enroll first.");
    }
    return FormRepository.hasTodayAlreadySentResponse(email);
  }
}
