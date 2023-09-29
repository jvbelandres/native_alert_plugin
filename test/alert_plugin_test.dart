import 'package:alert_plugin/alert_plugin.dart';
import 'package:alert_plugin/alert_plugin_method_channel.dart';
import 'package:alert_plugin/alert_plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAlertPluginPlatform
    with MockPlatformInterfaceMixin
    implements AlertPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> showAlertDialog(
          {required String title, required String message}) =>
      Future.value(false);

  @override
  Future<bool?> showDialogWithTwoButtons(
          {required String title,
          required String message,
          required String positiveTextButton,
          required String negativeTextButton}) =>
      Future.value(false);
}

void main() {
  final AlertPluginPlatform initialPlatform = AlertPluginPlatform.instance;

  test('$MethodChannelAlertPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAlertPlugin>());
  });

  test('getPlatformVersion', () async {
    AlertPlugin alertPlugin = AlertPlugin();
    MockAlertPluginPlatform fakePlatform = MockAlertPluginPlatform();
    AlertPluginPlatform.instance = fakePlatform;

    expect(await alertPlugin.getPlatformVersion(), '42');
  });
}
