import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/navigation/app_router.dart";
import "package:sleep_app/theme/app_colors.dart";

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController emailController = TextEditingController();
  String? errorText;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                helperText: context.localize.email_text_field_hint,
                errorText: errorText,
              ),
            ),
            SizedBox(height: AppDimensions.heightMedium),
            TextButton(
              child:Text(context.localize.next),
              onPressed: () {

                String email = emailController.text.trim();
                final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

                setState(() {
                  if (email.isNotEmpty && emailValid) {
                    errorText = null;
                    context.router.push(const QuestionsRoute());
                  } else {
                    errorText = context.localize.email_error;
                  }
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: AppDimensions.paddingMedium, right: AppDimensions.paddingMedium),
        child: FloatingActionButton(
          onPressed: () => context.router.push(AlarmRoute()),
          backgroundColor: amethyst,
          child: Icon(Icons.alarm, color: dark),
        ),
      ),
    );
  }
}
