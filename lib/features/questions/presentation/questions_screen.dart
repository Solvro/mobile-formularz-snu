import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:form_builder_validators/form_builder_validators.dart";
import "package:formularz_snu_client/formularz_snu_client.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/features/questions/business/questions_service.dart";
import "package:sleep_app/gen/assets.gen.dart";
import "package:sleep_app/navigation/app_router.dart";
import "package:sleep_app/theme/app_colors.dart";

@RoutePage()
class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wypełnij ankietę 😴"),
      ),
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
                context.localize.go_to_bed_time,
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: AppDimensions.heightSmall),
              FormBuilderDateTimePicker(
                name: "bedtime",
                inputType: InputType.time,
                initialTime: const TimeOfDay(hour: 0, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                ]),
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.bed, color: AppColors.light, size: 32),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              Text(
                context.localize.go_sleep_time,
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: AppDimensions.heightSmall),
              FormBuilderDateTimePicker(
                name: "go_sleep_time",
                inputType: InputType.time,
                initialTime: const TimeOfDay(hour: 0, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.go_sleep_time,
                  ),
                ]),
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(
                    Icons.bedtime,
                    color: AppColors.light,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              Text(
                context.localize.awakening_times,
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: AppDimensions.heightSmall),
              FormBuilderTextField(
                name: "awekenings_times",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                ]),
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.alarm, color: AppColors.light, size: 32),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              Text(
                context.localize.awakening_time_total,
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: AppDimensions.heightSmall),
              FormBuilderTextField(
                name: "awakening_time_total",
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                ]),
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.timer, color: AppColors.light, size: 32),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              Text(
                context.localize.wake_up_time,
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: AppDimensions.heightSmall),
              FormBuilderDateTimePicker(
                name: "wakeup_time",
                inputType: InputType.time,
                initialTime: const TimeOfDay(hour: 8, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                ]),
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(
                    Icons.sunny,
                    color: AppColors.light,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              Text(
                context.localize.leave_bed_time,
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: AppDimensions.heightSmall),
              FormBuilderDateTimePicker(
                name: "leave_time",
                inputType: InputType.time,
                initialTime: const TimeOfDay(hour: 8, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: context.localize.required_field_error,
                  ),
                ]),
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.man, color: AppColors.light, size: 32),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              Text(
                context.localize.sleep_rate,
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: AppDimensions.heightSmall),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  tickMarkShape:
                      const RoundSliderTickMarkShape(tickMarkRadius: 0),
                  activeTickMarkColor: Colors.transparent,
                  inactiveTickMarkColor: Colors.transparent,
                ),
                child: FormBuilderSlider(
                  name: "sleep_rate",
                  divisions: 5,
                  initialValue: 0,
                  min: 0,
                  max: 5,
                  activeColor: AppColors.amethyst,
                  inactiveColor: AppColors.light,
                  minValueWidget: (min) => const SizedBox(),
                  valueWidget: (value) => Text("$value / 5"),
                  maxValueWidget: (max) => const SizedBox(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: context.localize.required_field_error,
                    ),
                  ]),
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.star, color: AppColors.light, size: 32),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.heightHuge),
              const SizedBox(height: AppDimensions.heightMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: context.router.popForced,
                    style:
                        TextButton.styleFrom(foregroundColor: AppColors.light),
                    child: Text(context.localize.cancel),
                  ),
                  const SizedBox(
                    width: AppDimensions.heightMedium,
                  ),
                  ElevatedButton(
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
                          SleepScore2.fromJson(
                            switch (formData["sleep_rate"]) {
                              "0" => "zero",
                              "1" => "one",
                              "2" => "two",
                              "3" => "three",
                              "4" => "four",
                              "5" => "five",
                              _ => "zero",
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
              const SizedBox(height: AppDimensions.heightMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.solvro.path,
                    width: 150,
                    height: 100,
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.heightSmall),
            ],
          ),
        ),
      ),
    );
  }
}
