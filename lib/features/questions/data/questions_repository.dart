import "package:formularz_snu_client/formularz_snu_client.dart";
import "package:sleep_app/features/api_base/client_provider.dart";

class QuestionsRepository {

  final Client client = ClientProvider().client;

  Future<void> submitForm(
    DateTime inBedStartTime,
    DateTime fallingAsleepTime,
    DateTime wakeUpTime,
    int midNightAwaikingsCount,
    DateTime outBedTime,
    Duration totalMidNightAwaikingsTime,
    SleepScore sleepQuality,
    String email,
  ) async {
    await client.formEntry.submitForm(
      FormData(
        inBedStartTime: inBedStartTime,
        fallingAsleepTime: fallingAsleepTime,
        wakeUpTime: wakeUpTime,
        midNightAwaikingsCount: midNightAwaikingsCount,
        outBedTime: outBedTime,
        totalMidNightAwaikingsTime: totalMidNightAwaikingsTime,
        sleepQuality: sleepQuality,
      ),
      email,
    );
  }
}
