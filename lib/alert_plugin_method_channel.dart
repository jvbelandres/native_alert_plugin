import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'alert_plugin_platform_interface.dart';

/// An implementation of [AlertPluginPlatform] that uses method channels.
class MethodChannelAlertPlugin extends AlertPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('alert_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> showAlertDialog(
      {required String title, required String message}) async {
    return await methodChannel.invokeMethod<bool>('showAlertDialog', {
      'title': title,
      'message': message,
    });
  }

  @override
  Future<bool?> showDialogWithTwoButtons(
      {required String title,
      required String message,
      required String positiveTextButton,
      required String negativeTextButton}) async {
    return await methodChannel.invokeMethod<bool>('showDialogWithTwoButtons', {
      'title': title,
      'message': message,
      'positiveTextButton': positiveTextButton,
      'negativeTextButton': negativeTextButton,
    });
  }
}
