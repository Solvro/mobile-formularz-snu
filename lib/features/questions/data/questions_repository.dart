import "package:formularz_snu_client/formularz_snu_client.dart";
import "package:sleep_app/dependency_injection.dart";

class QuestionsRepository {
  Future<void> submitSurveyResponse(
    DateTime inBedStartTime,
    DateTime fallingAsleepTime,
    DateTime wakeUpTime,
    int midNightAwaikingsCount,
    DateTime outBedTime,
    Duration totalMidNightAwaikingsTime,
    SleepScore sleepQuality,
    String email,
  ) async {
    await getIt<Client>().formEntry.submitForm(
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
