import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numerote_core/numerote_core.dart';

void main() {
  const MethodChannel channel = MethodChannel('numerote_core');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await NumeroteCore.platformVersion, '42');
  });
}
