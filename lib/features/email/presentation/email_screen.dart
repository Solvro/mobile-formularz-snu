import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:form_builder_validators/form_builder_validators.dart";
import "package:sleep_app/features/email/presentation/wrong_email_dialog.dart";
import "package:sleep_app/widgets/footer.dart";

import "../../../constants/app_dimensions.dart";
import "../../../extensions/context_extensions.dart";
import "../../../navigation/app_router.dart";
import "../../../theme/app_colors.dart";
import "../business/email_service.dart";

const emailRegexPattern =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

@RoutePage()
class EmailScreen extends StatelessWidget {
  EmailScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Future<void> onSubmitEmail() async {
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        final String email = _formKey.currentState?.value["email"] ?? "";

        final success = await EmailService.tryToEnroll(email);

        if (!context.mounted) return;

        if (!success) {
          await WrongEmailDialog.showWrongEmailDialog(context);
        } else {
          await context.router.replaceAll([const FirstFormRoute()]);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const Footer(),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: AppDimensions.heightBig),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.heightSmall / 3),
                child: Text(
                  "Wprowadź swój adres email, który podałeś w pierwszym etapie badania, aby kontynuować 📧",
                  style: context.theme.textTheme.headlineMedium,
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: const Alignment(0, -1 / 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormBuilderTextField(
                        name: "email",
                        decoration: InputDecoration(
                          helperText: context.localize.email_text_field_hint,
                          labelText: "Adres email",
                          hintText: "twoj-mail@gmail.com",
                          hintStyle:
                              const TextStyle(color: AppColors.lightGray),
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
                      const SizedBox(
                        height: 1.2 * AppDimensions.heightBig,
                      ),
                      ElevatedButton(
                        onPressed: onSubmitEmail,
                        child: Text(context.localize.next),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
