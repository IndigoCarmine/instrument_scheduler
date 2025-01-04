import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class SchedulingEndpoint extends Endpoint {
  int scheduleHashCode = 0;

  Future<bool> addSchedule(Session session, Schedule schedule) async {
    // Schedule the instrument
    print(
        'Scheduling instrument ${schedule.instrumentId} at ${schedule.startTime}');

    // check if the instrument has already been scheduled at the same time
    var schedules = await Schedule.db.find(session, where: (scheduleTable) {
      return scheduleTable.instrumentId.equals(schedule.instrumentId) &
          (scheduleTable.startTime
                  .between(schedule.startTime, schedule.endTime) |
              scheduleTable.endTime
                  .between(schedule.startTime, schedule.endTime));
    });

    if (schedules.isEmpty) {
      await Schedule.db.insertRow(session, schedule);
      _updateHashcode(session);
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteSchedule(Session session, int schedule_id) async {
    // Delete the schedule
    await Schedule.db.deleteWhere(session, where: (scaduleTable) {
      return scaduleTable.id.equals(schedule_id);
    });
    _updateHashcode(session);
  }

  Future<List<Schedule>> getAllSchedule(Session session) async {
    // Get the schedule for the instrument
    return await Schedule.db.find(session);
  }

  Future<void> _updateHashcode(Session session) async {
    // Get the hash of the schedule list
    var schedules = await Schedule.db.find(session);
    scheduleHashCode = schedules.hashCode;
  }

  Future<int> getHashCode(Session session) async {
    return scheduleHashCode;
  }
}
