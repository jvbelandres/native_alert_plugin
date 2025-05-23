import 'dart:async';

import 'package:alert_plugin/alert_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _alertPlugin = AlertPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _alertPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  _showAlert() async {
    try {
      final _ = await _alertPlugin.showAlertDialog(
          title: 'Native alert dialog', message: 'Flutter Flutter Flutter');
    } on PlatformException catch (e) {
      print(e);
    }
  }

  _showDialogWithTwoButtons() async {
    try {
      final bool? success = await _alertPlugin.showDialogWithTwoButtons(
          title: 'Native alert dialog test test test',
          message: 'Flutter Flutter Flutter',
          positiveTextButton: "Yes",
          negativeTextButton: "No");

      if (success == true) {
        print('success');
      } else {
        print('false');
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showDialogWithTwoButtons,
          child: const Icon(Icons.add_alert_rounded),
        ),
      ),
    );
  }
}
