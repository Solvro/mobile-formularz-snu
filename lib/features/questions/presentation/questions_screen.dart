import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
// ignore: library_prefixes
import "package:survey_kit/survey_kit.dart" as surveyKit;
import "package:survey_kit/survey_kit.dart";

@RoutePage()
class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Questions")),
      body: FutureBuilder<Task>(
        future: getSurveyTask(context), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: SurveyKit(
                task: snapshot.data!,
                onResult: (SurveyResult result) {},
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

}

Future<Task> getSurveyTask(BuildContext context) async {
  return surveyKit.OrderedTask(
    id: "sleep survey", 
    steps: [
      surveyKit.Step(
        id: context.localize.go_to_bed_time_id,
        content: [
          surveyKit.TextContent(
            text: context.localize.go_to_bed_time,
          ),
        ],
        answerFormat: surveyKit.TextAnswerFormat(
          hint: context.localize.time_hint,
          maxLines: 1,
          validationRegEx: r"^\d{1,2}:\d{2}$",
        ),
        stepShell: (step, child, context) {
          return HourQuestion(step: step, onNext: (result) => surveyKit.SurveyController().nextStep(context, result));
        },
      ),
      surveyKit.Step(
        id: context.localize.go_sleep_time_id,
        content: [
          surveyKit.TextContent(
            text: context.localize.go_sleep_time,
          ),
        ],
        answerFormat: surveyKit.TextAnswerFormat(
          hint: context.localize.time_hint,
          maxLines: 1,
          validationRegEx: r"^\d{1,2}:\d{2}$",
        ),
        stepShell: (step, child, context) {
          return HourQuestion(step: step, onNext: (result) => surveyKit.SurveyController().nextStep(context, result),);
        },
      ),
      surveyKit.Step(
        id: context.localize.go_to_bed_time_id,
        content: [
          surveyKit.TextContent(
            text: context.localize.go_to_bed_time,
          ),
        ],
        answerFormat: surveyKit.TextAnswerFormat(
          hint: context.localize.time_hint,
          maxLines: 1,
          validationRegEx: r"^\d{1,2}:\d{2}$",
        ),
        stepShell: (step, child, context) {
          return HourQuestion(step: step, onNext: (result) => surveyKit.SurveyController().nextStep(context, result));
        },
      ),
    ],
  );
}


class HourQuestion extends StatelessWidget {
  const HourQuestion({
    required this.step,
    required this.onNext,
  });

  final surveyKit.Step step;
  final Function(surveyKit.StepResult) onNext;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

      return Padding(
        padding: EdgeInsets.only(left: AppDimensions.paddingBig, right: AppDimensions.paddingBig, bottom: 128),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text((step.content.first as surveyKit.TextContent).text),
            const SizedBox(height: AppDimensions.heightMedium),
            TextField(
              controller: controller, 
              decoration: InputDecoration(
                hintText: (step.answerFormat as surveyKit.TextAnswerFormat).hint,
              ),
            ),
            const SizedBox(height: AppDimensions.heightMedium),
            TextButton(
              child: Text(context.localize.next),
              onPressed: () {
                String userInput = controller.text.trim();
                RegExp regex = RegExp((step.answerFormat as surveyKit.TextAnswerFormat).validationRegEx!);

                if (userInput.isEmpty || !regex.hasMatch(userInput)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.localize.time_format_error)),
                  );
                  return;
                }

                surveyKit.StepResult result = surveyKit.StepResult(
                  id: step.id,
                  valueIdentifier: userInput,
                  result: userInput,
                  startTime: DateTime.now(),
                  endTime: DateTime.now(),
                  step: step,
                );

                onNext(result);
              },
            ),
          ],
        ),
      );
  }  
}
