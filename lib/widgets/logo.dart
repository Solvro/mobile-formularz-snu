import "package:flutter/material.dart";

import "../constants/app_dimensions.dart";
import "../gen/assets.gen.dart";

class TextLogo extends StatelessWidget {
  const TextLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.heightMedium,
        bottom: AppDimensions.heightBig,
      ),
      child: Text(
        "Badanie snu",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          Assets.icon.path,
          width: 150,
          height: 150,
        ),
        const TextLogo(),
      ],
    );
  }
}
