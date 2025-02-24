import "package:formularz_snu_client/formularz_snu_client.dart";
import "package:sleep_app/dependency_injection.dart";

class FormRepository {
  Future<bool> doesEmailExist(String email) async {
    return getIt<Client>().participant.doesThisEmailExist(email);
  }

  Future<bool> hasTodayAlreadySentResponse(String email) async {
    return getIt<Client>().formEntry.hasTodayAlreadySentResponse(email);
  }

  Future<bool> isStudyInProgress() async {
    return getIt<Client>().config.isStudyInProgress();
  }
}
