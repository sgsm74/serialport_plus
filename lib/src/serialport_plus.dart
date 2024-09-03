import 'package:flutter/services.dart';

import 'serialport_plus_platform_interface.dart';

class SerialportPlus {
  Future<List?> getAllDevices() {
    return SerialportPlusPlatform.instance.getAllDevices();
  }

  Future<List?> getAllDevicesPath() {
    return SerialportPlusPlatform.instance.getAllDevicesPath();
  }

  Future<bool?> open(
      String filePath, int baudrate, int dataBits, int parity, int stopBits) {
    return SerialportPlusPlatform.instance
        .open(filePath, baudrate, dataBits, parity, stopBits);
  }

  Future<bool?> write(Uint8List data) {
    return SerialportPlusPlatform.instance.write(data);
  }

  Stream<Uint8List> read() {
    return SerialportPlusPlatform.instance.read();
  }

  Future<bool?> close() {
    return SerialportPlusPlatform.instance.close();
  }
}
