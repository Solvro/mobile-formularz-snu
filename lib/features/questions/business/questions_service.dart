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
        month: DateTime.now().month,
        day: inBedStartTime.hour > wakeUpTime.hour
            ? DateTime.now().day - 1
            : DateTime.now().day,
      ),
      fallingAsleepTime.copyWith(
        year: DateTime.now().year,
        month: DateTime.now().month,
        day: fallingAsleepTime.hour > wakeUpTime.hour
            ? DateTime.now().day - 1
            : DateTime.now().day,
      ),
      wakeUpTime.copyWith(
        year: DateTime.now().year,
        month: DateTime.now().month,
        day: DateTime.now().day,
      ),
      midNightAwaikingsCount,
      outBedTime.copyWith(
        year: DateTime.now().year,
        month: DateTime.now().month,
        day: DateTime.now().day,
      ),
      totalMidNightAwaikingsTime,
      sleepQuality,
      email,
    );
  }
}
