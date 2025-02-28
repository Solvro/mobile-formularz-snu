import "package:flutter/material.dart";
import "package:sleep_app/gen/assets.gen.dart";

import "../constants/app_dimensions.dart";
import "../extensions/context_extensions.dart";

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Aplikacja stworzona przez Koło Naukowe Solvro",
          style: context.theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.heightBig),
        Image.asset(
          Assets.solvro.path,
          width: 150,
        ),
        const SizedBox(height: 2 * AppDimensions.heightBig),
      ],
    );
  }
}
