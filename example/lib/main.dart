import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:serialport_plus/serialport_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _devices = [];
  final _serialportFlutterPlugin = SerialportPlus();

  @override
  void initState() {
    getDevices();
    super.initState();
  }

  @override
  void dispose() async {
    await _serialportFlutterPlugin.close();
    super.dispose();
  }

  Future<void> getDevices() async {
    List? devices;
    try {
      devices = (await _serialportFlutterPlugin.getAllDevicesPath());
    } on PlatformException {
      devices = [];
    }
    if (!mounted) return;

    setState(() {
      _devices = devices!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Serialport plus example app'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView(
                  children: [
                    for (final device in _devices)
                      Builder(
                        builder: (context) {
                          return Text(device);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
