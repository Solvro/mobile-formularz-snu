import "package:formularz_snu_client/formularz_snu_client.dart";
import "package:sleep_app/dependency_injection.dart";

class StudyInProgressRepo {
  static Future<bool> isStudyInProgress() async {
    return getIt<Client>().config.isStudyInProgress();
  }
}
