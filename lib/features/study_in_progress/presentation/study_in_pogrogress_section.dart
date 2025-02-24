import "package:flutter/material.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/study_in_progress/data/study_in_progress_repo.dart";

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
          return const Text("Wystąpił błąd");
        } else {
          final bool studyInProgress = snapshot.data ?? false;
          return studyInProgress
              ? TextButton(
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
