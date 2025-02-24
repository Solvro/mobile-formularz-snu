import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:form_builder_validators/form_builder_validators.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/email/data/email_remote_repository.dart";
import "package:sleep_app/features/study_in_progress/data/study_in_progress_repo.dart";
import "package:sleep_app/navigation/app_router.dart";

const emailRegexPattern =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

@RoutePage()
class EmailScreen extends StatelessWidget {
  EmailScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Future<void> tryStartSurvey() async {
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        final String email = _formKey.currentState?.value["email"] ?? "";

        final studyInProgress = await StudyInProgressRepo.isStudyInProgress();
        final enrolled = await EmailRemoteRepository.doesEmailExist(email);
        final hasAlreadySentToday =
            await EmailRemoteRepository.hasTodayAlreadySentResponse(email);

        if (!context.mounted) return;

        // in realease negation of condition
        if (studyInProgress) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.localize.study_not_in_progress)),
          );
        } else if (!enrolled) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.localize.not_enrolled)),
          );
        } else if (hasAlreadySentToday) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.localize.alread_sent_today)),
          );
        } else {
          await context.router.push(const QuestionsRoute());
        }
      }
    }

    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
        child: FormBuilder(
          key: _formKey,
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
                onPressed: tryStartSurvey,
                child: Text(context.localize.next),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
