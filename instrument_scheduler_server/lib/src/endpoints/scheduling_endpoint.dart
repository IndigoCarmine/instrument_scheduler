import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class SchedulingEndpoint extends Endpoint {
  Future<void> scheduleInstrument(Session session, Schedule schedule) async {
    // Schedule the instrument
    print(
        'Scheduling instrument ${schedule.instrumentId} at ${schedule.startTime}');
    await Schedule.db.insertRow(session, schedule);
  }

  Future<void> deleteSchedule(Session session, Schedule schedule) async {
    // Delete the schedule
    print('Deleting schedule $schedule');
    await Schedule.db.deleteRow(session, schedule);
  }

  Future<List<Schedule>> getAllSchedule(Session session) async {
    // Get the schedule for the instrument
    return await Schedule.db.find(session);
  }
}
