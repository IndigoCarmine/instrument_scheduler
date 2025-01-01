import 'package:test/test.dart';
import 'package:instrument_scheduler_server/src/example_util.dart';

void main() {
  test(
      'Given ExampleUtil '
      'when calling `buildGreeting` with name '
      'then returned greeting includes name', () async {
    final greeting = ExampleUtil.buildGreeting('Alice');
    expect(greeting, 'Hello Alice');
  });
}
