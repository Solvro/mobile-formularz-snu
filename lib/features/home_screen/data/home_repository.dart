import "package:formularz_snu_client/formularz_snu_client.dart";
import "package:sleep_app/features/api_base/client_provider.dart";

class HomeRepository {

  final Client client = ClientProvider().client;

  Future<bool> doesEmailExist(String email) async {
    return client.participant.doesThisEmailExist(
      email,
    );
  }

  Future<bool> hasTodayAlreadySentResponse(String email) async {
    return client.formEntry.hasTodayAlreadySentResponse(
      email,
    );
  }
  
}
