import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../extensions/context_extensions.dart";
import "../../../navigation/app_router.dart";
import "../../email/data/email_local_repository.dart";
import "../data/study_in_progress_repo.dart";

class StudyInPogrogressSection extends StatelessWidget {
  const StudyInPogrogressSection({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.microtask(StudyInProgressRepo.isStudyInProgress),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(
            "Wystąpił błąd",
            style: TextStyle(color: context.theme.colorScheme.error),
          );
        } else {
          final bool studyInProgress = snapshot.data ?? false;
          return studyInProgress
              ? ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    "Weź udział w badaniu",
                    style: context.theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                )
              : Text(
                  "Aktualnie nie trwa żadne badanie. Sprawdź za parę dni, lub odezwij się do nas.",
                  style: context.theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                );
        }
      },
    );
  }
}

class RedirectIfNotInProgressAnymore extends StatelessWidget {
  const RedirectIfNotInProgressAnymore({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.microtask(StudyInProgressRepo.isStudyInProgress),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(
            "Wystąpił błąd",
            style: TextStyle(color: context.theme.colorScheme.error),
          );
        } else {
          final bool studyInProgress = snapshot.data ?? false;
          return studyInProgress ? child : const LogoutWidget();
        }
      },
    );
  }
}

class LogoutWidget extends HookWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logOut = useCallback(() async {
      await EmailLocalRepository.deleteEmail();
      if (context.mounted) {
        await context.router.replaceAll([const HomeRoute()]);
      }
    });

    useEffect(
      () {
        unawaited(logOut());
        return null;
      },
      [],
    );

    return const CircularProgressIndicator();
  }
}
