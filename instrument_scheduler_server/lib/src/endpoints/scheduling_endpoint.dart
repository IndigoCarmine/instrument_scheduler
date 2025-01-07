import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class SchedulingEndpoint extends Endpoint {
  int scheduleHashCode = 0;

  Future<bool> addSchedule(Session session, Schedule schedule) async {
    // Schedule the instrument
    print(
        'Scheduling instrument ${schedule.instrumentId} at ${schedule.startTime}');

    // check if the instrument has already been scheduled at the same time
    // The start and end time of the schedule is fixed to avoid the case where the schedules are continuous
    final start_fixed = schedule.startTime.add(const Duration(seconds: 1));
    final end_fixed = schedule.endTime.subtract(const Duration(seconds: 1));
    var schedules = await Schedule.db.find(session, where: (scheduleTable) {
      return scheduleTable.id
              .notEquals(schedule.id) & // Exclude the schedule itself
          scheduleTable.instrumentId.equals(
              schedule.instrumentId) & // the check is for the same instrument
          (scheduleTable.startTime.between(start_fixed, end_fixed) |
              scheduleTable.endTime.between(start_fixed, end_fixed));
    });

    if (schedules.isEmpty) {
      await Schedule.db.insertRow(session, schedule);
      _updateHashcode(session);
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateSchedule(Session session, Schedule schedule) async {
    await Schedule.db.updateRow(session, schedule);
    _updateHashcode(session);
  }

  Future<void> deleteSchedule(Session session, int schedule_id) async {
    await Schedule.db.deleteWhere(session, where: (scaduleTable) {
      return scaduleTable.id.equals(schedule_id);
    });
    _updateHashcode(session);
  }

  Future<List<Schedule>> getAllSchedule(Session session) async {
    return await Schedule.db.find(session);
  }

  Future<void> _updateHashcode(Session session) async {
    // Get the hash of the schedule list
    var schedules = await Schedule.db.find(session);
    scheduleHashCode = schedules.hashCode;
  }

  // This method is used to get the hash code of the schedule list
  Future<int> getHashCode(Session session) async {
    return scheduleHashCode;
  }
}
