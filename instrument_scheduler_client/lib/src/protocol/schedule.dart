/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Schedule implements _i1.SerializableModel {
  Schedule._({
    this.id,
    required this.instrumentId,
    required this.startTime,
    required this.endTime,
    required this.userName,
    required this.note,
  });

  factory Schedule({
    int? id,
    required int instrumentId,
    required DateTime startTime,
    required DateTime endTime,
    required String userName,
    required String note,
  }) = _ScheduleImpl;

  factory Schedule.fromJson(Map<String, dynamic> jsonSerialization) {
    return Schedule(
      id: jsonSerialization['id'] as int?,
      instrumentId: jsonSerialization['instrumentId'] as int,
      startTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startTime']),
      endTime: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      userName: jsonSerialization['userName'] as String,
      note: jsonSerialization['note'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int instrumentId;

  DateTime startTime;

  DateTime endTime;

  String userName;

  String note;

  Schedule copyWith({
    int? id,
    int? instrumentId,
    DateTime? startTime,
    DateTime? endTime,
    String? userName,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'instrumentId': instrumentId,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      'userName': userName,
      'note': note,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduleImpl extends Schedule {
  _ScheduleImpl({
    int? id,
    required int instrumentId,
    required DateTime startTime,
    required DateTime endTime,
    required String userName,
    required String note,
  }) : super._(
          id: id,
          instrumentId: instrumentId,
          startTime: startTime,
          endTime: endTime,
          userName: userName,
          note: note,
        );

  @override
  Schedule copyWith({
    Object? id = _Undefined,
    int? instrumentId,
    DateTime? startTime,
    DateTime? endTime,
    String? userName,
    String? note,
  }) {
    return Schedule(
      id: id is int? ? id : this.id,
      instrumentId: instrumentId ?? this.instrumentId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      userName: userName ?? this.userName,
      note: note ?? this.note,
    );
  }
}
