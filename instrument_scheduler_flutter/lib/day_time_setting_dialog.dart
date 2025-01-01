// time and day setting dialog
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

Future<CalendarEventData> showDayTimeSettingDialog(
    BuildContext context, CalendarEventData data) async {
  var new_data = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return DayTimeSettingDialog(data: data);
    },
  );

  if (new_data != null) {
    print('New data: $new_data');
    return new_data as CalendarEventData;
  } else {
    return data;
  }
}

class DayTimeSettingDialog extends StatefulWidget {
  const DayTimeSettingDialog({super.key, required this.data});

  final CalendarEventData? data;

  @override
  State<DayTimeSettingDialog> createState() => _DayTimeSettingDialogState();
}

class _DayTimeSettingDialogState extends State<DayTimeSettingDialog> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  void initState() {
    super.initState();
    _startTime =
        TimeOfDay.fromDateTime(widget.data!.startTime ?? DateTime.now());
    _endTime = TimeOfDay.fromDateTime(
        widget.data!.endTime ?? DateTime.now().add(Duration(hours: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set time'),
      content: Container(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TimeRangePicker(
              start: _startTime!,
              end: _endTime!,
              onStartChange: (start) {
                setState(() {
                  _startTime = start;
                });
              },
              onEndChange: (end) {
                setState(() {
                  _endTime = end;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(CalendarEventData(
                  title: widget.data!.title,
                  date: widget.data!.date,
                  startTime: DateTime(
                    widget.data!.date.year,
                    widget.data!.date.month,
                    widget.data!.date.day,
                    _startTime!.hour,
                    _startTime!.minute,
                  ),
                  endTime: DateTime(
                    widget.data!.date.year,
                    widget.data!.date.month,
                    widget.data!.date.day,
                    _endTime!.hour,
                    _endTime!.minute,
                  ),
                  color: widget.data!.color,
                ));
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
