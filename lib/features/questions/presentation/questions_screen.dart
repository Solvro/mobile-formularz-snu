import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:form_builder_validators/form_builder_validators.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/navigation/app_router.dart";
import "package:sleep_app/theme/app_colors.dart";

@RoutePage()
class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(title: Text("Questions")),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
        child: FormBuilder(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [

              SizedBox(height: AppDimensions.heightBig),
              Text(context.localize.questions_headline, style: context.theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.normal)),
              SizedBox(height: AppDimensions.heightBig),
              Divider(color: light, thickness: 1,),
              SizedBox(height: AppDimensions.heightBig),

              FormBuilderDateTimePicker(
                name: "bedtime",
                inputType: InputType.time,
                initialTime: TimeOfDay(hour: 0, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: "This field is required"),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.go_to_bed_time,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.bed, color: light),
                ),
              ),

              SizedBox(height: AppDimensions.heightHuge),

              FormBuilderDateTimePicker(
                name: "go_sleep_time",
                inputType: InputType.time,
                initialTime: TimeOfDay(hour: 0, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: "This field is required"),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.go_sleep_time,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.bedtime, color: light),
                ),
              ),

              SizedBox(height: AppDimensions.heightHuge),

              FormBuilderTextField(
                name: "fall_asleep_time",
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: "This field is required"),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.fall_asleep_time,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.bedtime, color: light),
                ),
              ),

              SizedBox(height: AppDimensions.heightHuge),

              FormBuilderTextField(
                name: "awekenings_times",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: "This field is required"),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.awakening_times,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.alarm, color: light),
                ),
              ),

              SizedBox(height: AppDimensions.heightHuge),

              FormBuilderTextField(
                name: "awakening_time_total",
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: "This field is required"),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.awakening_time_total,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.timer, color: light),
                ),
              ),

              SizedBox(height: AppDimensions.heightHuge),

              FormBuilderDateTimePicker(
                name: "wakeup_time",
                inputType: InputType.time,
                initialTime: TimeOfDay(hour: 8, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: "This field is required"),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.wake_up_time,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.sunny, color: light),
                ),
              ),

              SizedBox(height: AppDimensions.heightHuge),

              FormBuilderDateTimePicker(
                name: "leave_time",
                inputType: InputType.time,
                initialTime: TimeOfDay(hour: 8, minute: 0),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: "This field is required"),
                ]),
                decoration: InputDecoration(
                  labelText: context.localize.leave_bed_time,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.man, color: light),
                ),
              ),

              SizedBox(height: AppDimensions.heightHuge),

              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 0),
                  activeTickMarkColor: Colors.transparent,
                  inactiveTickMarkColor: Colors.transparent, 
                ),
                child: FormBuilderSlider(
                  name: "sleep_rate",
                  divisions: 5,
                  initialValue: 0,
                  min: 0,
                  max: 5,
                  activeColor: light,
                  inactiveColor: amethyst,
                  minValueWidget: (min) => SizedBox(),
                  valueWidget: (value) => Text("$value / 5"),
                  maxValueWidget: (max) => SizedBox(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "This field is required"),
                  ]),
                  decoration: InputDecoration(
                    labelText: context.localize.sleep_rate,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.star, color: light),
                  ),
                ),
              ),

              SizedBox(height: AppDimensions.heightHuge),
              Divider(color: light, thickness: 1,),
              SizedBox(height: AppDimensions.heightMedium),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => context.router.popForced(),
                    style: context.theme.textButtonTheme.style?.copyWith(
                      foregroundColor: WidgetStateProperty.all(amethyst),
                      backgroundColor: WidgetStateProperty.all(Colors.transparent),
                      side: WidgetStateProperty.all(BorderSide(color: amethyst, width: 2)),
                    ),
                    child: Text(context.localize.cancel),
                  ),
                  SizedBox(width: AppDimensions.heightMedium,), 
                  TextButton(
                    child: Text(context.localize.submit),
                    onPressed: () {
                      if(formKey.currentState?.saveAndValidate(focusOnInvalid: false) ?? false) {
                        // TODO save form results to backend
                        context.router.push(ThankYouRoute());
                      }
                    },
                  ),
                ],
              ),

              SizedBox(height: AppDimensions.heightHuge),
              SizedBox(height: AppDimensions.heightHuge),
              SizedBox(height: AppDimensions.heightHuge),
            ],
          ),
        ),
      ),
    );
  }
}
