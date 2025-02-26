import "package:formularz_snu_client/formularz_snu_client.dart";
import "package:sleep_app/features/email/data/email_local_repository.dart";
import "package:sleep_app/features/questions/data/questions_repository.dart";

class QuestionsService {
  static Future<void> submitSurveyResponse(
    DateTime inBedStartTime,
    DateTime fallingAsleepTime,
    DateTime wakeUpTime,
    int midNightAwaikingsCount,
    DateTime outBedTime,
    Duration totalMidNightAwaikingsTime,
    SleepScore2 sleepQuality,
  ) async {
    final email = await EmailLocalRepository.getEnrolledEmail();
    if (email == null) {
      throw Exception("Email not found. Please enroll first.");
    }
    await QuestionsRepository().submitSurveyResponse(
      inBedStartTime,
      fallingAsleepTime,
      wakeUpTime,
      midNightAwaikingsCount,
      outBedTime,
      totalMidNightAwaikingsTime,
      sleepQuality,
      email,
    );
  }
}
