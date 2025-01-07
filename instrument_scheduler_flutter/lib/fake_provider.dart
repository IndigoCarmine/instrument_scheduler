import 'dart:async';

import 'package:instrument_scheduler_client/instrument_scheduler_client.dart';
import 'package:instrument_scheduler_flutter/schedule_provider.dart';

class FakeScheduleNotifier extends ScheduleNotifier {
  @override
  FakeScheduleNotifier(List<Schedule>? s) {
    state = [
      Schedule(
        endTime: DateTime.now(),
        startTime: DateTime.now().add(const Duration(hours: 1)),
        id: 1,
        instrumentId: 1,
        userName: "Alice",
        note: "Note",
      ),
    ];
  }

  @override
  Future<void> fetchAllSchedules() async {}

  @override
  void dispose() {
    super.dispose();
  }
}
