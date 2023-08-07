import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'serialport_plus_method_channel.dart';

abstract class SerialportPlusPlatform extends PlatformInterface {
  /// Constructs a SerialportPlusPlatform.
  SerialportPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static SerialportPlusPlatform _instance = MethodChannelSerialportPlus();

  /// The default instance of [SerialportPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelSerialportPlus].
  static SerialportPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SerialportPlusPlatform] when
  /// they register themselves.
  static set instance(SerialportPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List?> getAllDevices() {
    throw UnimplementedError('getAllDevices() has not been implemented.');
  }

  Future<List?> getAllDevicesPath() {
    throw UnimplementedError('getAllDevicesPath() has not been implemented.');
  }

  Future<bool?> open(
      String filePath, int baudrate, int dataBits, int parity, int stopBits) {
    throw UnimplementedError('open() has not been implemented.');
  }

  Future<bool?> write(Uint8List data) {
    throw UnimplementedError('write() has not been implemented.');
  }

  Stream<Uint8List?> read() {
    throw UnimplementedError('read() has not been implemented.');
  }

  Future<bool?> close() {
    throw UnimplementedError('close() has not been implemented.');
  }
}
