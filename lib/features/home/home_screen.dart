import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../constants/app_dimensions.dart";
import "../../extensions/context_extensions.dart";
import "../../gen/assets.gen.dart";
import "../../navigation/app_router.dart";
import "../email/data/email_local_repository.dart";
import "../study_in_progress/presentation/study_in_pogrogress_section.dart";

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.microtask(EmailLocalRepository.getEnrolledEmail),
      builder: (context, snapshot) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingBig,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.icon.path,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: AppDimensions.heightMedium),
                Text(
                  "Badanie snu",
                  style: context.theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: AppDimensions.heightBig),
                EnrolledEmailConsumer(
                  snapshot: snapshot,
                ),
                const SizedBox(height: AppDimensions.heightBig),
                Text(
                  "Aplikacja stworzona przez Koło Naukowe Solvro",
                  style: context.theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EnrolledEmailConsumer extends StatelessWidget {
  const EnrolledEmailConsumer({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot<String?> snapshot;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              final isLogged = snapshot.hasData;
              if (!isLogged) {
                return StudyInPogrogressSection(
                  onPressed: () {
                    unawaited(context.router.push(EmailRoute()));
                  },
                );
              } else {
                return const RedirectWidget();
              }
            }
            return Text(
              "Wystąpił błąd: ${snapshot.error}",
              style: context.theme.textTheme.bodyMedium?.copyWith(
                color: context.theme.colorScheme.error,
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class RedirectWidget extends HookWidget {
  const RedirectWidget({super.key});
  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        Future.microtask(() async {
          if (!context.mounted) return;
          await context.router.replaceAll([const QuestionsRoute()]);
        });
        return null;
      },
      [],
    );
    return const CircularProgressIndicator();
  }
}
