
import 'serialport_plus_platform_interface.dart';

class SerialportPlus {
  Future<String?> getPlatformVersion() {
    return SerialportPlusPlatform.instance.getPlatformVersion();
  }
}
