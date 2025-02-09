import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/localization_extension.dart";

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: context.localize.email_text_field_hint,
              ),
            ),
          ],
        ),
      ),
    );
  }  
}
