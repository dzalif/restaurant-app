import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'background_service.dart';
import 'date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool? isScheduled;

  Future<bool> scheduledNews() async {
    final prefs = await SharedPreferences.getInstance();
    final prefIsSchedule = prefs.getBool('is_scheduled');

    if (prefIsSchedule == null) {
      isScheduled = false;
    } else {
      isScheduled = prefIsSchedule;
    }

    if (isScheduled!) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}