import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'alert_plugin_method_channel.dart';

abstract class AlertPluginPlatform extends PlatformInterface {
  /// Constructs a AlertPluginPlatform.
  AlertPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static AlertPluginPlatform _instance = MethodChannelAlertPlugin();

  /// The default instance of [AlertPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelAlertPlugin].
  static AlertPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AlertPluginPlatform] when
  /// they register themselves.
  static set instance(AlertPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> showAlertDialog(
      {required String title, required String message}) {
    throw UnimplementedError('showAlertDialog() has not been implemented.');
  }

  Future<bool?> showDialogWithTwoButtons(
      {required String title,
      required String message,
      required String positiveTextButton,
      required String negativeTextButton}) {
    throw UnimplementedError(
        'showDialogWithTwoButtons() has not been implemented.');
  }
}
