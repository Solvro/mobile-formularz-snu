import "package:formularz_snu_client/formularz_snu_client.dart";
import "package:serverpod_flutter/serverpod_flutter.dart";

// for now we don't have any auth nor api key
final client = Client("https://api.formularz-snu.s.solvro.pl/")
  ..connectivityMonitor = FlutterConnectivityMonitor();

Future<void> exampleQueries() async {
  await client.participant.doesThisEmailExist(
    "test@test.test", // returns whether a person is enrolled in the study
  );
  await client.config
      .isStudyInProgress(); // returns whether the study is in progress (current datetime is after start date and before end date)

  await client.formEntry.submitForm(
    // submitting a form
    FormData(
      inBedStartTime: DateTime.now(),
      fallingAsleepTime: DateTime.now(),
      wakeUpTime: DateTime.now(),
      midNightAwaikingsCount: 6,
      outBedTime: DateTime.now(),
      totalMidNightAwaikingsTime: Duration(days: 1),
      sleepQuality: SleepScore.four,
    ),
    "test@test.test",
  );

  await client.formEntry.hasTodayAlreadySentResponse(
    "test@test.test", // returns whether the participant has already submitted a form today
  );
}
