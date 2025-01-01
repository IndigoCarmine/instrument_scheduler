/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Schedule implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = ScheduleTable();

  static const db = ScheduleRepository._();

  @override
  int? id;

  int instrumentId;

  DateTime startTime;

  DateTime endTime;

  String userName;

  String note;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'instrumentId': instrumentId,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      'userName': userName,
      'note': note,
    };
  }

  static ScheduleInclude include() {
    return ScheduleInclude._();
  }

  static ScheduleIncludeList includeList({
    _i1.WhereExpressionBuilder<ScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduleTable>? orderByList,
    ScheduleInclude? include,
  }) {
    return ScheduleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Schedule.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Schedule.t),
      include: include,
    );
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

class ScheduleTable extends _i1.Table {
  ScheduleTable({super.tableRelation}) : super(tableName: 'schedule') {
    instrumentId = _i1.ColumnInt(
      'instrumentId',
      this,
    );
    startTime = _i1.ColumnDateTime(
      'startTime',
      this,
    );
    endTime = _i1.ColumnDateTime(
      'endTime',
      this,
    );
    userName = _i1.ColumnString(
      'userName',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
  }

  late final _i1.ColumnInt instrumentId;

  late final _i1.ColumnDateTime startTime;

  late final _i1.ColumnDateTime endTime;

  late final _i1.ColumnString userName;

  late final _i1.ColumnString note;

  @override
  List<_i1.Column> get columns => [
        id,
        instrumentId,
        startTime,
        endTime,
        userName,
        note,
      ];
}

class ScheduleInclude extends _i1.IncludeObject {
  ScheduleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Schedule.t;
}

class ScheduleIncludeList extends _i1.IncludeList {
  ScheduleIncludeList._({
    _i1.WhereExpressionBuilder<ScheduleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Schedule.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Schedule.t;
}

class ScheduleRepository {
  const ScheduleRepository._();

  Future<List<Schedule>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Schedule>(
      where: where?.call(Schedule.t),
      orderBy: orderBy?.call(Schedule.t),
      orderByList: orderByList?.call(Schedule.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Schedule?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduleTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Schedule>(
      where: where?.call(Schedule.t),
      orderBy: orderBy?.call(Schedule.t),
      orderByList: orderByList?.call(Schedule.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Schedule?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Schedule>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Schedule>> insert(
    _i1.Session session,
    List<Schedule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Schedule>(
      rows,
      transaction: transaction,
    );
  }

  Future<Schedule> insertRow(
    _i1.Session session,
    Schedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Schedule>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Schedule>> update(
    _i1.Session session,
    List<Schedule> rows, {
    _i1.ColumnSelections<ScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Schedule>(
      rows,
      columns: columns?.call(Schedule.t),
      transaction: transaction,
    );
  }

  Future<Schedule> updateRow(
    _i1.Session session,
    Schedule row, {
    _i1.ColumnSelections<ScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Schedule>(
      row,
      columns: columns?.call(Schedule.t),
      transaction: transaction,
    );
  }

  Future<List<Schedule>> delete(
    _i1.Session session,
    List<Schedule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Schedule>(
      rows,
      transaction: transaction,
    );
  }

  Future<Schedule> deleteRow(
    _i1.Session session,
    Schedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Schedule>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Schedule>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ScheduleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Schedule>(
      where: where(Schedule.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScheduleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Schedule>(
      where: where?.call(Schedule.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
