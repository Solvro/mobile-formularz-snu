import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:sleep_app/features/alarm/presentation/alarm_info.dart";
import "package:sleep_app/features/email/data/email_local_repository.dart";
import "package:sleep_app/gen/assets.gen.dart";
import "package:sleep_app/theme/app_colors.dart";

import "../../../constants/app_dimensions.dart";
import "../../../extensions/context_extensions.dart";
import "../../../navigation/app_router.dart";
import "../../../widgets/logo.dart";
import "../business/form_service.dart";

@RoutePage()
class FirstFormScreen extends HookWidget {
  const FirstFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logOut = useCallback(() async {
      await EmailLocalRepository.deleteEmail();
      if (context.mounted) {
        await context.router.replaceAll([const HomeRoute()]);
      }
    });

    return FutureBuilder(
      future: Future.microtask(FormService.hasTodayAlreadySent),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: logOut,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.light,
                ),
                child: const Text("Wyloguj się"),
              ),
            ],
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.solvro.path,
                width: 150,
                height: 100,
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: const Alignment(0, -1 / 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TextLogo(),
                      TodaySentConsumer(snapshot: snapshot),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: AppColors.lavenda,
                thickness: 3,
              ),
              const Expanded(
                child: Center(child: AlarmInfo()),
              ),
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
                const SizedBox(height: 2 * AppDimensions.heightBig),
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
