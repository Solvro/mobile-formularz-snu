import "package:formularz_snu_client/formularz_snu_client.dart";

import "../../../dependency_injection.dart";

class EmailRemoteRepository {
  static Future<bool> doesEmailExist(String email) async {
    return getIt<Client>().participant.doesThisEmailExist(email);
  }
}
