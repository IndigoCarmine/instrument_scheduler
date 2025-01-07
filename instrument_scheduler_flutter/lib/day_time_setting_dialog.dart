// time and day setting dialog
import 'package:flutter/material.dart';
import 'package:instrument_scheduler_client/instrument_scheduler_client.dart';
import 'package:time_range_picker/time_range_picker.dart';

sealed class ScheduleResult {
  final Schedule schedule;

  ScheduleResult(this.schedule);
}

class ScheduleSave extends ScheduleResult {
  ScheduleSave(Schedule schedule) : super(schedule);
}

class ScheduleRemove extends ScheduleResult {
  ScheduleRemove(Schedule schedule) : super(schedule);
}

Future<ScheduleResult> showDayTimeSettingDialog(
    BuildContext context, Schedule data) async {
  var new_data = await showDialog<ScheduleResult>(
    context: context,
    builder: (BuildContext context) {
      return DayTimeSettingDialog(data: data);
    },
  );

  if (new_data != null) {
    print('New data: $new_data');
    return new_data;
  } else {
    return ScheduleSave(data);
  }
}

class DayTimeSettingDialog extends StatefulWidget {
  const DayTimeSettingDialog({super.key, required this.data});

  final Schedule data;

  @override
  State<DayTimeSettingDialog> createState() => _DayTimeSettingDialogState();
}

class _DayTimeSettingDialogState extends State<DayTimeSettingDialog> {
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late String _note;

  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _startTime = TimeOfDay.fromDateTime(widget.data.startTime.toLocal());
    _endTime = TimeOfDay.fromDateTime(widget.data.endTime.toLocal());
    _note = widget.data.note;

    _noteController = TextEditingController(text: _note);
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
              start: _startTime,
              end: _endTime,
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
              hideButtons: true,
            ),
            Text(widget.data.userName),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Note',
              ),
              controller: _noteController,
              onChanged: (value) {
                _note = value;
                setState(() {});
              },
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final localStartTime = widget.data.startTime.toLocal();
                    final localEndTime = widget.data.endTime.toLocal();
                    Navigator.of(context).pop(
                      ScheduleSave(Schedule(
                        id: widget.data.id,
                        startTime: DateTime(
                          localStartTime.year,
                          localStartTime.month,
                          localStartTime.day,
                          _startTime.hour,
                          _startTime.minute,
                        ),
                        endTime: DateTime(
                          localEndTime.year,
                          localEndTime.month,
                          localEndTime.day,
                          _endTime.hour,
                          _endTime.minute,
                        ),
                        instrumentId: widget.data.instrumentId,
                        userName: widget.data.userName,
                        note: _note,
                      )),
                    );
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(ScheduleRemove(widget.data));
                  },
                  child: const Text('Remove'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
