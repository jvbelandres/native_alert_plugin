package com.example.alert_plugin

import android.app.Activity
import android.app.AlertDialog
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AlertPlugin */
class AlertPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var currentActivity: Activity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "alert_plugin")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
        "getPlatformVersion" -> {
          result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        "showAlertDialog" -> {
          val args = call.arguments as? Map<String, Any>

          return currentActivity?.let {
            val title = args?.get("title") as String?
            val message = args?.get("message") as String?
            val builder = AlertDialog.Builder(it)
            builder.setTitle(title ?: "Title Default")
            builder.setMessage(message ?: "Message Default")
              .setPositiveButton(android.R.string.ok) { _, _ ->
                result.success(true)
              }
            builder.create().show()
          } ?: result.error("0", "Current activity null", "Can not show dialog because current activity is null.")
        }
      "showDialogWithTwoButtons" -> {
        val args = call.arguments as? Map<String, Any>

        return currentActivity?.let {
          val title = args?.get("title") as String?
          val message = args?.get("message") as String?
          val positiveTextButton = args?.get("positiveTextButton") as String?
          val negativeTextButton = args?.get("negativeTextButton") as String?

          val builder = AlertDialog.Builder(it)
          builder.setTitle(title ?: "Title Default")
          builder.setMessage(message ?: "Message Default")
            .setPositiveButton(positiveTextButton ?: "Yes") { _, _ ->
              result.success(true)
            }
            .setNegativeButton(negativeTextButton ?: "No") { _, _ ->
              result.success(false)
            }
          builder.create().show()
        } ?: result.error("0", "Current activity null", "Can not show dialog because current activity is null.")
      }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    currentActivity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    currentActivity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    currentActivity = binding.activity
  }

  override fun onDetachedFromActivity() {
    currentActivity = null
  }
}
