import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:form_builder_validators/form_builder_validators.dart";
import "package:formularz_snu_client/formularz_snu_client.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/questions/business/questions_service.dart";
import "package:sleep_app/navigation/app_router.dart";
import "package:sleep_app/theme/app_colors.dart";

@RoutePage()
class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(title: Text(context.localize.questions)),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
        child: FormBuilder(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              const SizedBox(height: AppDimensions.heightBig),
              Text(
                context.localize.questions_headline,
                style: context.theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: AppDimensions.heightBig),
              const Divider(
                color: AppColors.light,
                thickness: 1,
              ),
              const SizedBox(height: AppDimensions.heightBig),
              FormBuilderDateTimePicker(
                name: "bedtime",
                inputType: InputType.time,
                initialTime: const TimeOfDay(hour: 0, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.go_to_bed_time,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: const Icon(Icons.bed, color: AppColors.light),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              FormBuilderDateTimePicker(
                name: "go_sleep_time",
                inputType: InputType.time,
                initialTime: const TimeOfDay(hour: 0, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.go_sleep_time,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: const Icon(Icons.bedtime, color: AppColors.light),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              FormBuilderTextField(
                name: "awekenings_times",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.awakening_times,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: const Icon(Icons.alarm, color: AppColors.light),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              FormBuilderTextField(
                name: "awakening_time_total",
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.awakening_time_total,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: const Icon(Icons.timer, color: AppColors.light),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              FormBuilderDateTimePicker(
                name: "wakeup_time",
                inputType: InputType.time,
                initialTime: const TimeOfDay(hour: 8, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.wake_up_time,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: const Icon(Icons.sunny, color: AppColors.light),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              FormBuilderDateTimePicker(
                name: "leave_time",
                inputType: InputType.time,
                initialTime: const TimeOfDay(hour: 8, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.leave_bed_time,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: const Icon(Icons.man, color: AppColors.light),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  tickMarkShape:
                      const RoundSliderTickMarkShape(tickMarkRadius: 0),
                  activeTickMarkColor: Colors.transparent,
                  inactiveTickMarkColor: Colors.transparent,
                ),
                child: FormBuilderSlider(
                  name: "sleep_rate",
                  divisions: 9,
                  initialValue: 1,
                  min: 1,
                  max: 10,
                  activeColor: AppColors.light,
                  inactiveColor: AppColors.amethyst,
                  minValueWidget: (min) => const SizedBox(),
                  valueWidget: (value) => Text("$value / 10"),
                  maxValueWidget: (max) => const SizedBox(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: context.localize.required_field_error,
                    ),
                  ]),
                  decoration: InputDecoration(
                    labelText: context.localize.sleep_rate,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.star, color: AppColors.light),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              const Divider(
                color: AppColors.light,
                thickness: 1,
              ),
              const SizedBox(height: AppDimensions.heightMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => context.router.popForced(),
                    style: context.theme.textButtonTheme.style?.copyWith(
                      foregroundColor:
                          WidgetStateProperty.all(AppColors.amethyst),
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                      side: WidgetStateProperty.all(
                        const BorderSide(color: AppColors.amethyst, width: 2),
                      ),
                    ),
                    child: Text(context.localize.cancel),
                  ),
                  const SizedBox(
                    width: AppDimensions.heightMedium,
                  ),
                  TextButton(
                    child: Text(context.localize.submit),
                    onPressed: () async {
                      if (formKey.currentState
                              ?.saveAndValidate(focusOnInvalid: false) ??
                          false) {
                        final formData = formKey.currentState!.value;

                        await QuestionsService.submitSurveyResponse(
                          formData["bedtime"],
                          formData["go_sleep_time"],
                          formData["wakeup_time"],
                          int.tryParse(
                                formData["awekenings_times"] as String,
                              ) ??
                              0,
                          formData["leave_time"],
                          Duration(
                            minutes:
                                int.parse(formData["awakening_time_total"]),
                          ),
                          SleepScore.fromJson(
                            switch (formData["sleep_rate"]) {
                              "1" => "one",
                              "2" => "two",
                              "3" => "three",
                              "4" => "four",
                              "5" => "five",
                              "6" => "six",
                              "7" => "seven",
                              "8" => "eight",
                              "9" => "nine",
                              "10" => "ten",
                              _ => "one",
                            },
                          ),
                        );

                        if (context.mounted) {
                          await context.router.push(const ThankYouRoute());
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 3 * AppDimensions.heightHuge),
            ],
          ),
        ),
      ),
    );
  }
}
