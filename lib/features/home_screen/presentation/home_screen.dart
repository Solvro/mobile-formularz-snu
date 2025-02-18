import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:form_builder_validators/form_builder_validators.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/navigation/app_router.dart";
import "package:sleep_app/theme/app_colors.dart";

const String emailRegexPattern =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

@RoutePage()
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
        child: FormBuilder(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormBuilderTextField(
                name: "email",
                decoration: InputDecoration(
                  helperText: context.localize.email_text_field_hint,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                  FormBuilderValidators.match(
                    RegExp(emailRegexPattern),
                    errorText: context.localize.email_error,
                  ),
                ]),
              ),
              const SizedBox(height: AppDimensions.heightMedium),
              TextButton(
                child: Text(context.localize.next),
                onPressed: () async {
                  if (formKey.currentState?.saveAndValidate() ?? false) {
                    await context.router.push(const QuestionsRoute());
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: AppDimensions.paddingMedium,
          right: AppDimensions.paddingMedium,
        ),
        child: FloatingActionButton(
          onPressed: () async => context.router.push(const AlarmRoute()),
          backgroundColor: AppColors.amethyst,
          child: const Icon(Icons.alarm, color: AppColors.dark),
        ),
      ),
    );
  }
}
