import 'alert_plugin_platform_interface.dart';

class AlertPlugin {
  Future<String?> getPlatformVersion() {
    return AlertPluginPlatform.instance.getPlatformVersion();
  }

  Future<bool?> showAlertDialog(
      {required String title, required String message}) {
    return AlertPluginPlatform.instance
        .showAlertDialog(title: title, message: message);
  }

  Future<bool?> showDialogWithTwoButtons(
      {required String title,
      required String message,
      required String positiveTextButton,
      required String negativeTextButton}) {
    return AlertPluginPlatform.instance.showDialogWithTwoButtons(
        title: title,
        message: message,
        positiveTextButton: positiveTextButton,
        negativeTextButton: negativeTextButton);
  }
}
