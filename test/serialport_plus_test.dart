import 'package:flutter_test/flutter_test.dart';
import 'package:serialport_plus/serialport_plus.dart';
import 'package:serialport_plus/serialport_plus_platform_interface.dart';
import 'package:serialport_plus/serialport_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSerialportPlusPlatform
    with MockPlatformInterfaceMixin
    implements SerialportPlusPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SerialportPlusPlatform initialPlatform = SerialportPlusPlatform.instance;

  test('$MethodChannelSerialportPlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSerialportPlus>());
  });

  test('getPlatformVersion', () async {
    SerialportPlus serialportPlusPlugin = SerialportPlus();
    MockSerialportPlusPlatform fakePlatform = MockSerialportPlusPlatform();
    SerialportPlusPlatform.instance = fakePlatform;

    expect(await serialportPlusPlugin.getPlatformVersion(), '42');
  });
}
