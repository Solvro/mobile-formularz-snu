import "dart:async";

import "package:alarm/alarm.dart";
import "package:alarm/utils/alarm_set.dart";
import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:logger/web.dart";

import "../../../extensions/context_extensions.dart";
import "../../../theme/app_colors.dart";
import "../business/alarm_service.dart";

class AlarmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: context.theme.colorScheme.primary,
          width: 2,
        ),
      ),
      title: const Text("Budzik zadzwonił"),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Budzik zadzwonił, wypełnij ankietę.",
          ),
          Icon(
            Icons.alarm,
            color: AppColors.light,
            size: 150,
          ),
        ],
      ),
      actions: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                unawaited(AlarmService.stopAlarm());
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }

  static Future<void> showAlarmDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlarmDialog();
      },
    );
  }
}

class AlarmPopupRoot extends StatefulWidget {
  const AlarmPopupRoot({super.key, required this.child});
  final Widget child;

  @override
  State<AlarmPopupRoot> createState() => _AlarmPopupRootState();
}

class _AlarmPopupRootState extends State<AlarmPopupRoot> {
  late StreamSubscription<AlarmSet> subs;
  @override
  void initState() {
    super.initState();
    subs = Alarm.ringing.listen((alarms) async {
      if (alarms.alarms.isEmpty) return;
      Logger().i("Alarm is ringing.");
      await AlarmDialog.showAlarmDialog(context);
    });
  }

  @override
  void dispose() {
    unawaited(subs.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

@RoutePage()
class AlarmRootScreen extends StatelessWidget {
  const AlarmRootScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const AlarmPopupRoot(
      child: AutoRouter(),
    );
  }
}
