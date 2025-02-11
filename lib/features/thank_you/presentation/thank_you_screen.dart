import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";

@RoutePage()
class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.localize.thank_you, style: context.theme.textTheme.headlineMedium, textAlign: TextAlign.center,),
          SizedBox(height: AppDimensions.heightBig),
          Text(context.localize.final_emotes, style: context.theme.textTheme.bodyMedium, textAlign: TextAlign.center,),
          SizedBox(height: AppDimensions.heightBig),
          TextButton(
            onPressed: () => context.router.popUntilRoot(),
            child: Text(context.localize.back),
          ),
        ],
      ),
    );
  }
}
