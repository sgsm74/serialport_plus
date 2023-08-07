import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:serialport_plus/serialport_plus.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSerialportPlusPlatform
    with MockPlatformInterfaceMixin
    implements SerialportPlusPlatform {
  void main() {
    final SerialportPlusPlatform initialPlatform =
        SerialportPlusPlatform.instance;

    test('$MethodChannelSerialportPlus is the default instance', () {
      expect(initialPlatform, isInstanceOf<MethodChannelSerialportPlus>());
    });
  }

  @override
  Future<bool?> close() {
    throw UnimplementedError();
  }

  @override
  Future<List?> getAllDevices() {
    throw UnimplementedError();
  }

  @override
  Future<List?> getAllDevicesPath() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> open(
      String filePath, int baudrate, int dataBits, int parity, int stopBits) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> write(Uint8List data) {
    throw UnimplementedError();
  }
}
