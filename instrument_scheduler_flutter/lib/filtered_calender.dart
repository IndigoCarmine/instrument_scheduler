import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instrument_scheduler_client/instrument_scheduler_client.dart';

import 'schedule_provider.dart';
import 'day_time_setting_dialog.dart';

class FilteredCalender extends ConsumerWidget {
  const FilteredCalender(this.instrument_ids, {Key? key}) : super(key: key);
  final List<int> instrument_ids;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = EventController();
    var schedules = ref.watch(scheduleProvider);

    if (schedules == null) {
      return const Center(child: CircularProgressIndicator());
    }

    var converted_schedules = schedules
        .map((schedule) {
          // Filter out schedules that are not for the selected instruments
          if (!instrument_ids.contains(schedule.instrumentId)) {
            return null;
          }
          return CalendarEventData(
              title: schedule.userName,
              date: schedule.startTime.add(Duration(hours: 9)),
              startTime: schedule.startTime.add(Duration(hours: 9)),
              endTime: schedule.endTime.add(Duration(hours: 9)),
              color: Colors.blue);
        })
        .nonNulls
        .toList();
    controller.addAll(converted_schedules);
    return WeekView(
      // WeekView is a widget from the calendar_view package
      controller: controller,
      onDateTap: (date) {
        print('Date tapped: $date');

        // Add a new schedule
        var new_schedule = Schedule(
            startTime: date,
            endTime: date.add(Duration(hours: 3)),
            instrumentId: instrument_ids.first,
            userName: 'New User',
            note: 'New Note');

        addSchedule(new_schedule);
      },
      onEventTap: (data, daytime) async {
        print('Event tapped: $data');
        var new_data = await showDayTimeSettingDialog(context, data[0]);

        if (new_data != null) {
          print('New data: $data');
          addSchedule(Schedule(
            startTime: new_data.startTime!,
            endTime: new_data.endTime!,
            instrumentId: instrument_ids.first,
            userName: new_data.title,
            note: 'New Note',
          ));
          // removeSchedule(
          //   Schedule(
          //     startTime: data[0].startTime!,
          //     endTime: data[0].endTime!,
          //     instrumentId: instrument_ids.first,
          //     userName: data[0].title,
          //     note: 'New Note',
          //   ),
          // );
        }
      },
    );
  }
}
