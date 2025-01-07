import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instrument_scheduler_client/instrument_scheduler_client.dart';

import 'schedule_provider.dart';
import 'day_time_setting_dialog.dart';

bool Function(Schedule) idFilter(List<int> instrument_ids) {
  return (schedule) => instrument_ids.contains(schedule.instrumentId);
}

bool Function(Schedule) allFilter() {
  return (schedule) => true;
}

class FilteredCalender extends ConsumerWidget {
  const FilteredCalender(
      this.isSelectedSchedule, this.userName, this.defaultInstrumentId,
      {Key? key})
      : super(key: key);

  // A filter function that returns true if the schedule should be displayed
  final bool Function(Schedule) isSelectedSchedule;
  final String userName;
  final int defaultInstrumentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = EventController<Schedule>();
    var schedules = ref.watch(scheduleProvider);
    var width = MediaQuery.of(context).size.width;
    var fontSize = 8 * width / 375;
    if (fontSize > 24) {
      fontSize = 24;
    }

    var converted_schedules = schedules
        .map((schedule) {
          // Filter out schedules that are not for the selected instruments
          if (!isSelectedSchedule(schedule)) {
            return null;
          }
          // Convert the schedule to a CalendarEventData
          // The time zone is set to JST (UTC+9)
          return CalendarEventData(
              title: schedule.userName,
              titleStyle: TextStyle(color: Colors.white, fontSize: fontSize),
              date: schedule.startTime.toLocal(),
              startTime: schedule.startTime.toLocal(),
              endTime: schedule.endTime.toLocal(),
              color: Colors.blue,
              event: schedule);
        })
        .nonNulls
        .toList();
    controller.addAll(converted_schedules);
    return WeekView<Schedule>(
      controller: controller,
      onDateTap: (date) async {
        // Add a new schedule
        var new_schedule = Schedule(
            startTime: date,
            endTime: date.add(Duration(hours: 1)),
            instrumentId: defaultInstrumentId,
            userName: userName,
            note: '');

        print('Adding schedule: $new_schedule');

        final successed = await addSchedule(new_schedule);
        if (!successed) {
          //show snackbar
          var snackBar = SnackBar(
            content: Text('Failed to add schedule'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
      },
      onEventTap: (data, daytime) async {
        print('Event tapped: $data');
        var new_data = await showDayTimeSettingDialog(context, data[0].event!);

        print('New data: $data');
        switch (new_data) {
          case ScheduleSave():
            {
              var success = await addSchedule(new_data.schedule);

              if (!success) {
                //show snackbar
                var snackBar = SnackBar(
                  content: Text('Failed to add schedule'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                return;
              }

              var old_data = ref
                  .read(scheduleProvider)
                  .where((element) => element == data[0].event)
                  .first;

              removeSchedule(
                old_data.id!,
              );
            }
            break;
          case ScheduleRemove():
            {
              removeSchedule(new_data.schedule.id!);
            }
            break;
        }
      },
    );
  }
}
