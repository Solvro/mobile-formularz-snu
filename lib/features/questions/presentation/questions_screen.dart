import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:sleep_app/constants/app_dimensions.dart";
import "package:sleep_app/extensions/context_extensions.dart";
import "package:sleep_app/navigation/app_router.dart";
import "package:sleep_app/theme/app_colors.dart";

@RoutePage()
class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Questions")),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingBig),
        child: FormBuilder(
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
                decoration: InputDecoration(
                  labelText: context.localize.go_sleep_time,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.bedtime, color: light),
                ),
                initialTime: TimeOfDay(hour: 0, minute: 0),
              ),
              SizedBox(height: AppDimensions.heightHuge),
              FormBuilderDateTimePicker(
                name: "fall_asleep_time",
                inputType: InputType.time,
                decoration: InputDecoration(
                  labelText: context.localize.fall_asleep_time,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.bedtime, color: light),
                ),
                initialTime: TimeOfDay(hour: 0, minute: 0),
              ),
              SizedBox(height: AppDimensions.heightHuge),
              FormBuilderTextField(
                name: "awekenings_times",
                decoration: InputDecoration(
                  labelText: context.localize.awakening_times,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.alarm, color: light),
                ),
              ),
              SizedBox(height: AppDimensions.heightHuge),
              FormBuilderTextField(
                name: "awakening_time_total",
                decoration: InputDecoration(
                  labelText: context.localize.awakening_time_total,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  icon: Icon(Icons.timer, color: light),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: AppDimensions.heightHuge),
              FormBuilderDateTimePicker(
                name: "wakeup_time",
                inputType: InputType.time,
                initialTime: TimeOfDay(hour: 8, minute: 0),
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
                    onPressed: () => (),
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
                    onPressed: () => context.router.push(const ThankYouRoute()),
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
