import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../constants/app_dimensions.dart";
import "../../../extensions/context_extensions.dart";
import "../../../navigation/app_router.dart";
import "../../../widgets/footer.dart";
import "../../../widgets/logo.dart";
import "../../alarm/presentation/alarm_fab.dart";
import "../business/form_service.dart";

@RoutePage()
class FirstFormScreen extends StatelessWidget {
  const FirstFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.microtask(FormService.hasTodayAlreadySent),
      builder: (context, snapshot) {
        return Scaffold(
          floatingActionButton: const AlarmFab(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextLogo(),
                TodaySentConsumer(
                  snapshot: snapshot,
                ),
                const Footer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TodaySentConsumer extends StatelessWidget {
  const TodaySentConsumer({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot<bool> snapshot;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasError) {
            final isSent = snapshot.data ?? false;
            if (isSent) {
              return const Text(
                "Dzisiaj ankieta została ju wypełniona. Dziękujemy i zapraszamy jutro. Pamiętaj o opcji ustawienia budzika w naszej aplikacji!",
                textAlign: TextAlign.center,
              );
            }
            return Column(
              children: [
                const Text(
                  "Dzisiaj jeszcze nie wypełniłeś ankiety. Zapraszamy do wypełnienia!",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.heightBig),
                TextButton(
                  onPressed: () async {
                    await context.router.push(const QuestionsRoute());
                  },
                  child: const Text("Wypełnij ankietę"),
                ),
              ],
            );
          }
          return Text(
            "Wystąpił błąd podczas sprawdzania czy ankieta została już wypełniona",
            style: TextStyle(color: context.theme.colorScheme.error),
            textAlign: TextAlign.center,
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
