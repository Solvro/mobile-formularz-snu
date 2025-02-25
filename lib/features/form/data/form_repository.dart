import "package:formularz_snu_client/formularz_snu_client.dart";

import "../../../dependency_injection.dart";

class FormRepository {
  static Future<bool> hasTodayAlreadySentResponse(String email) async {
    return getIt<Client>().formEntry.hasTodayAlreadySentResponse(email);
  }
}
