import Flutter
import UIKit

public class AlertPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "alert_plugin", binaryMessenger: registrar.messenger())
    let instance = AlertPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "showAlertDialog":
        let args = call.arguments as? Dictionary<String, String>
        let title = args?["title"] ?? "Hello"
        let message = args?["message"] ?? "I am a native alert dialog."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            result(true)
          }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil);
    case "showDialogWithTwoButtons":
            let args = call.arguments as? Dictionary<String, String>
            let title = args?["title"] ?? "Hello"
            let message = args?["message"] ?? "I am a native alert dialog."
            let positiveTextButton = args?["positiveTextButton"] ?? "Yes"
            let negativeTextButton = args?["negativeTextButton"] ?? "No"

            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: positiveTextButton, style: UIAlertAction.Style.default, handler: { action in
                result(true)
              }))
            alert.addAction(UIAlertAction(title: negativeTextButton, style: UIAlertAction.Style.default, handler: { action in
                result(false)
              }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil);
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
