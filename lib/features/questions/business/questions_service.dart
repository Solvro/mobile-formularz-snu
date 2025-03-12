import "package:formularz_snu_client/formularz_snu_client.dart";

import "../../email/data/email_local_repository.dart";
import "../data/questions_repository.dart";

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
      inBedStartTime.copyWith(
        year: DateTime.now().year,
      ),
      fallingAsleepTime.copyWith(
        year: DateTime.now().year,
      ),
      wakeUpTime.copyWith(
        year: DateTime.now().year,
      ),
      midNightAwaikingsCount,
      outBedTime.copyWith(
        year: DateTime.now().year,
      ),
      totalMidNightAwaikingsTime,
      sleepQuality,
      email,
    );
  }
}
