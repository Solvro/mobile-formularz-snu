import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/study_in_progress/presentation/study_in_pogrogress_section.dart";
import "package:sleep_app/gen/assets.gen.dart";
import "package:sleep_app/navigation/app_router.dart";

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
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
            Center(
              child: StudyInPogrogressSection(
                onPressed: () {
                  unawaited(context.router.push(EmailRoute()));
                },
              ),
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
  }
}
