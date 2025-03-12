import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../constants/app_dimensions.dart";
import "../../../extensions/context_extensions.dart";
import "../../../gen/assets.gen.dart";
import "../../../navigation/app_router.dart";

@RoutePage()
class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.heightHuge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            Text(
              "Dziękujemy za wypełnienie dzisiejszej ankiety! Do zobaczenia jutro! 👀",
              style: context.theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.heightBig),
            ElevatedButton(
              onPressed: () async =>
                  context.router.replaceAll([const FirstFormRoute()]),
              child: const Text("Powrót do strony głównej"),
            ),
          ],
        ),
      ),
    );
  }
}
