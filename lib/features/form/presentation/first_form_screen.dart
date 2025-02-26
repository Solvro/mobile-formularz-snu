import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:sleep_app/features/alarm/presentation/alarm_info.dart";
import "package:sleep_app/features/email/data/email_local_repository.dart";

import "../../../constants/app_dimensions.dart";
import "../../../extensions/context_extensions.dart";
import "../../../navigation/app_router.dart";
import "../../../widgets/footer.dart";
import "../../../widgets/logo.dart";
import "../business/form_service.dart";

enum PopupMenuItemAction {
  logOut,
  setAlarm,
}

@RoutePage()
class FirstFormScreen extends HookWidget {
  const FirstFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onPopupMenuClicked = useCallback((PopupMenuItemAction action) async {
      switch (action) {
        case PopupMenuItemAction.logOut:
          {
            await EmailLocalRepository.deleteEmail();
            if (context.mounted) {
              await context.router.replaceAll([const HomeRoute()]);
            }
          }
        case PopupMenuItemAction.setAlarm:
          await context.router.push(const AlarmRoute());
      }
    });

    return FutureBuilder(
      future: Future.microtask(FormService.hasTodayAlreadySent),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              PopupMenuButton<PopupMenuItemAction>(
                icon: const Icon(Icons.more_vert),
                onSelected: onPopupMenuClicked,
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<PopupMenuItemAction>(
                      value: PopupMenuItemAction.logOut,
                      child: Text("Wyloguj się"),
                    ),
                    const PopupMenuItem<PopupMenuItemAction>(
                      value: PopupMenuItemAction.setAlarm,
                      child: Text("Ustaw budzik"),
                    ),
                  ];
                },
              ),
            ],
          ),
          bottomNavigationBar: const Footer(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextLogo(),
              TodaySentConsumer(snapshot: snapshot),
              const AlarmInfo(),
            ],
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
                ElevatedButton(
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
