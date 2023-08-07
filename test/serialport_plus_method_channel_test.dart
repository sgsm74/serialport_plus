import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serialport_plus/serialport_plus.dart';

void main() {
  MethodChannelSerialportPlus platform = MethodChannelSerialportPlus();
  const MethodChannel channel = MethodChannel('serialport_plus');

  TestWidgetsFlutterBinding.ensureInitialized();
}
