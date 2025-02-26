import "package:flutter/material.dart";
import "package:sleep_app/gen/assets.gen.dart";

import "../constants/app_dimensions.dart";
import "../extensions/context_extensions.dart";

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 3 * AppDimensions.heightBig),
        Text(
          "Aplikacja stworzona przez Koło Naukowe Solvro",
          style: context.theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Image.asset(
          Assets.solvro.path,
          width: 150,
          height: 150,
        ),
      ],
    );
  }
}
