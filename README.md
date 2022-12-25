# serialport_plus


A Flutter plugin integrated with [Android-SerialPort-API](https://github.com/licheedev/Android-SerialPort-API).

This plugin works only for rooted Android devices.


## Usage

### List devices

``` dart
  List devices = await SerialportFlutter.listDevices();

```
### List devices path

``` dart
  List devices = await SerialportFlutter.listDevicesPath();

```
### Open/Close device

``` dart
bool openResult = await SerialportFlutter.open('/your/device/path', baudrate, dataBits, parity, stopBits);
bool closeResult = await SerialportFlutter.close();
```

### Write data to device

``` dart

SerialportFlutter.write(Uint8List.fromList("Write some data".codeUnits));
```

