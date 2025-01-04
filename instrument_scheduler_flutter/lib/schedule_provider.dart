import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instrument_scheduler_client/instrument_scheduler_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

var client = Client('http://$localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

class ScheduleNotifier extends StateNotifier<List<Schedule>?> {
  ScheduleNotifier() : super(null) {
    _startFetchingSchedules();
  }

  Timer? _timer;
  int scheduleHashCode = 1000; // initial value

  void _startFetchingSchedules() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      await fetchAllSchedules();
    });
  }

  Future<void> fetchAllSchedules() async {
    try {
      // check if the schedule has been updated
      final new_hashcode = await client.scheduling.getHashCode();
      if (new_hashcode == scheduleHashCode) return;

      // update state
      scheduleHashCode = new_hashcode;
      state = await client.scheduling.getAllSchedule();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final scheduleProvider =
    StateNotifierProvider<ScheduleNotifier, List<Schedule>?>((ref) {
  return ScheduleNotifier();
});

bool listEquals(List<Schedule>? list1, List<Schedule>? list2) {
  if (list1 == null || list2 == null) return false;
  if (list1.length != list2.length) return false;
  for (int i = 0; i < list1.length; i++) {
    if (list1[i] != list2[i]) return false;
  }
  return true;
}

void removeAllSchedules() async {
  await client.scheduling.getAllSchedule().then((result) {
    result.forEach((schedule) {
      client.scheduling.deleteSchedule(schedule.id!);
    });
  });
}

Future<bool> addSchedule(Schedule schedule) async {
  return await client.scheduling.addSchedule(schedule);
}

void removeSchedule(int schedule_id) async {
  await client.scheduling.deleteSchedule(schedule_id);
}
