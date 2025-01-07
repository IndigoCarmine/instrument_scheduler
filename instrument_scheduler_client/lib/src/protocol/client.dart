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
import 'dart:async' as _i2;
import 'package:instrument_scheduler_client/src/protocol/schedule.dart' as _i3;
import 'protocol.dart' as _i4;

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointScheduling extends _i1.EndpointRef {
  EndpointScheduling(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'scheduling';

  _i2.Future<bool> addSchedule(_i3.Schedule schedule) =>
      caller.callServerEndpoint<bool>(
        'scheduling',
        'addSchedule',
        {'schedule': schedule},
      );

  _i2.Future<void> updateSchedule(_i3.Schedule schedule) =>
      caller.callServerEndpoint<void>(
        'scheduling',
        'updateSchedule',
        {'schedule': schedule},
      );

  _i2.Future<void> deleteSchedule(int schedule_id) =>
      caller.callServerEndpoint<void>(
        'scheduling',
        'deleteSchedule',
        {'schedule_id': schedule_id},
      );

  _i2.Future<List<_i3.Schedule>> getAllSchedule() =>
      caller.callServerEndpoint<List<_i3.Schedule>>(
        'scheduling',
        'getAllSchedule',
        {},
      );

  _i2.Future<int> getHashCode() => caller.callServerEndpoint<int>(
        'scheduling',
        'getHashCode',
        {},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i4.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    example = EndpointExample(this);
    scheduling = EndpointScheduling(this);
  }

  late final EndpointExample example;

  late final EndpointScheduling scheduling;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'scheduling': scheduling,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
