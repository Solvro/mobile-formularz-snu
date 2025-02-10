import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/navigation/app_router.dart";

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
                hintText: context.localize.email_text_field_hint,
              ),
            ),
            SizedBox(height: AppDimensions.heightMedium),
            TextButton(
              child:Text(context.localize.next),
              onPressed: () => context.router.push(const QuestionsRoute()), 
            ),
          ],
        ),
      ),
    );
  }  
}
