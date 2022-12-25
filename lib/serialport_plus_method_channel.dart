import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'serialport_plus_platform_interface.dart';

/// An implementation of [SerialportPlusPlatform] that uses method channels.
class MethodChannelSerialportPlus extends SerialportPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('serialport_plus');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
