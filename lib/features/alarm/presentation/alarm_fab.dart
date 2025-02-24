import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/navigation/app_router.dart";
import "package:sleep_app/theme/app_colors.dart";

class AlarmFab extends StatelessWidget {
  const AlarmFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppDimensions.paddingMedium,
        right: AppDimensions.paddingMedium,
      ),
      child: FloatingActionButton(
        onPressed: () async => context.router.push(const AlarmRoute()),
        backgroundColor: AppColors.amethyst,
        child: const Icon(Icons.alarm, color: AppColors.dark),
      ),
    );
  }
}
